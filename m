Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB64018D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbhIFJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:31:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241313AbhIFJbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:31:09 -0400
Received: from zn.tnic (p200300ec2f0c2400e3336e9341833586.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2400:e333:6e93:4183:3586])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D96501EC04D1;
        Mon,  6 Sep 2021 11:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630920603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1HSM8YrKqN1A8cBHayWCuJLrO98T8taynt/2Ecj/p4=;
        b=khLOXp/6KvfYyqQj1w2mTd9JUhUeg6l9ESMQubY/wvdTH4hAHhq3J18qt6hX7gtKrXepD5
        5gBoIKzSE7Sib3p5MMAu8MZwcU2fvOlqJjNKai2voOLD7S2bcX4vMZ9rUu9J+CWydi5IdF
        3xspFkUYNO6ClUsgns5A9XD5/dn7UU4=
Date:   Mon, 6 Sep 2021 11:30:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not
 supported
Message-ID: <YTXfmRIwWREJgEU9@zn.tnic>
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
> RTM and HLE features, it will affect TAA mitigation.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kernel/cpu/tsx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index 9c7a5f049292..5e852c14fef2 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -122,6 +122,13 @@ void __init tsx_init(void)
> 
>         if (!tsx_ctrl_is_supported()) {
>                 tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
> +
> +               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulation,
> +                * but guest supports RTM and HLE features, it will affect TAA
> +                * （tsx_async_abort）mitigation.
> +                */
> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
>                 return;
>         }

How does that even happen - the hypervisor does not support the MSR but
"guest supports" TSX features?!

I guess the guest is detecting it wrong.

What hypervisor, what guest, how do I reproduce?

Please give full details.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
