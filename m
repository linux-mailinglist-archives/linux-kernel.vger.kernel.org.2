Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFAE3B77CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhF2Sat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:30:49 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:54880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234140AbhF2Sar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:30:47 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 61EF818224D99;
        Tue, 29 Jun 2021 18:28:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 4A2BD1124F9;
        Tue, 29 Jun 2021 18:28:18 +0000 (UTC)
Message-ID: <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Jun 2021 11:28:16 -0700
In-Reply-To: <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-2-jim.cromie@gmail.com>
         <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
         <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
         <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Stat-Signature: k457dckdzaqjyfqu6t5a34aagc7ut1ue
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4A2BD1124F9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Tc4uxIqS2Y5tOlLXlQ7XG3hNh11y9RSE=
X-HE-Tag: 1624991298-758213
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-29 at 10:48 -0600, jim.cromie@gmail.com wrote:
> hi Joe,

hey Jim.

> > > This .lds.h test is also used in one other place.
> > > 
> > > It might be better to avoid all tests in .lds.h files by using a
> > > "next if" much earlier.
> 
> checkpatch: subtle decrufting
> 
> sub process() uses a next-if statement to end a block of tests early,
> because following tests pertain only to certain types of source files.
> That statement has some history:
> 
>  $ grep -P 'sub process|next if \(\$realfile' blame-check
>  0a920b5b666d0 (Andy Whitcroft      2007-06-01 00:46:48 -0700 2558) sub process {
>  d6430f71805aa (Joe Perches         2016-12-12 16:46:28 -0800 3621) next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
>  de4c924c26504 (Geert Uytterhoeven  2014-10-13 15:51:46 -0700 3712) next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);

Looks like I should have also removed the |pl from this block
when I removed it from commit d6430f71805aa. 

Oh well, no real harm done...

>  b9ea10d691ecb (Andy Whitcroft      2008-10-15 22:02:24 -0700 3973) next if ($realfile !~ /\.(h|c)$/);
> 
> Commit:b9ea adds the early-block-termination line, then 2 subsequent
> commits (de4c, d643) copy that line up/earlier in sub process (with
> different filetype selection), largely masking the purposes of the
> older/later lines (block-early-terminate to skip file-type specific
> tests).

Not really.

The first in file order next-if commit d6430f71805aa was a
modification of the earlier commits listed below:

5368df20fb364e
00df344fd06fd6
0a920b5b666d0b

All of these were just additions of various file types to the test.

> This code is hurting my brain.

Perhaps Advil or another leaded or unleaded beverage might help.
They help me...

> changing d643 to allow *.pl to fall thru for further testing
> is probably the best small move.

Definitely not as it's there specifically to avoid long line tests in perl.

> FWIW, one version of a 1-line fix for *.lds.h files.
> this one adds the new line after the 1st of the 3 blame-lines.
> Maybe it should be added after the SPDX check (which would complain)

Maybe a slight reworking of all the "next if" tests would work.

I moved the incorrect spdx line number test up, but didn't test
whether or not it's appropriate here as I don't know of a case
of the top of my head.  I also don't know if the linker .lds.h
files should be tested for long lines or not.

It looks like these files are mostly < 80 columns

$ git ls-files -- '*.lds.h'| xargs cat | awk '{print length($0), $0;}' | sort -rn | head
106 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
94 #if defined(CONFIG_GCOV_KERNEL) || defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN) || \
79 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
78  * [__init_begin, __init_end] is the init section that may be freed after init
78 #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
77  * .init section and thus will be preserved for later use in the decompressed
77 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
77  * <asm/module.lds.h> can specify arch-specific sections for linking modules.
76 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
76  * .boot.data variables are kept in separate .boot.data.<var name> sections,

---
 scripts/checkpatch.pl | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4a..ea198499e16df 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3617,9 +3617,6 @@ sub process {
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}
 
-# check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
-
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
 		    $rawline =~ /\bSPDX-License-Identifier:/ &&
@@ -3628,6 +3625,9 @@ sub process {
 			     "Misplaced SPDX-License-Identifier tag - use line $checklicenseline instead\n" . $herecurr);
 		}
 
+# check we are in a valid source file if not then ignore this hunk
+		next if ($realfile !~ /\.(?:h|c|s|S|sh|dtsi|dts)$/);
+
 # line length limit (with some exclusions)
 #
 # There are a few types of lines that may extend beyond $max_line_length:
@@ -3708,8 +3708,8 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
 		}
 
-# check we are in a valid source file C or perl if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
+# check we are in a valid source C or .dts? file, if not then ignore this hunk
+		next if ($realfile !~ /\.(?:h|c|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
 # more than $tabsize must use tabs.
@@ -3737,6 +3737,9 @@ sub process {
 			}
 		}
 
+# skip all following test for linker files.
+		next if ($realfile =~ /\.lds\.h$/);
+
 # check for assignments on the start of a line
 		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
 			my $operator = $1;
@@ -3970,7 +3973,7 @@ sub process {
 		}
 
 # check we are in a valid C source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c)$/);
+		next if ($realfile !~ /\.(?:h|c)$/);
 
 # check for unusual line ending [ or (
 		if ($line =~ /^\+.*([\[\(])\s*$/) {

