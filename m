Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02A34B15D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFB7619D3;
        Fri, 26 Mar 2021 21:29:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1F-002DQO-Qa; Fri, 26 Mar 2021 17:29:25 -0400
Message-ID: <20210326212925.677385073@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "John (Warthog9) Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 1/6] scripts/recordmcount.pl: Make indent spacing consistent
References: <20210326212848.385566448@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Emacs by default will have perl files have 4 space indents, where 8 spaces
are represented with a single tab. There are some places in
recordmcount.pl that has 8 spaces where a tab should be used. Replace them
to make the file consistent.

No functional changes.

Cc: "John (Warthog9) Hawley" <warthog9@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.pl | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 867860ea57da..5652da5e345e 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -266,9 +266,9 @@ if ($arch eq "x86_64") {
     # force flags for this arch
     $ld .= " -m shlelf_linux";
     if ($endian eq "big") {
-        $objcopy .= " -O elf32-shbig-linux";
+	$objcopy .= " -O elf32-shbig-linux";
     } else {
-        $objcopy .= " -O elf32-sh-linux";
+	$objcopy .= " -O elf32-sh-linux";
     }
 
 } elsif ($arch eq "powerpc") {
@@ -289,12 +289,12 @@ if ($arch eq "x86_64") {
 	    $ldemulation = "lppc"
     }
     if ($bits == 64) {
-        $type = ".quad";
-        $cc .= " -m64 ";
-        $ld .= " -m elf64".$ldemulation." ";
+	$type = ".quad";
+	$cc .= " -m64 ";
+	$ld .= " -m elf64".$ldemulation." ";
     } else {
-        $cc .= " -m32 ";
-        $ld .= " -m elf32".$ldemulation." ";
+	$cc .= " -m32 ";
+	$ld .= " -m elf32".$ldemulation." ";
     }
 
 } elsif ($arch eq "arm") {
@@ -313,7 +313,7 @@ if ($arch eq "x86_64") {
     $type = "data8";
 
     if ($is_module eq "0") {
-        $cc .= " -mconstant-gp";
+	$cc .= " -mconstant-gp";
     }
 } elsif ($arch eq "sparc64") {
     # In the objdump output there are giblets like:
@@ -530,10 +530,10 @@ while (<IN>) {
 	$read_function = defined($text_sections{$1});
 	if (!$read_function) {
 	    foreach my $prefix (keys %text_section_prefixes) {
-	        if (substr($1, 0, length $prefix) eq $prefix) {
-	            $read_function = 1;
-	            last;
-	        }
+		if (substr($1, 0, length $prefix) eq $prefix) {
+		    $read_function = 1;
+		    last;
+		}
 	    }
 	}
 	# print out any recorded offsets
-- 
2.30.1


