Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A42428E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhJKNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237010AbhJKNfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2306B60F38;
        Mon, 11 Oct 2021 13:33:13 +0000 (UTC)
Date:   Mon, 11 Oct 2021 14:33:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: asm: vdso: gettimeofday: export common variables
Message-ID: <YWQ9FTJUMu9PMPpa@arm.com>
References: <20211007195754.678124-1-anders.roxell@linaro.org>
 <20211011100256.GA3681@willie-the-truck>
 <CAK8P3a0wf8_8YWmi8FRjmqUZej3ximgfxHgRZEOxsV-x3M5_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0wf8_8YWmi8FRjmqUZej3ximgfxHgRZEOxsV-x3M5_QQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 02:47:56PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 11, 2021 at 12:03 PM Will Deacon <will@kernel.org> wrote:
> > On Thu, Oct 07, 2021 at 09:57:54PM +0200, Anders Roxell wrote:
> > > When building the kernel with sparse enabled 'C=1' the following
> > > warnings can be seen:
> > >
> > > arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: symbol '__kernel_clock_gettime' was not declared. Should it be static?
> > > arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: symbol '__kernel_gettimeofday' was not declared. Should it be static?
> > > arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: symbol '__kernel_clock_getres' was not declared. Should it be static?
> > >
> > > Rework so the variables are exported, since these variables are
> > > created and used in vdso/vgettimeofday.c, also used in vdso.lds.S.
> >
> > Hmm, these functions are part of the vDSO and shouldn't be called from the
> > kernel, so I don't think it makes sense to add prototypes for them to a
> > kernel header, to be honest.
> 
> It's a recurring problem, and I have recommended this method to Anders as
> I don't see any of the alternatives as better.
> 
> The thing is that both sparse (with make C=1) and gcc/clang (with make W=1)
> warn about missing prototypes, and this catches a lot of real bugs. I hope
> that we can eventually get to the point of enabling the warning by default for
> all files, but that means we need a declaration for each global function and
> variable.

I don't think there's anything in the asm/vdso/gettimeofday.h that is
required by the kernel. However, it gets dragged in via the datapage.h.
If I got it right, something like this should avoid it and we can
include the prototypes:

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..a8d26d7d042d 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -121,22 +121,6 @@ struct vdso_data {
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 
-/*
- * The generic vDSO implementation requires that gettimeofday.h
- * provides:
- * - __arch_get_vdso_data(): to get the vdso datapage.
- * - __arch_get_hw_counter(): to get the hw counter based on the
- *   clock_mode.
- * - gettimeofday_fallback(): fallback for gettimeofday.
- * - clock_gettime_fallback(): fallback for clock_gettime.
- * - clock_getres_fallback(): fallback for clock_getres.
- */
-#ifdef ENABLE_COMPAT_VDSO
-#include <asm/vdso/compat_gettimeofday.h>
-#else
-#include <asm/vdso/gettimeofday.h>
-#endif /* ENABLE_COMPAT_VDSO */
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/gettimeofday.h b/include/vdso/gettimeofday.h
new file mode 100644
index 000000000000..0270da504fe3
--- /dev/null
+++ b/include/vdso/gettimeofday.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_vdso_data(): to get the vdso datapage.
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
+#include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 9a2af9fca45e..cb7a456323e3 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -6,6 +6,8 @@
 
 #include <vdso/datapage.h>
 
+#include <asm/barrier.h>
+
 static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ce2f69552003..8c1786ae59d8 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -3,6 +3,7 @@
  * Generic userspace implementations of gettimeofday() and similar.
  */
 #include <vdso/datapage.h>
+#include <vdso/gettimeofday.h>
 #include <vdso/helpers.h>
 
 #ifndef vdso_calc_delta

-- 
Catalin
