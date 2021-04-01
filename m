Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1602F3517E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhDARm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhDARhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A4C0613B9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:18:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 11so1341813pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P569iaTbs6O5c4QvqrT8hmFqAirjxm+5X5n/nLel8Hk=;
        b=SdIzob6Rg9lJgd20DviDj66kT6JWmI8l4nn81KpJ8eJKbOQf+fMz0mfbQBEglYad8f
         fq3HjSdtdzSWIN/p0S0HS9WjsO+GP+vRSFNpbm0EgHYOaThKtaXgvbwUTismZa4jJmO4
         OA9p5NKzddeSnnSaadxllyht67NmLCYi7x6ftUNvwU1gdwwPkt2Q0Oa7lQDT0GzLWUIm
         fAlGhXcWinDInv8lB6TeuVoZQwxnVbV/VyQ45oMgv7VcDShjxBXA/QDRyX7igOYD+0I3
         Dq1LcTaVEbC1fuzOBZjTYCKB5jd3SR+8cmazJ/+qigcVNEo3ZZqZeOLaxHhKobsLMApJ
         npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P569iaTbs6O5c4QvqrT8hmFqAirjxm+5X5n/nLel8Hk=;
        b=g9txtNNeGvMUFHwzgp5sR1h9EOgX44QUyLk9hC9cjOYqGd64qPujJngzoid89iksfa
         3JtpQGB1Mn+Nbf+QBvHxm73E8PZSRxdIhPEtAvViPuHrzY9X80v6AaFth93S+O52kCxD
         pyu2cOdtSgM/SGgf73Wz+vneaTAd0p2FnGc/zVEeCkRjW1+yRTCoBi0+u2om/X8mrL4Q
         P6z2pVRxu83JMp4OC1ck383HdhryK3OFdMvWmj0UpeWNkkOsb56zXrWAbG5DSeqX9hJQ
         az72BAjtylahGmLiEmDt5KS8NMZja1GYi0ff+yGKmfwEJGG+e9MfKfg+F4c5WI9wVWIf
         b8zw==
X-Gm-Message-State: AOAM532MvUOkbP3xGzkNsdjje2kEOUG4gghrZSKUWNZFuFM0d9NCZuDm
        jFEquW+PjlroNUCSFAQjA6mZRg==
X-Google-Smtp-Source: ABdhPJz8KUHW7fvncKxqlaOv7HvQQN55BF4qVQIjaxSsBq1uiESyP2+Jik4zX8CZhRuMK5Ox7skF+g==
X-Received: by 2002:a65:4887:: with SMTP id n7mr7267201pgs.14.1617279522544;
        Thu, 01 Apr 2021 05:18:42 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id i22sm5413134pgj.90.2021.04.01.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:18:41 -0700 (PDT)
Subject: Re: [PATCH v2] dmaengine: k3dma: use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>, vkoul@kernel.org,
        mchehab@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
References: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <8091f42c-755d-c412-bb1d-b723d887bf43@linaro.org>
Date:   Thu, 1 Apr 2021 20:18:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/1 下午7:50, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to the official website.
>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>

Thanks for the patch.

Acked-by:  Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
> V2:
>   -remove the terms of use link.
> ---
>   drivers/dma/k3dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index d0b2e60..ecdaada9 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2013 - 2015 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.
>    */
>   #include <linux/sched.h>
>   #include <linux/device.h>
> @@ -1039,6 +1039,6 @@ static struct platform_driver k3_pdma_driver = {
>   
>   module_platform_driver(k3_pdma_driver);
>   
> -MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
> +MODULE_DESCRIPTION("HiSilicon k3 DMA Driver");
>   MODULE_ALIAS("platform:k3dma");
>   MODULE_LICENSE("GPL v2");

