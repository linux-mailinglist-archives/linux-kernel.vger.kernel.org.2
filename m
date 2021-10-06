Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6126424522
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhJFRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:50:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50676 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhJFRu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:50:28 -0400
Received: from zn.tnic (p200300ec2f0d3600a30656d48e985313.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:a306:56d4:8e98:5313])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8775B1EC0409;
        Wed,  6 Oct 2021 19:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633542514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AH7GW7BVXadMmUJIL7JNrzcm40pgdLpO4jzeUfZvHYc=;
        b=k9mVp0hHYzbwJuprCXXwIuZKoSxra4LKmOvFeOghWJQv9stdPmfGqBbrrAq5RVOBS/dCoP
        3hIFwcnbDAneDYy4WI+LlD5cXhy65fAb/buUAhFYjV7D2pSCnViJSwQSiS4fTJmS23K+SB
        VkPjvIkkKd2AoceCzN54KIW8wNxJBMc=
Date:   Wed, 6 Oct 2021 19:48:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YV3hbK/uhChK5Pse@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

so I sat down and wrote something and tried to capture all the stuff we
so talked about that it is clear in the future why we did it.

Thoughts?

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 6 Oct 2021 19:34:55 +0200
Subject: [PATCH] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 automatically

This Kconfig option was added initially so that memory encryption is
enabled by default on machines which support it.

However, Raven-class GPUs, a.o., cannot handle DMA masks which are
shorter than the bit position of the encryption, aka C-bit. For that,
those devices need to have the IOMMU present.

If the IOMMU is disabled or in passthrough mode, though, the kernel
would switch to SWIOTLB bounce-buffering for those transfers.

In order to avoid that,

   2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")

disables the default IOMMU passthrough mode so that devices for which
the default 256K DMA is insufficient, can use the IOMMU instead.

However 2, there are cases where the IOMMU is disabled in the BIOS, etc,
think the usual hardware folk "oops, I dropped the ball there" cases.

Which means, it can happen that there are systems out there with devices
which need the IOMMU to function properly with SME enabled but the IOMMU
won't necessarily be enabled.

So in order for those devices to function, drop the "default y" for
the SME by default on option so that users who want to have SME, will
need to either enable it in their config or use "mem_encrypt=on" on the
kernel command line.

Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8055da49f1c0..6a336b1f3f28 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
 
 config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	default y
 	depends on AMD_MEM_ENCRYPT
 	help
 	  Say yes to have system memory encrypted by default if running on
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
