Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849E35A4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhDIRlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhDIRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:41:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE2C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:41:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0be10039b183a609a7c35d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:39b1:83a6:9a7:c35d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A84B01EC04DA;
        Fri,  9 Apr 2021 19:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617990094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pyfzScFhoNU/YXdAgkqc68I8PVKrgnnmXt76pCEEmyM=;
        b=sFXXnSZi2I42LUwLLS4g2xLRgeXsqJua14fk+3KS3XfjbtkWR2PUOSnG3wbTlELgTHdxgk
        fRoNhzUYf88z+NT5cR6641T+BaBZrNWQy8byo2nHu/jYrEIVtaLSTQe36Xk0FcibnV/8/B
        PqJJwSzRekaqcU+ojbksiVMsCLKhixo=
Date:   Fri, 9 Apr 2021 19:41:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
Message-ID: <20210409174134.GH15567@zn.tnic>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406155004.230790-2-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:50:00AM -0500, Ramakrishna Saripalli wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index cc96e26d69f7..21e7f8d0d7d9 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -201,7 +201,7 @@
>  #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
>  #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
>  #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
> -/* FREE!                                ( 7*32+10) */
> +#define X86_FEATURE_PSFD		( 7*32+10) /* Predictive Store Forward Disable */

You don't need this one...

>  #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
>  #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
>  #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
> @@ -309,6 +309,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_PSFD		(13*32+28) /* "" Predictive Store Forward Disable */

... when you have this one. And this one is AMD-specific so you can just
as well call it X86_FEATURE_PSFD and remove the "".

>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> @@ -428,5 +429,6 @@
>  #define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
>  #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
>  #define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
> +#define X86_BUG_PSF			X86_BUG(25) /* CPU is affected by Predictive Store Forwarding attack */

And I think you don't need this one either if we do a "light" controls
thing but lemme look at the rest first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
