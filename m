Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1B423F92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJFNsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:48:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7416C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 06:46:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d3600bd612f435519a27c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:bd61:2f43:5519:a27c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FD411EC04BF;
        Wed,  6 Oct 2021 15:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633528009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tzik7tIsVu7/8H5H0YintX63qe5jAGmz+E84DZeaw4M=;
        b=jvM/oQeKcdOqtzSg35cEv0v3qA9MCZhFpgxQF3Oic1X+xNi8zFUmT+ShQqL9eobf6PCi8f
        UgEtiYZm1Z72djtQUO4g0M9CBrrRvAdB3J412Db7gi9YVQFWoNpXOQeWrMhYQD4fsoBTLm
        82jp5sGBkCz2j/lVrk3ImlvqGyD1CIg=
Date:   Wed, 6 Oct 2021 15:46:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YV2oxBw4I4kizvhF@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 09:23:22AM -0400, Alex Deucher wrote:
> There could be some OEM systems that disable the IOMMU on the platform
> and don't provide a switch in the bios to enable it.  The GPU driver
> will still work in that case, it will just not be able to enable KFD
> support for ROCm compute.  SME won't work for most devices in that
> case however since most devices have a DMA mask too small to handle
> the C bit for encryption.  SME should be dependent on IOMMU being
> enabled.

Yeah, I'd let you hash this out with Tom.

> I'm not an SME expert, but I thought that that was already the case.

Yeah, I think Paul wants this:

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b79e88ee6627..e94c2df7a043 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,7 +1518,6 @@ config AMD_MEM_ENCRYPT
 
 config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	default y
 	depends on AMD_MEM_ENCRYPT
 	help
 	  Say yes to have system memory encrypted by default if running on

---

The reason we did this is so that you don't want to supply
mem_encrypt=on on the cmdline but didn't anticipate any such fun with
some devices.

> We just added the error condition in the GPU driver to prevent the
> driver from loading when the user forced SME on.  IIRC, there were
> users that cared more about SME than graphics support.

Well, it's a distro kernel so we should at least try to make everyone
happy. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
