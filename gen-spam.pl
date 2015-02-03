
use common::sense;
use JSON::XS;


my @names = qw( alice bob joe mike dave max marion leland guy rob);

my @files = map { "chapter.$_" } ( 1.. 10);

my $LOREM =<<END;
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla pariatur,
At vero eos et accusamus et iusto odio dignissimos ducimus, qui blanditiis praesentium voluptatum deleniti atque corrupti, os dolores et quas molestias excepturi sint, obcaecati cupiditate non provident, similique sunt in culpa, qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit, quo minus id, quod maxime placeat, facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat
END

my @IPSUM = split(/,/, $LOREM);

sub phrase { 
    return $IPSUM[ int rand $#IPSUM ];
}

my $prefix = "./book";
-d $prefix  || print qx{ mkdir -p $prefix };
my $branch = 'spam';

print qx{ git checkout $branch };

for (1..5) {
    my $f = $files[ int rand $#files ];
    my $n = $names[ int rand $#names ];
    my $p = phrase();
    $p =~ m@ (\w+) (\w+)@;
    my $path = "$prefix/$f";
    print qq! echo "...$p" >> $f && git commit -m "$n updates $f:  for $1" $path!, "\n";
}

print qx{ git push origin $branch }

