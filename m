Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4069E3F7162
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhHYJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhHYJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:04:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:03:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i21so8782355ejd.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4LUZQEf1FWhO8/L5Pn1dteozC/zUI7RffyG6+EOHYI0=;
        b=BYRvLO1nT5wfq/PdSUipimEcyMAshc+sOEO/dZAMCffuCi7w/4mwNtbPO6ktjrMR6C
         Y9rkT2N12HKVsHDjGvpa6Z/6OUbK/4g+0FiKscVZj+5m4Mdvo8ZUdw5rPIUhCRDL5NNz
         C0eLUhlCEthvhgxIfUAKPGhpQ/cAER2LDkuoVOfAONYgeFwvZgjz3E9OLr/8VfZkD288
         +2eynglMPmuoeUt2meeC9HZ2Lo1KaOL7dP5k2bH+r55ASJZNfIZtgZTQf+sgXR7AoCC/
         qe32/dM2gDrCec0HNCraBS5V2NN9icNBG4z+/MVRNfAZQmI/tjv0XdCFY9qh1NPHeSnD
         JKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LUZQEf1FWhO8/L5Pn1dteozC/zUI7RffyG6+EOHYI0=;
        b=p5RWpio727YHtym0eJ+tVUD40VNlFHEvVLHkaTfW5sTZJoqDqO/IQdYBtj/yGLxdsY
         Piu+na1exjyD+l4+cyjDOPUk87ntjkjLXpGJzGbevukuKqEp2PrOW2DyPjOiNfuoMjPf
         e8l91A2CFpN14bRXcPwZN3rjS3mTCbXgyoquvLgi2cJPhK7sdKA62dy1c0S7Ml8nTgsa
         Om7UKtOoBseI5RePs1cheK1/0SyRGv3lZJaKDqh5+aWrU6xWTTlW8iOjOo1ft1P9yueJ
         OlUvTgh2HmFvwvWQA0pI9F70o8+m6vdash6C7/6/iF12P2n/QLy4eUIZgBh/9j1sfGOY
         YtNw==
X-Gm-Message-State: AOAM531Jp+pTcVGcQpM+feEDNpX+4b9YlaP8NvGAUZOEaQNerGNsHwtq
        a1fD4zSLbBrqJdrX/6mZoP9V+Q==
X-Google-Smtp-Source: ABdhPJy0bQdYxtuwPyYk7aB1tnv5xSrALpyHjrcIY0eAgxDYVpz/TnEg34bRCu6QFb1yXU+EVCu6NA==
X-Received: by 2002:a17:907:4cf:: with SMTP id vz15mr32598299ejb.543.1629882199383;
        Wed, 25 Aug 2021 02:03:19 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id o6sm6261838eju.91.2021.08.25.02.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 02:03:19 -0700 (PDT)
Subject: Re: [PATCH v4 07/10] microblaze: snapshot thread flags
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mattst88@gmail.com, mingo@redhat.com, mpe@ellerman.id.au,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
References: <20210803095428.17009-1-mark.rutland@arm.com>
 <20210803095428.17009-8-mark.rutland@arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <d62b4ccf-505d-e8e2-1195-48327ba4a4eb@monstr.eu>
Date:   Wed, 25 Aug 2021 11:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210803095428.17009-8-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/21 11:54 AM, Mark Rutland wrote:
> Some thread flags can be set remotely, and so even when IRQs are
> disabled, the flags can change under our feet. Generally this is
> unlikely to cause a problem in practice, but it is somewhat unsound, and
> KCSAN will legitimately warn that there is a data race.
> 
> To avoid such issues, a snapshot of the flags has to be taken prior to
> using them. Some places already use READ_ONCE() for that, others do not.
> 
> Convert them all to the new flag accessor helpers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
> index fc61eb0eb8dd..23e8a9336a29 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -283,7 +283,7 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
>  #ifdef DEBUG_SIG
>  	pr_info("do signal: %p %d\n", regs, in_syscall);
>  	pr_info("do signal2: %lx %lx %ld [%lx]\n", regs->pc, regs->r1,
> -			regs->r12, current_thread_info()->flags);
> +			regs->r12, read_thread_flags());
>  #endif
>  
>  	if (get_signal(&ksig)) {
> 

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

