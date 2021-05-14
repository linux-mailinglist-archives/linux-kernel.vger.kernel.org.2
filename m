Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38068380C93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhENPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhENPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:12:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62CC061574;
        Fri, 14 May 2021 08:11:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so1780438pjb.2;
        Fri, 14 May 2021 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pcLdn48Dmzh4pJ/DDFKwuhkdMQ9PHDMczJ4nmzEd9Tk=;
        b=AVBSh8Ck75TCIvOWZOpauYQenv0shNXgO2EHTbaKy4ujxbyAS/x/8KUgurdmOuErYT
         m1PHjTFDX12xEvLZOGAO+ZObqp/3jE25BxMD8Cl4n55njrq95po6/W4Q5OpUIwIps/tu
         NL/zToKTr1NxMKQd0V/GD1G0fDjLVDtJoKqb82d1J2r9Gw4FC32H7tWyAU3A6M8vFnZw
         GqysU8IbtwZNnkKhon9ANT2iCJUoF1/+L24KuakPDgW7wcjW/o8Db9HndU8V7KBUD8SD
         Ynge5UvdKWxNUVEjVnWUttEivCVz46YKMbnx30BjxfMP+obVCLp9P/t9tFYVuqJ8rOqM
         2A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pcLdn48Dmzh4pJ/DDFKwuhkdMQ9PHDMczJ4nmzEd9Tk=;
        b=r+c9/mcT+H2v5/snZ9QtML3mv+A1qE/9xhRaLuiJ22iiwadJRRNPjvvPzJSiiOInPy
         Z1h10eimSOVX5Fw0blM7ZXm+/6mlX4Se/VWNZ1RYm9oIlHWkHrdrJmimrLAMVY7vTraQ
         FwpVPFi0JQiojXdPa3F1ysS7651fGvtLYmPS1IYbHvqJziVvifdFwiHQp++KoW05aEbu
         PXRjBqorw4YnxArjq6L5gZh1jbwvOz8VwE4R9fZQlizANAbNnOJ6BpvACKGAdTK//28r
         quChqaGna60QZ9jP6tA2VAgLYzfMoJmSb1VxWEQ7tKMWiK/b5WPFbozFvRNhLqmh/IGI
         66AQ==
X-Gm-Message-State: AOAM5316f17cKF0VUPH7mFnEH91vEthsne8mMOziNNWc2/f2I/5oVSoN
        zXiwVEbExnSMBsUxk2zQjuTM6CmTibTipQ==
X-Google-Smtp-Source: ABdhPJwu1U78KOz9u9HwqYVkrAdDD2+Mg/YkZc7akNwJtTCqBgEDo71FIVkTBbBjEb3eXz/jNb8aoQ==
X-Received: by 2002:a17:90a:fd95:: with SMTP id cx21mr11584495pjb.137.1621005065402;
        Fri, 14 May 2021 08:11:05 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a93f:3d36:ea03:6cce:19ef? ([2405:201:600d:a93f:3d36:ea03:6cce:19ef])
        by smtp.gmail.com with ESMTPSA id v15sm4642168pgc.57.2021.05.14.08.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:11:04 -0700 (PDT)
Subject: Re: [RFC v4] scripts: kernel-doc: reduce repeated regex expressions
 into variables
To:     corbet@lwn.net
Cc:     lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87bl9ujy2r.fsf@meer.lwn.net>
 <20210514144244.25341-1-yashsri421@gmail.com>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <366a8632-7a50-0d60-f93e-09acf5e164ef@gmail.com>
Date:   Fri, 14 May 2021 20:40:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514144244.25341-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/5/21 8:12 pm, Aditya Srivastava wrote:
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
> ---
> Changes in v4:
> - Fix htmldocs warning at function parsing, involving repeated $type2 identifiers capture
> - Re-tested against all files in kernel tree
> 
> Changes in v3:
> - Remove variables for separate qualifiers in "sub dump_struct"
> - Make a common variable for all the qualifiers
> - Make $attribute global variable to use it at "sub check_sections" as well
> 
> Changes in v2:
> - Rename $pointer_function to $function_pointer
> - Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
> - Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end
> 
>  scripts/kernel-doc | 71 ++++++++++++++++++++++------------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 4840e748fca8..7c4a6a507ac4 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -406,6 +406,8 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
>  my $doc_inline_end = '^\s*\*/\s*$';
>  my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
>  my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
> +my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
> +my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
>  
>  my %parameterdescs;
>  my %parameterdesc_start_lines;
> @@ -694,7 +696,7 @@ sub output_function_man(%) {
>  	    $post = ");";
>  	}
>  	$type = $args{'parametertypes'}{$parameter};
> -	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
> +	if ($type =~ m/$function_pointer/) {
>  	    # pointer-to-function
>  	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
>  	} else {
> @@ -974,7 +976,7 @@ sub output_function_rst(%) {
>  	$count++;
>  	$type = $args{'parametertypes'}{$parameter};
>  
> -	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
> +	if ($type =~ m/$function_pointer/) {
>  	    # pointer-to-function
>  	    print $1 . $parameter . ") (" . $2 . ")";
>  	} else {
> @@ -1211,7 +1213,9 @@ sub dump_struct($$) {
>      my $members;
>      my $type = qr{struct|union};
>      # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
> -    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
> +    my $qualifiers = qr{$attribute|__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned};
> +    my $definition_body = qr{\{(.*)\}\s*$qualifiers*};
> +    my $struct_members = qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};
>  
>      if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
>  	$decl_type = $1;
> @@ -1235,27 +1239,27 @@ sub dump_struct($$) {
>  	# strip comments:
>  	$members =~ s/\/\*.*?\*\///gos;
>  	# strip attributes
> -	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
> +	$members =~ s/\s*$attribute/ /gi;
>  	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
>  	$members =~ s/\s*__packed\s*/ /gos;
>  	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
>  	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
>  	$members =~ s/\s*____cacheline_aligned/ /gos;
>  
> +	my $args = qr{([^,)]+)};
>  	# replace DECLARE_BITMAP
>  	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
> -	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
> +	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
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
>  		my $newmember;
>  		my $maintype = $1;
>  		my $ids = $4;
> @@ -1315,7 +1319,7 @@ sub dump_struct($$) {
>  				}
>  			}
>  		}
> -		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
> +		$members =~ s/$struct_members/$newmember/;
>  	}
>  
>  	# Ignore other nested elements, like enums
> @@ -1555,8 +1559,9 @@ sub create_parameterlist($$$$) {
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
> @@ -1707,7 +1712,7 @@ sub check_sections($$$$$) {
>  		foreach $px (0 .. $#prms) {
>  			$prm_clean = $prms[$px];
>  			$prm_clean =~ s/\[.*\]//;
> -			$prm_clean =~ s/__attribute__\s*\(\([a-z,_\*\s\(\)]*\)\)//i;
> +			$prm_clean =~ s/$attribute//i;
>  			# ignore array size in a parameter string;
>  			# however, the original param string may contain
>  			# spaces, e.g.:  addr[6 + 2]
> @@ -1809,8 +1814,14 @@ sub dump_function($$) {
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
> @@ -1818,23 +1829,9 @@ sub dump_function($$) {
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
> +	$prototype =~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
>  	$return_type = $1;
>  	$declaration_name = $2;
>  	my $args = $3;
> @@ -2111,12 +2108,12 @@ sub process_name($$) {
>      } elsif (/$doc_decl/o) {
>  	$identifier = $1;
>  	my $is_kernel_comment = 0;
> -	my $decl_start = qr{\s*\*};
> +	my $decl_start = qr{$doc_com};
>  	# test for pointer declaration type, foo * bar() - desc
>  	my $fn_type = qr{\w+\s*\*\s*}; 
>  	my $parenthesis = qr{\(\w*\)};
>  	my $decl_end = qr{[-:].*};
> -	if (/^$decl_start\s*([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
> +	if (/^$decl_start([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
>  	    $identifier = $1;
>  	}
>  	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
> @@ -2126,8 +2123,8 @@ sub process_name($$) {
>  	}
>  	# Look for foo() or static void foo() - description; or misspelt
>  	# identifier
> -	elsif (/^$decl_start\s*$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||
> -	    /^$decl_start\s*$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {
> +	elsif (/^$decl_start$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||
> +	    /^$decl_start$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {
>  	    $identifier = $1;
>  	    $decl_type = 'function';
>  	    $identifier =~ s/^define\s+//;
> 

Hi Jonathan!
The warning you mentioned was not showing to me on running "make
htmldocs", for some reason.. As a result, I haven't been able to test
the patch for this warning.. However, I understood the reason for the
error.
It was in this line:
> +	$prototype =~ m/^($type2)+\s*($name)\s*$prototype_end/)  {

Here, $1 was taking only the last captured value, instead of all the
occurrences, as was desired by me.

Just for reference, these were the warnings which I was getting:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/htmldocs_msgs

Thanks
Aditya
