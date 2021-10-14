Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FBE42E122
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhJNS0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhJNS0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:26:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFC261037;
        Thu, 14 Oct 2021 18:24:12 +0000 (UTC)
Date:   Thu, 14 Oct 2021 14:24:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zong Li <zong@andestech.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: nds32/ftrace: Fix Error: invalid operands (*UND* and *UND*
 sections) for `^'
Message-ID: <20211014142410.7601ebad@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I received a build failure for a new patch I'm working on the nds32
architecture, and when I went to test it, I couldn't get to my build error,
because it failed to build with a bunch of:

  Error: invalid operands (*UND* and *UND* sections) for `^'

issues with various files. Those files were temporary asm files that looked
like:  kernel/.tmp_mc_fork.s

I decided to look deeper, and found that the "mc" portion of that name
stood for "mcount", and was created by the recordmcount.pl script. One that
I wrote over a decade ago. Once I knew the source of the problem, I was
able to investigate it further.

The way the recordmcount.pl script works (BTW, there's a C version that
simply modifies the ELF object) is by doing an "objdump" on the object
file. Looks for all the calls to "mcount", and creates an offset of those
locations from some global variable it can use (usually a global function
name, found with <.*>:). Creates a asm file that is a table of references
to these locations, using the found variable/function. Compiles it and
links it back into the original object file. This asm file is called
".tmp_mc_<object_base_name>.s".

The problem here is that the objdump produced by the nds32 object file,
contains things that look like:

 0000159a <.L3^B1>:
    159a:       c6 00           beqz38 $r6, 159a <.L3^B1>
                        159a: R_NDS32_9_PCREL_RELA      .text+0x159e
    159c:       84 d2           movi55 $r6, #-14
    159e:       80 06           mov55 $r0, $r6
    15a0:       ec 3c           addi10.sp #0x3c
 

Where ".L3^B1 is somehow selected as the "global" variable to index off of.

Then the assembly file that holds the mcount locations looks like this:

        .section __mcount_loc,"a",@progbits
        .align 2
        .long .L3^B1 + -5522
        .long .L3^B1 + -5384
        .long .L3^B1 + -5270
        .long .L3^B1 + -5098
        .long .L3^B1 + -4970
        .long .L3^B1 + -4758
        .long .L3^B1 + -4122
        [...]

And when it is compiled back to an object to link to the original object,
the compile fails on the "^" symbol.

Simple solution for now, is to have the perl script ignore using function
symbols that have an "^" in the name.

Fixes: fbf58a52ac088 ("nds32/ftrace: Add RECORD_MCOUNT support")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 8f6b13ae46bf..7d631aaa0ae1 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -189,7 +189,7 @@ if ($arch =~ /(x86(_64)?)|(i386)/) {
 $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\S+)";
 $weak_regex = "^[0-9a-fA-F]+\\s+([wW])\\s+(\\S+)";
 $section_regex = "Disassembly of section\\s+(\\S+):";
-$function_regex = "^([0-9a-fA-F]+)\\s+<(.*?)>:";
+$function_regex = "^([0-9a-fA-F]+)\\s+<([^^]*?)>:";
 $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s(mcount|__fentry__)\$";
 $section_type = '@progbits';
 $mcount_adjust = 0;
