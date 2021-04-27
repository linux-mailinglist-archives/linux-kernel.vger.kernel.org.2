Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9A36C8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhD0P4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhD0P4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:56:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46705C061574;
        Tue, 27 Apr 2021 08:55:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C23512C8;
        Tue, 27 Apr 2021 15:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C23512C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619538935; bh=o0JR5xJhMHegHhsx1/RCkGISK0OfDmkdQm+nmJlYYiU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i0qZkdCkut82stVUYAQuy+zbaQU5wGaL9a4PWRuFz2DC0IMgpL3ae6v4jCjMPA1oY
         3Pu8nJVcb/Kr/vcVIaU1WvbrkpYDOGll+aL4RqyBpO8HdBOfaLgdv4jOceSgYfJC5o
         wf54MEB2dfteHtyol9sgXOGBnE0ekpfsLNZGFT7eX/goaLAfMvF8T6DjVqnb9jiNn0
         hEMrnQ/pxnwK1pKg000wcFhAUQ6Umzhd8yIlIBW8Fow6H1zm0D8NanemaLZSzUAgtx
         rwVKW+GEIKjvLj1w5mZfG4SWjrx1sjnXUdHl9zRVoe1tvCMpfMq5aP9iKF6DLyeEwl
         VZM6lhDxjS8Cg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] scripts: kernel-doc: reduce repeated regex expressions
 into variables
In-Reply-To: <20210424124731.29905-1-yashsri421@gmail.com>
References: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
 <20210424124731.29905-1-yashsri421@gmail.com>
Date:   Tue, 27 Apr 2021 09:55:35 -0600
Message-ID: <87wnsnd8nc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> There are some regex expressions in the kernel-doc script, which are used
> repeatedly in the script.
>
> Reduce such expressions into variables, which can be used everywhere.
>
> A quick manual check found that no errors and warnings were added/removed
> in this process.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

So my comments pretty much mirror Willy's ...  there is a lot to really
like here mixed with some stuff that's not as helpful.

> Changes in v2:
> - Rename $pointer_function to $function_pointer
> - Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
> - Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end
>
>  scripts/kernel-doc | 80 +++++++++++++++++++++++-----------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2a85d34fdcd0..fe7f51be44e0 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -406,6 +406,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
>  my $doc_inline_end = '^\s*\*/\s*$';
>  my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
>  my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
> +my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
>  
>  my %parameterdescs;
>  my %parameterdesc_start_lines;
> @@ -694,7 +695,7 @@ sub output_function_man(%) {
>  	    $post = ");";
>  	}
>  	$type = $args{'parametertypes'}{$parameter};
> -	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
> +	if ($type =~ m/$function_pointer/) {

This kind of change is wonderful.  The more that we can coalesce this
regex mess and reuse it throughout the script, the more maintainable it
will be.

>  	    # pointer-to-function
>  	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
>  	} else {
> @@ -974,7 +975,7 @@ sub output_function_rst(%) {
>  	$count++;
>  	$type = $args{'parametertypes'}{$parameter};
>  
> -	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
> +	if ($type =~ m/$function_pointer/) {
>  	    # pointer-to-function
>  	    print $1 . $parameter . ") (" . $2 . ")";
>  	} else {
> @@ -1210,8 +1211,14 @@ sub dump_struct($$) {
>      my $decl_type;
>      my $members;
>      my $type = qr{struct|union};
> +    my $packed = qr{__packed};
> +    my $aligned = qr{__aligned};
> +    my $cacheline_aligned_in_smp = qr{____cacheline_aligned_in_smp};
> +    my $cacheline_aligned = qr{____cacheline_aligned};
> +    my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
>      # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
> -    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
> +    my $definition_body = qr{\{(.*)\}(?:\s*(?:$packed|$aligned|$cacheline_aligned_in_smp|$cacheline_aligned|$attribute))*};
> +    my $struct_members = qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};

This is a bit less helpful - variables like $aligned don't do much for
us.  That can be seen just below:

>  
>      if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
>  	$decl_type = $1;
> @@ -1235,27 +1242,27 @@ sub dump_struct($$) {
>  	# strip comments:
>  	$members =~ s/\/\*.*?\*\///gos;
>  	# strip attributes
> -	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
> -	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
> -	$members =~ s/\s*__packed\s*/ /gos;
> +	$members =~ s/\s*$attribute/ /gi;
> +	$members =~ s/\s*$aligned\s*\([^;]*\)/ /gos;
> +	$members =~ s/\s*$packed\s*/ /gos;

The use of the variables here doesn't really make those expressions more
readable.  

>  	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
> -	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
> -	$members =~ s/\s*____cacheline_aligned/ /gos;
> +	$members =~ s/\s*$cacheline_aligned_in_smp/ /gos;
> +	$members =~ s/\s*$cacheline_aligned/ /gos;
>  
> +	my $args = qr{([^,)]+)};
>  	# replace DECLARE_BITMAP
>  	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
> -	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
> +	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;

Here too ... this is the kind of stuff that makes me glad that Colorado
is a legal-weed state, and the new version, while better, doesn't change
that basic fact.

>  	# replace DECLARE_HASHTABLE
> -	$members =~ s/DECLARE_HASHTABLE\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
> +	$members =~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
>  	# replace DECLARE_KFIFO
> -	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
> +	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
>  	# replace DECLARE_KFIFO_PTR
> -	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
> -
> +	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
>  	my $declaration = $members;
>  
>  	# Split nested struct/union elements as newer ones
> -	while ($members =~ m/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/) {
> +	while ($members =~ m/$struct_members/) {

...but this is great.

>  		my $newmember;
>  		my $maintype = $1;
>  		my $ids = $4;
> @@ -1315,7 +1322,7 @@ sub dump_struct($$) {
>  				}
>  			}
>  		}
> -		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
> +		$members =~ s/$struct_members/$newmember/;
>  	}
>  
>  	# Ignore other nested elements, like enums
> @@ -1555,8 +1562,9 @@ sub create_parameterlist($$$$) {
>      my $param;
>  
>      # temporarily replace commas inside function pointer definition
> -    while ($args =~ /(\([^\),]+),/) {
> -	$args =~ s/(\([^\),]+),/$1#/g;
> +    my $arg_expr = qr{\([^\),]+};
> +    while ($args =~ /$arg_expr,/) {
> +	$args =~ s/($arg_expr),/$1#/g;
>      }
>  
>      foreach my $arg (split($splitter, $args)) {
> @@ -1808,8 +1816,14 @@ sub dump_function($$) {
>      # - parport_register_device (function pointer parameters)
>      # - atomic_set (macro)
>      # - pci_match_device, __copy_to_user (long return type)
> -
> -    if ($define && $prototype =~ m/^()([a-zA-Z0-9_~:]+)\s+/) {
> +    my $name = qr{[a-zA-Z0-9_~:]+};
> +    my $prototype_end1 = qr{[^\(]*};
> +    my $prototype_end2 = qr{[^\{]*};
> +    my $prototype_end = qr{\(($prototype_end1|$prototype_end2)\)};
> +    my $type1 = qr{[\w\s]+};
> +    my $type2 = qr{$type1\*+};
> +
> +    if ($define && $prototype =~ m/^()($name)\s+/) {
>          # This is an object-like macro, it has no return type and no parameter
>          # list.
>          # Function-like macros are not allowed to have spaces between
> @@ -1817,23 +1831,9 @@ sub dump_function($$) {
>          $return_type = $1;
>          $declaration_name = $2;
>          $noret = 1;
> -    } elsif ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
> +    } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
> +	$prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
> +	$prototype =~ m/^($type2)+\s*($name)\s*$prototype_end/)  {

It's hard not to be happy about something like that - this is a definite
step toward clarifying this code.

I think I'll stop here; hopefully I've gotten my point across.  I really
like where this work is heading; focusing just a bit more on pulling the
regexes together and making the whole thing more readable would be
wonderful.

Thanks,

jon
