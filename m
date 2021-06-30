Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8197F3B8776
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhF3RPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:15:16 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:55118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229814AbhF3RPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:15:15 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BD58C183B04AF;
        Wed, 30 Jun 2021 17:12:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 23072C417C;
        Wed, 30 Jun 2021 17:12:45 +0000 (UTC)
Message-ID: <3010b4d82ea746e5d0557837ceb16429cd7118ac.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Jun 2021 10:12:42 -0700
In-Reply-To: <CAJfuBxzBuGv95bOF1Pt-5KC+ToH5JXWHySG+72cViGbYXuBR=g@mail.gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-2-jim.cromie@gmail.com>
         <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
         <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
         <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
         <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
         <CAJfuBxyQ8OX8+A64SQPG4pXYKBDhyab7_-Dcc_C2_t-4oG9xng@mail.gmail.com>
         <cabb80f84ee0c11aaa548e8ebc87da72883c5a21.camel@perches.com>
         <CAJfuBxzBuGv95bOF1Pt-5KC+ToH5JXWHySG+72cViGbYXuBR=g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 23072C417C
X-Stat-Signature: z6bhy5w4fwfx784b6tap5ejjo1qrf36g
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/HgoMFBpuDoMhVqKYsnTUvBmDB0y3k7pQ=
X-HE-Tag: 1625073165-226559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-30 at 10:38 -0600, jim.cromie@gmail.com wrote:
> On Tue, Jun 29, 2021 at 2:01 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2021-06-29 at 13:50 -0600, jim.cromie@gmail.com wrote:
> > > this does 3 different things
> > > 
> > > - non-capturing matches  -  these add no functionality,
> > 
> > true, it's nominally a bit faster through.
> > 
> > > - moves the skip-remaining-tests check after SPDX
> > >    that feels like a legal Q: should it be on all files ?
> > >    moving it does seem proper though.
> > 
> > to me too.
> > 
> > > - adds the skip linker-script
> > >   since i went ahead and added it 3 times to see errs/warns
> > >   I didnt consider your precise placement,
> > >   how does it do with 18/8 errs/warnings on ref-test ?
> > 
> > $ ./scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --strict --terse
> 
> cool options.
> <Aside>
> some oddities are hidden there;
> Im seeing the err/warn counts change along with use of those options.
> not a big deal, but it is mildly surprising
> forex:
> $ scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse
> ...
> total: 18 errors, 7 warnings, 1164 lines checked
> $ scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse --strict
> ...
> total: 9 errors, 7 warnings, 95 checks, 1164 lines checked


The difference is a --strict test 'if ($check)' that precedes and
in effect 'overrides' the ERROR output for that output around line 5120.

$ ./scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse
[]
include/asm-generic/vmlinux.lds.h:101: ERROR: need consistent spacing around '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: ERROR: need consistent spacing around '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: ERROR: need consistent spacing around '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: ERROR: need consistent spacing around '*' (ctx:VxW)

vs:

$ ./scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse --strict
[]
include/asm-generic/vmlinux.lds.h:101: CHECK: spaces preferred around that '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: CHECK: spaces preferred around that '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: CHECK: spaces preferred around that '*' (ctx:VxW)
include/asm-generic/vmlinux.lds.h:101: CHECK: spaces preferred around that '*' (ctx:VxW)

> just to note, this is about a generalization of
> 
> commit 263afd39c06f5939ef943e0d535380d4b8e56484
> Author: Chris Down <chris@chrisdown.name>
> Date:   Thu Feb 25 17:22:04 2021 -0800
> 
>     checkpatch: don't warn about colon termination in linker scripts

Which means the additional test in that commit should be removed too.

Maybe:
---
 scripts/checkpatch.pl | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4a..f4f5826054214 100755
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
@@ -5147,7 +5150,7 @@ sub process {
 				# A colon needs no spaces before when it is
 				# terminating a case value or a label.
 				} elsif ($opv eq ':C' || $opv eq ':L') {
-					if ($ctx =~ /Wx./ and $realfile !~ m@.*\.lds\.h$@) {
+					if ($ctx =~ /Wx./) {
 						if (ERROR("SPACING",
 							  "space prohibited before that '$op' $at\n" . $hereptr)) {
 							$good = rtrim($fix_elements[$n]) . trim($fix_elements[$n + 1]);


