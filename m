Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FEC4246B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhJFTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:34:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhJFTef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:34:35 -0400
Received: from zn.tnic (p200300ec2f0d36003dde9a53b36f1ff2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:3dde:9a53:b36f:1ff2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AA8C1EC0409;
        Wed,  6 Oct 2021 21:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633548762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sy4WTY2NLRXQm2Nup8BPLSSFgX15mIq3h1FN9sZbFd0=;
        b=I1k1hpqhGNKjHStuR7EfXqYlP8rRtm3P47neiuhEosVO+7H73fbwRusx/sXBsqtDOwabC5
        oES1k4Zc3BRn9zC+eO/Zhn2/0BWs/baLRrRbupoH1DMhgMVupggIUAJYoRH8o7CEZVd2tA
        8PdyjhdbUkV+jCOOkM1Gt75ffgj7Wvg=
Date:   Wed, 6 Oct 2021 21:32:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <YV351s3Fyhnmen9g@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
 <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
 <CADnq5_M2y1tUAcUPNOrmB=pHfBGtnqMtTrw24ZC45202hg-kYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_M2y1tUAcUPNOrmB=pHfBGtnqMtTrw24ZC45202hg-kYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:21:40PM -0400, Alex Deucher wrote:
> And just another general comment, swiotlb + bounce buffers isn't
> really useful on GPUs.  You may have 10-100s of MBs of memory mapped
> long term into the GPU's address space for random access.  E.g., you
> may have buffers in system memory that the display hardware is
> actively scanning out of.  For GPUs you should really only enable SME
> if IOMMU is enabled in remapping mode.  But that is probably beyond
> the discussion here.

Right, but insights into how these things work (or don't work) together
are always welcome. And yes, as 2cc13bb4f59f says:

    "... The bounce buffer
    code has an upper limit of 256kb for the size of DMA
    allocations, which is too small for certain devices and
    causes them to fail."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
