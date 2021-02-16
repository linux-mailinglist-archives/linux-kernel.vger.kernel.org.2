Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5C31C538
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 03:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBPCBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 21:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBPCBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 21:01:40 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4735C60238;
        Tue, 16 Feb 2021 02:00:59 +0000 (UTC)
Date:   Mon, 15 Feb 2021 21:00:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without
 size
Message-ID: <20210215210057.4ceb6339@oasis.local.home>
In-Reply-To: <20210215200639.67141685@oasis.local.home>
References: <20210215164446.530f6311@gandalf.local.home>
        <20210216000504.axm3k4xho47c6drz@treble>
        <20210215200639.67141685@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/bXGQGfX8vm3N8i=A7vGCG6X"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/bXGQGfX8vm3N8i=A7vGCG6X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 15 Feb 2021 20:06:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Strange, that when I applied this to the latest kernel on a my build
> system (binutils 2.35), it still created all the necessary mcount
> locations??

I know why it worked. If you are using the latest gcc on the latest
mainline, it will not even bother with recordmcount, and will just
create the __mcount_loc sections, as latest gcc knows about ftrace.

(this is what I get for working on a company holiday)

Since this is a toolchain issue, perhaps the correct thing to do is to
backport to stable the changes to have it build with -mrecord-mcount if
the build system enables it.

If you are using the lastest compilers to build stable releases, and
that's causing issues, then you should have the stable releases use the
latest kernel compiler options.

Greg,

Can you test the following two backports. It does change the semantics
of what is built, but then again if you are using a newer compiler to
build stable kernels, that can change things too.

96f60dfa5819a ("trace: Use -mcount-record for dynamic ftrace")
07d0408120216 ("tracing: Avoid calling cc-option -mrecord-mcount for every Makefile")

I attached the backports to 4.4. (just compiled tested, I'll test them more tomorrow)

Thanks!

-- Steve

--MP_/bXGQGfX8vm3N8i=A7vGCG6X
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-trace-Use-mcount-record-for-dynamic-ftrace.patch

From f9a03bb58aa222824b3041efbf62488af693feaa Mon Sep 17 00:00:00 2001
From: Andi Kleen <ak@linux.intel.com>
Date: Mon, 27 Nov 2017 13:34:13 -0800
Subject: [PATCH 1/2] trace: Use -mcount-record for dynamic ftrace

gcc 5 supports a new -mcount-record option to generate ftrace
tables directly. This avoids the need to run record_mcount
manually.

Use this option when available.

So far doesn't use -mcount-nop, which also exists now.

This is needed to make ftrace work with LTO because the
normal record-mcount script doesn't run over the link
time output.

It should also improve build times slightly in the general
case.
Link: http://lkml.kernel.org/r/20171127213423.27218-12-andi@firstfloor.org

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/Makefile.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 42aef001dfdd..fff1452cb76e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -221,6 +221,11 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
+# gcc 5 supports generating the mcount tables directly
+ifneq ($(call cc-option,-mrecord-mcount,y),y)
+KBUILD_CFLAGS += -mrecord-mcount
+else
+# else do it all manually
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -250,6 +255,7 @@ cmd_record_mcount =						\
 		$(sub_cmd_record_mcount)			\
 	fi;
 endif
+endif
 
 define rule_cc_o_c
 	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
-- 
2.30.1


--MP_/bXGQGfX8vm3N8i=A7vGCG6X
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0002-tracing-Avoid-calling-cc-option-mrecord-mcount-for-e.patch

From 76a3bbb0b0b193ac4dcd3c005cc6abcaddaadfe6 Mon Sep 17 00:00:00 2001
From: Vasily Gorbik <gor@linux.ibm.com>
Date: Mon, 6 Aug 2018 15:17:44 +0200
Subject: [PATCH 2/2] tracing: Avoid calling cc-option -mrecord-mcount for
 every Makefile

Currently if CONFIG_FTRACE_MCOUNT_RECORD is enabled -mrecord-mcount
compiler flag support is tested for every Makefile.

Top 4 cc-option usages:
    511 -mrecord-mcount
     11  -fno-stack-protector
      9 -Wno-override-init
      2 -fsched-pressure

To address that move cc-option from scripts/Makefile.build to top Makefile
and export CC_USING_RECORD_MCOUNT to be used in original place.

While doing that also add -mrecord-mcount to CC_FLAGS_FTRACE (if gcc
actually supports it).

Link: http://lkml.kernel.org/r/patch-2.thread-aa7b8d.git-de935bace15a.your-ad-here.call-01533557518-ext-9465@work.hours

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile               | 7 +++++++
 scripts/Makefile.build | 7 ++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0057587d2cbe..9f2123555429 100644
--- a/Makefile
+++ b/Makefile
@@ -760,6 +760,13 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+  # gcc 5 supports generating the mcount tables directly
+  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
+    CC_FLAGS_FTRACE	+= -mrecord-mcount
+    export CC_USING_RECORD_MCOUNT := 1
+  endif
+endif
 export CC_FLAGS_FTRACE
 ifdef CONFIG_HAVE_FENTRY
 CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index fff1452cb76e..673ab54c0af6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -221,11 +221,8 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# gcc 5 supports generating the mcount tables directly
-ifneq ($(call cc-option,-mrecord-mcount,y),y)
-KBUILD_CFLAGS += -mrecord-mcount
-else
-# else do it all manually
+ifndef CC_USING_RECORD_MCOUNT
+# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
-- 
2.30.1


--MP_/bXGQGfX8vm3N8i=A7vGCG6X--
