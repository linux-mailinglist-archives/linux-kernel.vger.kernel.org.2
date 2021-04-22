Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D88368712
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhDVTTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhDVTTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:19:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B30C06174A;
        Thu, 22 Apr 2021 12:18:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so8383186plg.11;
        Thu, 22 Apr 2021 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Za5n3a0YABSf07Khq0oVNO/kC0EVX6Kl40bV12WKk8=;
        b=d4XVUb+9XJDQHLYmpREVNXpjl4iZax1b5RAXppZ7XAO2V7pW4gbddcOvFdixE0ergO
         Olh5glGIwWBGUS9Ud3cDuXRZ6O6FZPIVViVpPjV5WABSqe7xCrCuRMz1sKjQX4BUdm4U
         ghNb265AlK6a229T2GMlSlm75a0pKttYM2ib32PVaYgZRdqB6aRt1qwGjg5A5CRKel4C
         aWr8p7F7P+HkJgt0QfihtxXketiu4gsWRIKSFfNENTNch7jTlgvYC/1EvOSI3GOM0+Y4
         Lr/fr6UCW5TZwZrmk/VABEgqQOC0ZYVaGtqXHQhVJVzWRt+itIOks6+eW4v9Zq1ZD2td
         Seng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Za5n3a0YABSf07Khq0oVNO/kC0EVX6Kl40bV12WKk8=;
        b=VPNCq+pfX4XaxlChtnLKasUd6GbHSmdF4+rmDAjBJ5AcLenk8q5Dv6pwD0yBhsT0KI
         sVCalWRnyHAtm3p7l/aNiOOI4mtrWPEKTacuzm1Ry0UTszNrEUCQaSH1MVfRWlSFGSSx
         Y2sroKY5qRC3aNWCKgIrkZ0Pb2rtGJ8GgJTbcJqABaxohXXmGD8moJ8K2blehieTBoIA
         fT7sWNGvnj23y2Pio4knS2iFWJDm1CXGmlIMekZ0F2GId+JgC6RIjhM4ZzT32FpL0TGz
         IG8kf2HOGrDoyz7Gc1hSkb3nYl9KNmicM9dsACd0sKZ1hI2KY+wKnJOn1dUeS4NGdwjW
         cMEQ==
X-Gm-Message-State: AOAM5310bicHvjKtHdvka3Q8Im1KmATWrNTYFo09UtSAdKv2XQqWnrZN
        zT2Qwa4SfBUGLxg7GSdn0wxcRBnr5fbtuA==
X-Google-Smtp-Source: ABdhPJx+GNvMPhj15qxg395ej+yjJHsEM25MarkleNyHuF3vfTq3EGOCl6/QUyLO1AiWHixRkucHxA==
X-Received: by 2002:a17:90b:1948:: with SMTP id nk8mr298832pjb.154.1619119127714;
        Thu, 22 Apr 2021 12:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:7d79:366e:c8a9:ca38])
        by smtp.googlemail.com with ESMTPSA id t19sm8228505pjs.1.2021.04.22.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:18:47 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     corbet@lwn.net
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] scripts: kernel-doc: reduce repeated regex expressions into variables
Date:   Fri, 23 Apr 2021 00:48:39 +0530
Message-Id: <20210422191839.6119-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 scripts/kernel-doc | 89 ++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2a85d34fdcd0..579c9fdd275f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -406,6 +406,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $pointer_function = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 
 my %parameterdescs;
 my %parameterdesc_start_lines;
@@ -694,7 +695,7 @@ sub output_function_man(%) {
 	    $post = ");";
 	}
 	$type = $args{'parametertypes'}{$parameter};
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$pointer_function/) {
 	    # pointer-to-function
 	    print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" . $post . "\"\n";
 	} else {
@@ -974,7 +975,7 @@ sub output_function_rst(%) {
 	$count++;
 	$type = $args{'parametertypes'}{$parameter};
 
-	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
+	if ($type =~ m/$pointer_function/) {
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
@@ -1808,8 +1816,11 @@ sub dump_function($$) {
     # - parport_register_device (function pointer parameters)
     # - atomic_set (macro)
     # - pci_match_device, __copy_to_user (long return type)
+    my $name = qr{[a-zA-Z0-9_~:]+};
+    my $prototype_end1 = qr{\(([^\(]*)\)};
+    my $prototype_end2 = qr{\(([^\{]*)\)};
 
-    if ($define && $prototype =~ m/^()([a-zA-Z0-9_~:]+)\s+/) {
+    if ($define && $prototype =~ m/^()($name)\s+/) {
         # This is an object-like macro, it has no return type and no parameter
         # list.
         # Function-like macros are not allowed to have spaces between
@@ -1817,23 +1828,23 @@ sub dump_function($$) {
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
+    } elsif ($prototype =~ m/^()($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+)\s+($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+\s+\w+)\s+($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
+	$prototype =~ m/^()($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+)\s+($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
+	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*($name)\s*$prototype_end2/)  {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
@@ -2110,12 +2121,12 @@ sub process_name($$) {
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
@@ -2125,8 +2136,8 @@ sub process_name($$) {
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

