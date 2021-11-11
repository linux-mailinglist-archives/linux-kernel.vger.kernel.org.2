Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEAA44D6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhKKMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:39:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhKKMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:39:29 -0500
Received: from zn.tnic (p200300ec2f0fc200bb2554a44f8eb9ed.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:c200:bb25:54a4:4f8e:b9ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95A2A1EC0399;
        Thu, 11 Nov 2021 13:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636634199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H/0MVi3x6RtASXvCMkN/SPohFWxDyxla0lHKCUdltMk=;
        b=EfC5mG8wobT5ycxhZH/A/4+NsBVl5qU9jRyBIsxHRszZkMC5qX6u0VeZuSmVGdC0TNKLEP
        9AojBA3CwL3wXp/RsZDXy3IUjddXJDjkwhj0CRdddczSQ51NcMNe2W1pFwaWNQe1jujDxR
        yQFXsOImoS8EkdTeI/2vX7QwHpLuZkE=
Date:   Thu, 11 Nov 2021 13:36:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling
 feature
Message-ID: <YY0OUNqv1w/ihmHX@zn.tnic>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-3-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111084415.663951-3-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:44:04AM -0800, Stephane Eranian wrote:
> This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit

For all your commit messages:

s/This patch adds/Add/

"This patch" in a commit message is a tautology.

> 31 of EBX on CPUID leaf function 0x80000008.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d5b5f2ab87a0..e71443f93f04 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -315,6 +315,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_BRS		(13*32+31) /* Branch Sampling available */

	X86_FEATURE_BRS

is perfectly fine - there's no need to say "amd_brs" in /proc/cpuinfo on
AMD machines as this is where this flag will be only set.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
