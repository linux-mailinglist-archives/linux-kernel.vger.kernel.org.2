Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC042187C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhJDUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhJDUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:37:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EECAC061745;
        Mon,  4 Oct 2021 13:36:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l7so46213590edq.3;
        Mon, 04 Oct 2021 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=e8jdR40hN8Bej0G05/tbT1UK44ZIydXMuCtKj+f0gaE=;
        b=fJxnqpo035ZWhhA3D8V7Uz2WBbNJEI6XLcxnu6hCA2sCmfT6rOXkLT8l0fpaCJgFBP
         5ZUYUpvt6nRXH6I+5caBvjuiFlxKD33GeyCkW52YSPiZ5e8RQhyDPcleONCt17jR8AM7
         EvFYBHclTCygUmoWZpTlU/OIMDskofoz2Ki9JKl+m1IcZdwdeZcXdFOEhn4EBQFEqAzr
         vmRkznwKMqPaizU8M1mNAYRrT4bUeYQfqS0j6mhmT7Q8SMDmrRYjfNczPH2DGiSqbUU2
         IgH+NCuGzGsL493qxIUqrjCFa6xGGJiNIKqVD2wyseOylmvX/8DcdOHRGTvT0ZY4FUBR
         t21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e8jdR40hN8Bej0G05/tbT1UK44ZIydXMuCtKj+f0gaE=;
        b=7AsvZvgHEQD+o76q0hMQP8DSJaw6SqPwJIXiZpHROvAMASK7bnIeA6KIJ8L208Gitr
         5ejHqBvMWZsTb6/P1rSEQcgPme98dL8rZra8oXF6bIn8SPaq2LPRJXpQp7XzhSIIJtFm
         /EvlycLCO/0LaL3b1VHwnhlpEUkRvkeS+/2UX4RZekvMhtJcdiMo8sF6TPDCSU0zOESR
         Dr5zN1o64YdeCzIPqcxpMSwye9y4Viyq75C8gxJehDe4SKklddGZIUod84br55DQ5N27
         PyY0+NdzFmskWjar07xjC/uf8P6djFi6GxtEnkEHz7z0/EFOYK+hZe1xWsQ8Rsja4icc
         zNLQ==
X-Gm-Message-State: AOAM5304hkhMUhFqyqdSDXFdTphInWRSIqpgPdtVbsCmuM6GIiWrPTbm
        Kof9sYGjyUk1rv62SNj3qSI=
X-Google-Smtp-Source: ABdhPJyus9YhbK6jp+AZHZJAS/8HxtABx6LiZakikCXLp5NugKcoxiU4gynnsRFDBj9LXMHkYVPBuA==
X-Received: by 2002:a17:906:2b91:: with SMTP id m17mr19258598ejg.202.1633379758739;
        Mon, 04 Oct 2021 13:35:58 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:ca3f:670e:572a:c357? ([2001:981:6fec:1:ca3f:670e:572a:c357])
        by smtp.gmail.com with ESMTPSA id y93sm7885614ede.42.2021.10.04.13.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:35:58 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to
 the right controller"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
References: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com>
Date:   Mon, 4 Oct 2021 22:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 04-10-2021 om 16:18 schreef Andy Shevchenko:
> The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the right
> controller") changed the device for the UDC and broke the user space scripts
> that instantiate the USB gadget(s) via ConfigFS.

I confirm this regression on Intel Edison since at least 5.15-rc2 while 
in 5.14.0 it was working fine.

This patch resolves the issue as tested on 5.15-rc4.

Tested-by: Ferry Toth<fntoth@gmail.com>

> Revert it for now until the better solution will be proposed.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/dwc3/gadget.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 8e66a70adae6..13664609ed3c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4253,7 +4253,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>   	}
>   
>   
> -	usb_initialize_gadget(dwc->sysdev, dwc->gadget, dwc_gadget_release);
> +	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
>   	dev				= &dwc->gadget->dev;
>   	dev->platform_data		= dwc;
>   	dwc->gadget->ops		= &dwc3_gadget_ops;
