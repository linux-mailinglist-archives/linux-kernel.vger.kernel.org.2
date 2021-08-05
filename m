Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823CF3E18A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbhHEPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242371AbhHEPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:49:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3690561155;
        Thu,  5 Aug 2021 15:49:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mBfcm-0037xX-94; Thu, 05 Aug 2021 11:49:36 -0400
Message-ID: <20210805154936.119679988@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Aug 2021 11:43:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [for-linus][PATCH 4/6] scripts/recordmcount.pl: Remove check_objcopy() and $can_use_local
References: <20210805154336.208362117@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

When building ARCH=riscv allmodconfig with llvm-objcopy, the objcopy
version warning from this script appears:

WARNING: could not find objcopy version or version is less than 2.17.
        Local function references are disabled.

The check_objcopy() function in scripts/recordmcount.pl is set up to
parse GNU objcopy's version string, not llvm-objcopy's, which triggers
the warning.

Commit 799c43415442 ("kbuild: thin archives make default for all archs")
made binutils 2.20 mandatory and commit ba64beb17493 ("kbuild: check the
minimum assembler version in Kconfig") enforces this at configuration
time so just remove check_objcopy() and $can_use_local instead, assuming
--globalize-symbol is always available.

llvm-objcopy has supported --globalize-symbol since LLVM 7.0.0 in 2018
and the minimum version for building the kernel with LLVM is 10.0.1 so
there is no issue introduced:

Link: https://github.com/llvm/llvm-project/commit/ee5be798dae30d5f9414b01f76ff807edbc881aa
Link: https://lkml.kernel.org/r/20210802210307.3202472-1-nathan@kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile                |  1 -
 scripts/recordmcount.pl | 40 ----------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/Makefile b/Makefile
index e4f5895badb5..d6915f361aa4 100644
--- a/Makefile
+++ b/Makefile
@@ -546,7 +546,6 @@ export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
 PHONY += scripts_basic
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
-	$(Q)rm -f .tmp_quiet_recordmcount
 
 PHONY += outputmakefile
 ifdef building_out_of_srctree
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index c17e48020ec3..8f6b13ae46bf 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -173,39 +173,6 @@ my $mcount_regex;	# Find the call site to mcount (return offset)
 my $mcount_adjust;	# Address adjustment to mcount offset
 my $alignment;		# The .align value to use for $mcount_section
 my $section_type;	# Section header plus possible alignment command
-my $can_use_local = 0; 	# If we can use local function references
-
-# Shut up recordmcount if user has older objcopy
-my $quiet_recordmcount = ".tmp_quiet_recordmcount";
-my $print_warning = 1;
-$print_warning = 0 if ( -f $quiet_recordmcount);
-
-##
-# check_objcopy - whether objcopy supports --globalize-symbols
-#
-#  --globalize-symbols came out in 2.17, we must test the version
-#  of objcopy, and if it is less than 2.17, then we can not
-#  record local functions.
-sub check_objcopy
-{
-    open (IN, "$objcopy --version |") or die "error running $objcopy";
-    while (<IN>) {
-	if (/objcopy.*\s(\d+)\.(\d+)/) {
-	    $can_use_local = 1 if ($1 > 2 || ($1 == 2 && $2 >= 17));
-	    last;
-	}
-    }
-    close (IN);
-
-    if (!$can_use_local && $print_warning) {
-	print STDERR "WARNING: could not find objcopy version or version " .
-	    "is less than 2.17.\n" .
-	    "\tLocal function references are disabled.\n";
-	open (QUIET, ">$quiet_recordmcount");
-	printf QUIET "Disables the warning from recordmcount.pl\n";
-	close QUIET;
-    }
-}
 
 if ($arch =~ /(x86(_64)?)|(i386)/) {
     if ($bits == 64) {
@@ -434,8 +401,6 @@ if ($filename =~ m,^(.*)(\.\S),) {
 my $mcount_s = $dirname . "/.tmp_mc_" . $prefix . ".s";
 my $mcount_o = $dirname . "/.tmp_mc_" . $prefix . ".o";
 
-check_objcopy();
-
 #
 # Step 1: find all the local (static functions) and weak symbols.
 #         't' is local, 'w/W' is weak
@@ -473,11 +438,6 @@ sub update_funcs
 
     # is this function static? If so, note this fact.
     if (defined $locals{$ref_func}) {
-
-	# only use locals if objcopy supports globalize-symbols
-	if (!$can_use_local) {
-	    return;
-	}
 	$convert{$ref_func} = 1;
     }
 
-- 
2.30.2
