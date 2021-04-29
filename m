Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F536E4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhD2Gi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Gi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:38:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA9C06138B;
        Wed, 28 Apr 2021 23:37:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lr7so15947424pjb.2;
        Wed, 28 Apr 2021 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWvEqPxo5quJ67cNZw5T846UEoXgYHse2SDYouWmS8g=;
        b=LWdylvemY/bsXptkS0JHBD0BVlJFgNs0PPHw4P/qWND/kR6wPAUbdV18IXjW5XhKsp
         hOzHjR84p80bl5mEw/zPm/Qn9fxD/rgykA4IPtEPlF44lY9piNtXpeOBpjkCmSAc+0Wr
         ZtHghNfZAFYJaAQckyhGbzbhU8VAwUPGdmAaIUWkZVIV7j7PZWzMu71UgF8D3CCUtYp1
         3wr4771nTPMMmxXcFYt35KOkamgnPXvxEhDJf6MrH7mW1rSQLryHY4wKa3XK7+8exbLR
         Ivo5zpji6TWEgDj8a2c824S8q4+nCYTPbLx/7ctxIMFt3WvdUk/j/AeEFflvPF+U2IUf
         0lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWvEqPxo5quJ67cNZw5T846UEoXgYHse2SDYouWmS8g=;
        b=gl++Bhw8se2b6YbC+qslaZQt4gTHKwXi1ehXeJP4QHQeF+v6D+Vdnc+6TEC7vJKlWl
         J8k3IZS3XabT3suqL/4cAjeKpEMOMgqAdSIAf/eGF5+s4qBRyni1DOrp0urX1e0I1uys
         q3CmDFsXgmtmF6FeQYmiAha665CvqrN3L6/35SD5ZuFJZjdLKAAaXkHnWMeKgUM/xzqw
         kRMdEuGKhoc/UDO4vAUDXF7Wbhk1GlvXvB+khRgtiyFxjTht9lUDGKSAOzOE8fkWrsiQ
         7XXO/4auPD9/OKIJnbP4gWd/Ix0TzpW4fd4eekxbgZKweY+CKPZM2+nkdGkOiRxW8Wwm
         Ukfw==
X-Gm-Message-State: AOAM531Xn064/hhE7y4v5GS4t+lp0swdLmv7dp45mANSqJ7GWrkHNF5k
        a0Rkjbgaky7dTlJv+e0X4fbJ9R7/WC8xeQ==
X-Google-Smtp-Source: ABdhPJymbtsAxpkU843VHh5l1oAGwRNO6wiPW751bAvcs1M+W79Lh8KKrxAVE67pHGkWA1bS9yu/Wg==
X-Received: by 2002:a17:90b:3b43:: with SMTP id ot3mr36306030pjb.100.1619678259362;
        Wed, 28 Apr 2021 23:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:292c:376:689b:476d])
        by smtp.googlemail.com with ESMTPSA id o9sm1573331pfh.217.2021.04.28.23.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:37:38 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions into variables
Date:   Thu, 29 Apr 2021 12:07:29 +0530
Message-Id: <20210429063729.8144-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427165633.GA235567@casper.infradead.org>
References: <20210427165633.GA235567@casper.infradead.org>
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
Changes in v3:
- Remove variables for separate qualifiers in "sub dump_struct"
- Make a common variable for all the qualifiers
- Make $attribute global variable to use it at "sub check_sections" as well

Changes in v2:
- Rename $pointer_function to $function_pointer
- Combine elsif-block expressions at "sub dump_function" into lesser regex expressions
- Combine $prototype_end1,$prototype_end2 expressions into a common $prototype_end

 scripts/kernel-doc | 71 ++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2a85d34fdcd0..721005a02e64 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -406,6 +406,8 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
+my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
 
 my %parameterdescs;
 my %parameterdesc_start_lines;
@@ -694,7 +696,7 @@ sub output_function_man(%) {
 	    $post = ");";
 	}
 	$type = $args{'parametertypes'}{$parameter};
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$function_pointer/) {
 	    # pointer-to-function
 	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
 	} else {
@@ -974,7 +976,7 @@ sub output_function_rst(%) {
 	$count++;
 	$type = $args{'parametertypes'}{$parameter};
 
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$function_pointer/) {
 	    # pointer-to-function
 	    print $1 . $parameter . ") (" . $2 . ")";
 	} else {
@@ -1211,7 +1213,9 @@ sub dump_struct($$) {
     my $members;
     my $type = qr{struct|union};
     # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
-    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
+    my $qualifiers = qr{$attribute|__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned};
+    my $definition_body = qr{\{(.*)\}\s*$qualifiers*};
+    my $struct_members = qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};
 
     if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
 	$decl_type = $1;
@@ -1235,27 +1239,27 @@ sub dump_struct($$) {
 	# strip comments:
 	$members =~ s/\/\*.*?\*\///gos;
 	# strip attributes
-	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
+	$members =~ s/\s*$attribute/ /gi;
 	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
 	$members =~ s/\s*__packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
 	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
 	$members =~ s/\s*____cacheline_aligned/ /gos;
 
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
@@ -1315,7 +1319,7 @@ sub dump_struct($$) {
 				}
 			}
 		}
-		$members =~ s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
+		$members =~ s/$struct_members/$newmember/;
 	}
 
 	# Ignore other nested elements, like enums
@@ -1555,8 +1559,9 @@ sub create_parameterlist($$$$) {
     my $param;
 
     # temporarily replace commas inside function pointer definition
-    while ($args =~ /(\([^\),]+),/) {
-	$args =~ s/(\([^\),]+),/$1#/g;
+    my $arg_expr = qr{\([^\),]+};
+    while ($args =~ /$arg_expr,/) {
+	$args =~ s/($arg_expr),/$1#/g;
     }
 
     foreach my $arg (split($splitter, $args)) {
@@ -1707,7 +1712,7 @@ sub check_sections($$$$$) {
 		foreach $px (0 .. $#prms) {
 			$prm_clean = $prms[$px];
 			$prm_clean =~ s/\[.*\]//;
-			$prm_clean =~ s/__attribute__\s*\(\([a-z,_\*\s\(\)]*\)\)//i;
+			$prm_clean =~ s/$attribute//i;
 			# ignore array size in a parameter string;
 			# however, the original param string may contain
 			# spaces, e.g.:  addr[6 + 2]
@@ -1808,8 +1813,14 @@ sub dump_function($$) {
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
@@ -1817,23 +1828,9 @@ sub dump_function($$) {
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
@@ -2110,12 +2107,12 @@ sub process_name($$) {
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
@@ -2125,8 +2122,8 @@ sub process_name($$) {
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

