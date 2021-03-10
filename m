Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76E73338C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhCJJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCJJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:30:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF173C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:30:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bm21so37291890ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6NyVUFvTIsvrwgEQgfKqG7hoPgTwYcNq+S4TQGFp7/k=;
        b=NXEZOGSZlXeCC78mn9EpWeZyo0RF1OVuZWJBvO1ZEJYM8MQgup0skzYL46mjIzoXKz
         8VyMqrLek9bDCj9XBOdA8S9QyMdYsY5hdKoV2e7GbMdT3aOhxllqoDrBrzqN24ZK7fsg
         7mLWir84C2PKWhZ4tARPoS2N4FJiPKFZ+/lzop0WpshxzFMbxOhEAHRb+Y0JEi9V3Ulk
         uYRaSpKLmMh6dzwcQ4xJToPXK/y2PM2Y454lyA9u4bm/b/DsemZoySw9HAQMuQngUrpD
         fGIfc5HcSTsOaMRjjOAZP8Q84O5iwiQm/2s0DuoecNyfQgjdR0AZkNt9N1Kkq+dZEbxX
         0Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6NyVUFvTIsvrwgEQgfKqG7hoPgTwYcNq+S4TQGFp7/k=;
        b=koNgoJbF/z5QbeF4RMDMT3AvnX1T1weE9UsCKNL3/mXmCv+E7g+kTDq2AMQG/mTfOb
         reALPBCu/811VPcwwn0WFX2kY6fxNV3tq6aMUpDgvkxHJy0OglzgARo76WWJsahiEjfV
         ab8lAGcpcMEOCFq/Pc+b/E7+7AyrUtc1OtYwEt4+DGDBIZ+qRocSFWXpgJrJ9cR210ew
         oO/ZpRGmuaIjEvf5RrBGZVjJbM82MmJ8Uat2N9d3HxKnDg7P9wCFHoTpwXR7J6Bfvlcf
         hh9WZqXb+EBcw/vTzIH7wpYyumDQfx+nR34BZ3ASt4HZIocUBX8X+ot25XIFGE9dEsOR
         7eQA==
X-Gm-Message-State: AOAM532QzdKZ40lqTYjYLY0mkIxqhUF76057454kiDhYTpo1lPzizj93
        1gef9snxNx9A5+t+aLz1XxADiJRTa2Znjm3G
X-Google-Smtp-Source: ABdhPJyFYdnT/xrwnjkTrdIoYrDu4IcbPt3J+Iee6c46KAC1JH85E/+Ub6i1MQpPXEXjwZbbKd9Atw==
X-Received: by 2002:a17:906:3295:: with SMTP id 21mr2687534ejw.88.1615368648466;
        Wed, 10 Mar 2021 01:30:48 -0800 (PST)
Received: from ?IPv6:2a02:768:2307:40d6:f666:9af6:3fed:e53b? ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id z9sm6109678edr.75.2021.03.10.01.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 01:30:48 -0800 (PST)
Subject: Re: [PATCH] microblaze: remove unneeded variable 'err'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
References: <1615366218-7634-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <fe13a449-070a-dabc-4e45-7dcea0ce6bb9@monstr.eu>
Date:   Wed, 10 Mar 2021 10:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615366218-7634-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/21 9:50 AM, Yang Li wrote:
> Fix the following coccicheck warning:
> ./arch/microblaze/kernel/signal.c:60:14-17: Unneeded variable: "err".
> Return "0" on line 78
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/microblaze/kernel/signal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
> index fc61eb0..c4b7b30 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -57,8 +57,6 @@ struct rt_sigframe {
>  static int restore_sigcontext(struct pt_regs *regs,
>  				struct sigcontext __user *sc, int *rval_p)
>  {
> -	unsigned int err = 0;
> -
>  #define COPY(x)		{err |= __get_user(regs->x, &sc->regs.x); }

This is wrong because as you use err is used here.

Thanks,
Michal


>  	COPY(r0);
>  	COPY(r1);
> @@ -75,7 +73,7 @@ static int restore_sigcontext(struct pt_regs *regs,
>  
>  	*rval_p = regs->r3;
>  
> -	return err;
> +	return 0;
>  }
>  
>  asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
> 

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

