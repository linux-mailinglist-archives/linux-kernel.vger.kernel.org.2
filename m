Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31EA39C032
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFDTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFDTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:11:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563FC061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 12:09:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t28so8125176pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x4phZCArO57/nAHBH6wK0jiDVCCXPqfZUMSp8VW1kGI=;
        b=C1N49UpVttDNXICKYfIYXPqJwNltTwnwYS67CfT07A6nX/irUor4t4vzO11r7zOwDw
         LJrevynu25gP3Kqz4QgyCcgZNVYcGUZ/nlWXgKcIejBFlOvZ2AKRMLotHrx2sQuLWdgM
         Elhk09/CDFnA30qCdn239QIvptQuNkU7X+tIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4phZCArO57/nAHBH6wK0jiDVCCXPqfZUMSp8VW1kGI=;
        b=fWR3/UCzqGlbtB1OTj27C4ppgevnoXQL1gbg4+tVU/sI+l37PHDovhRoKtRuq9zA70
         Zcewev03zHlHWlgJzQQ6kiTQshD0UUxRlSXcDn72wInSRUY9yffeq3BKs3bZ9+XbOLhR
         4lgDnXGYfalVIOQXl6xwNgBjPVDki96W90l4fBx/smhGHLl0Y0b8hVcV75INE710NNRY
         KmhkuJggbtgTxuPVdEMytR8ukxETAr9ebhd7ZqX0OOllIGbJTXBd/ipfI7Uodv6o4RYm
         +0F6YZkhjUfxmIAfYye/xaXqLg3SkWmKJ1nG0s9q3aLusmrKIOYsCI0m4LFftfwMKIc+
         IdxQ==
X-Gm-Message-State: AOAM531y3JW+A4wNwZrQ6GhX96aZPOAj/Dk+ZeQV+Ur4AkZHCqqEff1r
        05wsRDVDDu5pnA3B406/wLzjpQ==
X-Google-Smtp-Source: ABdhPJwRf9nwsnQ7N8jGCuAZKvWEP3nUlkRvsJsl3AbIhIHsnx244dcrvPyT06IlS7s6qqcjAQRe2A==
X-Received: by 2002:a65:5684:: with SMTP id v4mr6241996pgs.218.1622833773609;
        Fri, 04 Jun 2021 12:09:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u20sm2309886pfn.192.2021.06.04.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:09:32 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:09:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Message-ID: <202106041207.AD4CE27@keescook>
References: <20210108121056.21940-1-sblbir@amazon.com>
 <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
 <202104081319.DAB1D817@keescook>
 <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
 <87tunsofan.ffs@nanos.tec.linutronix.de>
 <202104281307.F9FCF660@keescook>
 <YLn7FqKAWnmrEDZJ@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLn7FqKAWnmrEDZJ@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 08:06:14PM +1000, Balbir Singh wrote:
> On Wed, Apr 28, 2021 at 01:08:05PM -0700, Kees Cook wrote:
> > On Tue, Apr 27, 2021 at 12:24:16AM +0200, Thomas Gleixner wrote:
> > > On Mon, Apr 26 2021 at 10:31, Thomas Gleixner wrote:
> > > > On Thu, Apr 08 2021 at 13:23, Kees Cook wrote:
> > > >>
> > > >> I'd still really like to see this -- it's a big hammer, but that's the
> > > >> point for cases where some new flaw appears and we can point to the
> > > >> toolbox and say "you can mitigate it with this while you wait for new
> > > >> kernel/CPU."
> > > >>
> > > >> Any further thoughts from x86 maintainers? This seems like it addressed
> > > >> all of tglx's review comments.
> > > >
> > > > Sorry for dropping the ball on this. It's in my list of things to deal
> > > > with. Starting to look at it now.
> > > 
> > > So I went through the pile and for remorse I sat down and made the
> > > tweaks I think are necessary myself.
> > > 
> > > I've pushed out the result to
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush
> > 
> > Oh excellent; thank you for doing this!
> >
> 
> Thanks again Thomas!
> 
> I no longer have access to the bare metal hardware, but I was able to test
> this under qemu with some emulation changes. The changes worked as expected.
> 
> Folks on the list/cc, appreciate any tested-by or additional reviewed-by
> tags if you do happen to review/test.

I can't test the behavior (no access to CPU), but I wrote a simple prctl
tester. Perhaps this can be expanded on?


diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 333980375bc7..50c150d35962 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore
+			syscall_arg_fault fsgsbase_restore l1d_flush
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/l1d_flush.c b/tools/testing/selftests/x86/l1d_flush.c
new file mode 100644
index 000000000000..ef4e73679d58
--- /dev/null
+++ b/tools/testing/selftests/x86/l1d_flush.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * l1d_flush.c: Exercise the L1D flushing behaviors
+ */
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/prctl.h>
+
+#ifndef PR_SET_SPECULATION_CTRL
+# define PR_GET_SPECULATION_CTRL	52
+# define PR_SET_SPECULATION_CTRL	53
+#  define PR_SPEC_ENABLE		(1UL << 1)
+#  define PR_SPEC_DISABLE		(1UL << 2)
+#endif
+
+#ifndef PR_SPEC_L1D_FLUSH
+# define PR_SPEC_L1D_FLUSH		2
+#endif
+
+#include "../kselftest_harness.h"
+
+TEST(toggle)
+{
+	int ret;
+
+	ret = prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
+	ASSERT_GE(ret, 0) {
+		TH_LOG("PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH failed: %d (%s)", errno, strerror(errno));
+	}
+	EXPECT_EQ((ret & (PR_SPEC_DISABLE | PR_SPEC_ENABLE)), 0) {
+		TH_LOG("PR_SPEC_L1D_FLUSH is already enabled!?");
+	}
+
+	/* Enable */
+	ret = prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE, 0, 0);
+	EXPECT_EQ(ret, 0) {
+		if (errno == EPERM)
+			SKIP(return, "Kernel does not support PR_SPEC_L1D_FLUSH (boot with l1d_flush=on with a supported CPU)");
+		TH_LOG("PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE failed: %d (%s)", errno, strerror(errno));
+	}
+
+	/* Check Enable */
+	ret = prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
+	EXPECT_EQ((ret & (PR_SPEC_DISABLE | PR_SPEC_ENABLE)), PR_SPEC_ENABLE) {
+		TH_LOG("PR_SPEC_L1D_FLUSH did not stay enabled");
+	}
+
+	/* Disable */
+	ret = prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE, 0, 0);
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE failed: %d (%s)", errno, strerror(errno));
+	}
+
+	/* Check Disable */
+	ret = prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
+	EXPECT_EQ((ret & (PR_SPEC_DISABLE | PR_SPEC_ENABLE)), PR_SPEC_DISABLE) {
+		TH_LOG("PR_SPEC_L1D_FLUSH did not stay disabled");
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
Kees Cook
