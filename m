Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF46F36A140
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 14:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhDXMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhDXMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 08:48:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A222C061574;
        Sat, 24 Apr 2021 05:47:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s22so15914508pgk.6;
        Sat, 24 Apr 2021 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x46dloxAnBoN/LQXVFohrWguyCJk+h/VJA+1Fx1UBm0=;
        b=rsF8W6/6yExOGiFNzk+xtp+EX+XcbOEmHJChKMWFhKjfQwZz5u4zqlUSMIhH3NU6ul
         Lz3FH6gA3UM07D3CqVSuizq0W/PNJ0Pa0Ve/HiXpsSbni7D9J2NyREpVKPpZzRIOVp8F
         wZ/GajJhiVKrqTOqgCe267xdrk52AZHagEFlilTO7M89dNohHOzM7rKDPzNtn1FS28Df
         LWyBlb7OylGgEfEBhTJqv13a843dN4yAwbrjSPMGXjdu+ayqsqUJVpomCDee/U4KuIzA
         GYWEwAJ/Xm89/HwIRsy/QT244RQon+QiBjYAcXsrnLmiTMwHAfanuzOy1cde4552K5Ge
         aKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x46dloxAnBoN/LQXVFohrWguyCJk+h/VJA+1Fx1UBm0=;
        b=ClYrP/H8PbcJ/2bBto4g0t9nQmfVq0eamEFwBeRn5Y35g+lbroAN945QM+T62NTauF
         tU8Gq6dKZKx/UwEx+LlaTtjMK2zdBWLnzliDZU2XtAWSHo+P211uUl5ho/ow9qgzbOQU
         05vOYNjMLNf2r21hptllgmOjZxnWTBzNLE0R1TTfRw83tE1hOhoCZ9RLOeOAs8Odlp+7
         JlZ6Q8u0qanN5xqu2UAvlbpDyOJCRVUEGsarA+u0TRKxeEW9hbqacSB292YYs0K/KHsy
         9jM/MWeKcoPWH4Mi1aYJ/STJ+wKHWdluxP7pYX06dmWk+29FzAoVSQkj1OHQVHlxfDVL
         tBIg==
X-Gm-Message-State: AOAM530LR3mVUkK0GsB+shxfBAuSDb1MlVTWueQHrMTPVlUyMrnd2Dsd
        swQXg01+Wo97rGlYx1iVZ8A=
X-Google-Smtp-Source: ABdhPJyLxRm9mdrRXhmO7a6S9tSCRyd3KwhYQ9aKDB8ToyrQHPUWclyeXzCGZ+GUofNEGq7rZaxPwg==
X-Received: by 2002:aa7:80d6:0:b029:258:9404:13e with SMTP id a22-20020aa780d60000b02902589404013emr8491677pfn.37.1619268460766;
        Sat, 24 Apr 2021 05:47:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:2cc5:55e8:20f9:7536])
        by smtp.googlemail.com with ESMTPSA id i131sm7138677pgc.20.2021.04.24.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 05:47:40 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2] scripts: kernel-doc: reduce repeated regex expressions into variables
Date:   Sat, 24 Apr 2021 18:17:31 +0530
Message-Id: <20210424124731.29905-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
References: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some regex expressions in the kernel-doc script, which are used
repeatedly in the script.

Reduce such expressions into variables, which can be used everywhere.

A quick manual check found that no errors and warnings were added/removed
in this process.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
- Rename $pointer_function to $function_pointer
- Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
- Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end

 scripts/kernel-doc | 80 +++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2a85d34fdcd0..fe7f51be44e0 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -406,6 +406,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 
 my %parameterdescs;
 my %parameterdesc_start_lines;
@@ -694,7 +695,7 @@ sub output_function_man(%) {
 	    $post = ");";
 	}
 	$type = $args{'parametertypes'}{$parameter};
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$function_pointer/) {
 	    # pointer-to-function
 	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
 	} else {
@@ -974,7 +975,7 @@ sub output_function_rst(%) {
 	$count++;
 	$type = $args{'parametertypes'}{$parameter};
 
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$function_pointer/) {
 	    # pointer-to-function
 	    print $1 . $parameter . ") (" . $2 . ")";
 	} else {
@@ -1210,8 +1211,14 @@ sub dump_struct($$) {
     my $decl_type;
     my $members;
     my $type = qr{struct|union};
+    my $packed = qr{__packed};
+    my $aligned = qr{__aligned};
+    my $cacheline_aligned_in_smp = qr{____cacheline_aligned_in_smp};
+    my $cacheline_aligned = qr{____cacheline_aligned};
+    my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
     # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
-    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
+    my $definition_body = qr{\{(.*)\}(?:\s*(?:$packed|$aligned|$cacheline_aligned_in_smp|$cacheline_aligned|$attribute))*};
+    my $struct_members = qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};
 
     if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
 	$decl_type = $1;
@@ -1235,27 +1242,27 @@ sub dump_struct($$) {
 	# strip comments:
 	$members =~ s/\/\*.*?\*\///gos;
 	# strip attributes
-	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
-	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
-	$members =~ s/\s*__packed\s*/ /gos;
+	$members =~ s/\s*$attribute/ /gi;
+	$members =~ s/\s*$aligned\s*\([^;]*\)/ /gos;
+	$members =~ s/\s*$packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
-	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
-	$members =~ s/\s*____cacheline_aligned/ /gos;
+	$members =~ s/\s*$cacheline_aligned_in_smp/ /gos;
+	$members =~ s/\s*$cacheline_aligned/ /gos;
 
+	my $args = qr{([^,)]+)};
 	# replace DECLARE_BITMAP
 	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
-	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
+	$members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
 	# replace DECLARE_HASHTABLE
-	$members =~ s/DECLARE_HASHTABLE\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
+	$members =~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned long $1\[1 << (($2) - 1)\]/gos;
 	# replace DECLARE_KFIFO
-	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
+	$members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2 \*$1/gos;
 	# replace DECLARE_KFIFO_PTR
-	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
-
+	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
-	while ($members =~ m/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/) {
+	while ($members =~ m/$struct_members/) {
 		my $newmember;
 		my $maintype = $1;
 		my $ids = $4;
@@ -1315,7 +1322,7 @@ sub dump_struct($$) {
 				}
 			}
 		}
-		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
+		$members =~ s/$struct_members/$newmember/;
 	}
 
 	# Ignore other nested elements, like enums
@@ -1555,8 +1562,9 @@ sub create_parameterlist($$$$) {
     my $param;
 
     # temporarily replace commas inside function pointer definition
-    while ($args =~ /(\([^\),]+),/) {
-	$args =~ s/(\([^\),]+),/$1#/g;
+    my $arg_expr = qr{\([^\),]+};
+    while ($args =~ /$arg_expr,/) {
+	$args =~ s/($arg_expr),/$1#/g;
     }
 
     foreach my $arg (split($splitter, $args)) {
@@ -1808,8 +1816,14 @@ sub dump_function($$) {
     # - parport_register_device (function pointer parameters)
     # - atomic_set (macro)
     # - pci_match_device, __copy_to_user (long return type)
-
-    if ($define && $prototype =~ m/^()([a-zA-Z0-9_~:]+)\s+/) {
+    my $name = qr{[a-zA-Z0-9_~:]+};
+    my $prototype_end1 = qr{[^\(]*};
+    my $prototype_end2 = qr{[^\{]*};
+    my $prototype_end = qr{\(($prototype_end1|$prototype_end2)\)};
+    my $type1 = qr{[\w\s]+};
+    my $type2 = qr{$type1\*+};
+
+    if ($define && $prototype =~ m/^()($name)\s+/) {
         # This is an object-like macro, it has no return type and no parameter
         # list.
         # Function-like macros are not allowed to have spaces between
@@ -1817,23 +1831,9 @@ sub dump_function($$) {
         $return_type = $1;
         $declaration_name = $2;
         $noret = 1;
-    } elsif ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
-	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
+    } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
+	$prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
+	$prototype =~ m/^($type2)+\s*($name)\s*$prototype_end/)  {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
@@ -2110,12 +2110,12 @@ sub process_name($$) {
     } elsif (/$doc_decl/o) {
 	$identifier = $1;
 	my $is_kernel_comment = 0;
-	my $decl_start = qr{\s*\*};
+	my $decl_start = qr{$doc_com};
 	# test for pointer declaration type, foo * bar() - desc
 	my $fn_type = qr{\w+\s*\*\s*}; 
 	my $parenthesis = qr{\(\w*\)};
 	my $decl_end = qr{[-:].*};
-	if (/^$decl_start\s*([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
+	if (/^$decl_start([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
 	    $identifier = $1;
 	}
 	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
@@ -2125,8 +2125,8 @@ sub process_name($$) {
 	}
 	# Look for foo() or static void foo() - description; or misspelt
 	# identifier
-	elsif (/^$decl_start\s*$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||
-	    /^$decl_start\s*$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {
+	elsif (/^$decl_start$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||
+	    /^$decl_start$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {
 	    $identifier = $1;
 	    $decl_type = 'function';
 	    $identifier =~ s/^define\s+//;
-- 
2.17.1

