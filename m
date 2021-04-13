Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73235DB04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhDMJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhDMJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:23:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1428C061574;
        Tue, 13 Apr 2021 02:22:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 12so26099774lfq.13;
        Tue, 13 Apr 2021 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FwfRq003k7c0sRHU/LeK71oNXIIg9f2Cbnxik0Fz0nQ=;
        b=sX9K/Ljtw95FMyxwNsVeoUIlNF84+/1r6bcvSO2rZa/nVv3pL8NFbCap12feHhWX6w
         Uwap89QRhz3qiiB+KT8l3PcB4khbA8iSdLl2EwFlhLAc3QzDlcbpnFqsa+xd/7jn9nnt
         vaydNMI+Pw15HYPTB7RvIcQ0HNSHwve/2fwxG6xPxHe24sIV0cCNDiRHYMXiBgkSAX25
         TPu3zwBrZhJSCyPms4AxExcU9BOBE8aVf6GFFb0kN8FyTl3Q1n4CuNqER90h87T32psb
         WLK1eae0UejYFG21t8RQmGKlQXJoe25PnUAe8n7fogtci1wksP578IkXtPe9pecJrlY5
         b1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FwfRq003k7c0sRHU/LeK71oNXIIg9f2Cbnxik0Fz0nQ=;
        b=Ut5LiG9HSmapLxASegmDXM7Z6oVEA4aIQQ/dTshreFjuWiwP6KHzOEuTVcxtA9k6Mn
         a3nxIcWFVKP0dfbLBolvy6XvYn4m5u99wlFXEKk2zgTA/VD286/EY9BRZC+VgR06IQCL
         z8edKcGj6TlT2LuScy9UGFw3tE8JilVZ8rL77SqqKNQvOokmlyfSUVxmPSpkUNY5JNa8
         OUwZCFQodbJecUAAfiAxQEdmEkeRcCRPT5TT21PbvmqxEqqOQ5Jh6mYEz3W9gfyeB85p
         NCogf3ec+sRSASI5peEsEQjsnZzRb3Y2Jiw+hwWPaEwB1qIfAxnm32elibD8REL9wS0t
         Atkw==
X-Gm-Message-State: AOAM530A7tqbKk/B3EVblKKovwg4knn4niQDroMjFbZBuLVi3wV+amuB
        oq5mzbNgFEVtVBy+j7mDW8s=
X-Google-Smtp-Source: ABdhPJzqi84a+Vb4568i24ACcssIFvRunMl+wbAN2BjDniH75FYoen4JMSMo3yHfFQQWWqVuj4QTHA==
X-Received: by 2002:a05:6512:1324:: with SMTP id x36mr19139873lfu.189.1618305761247;
        Tue, 13 Apr 2021 02:22:41 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.152])
        by smtp.gmail.com with ESMTPSA id u25sm3167643lfu.293.2021.04.13.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 02:22:40 -0700 (PDT)
Subject: Re: [PATCH 07/12] usb: dwc2: Update enter clock gating when port is
 suspended
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <9ed1da9780cddf995841cc5867f195024f5a16d9.1618297800.git.Arthur.Petrosyan@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <2dc3798a-6a89-b363-aade-e127decfdf20@gmail.com>
Date:   Tue, 13 Apr 2021 12:22:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <9ed1da9780cddf995841cc5867f195024f5a16d9.1618297800.git.Arthur.Petrosyan@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13.04.2021 10:17, Artur Petrosyan wrote:

> Updates the implementation of entering clock gating mode
> when core receives port suspend.
> Instead of setting the required bit fields of the registers
> inline, called the "dwc2_host_enter_clock_gating()" function.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> ---
>   drivers/usb/dwc2/hcd.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 27f030d5de54..e1225fe6c61a 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
[...]
> @@ -3323,22 +3322,12 @@ int dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
>   		break;
>   	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
>   	case DWC2_POWER_DOWN_PARAM_NONE:
> -	default:
> -		hprt0 = dwc2_read_hprt0(hsotg);
> -		hprt0 |= HPRT0_SUSP;
> -		dwc2_writel(hsotg, hprt0, HPRT0);
> -		hsotg->bus_suspended = true;
>   		/*
> -		 * If power_down is supported, Phy clock will be suspended
> -		 * after registers are backuped.
> +		 * If not hibernation nor partial power down are supported,

    s/not/neither/?

MBR, Sergei
