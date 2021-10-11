Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9710742941A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJKQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:05:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhJKQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:05:10 -0400
Received: from zn.tnic (p200300ec2f08bb0030636ca0dab1dbfc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:3063:6ca0:dab1:dbfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89FC81EC03CA;
        Mon, 11 Oct 2021 18:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633968187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xo81DUxTI79r4bZwrBo156JdbuucSEWl4rjAfXkYrPw=;
        b=jXbvDrA8iQpoe7DXvfBYZhvwCTU87omzg8Bld7rWiSSHH+3DkQXyPGhANN+axk4179afsg
        Hp3k36SZ0Ix4VzpM5yJTkDyr/3K1m6wTFLRGufuptvpP6plCtdveKd9wCMFO4duFWdE5Mx
        3Ka/xiEBNWs+uTb3ZHdYZZVJ1qs+wXY=
Date:   Mon, 11 Oct 2021 18:03:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH -v2] x86/Kconfig: Do not enable
 AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically
Message-ID: <YWRgN63FOrQGO8jS@zn.tnic>
References: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
 <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic>
 <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
 <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
 <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

here's v2, I've added "however" number 3 below which should summarize
Christian's note about coherent and concurrent use of memory by the GPU
and CPU, which obviously cannot work with bounce buffers.

I'll send it to Linus next week if there are no more complaints.

Thx.

---
From: Borislav Petkov <bp@suse.de>

This Kconfig option was added initially so that memory encryption is
enabled by default on machines which support it.

However, devices which have DMA masks that are less than the bit
position of the encryption bit, aka C-bit, require the use of an IOMMU
or the use of SWIOTLB.

If the IOMMU is disabled or in passthrough mode, the kernel would switch
to SWIOTLB bounce-buffering for those transfers.

In order to avoid that,

  2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")

disables the default IOMMU passthrough mode so that devices for which the
default 256K DMA is insufficient, can use the IOMMU instead.

However 2, there are cases where the IOMMU is disabled in the BIOS, etc.
(think the usual hardware folk "oops, I dropped the ball there" cases) or a
driver doesn't properly use the DMA APIs or a device has a firmware or
hardware bug, e.g.:

  ea68573d408f ("drm/amdgpu: Fail to load on RAVEN if SME is active")

However 3, in the above GPU use case, there are APIs like Vulkan and
some OpenGL/OpenCL extensions which are under the assumption that
user-allocated memory can be passed in to the kernel driver and both the
GPU and CPU can do coherent and concurrent access to the same memory.
That cannot work with SWIOTLB bounce buffers, of course.

So, in order for those devices to function, drop the "default y" for the
SME by default active option so that users who want to have SME enabled,
will need to either enable it in their config or use "mem_encrypt=on" on
the kernel command line.

 [ tlendacky: Generalize commit message. ]

Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bd70e8a39fbf..d9830e7e1060 100644
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
