Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DE345AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCWJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:21:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhCWJVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:21:08 -0400
Received: from zn.tnic (p200300ec2f0be1003f6126910d1a5da6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:3f61:2691:d1a:5da6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B91651EC01A2;
        Tue, 23 Mar 2021 10:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616491262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jRX2e6PNBsdlXonezI0d+XWeJcO7juT5TsKtY9lrLE=;
        b=Gg7ehYMQOyMaWNhjOKoV/AcucmpqWHstUPl+uIpeCydbqU3OzD0CC1luzIRyeHp44M9fAV
        4EomH8aiA9KQAFfo5xmaJJVEfnt72/nykzydpZjybo80GhrGpjE+KkyzWWccFnQ/LH4py1
        7v42nZDrq9WkBA0q/0pUvXVNoblpktU=
Date:   Tue, 23 Mar 2021 10:21:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, tony.luck@intel.com, fenghua.yu@intel.com,
        rppt@kernel.org, xiaoyao.li@intel.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, johnny.chenyi@huawei.com
Subject: Re: [PATCH -next] x86: Fix =?utf-8?Q?intel?=
 =?utf-8?Q?_cpu_unsed_variable_=E2=80=98l2=E2=80=99?= warning
Message-ID: <20210323092102.GA4729@zn.tnic>
References: <20210323025901.205381-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323025901.205381-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:59:01AM +0800, Xu Yihang wrote:
> Fixes the following W=1 kernel build warning(s):
> ../arch/x86/kernel/cpu/intel.c: In function ‘init_intel’:
> ../arch/x86/kernel/cpu/intel.c:644:20: warning: variable ‘l2’ set but not used [-Wunused-but-set-variable]
>    unsigned int l1, l2;
>                     ^~
> 
> Compilation command(s):
> make allmodconfig ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> make W=1 arch/x86/kernel/cpu/intel.o ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-
> 
> According to Intel Software Developer's Manual Table 2-2 through Table 2-24 about MSRs:
> X86_FEATURE_BTS which represents Branch Trace Storage Unavailable and X86_FEATURE_PEBS
> represens Processor Event Based Sampling (PEBS) Unavailable, but on some platform these fields
> maybe reserved or not available. For the function init_intel it self, only bit 11 and bit 12
> are used for checking BTS and PEBS, and higher 32 bits are not used. So cast to void to
> avoid warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 63e381a46153..547ba6668eb3 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -644,6 +644,7 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		unsigned int l1, l2;
>  
>  		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
> +		(void) l2;
>  		if (!(l1 & (1<<11)))
>  			set_cpu_cap(c, X86_FEATURE_BTS);
>  		if (!(l1 & (1<<12)))
> -- 

Are you kidding me?

In what universe is this good idea?! Where have you seen other code like
that in the kernel and thought this makes sense?

I would strongly suggest you apply some brain matter and common sense
before sending patches like that and think real hard whether some
warnings need to be fixed at all cost and at all.

Because there's a reason these warnings are behind the W= switch.

Otherwise all your mail will land in /dev/null and you'll be purely
wasting your time.

Good luck!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
