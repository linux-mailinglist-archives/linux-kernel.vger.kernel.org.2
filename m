Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440AC39C7FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFEL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFEL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 07:58:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9983C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 04:56:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622894179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpWnmVHxbCFBJpIBNlJC2/Zez5OVesbD2d+9pLFUfeA=;
        b=w3RGEKZwACgnKOnrHcOQPnPj7jeDWoqRX4J1WvZ49oMIh+93gHf+l/UOlLUMt9oGWr4OCe
        FeNkq6QFW+YfiVedho7U/YHGH1ckUjSVV1npiEuDBoHRbzAxdCq+hEmUDnchABhZhaQ/+Z
        xMg7Ut+gzkz8C6DsQl+l6NmuqekMDsg4uQc+0h4YDvxzPLInY/SNLfdG92ToxJX9ORaf3x
        jGbHWx1NoYYu92DgMlCFyOF8JINTggHsr59nTyAbsSb2as5N31PdtkR4bKJ9c5bPzI0NtK
        ogOKAm4UDTkjx8Xf5qzqk+Wfx1KLXzllZxOSXcuLj3UWjUS/TdcpGJu/MhhbOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622894179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpWnmVHxbCFBJpIBNlJC2/Zez5OVesbD2d+9pLFUfeA=;
        b=48jHXOly+JQhOvTHkyc17UdGAfibBKd05gZuI6WI6XilWt4/zNY3hbmZQNnqT1cKGcWFhh
        U5GYJhMtmMtKN3BQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <87mts4zkac.ffs@nanos.tec.linutronix.de>
References: <20210602095543.149814064@linutronix.de> <433086cd-fadf-efe2-955b-0263a2fc969f@intel.com> <87mts4zkac.ffs@nanos.tec.linutronix.de>
Date:   Sat, 05 Jun 2021 13:56:19 +0200
Message-ID: <87k0n8zfrw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05 2021 at 12:18, Thomas Gleixner wrote:
> On Fri, Jun 04 2021 at 15:04, Dave Hansen wrote:
>> No bug is jumping out of the code as I took a brief look at it.  The
>> xbuf versus kbuf code looks a bit wonky, but I can't find a hole in it.
>
> I can....
>
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -128,7 +128,7 @@ int xstateregs_set(struct task_struct *t
>  		xbuf = vmalloc(count);
>  		if (!xbuf)
>  			return -ENOMEM;
> -		ret = user_regset_copyin(&pos, &count, NULL, &ubuf, xbuf, 0, -1);
> +		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xbuf, 0, -1);
>  		if (ret)
>  			goto out;
>  	}

But this whole user_regset_copyin() is pointless here. See below.

Thanks,

        tglx
---
 include/asm/fpu/xstate.h |    4 ----
 kernel/fpu/regset.c      |   40 ++++++++++++++++------------------------
 kernel/fpu/xstate.c      |   12 +++++++-----
 3 files changed, 23 insertions(+), 33 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -112,8 +112,4 @@ void copy_supervisor_to_kernel(struct xr
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
-
-/* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr);
-
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -6,6 +6,9 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
+
+#include <linux/vmalloc.h>
+
 #include <linux/sched/task_stack.h>
 
 /*
@@ -108,7 +111,7 @@ int xstateregs_set(struct task_struct *t
 		  const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
+	struct xregs_state *xbuf = NULL;
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
@@ -120,32 +123,21 @@ int xstateregs_set(struct task_struct *t
 	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
-	xsave = &fpu->state.xsave;
-
-	fpu__prepare_write(fpu);
-
-	if (using_compacted_format()) {
-		if (kbuf)
-			ret = copy_kernel_to_xstate(xsave, kbuf);
-		else
-			ret = copy_user_to_xstate(xsave, ubuf);
-	} else {
-		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
-		if (!ret)
-			ret = validate_user_xstate_header(&xsave->header);
+	if (!kbuf) {
+		xbuf = vmalloc(count);
+		if (!xbuf)
+			return -ENOMEM;
+		if (copy_from_user(xbuf, ubuf, count)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	xsave->i387.mxcsr &= mxcsr_feature_mask;
-
-	/*
-	 * In case of failure, mark all states as init:
-	 */
-	if (ret)
-		fpstate_init(&fpu->state);
+	fpu__prepare_write(fpu);
+	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ? kbuf : xbuf);
 
+out:
+	vfree(xbuf);
 	return ret;
 }
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -515,7 +515,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_user_xstate_header(const struct xstate_header *hdr)
+static int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & ~xfeatures_mask_user())
@@ -1172,14 +1172,16 @@ int copy_kernel_to_xstate(struct xregs_s
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
 
+	/* mxcsr reserved bits must be masked to zero for security reasons. */
+	xsave->i387.mxcsr &= mxcsr_feature_mask;
+
 	return 0;
 }
 
 /*
- * Convert from a ptrace or sigreturn standard-format user-space buffer to
- * kernel XSAVES format and copy to the target thread. This is called from
- * xstateregs_set(), as well as potentially from the sigreturn() and
- * rt_sigreturn() system calls.
+ * Convert from a sigreturn standard-format user-space buffer to kernel
+ * XSAVES format and copy to the target thread. This is called from the
+ * sigreturn() and rt_sigreturn() system calls.
  */
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 {
