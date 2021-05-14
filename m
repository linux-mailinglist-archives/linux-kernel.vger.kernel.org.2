Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E132380C18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhENOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhENOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:44:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AEC061574;
        Fri, 14 May 2021 07:42:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h20so16271047plr.4;
        Fri, 14 May 2021 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5VAehxotQaf0MdoTRxk7ubGUjnGk0bi6i0xDUEnFP4=;
        b=kFHG4PXCxyny33W2C4oFm+BTiYhvafaZ4yX8gf7TpFDj2284LOMQVj2NawbrVoR4If
         Q49ps0EgsTxSk7Xzz/xWmoA5ZfSNTknEmpUhGCSBG5/KU6DIKYKv0Otisf40i2GGzt7u
         /m3e4VlMgdztfGQaUWE5l4Kd/UKlKt0U56whYVf59Vfkag25EqJrjXsb6814ALBhaGQY
         QGeuLyBTMd+S49bnimZ7oZOnB+U2Qsg+lY0Rq/6rw74Ul2ke/PbcVZVOooffGkJVxeqT
         qDyLNKejz2D4Qyjmb7wUegBU/ZvBQMuSlq5qHAmreNHXsx2LSPLYACKFfJXVl8Mkq8dP
         iEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5VAehxotQaf0MdoTRxk7ubGUjnGk0bi6i0xDUEnFP4=;
        b=UEurlcmqrgl6mqFAtvaBwc5lHS9xZtdb6fc8k2F30yhxvB99bkPB8O75YYQ455hRJu
         BUJf/1hFRiiuIHBOetXFeNhCAtWP2UUdLi0wTqo3B/ZQ3uI2/UVNm2IjqAICKbHBVZwY
         t0dxwefLEzwEf+eH4UgudK8Lcv9zDs2wsEjyELnxe4GLFlqwsMERL1SDwgnJt6GJZ8pQ
         FEFDantTzHrqRqxooVTipz7MuvsddAXVUrHGRH39uSIjOIAvS72sIXbsnf22XlholbkO
         hjVULzxYZIGF+CuLfeWnRa1GPSu7s68lOxy2b3Lgaqr9jOP6sdRE3mkPi0B19gSHnRrG
         42gw==
X-Gm-Message-State: AOAM531WoaGg5TMjOTFAqLOf9E6Xl0uwvSy5LVzCiguuFYO6WhYPTIWz
        /Dr1zQXGM5hYfgACUWbkGbaNDgXWfBIkPw==
X-Google-Smtp-Source: ABdhPJxUmG03i2gZWfUXZMPSl1l8h/jKrCOC8uD3eYBHapIX+GOhkm01EKvVSzD5ttZenZS2KE7hpA==
X-Received: by 2002:a17:90b:17cd:: with SMTP id me13mr11712751pjb.128.1621003374939;
        Fri, 14 May 2021 07:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:3d36:ea03:6cce:19ef])
        by smtp.googlemail.com with ESMTPSA id k186sm4354592pgk.82.2021.05.14.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:42:54 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v4] scripts: kernel-doc: reduce repeated regex expressions into variables
Date:   Fri, 14 May 2021 20:12:44 +0530
Message-Id: <20210514144244.25341-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87bl9ujy2r.fsf@meer.lwn.net>
References: <87bl9ujy2r.fsf@meer.lwn.net>
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
Changes in v4:
- Fix htmldocs warning at function parsing, involving repeated $type2 identifiers capture
- Re-tested against all files in kernel tree

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
index 4840e748fca8..7c4a6a507ac4 100755
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
@@ -1809,8 +1814,14 @@ sub dump_function($$) {
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
@@ -1818,23 +1829,9 @@ sub dump_function($$) {
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
+	$prototype =~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
@@ -2111,12 +2108,12 @@ sub process_name($$) {
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
@@ -2126,8 +2123,8 @@ sub process_name($$) {
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

