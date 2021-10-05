Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CEE42230A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJEKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:07:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEKHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:07:19 -0400
Received: from zn.tnic (p200300ec2f0d200055ee2d4b24a868fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2000:55ee:2d4b:24a8:68fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23C0B1EC01CE;
        Tue,  5 Oct 2021 12:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633428328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fl3NTy+7nyl8fbo+eYvlq63lYu5XDMffAVCQYpFvDvQ=;
        b=HeyzxtCdm6AqnINVMzpXNMKVbjxq0H8Hza7OHD7dVn1RmbF+XelY4qrh8fCLL7tBfH+b2y
        vuJECUJZ05x4pW5IbjPcvMsfDbIneBMxMhCJ30tRGrVoFoL6dwddT2YQbt9+uoJ0pduZqn
        QXEB2zpxMxTERimgdsCijW2rFZgOj10=
Date:   Tue, 5 Oct 2021 12:05:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ser Olmy <ser.olmy@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Subject: Re: [x86] Kernel v5.14 series panic on Celeron Mendocino CPU
Message-ID: <YVwjY9TX6XMxkM2f@zn.tnic>
References: <CPeoI7yf4421QpWLM-CbgeDR17BBmhlLoixeYI3mu2WbDkgrZItfgImOO6BZez7CXQXXO9liq-rmZzgRVB95TP5MN0xUA8-d7-fSQZdyIZE=@protonmail.com>
 <YVtA67jImg3KlBTw@zn.tnic>
 <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lxqAtqDf_kLUxIlvmYPvuKB36LOK-z_cVbS9OOl0MbjZKZEaCaEFmHCbSy5sWBer6f9V_WAPLxUuSNrDBvyzEeQOJXepkVUztPXAOhPZniQ=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 06:17:42PM +0000, Ser Olmy wrote:
> On Monday, October 4th, 2021 at 7:59 PM, Borislav Petkov <bp@alien8.de> wrote:
> >
> > I'm assuming your CPU cannot do 64-bit mode?
> 
> Correct, it's an old Socket 370 Celeron

Ok, thanks for the info.

On your next reply, can you please hit the "reply-to-all" button so that
I can get your reply and not have to go fish it out of the lkml flood? I
would've easily missed it if tglx didn't point me to it.

In any case, your CPU is too old for me to even find such a box and your
.config boots fine in qemu so I guess we'll have to debug it.

Can you apply the diff below on your 5.14.9 kernel, boot with it and
send full dmesg again?

Thx.

---
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 64e29927cc32..5c6c11f831ed 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -112,7 +112,11 @@ static void __init fpu__init_system_mxcsr(void)
 		if (mask == 0)
 			mask = 0x0000ffbf;
 	}
+
 	mxcsr_feature_mask &= mask;
+
+	pr_info("%s: mxcsr_feature_mask: 0x%x, mask: 0x%x\n",
+		__func__, mxcsr_feature_mask, mask);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 445c57c9c539..808a0ff85141 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -380,8 +380,11 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			return -EFAULT;
 
 		/* Reject invalid MXCSR values. */
-		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask)
+		if (fpu->state.fxsave.mxcsr & ~mxcsr_feature_mask) {
+			WARN_ONCE(1, "fpu->state.fxsave.mxcsr: 0x%x, mxcsr_feature_mask: 0x%x\n",
+				  fpu->state.fxsave.mxcsr, mxcsr_feature_mask);
 			return -EINVAL;
+		}
 
 		/* Enforce XFEATURE_MASK_FPSSE when XSAVE is enabled */
 		if (use_xsave())


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
