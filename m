Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B335DB26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhDMJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhDMJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:30:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91EC061574;
        Tue, 13 Apr 2021 02:29:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so17743603lfr.0;
        Tue, 13 Apr 2021 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Fwu5RzA0J0NUnCwR9SJQg+h+H3PHRfLnER7tCl7tP4=;
        b=tfXAaOCiS+4ZwYQg6GUozn1WXAwSYUWK4SPHuMpZkUUK1JUqlGW3W+S4Z9TbArVuzN
         hkEUS3LNCLyrS7R2TwiuVGlqBs15SvVoxzUkeFOe8uLtVuexjORBAYkrtONTJ0SO1sPs
         VN3OkyB5D2dB0hyO9ZQfrlr1LZSpKnwfVCO4r5mhVDaD9L2gitykgzj4HK/okmBcOvrS
         pSbmzPftGBpWVgx0kHml1pTcHyph7dLZ6v7I9bTxqgb6VczJ/gqbN+IKkGFqLToWho65
         Sq9vD1tU36OC2Gx8KnGbr/s07qPDZDLzJenkqs4+lU7Zke7i1vsz7CAaFVeW+HuO7gmL
         5L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/Fwu5RzA0J0NUnCwR9SJQg+h+H3PHRfLnER7tCl7tP4=;
        b=g2q6NMX7glww/b4VxQl6rVAd56anln5WOJgf/yTMSpEshjrowA12VmtMp2BY1uvB5r
         BvdlUz8OnU+MGWUA/gH8eBmleLgbXS1JKmvkgIodvNC7mZql0ASJ12wQe4AZQK7Zm4V7
         dOT2a3blCpZax1nXvXM6Gj/fF6W8LNF69HPPCTKT6YFRcAeOyFgjaEBJKihIDMonsO0j
         +DtNkVfN9R3InP9eDUhmmwe2BKbQz6lP2TO0sAhxSECtegexc37UluaUeTrweuKQty9K
         2DY4ODBpHPNDG+lQ5jDajBoyWgGQ2cJbhtEg+eEYZjgfxLIrpdvu2vrgIvs/bQhvQ5Ic
         IfAg==
X-Gm-Message-State: AOAM530u7RT3i1D7AIdOzLiyzjet9NfV2x/gIhMrDWvW30MkpkK5zRGJ
        32bYjdjoOjrr62bFdY8bWHU=
X-Google-Smtp-Source: ABdhPJyv0pTZuHZV0MfwQGMh7mU1h5whnEAKO+RhfWG8tCVsJLekeMGBUEiJGWC9kJyevMKPwj8wwg==
X-Received: by 2002:ac2:58ed:: with SMTP id v13mr10561901lfo.166.1618306187193;
        Tue, 13 Apr 2021 02:29:47 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.152])
        by smtp.gmail.com with ESMTPSA id i13sm111940lfe.14.2021.04.13.02.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 02:29:46 -0700 (PDT)
Subject: Re: [PATCH v2 10/12] usb: dwc2: Add clock gating entering flow by
 system suspend
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <20210413073716.30C13A0094@mailhost.synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <45e520b4-b078-09b9-7082-eb3a35aa10bb@gmail.com>
Date:   Tue, 13 Apr 2021 12:29:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413073716.30C13A0094@mailhost.synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2021 10:37, Artur Petrosyan wrote:

> If not hibernation nor partial power down are supported,

    s/not/neither/?

> clock gating is used to save power.
> 
> Adds a new flow of entering clock gating when PC is
> suspended.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> ---
>   Changes in v2:
>   - None
> 
>   drivers/usb/dwc2/hcd.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 31d6a1b87228..09dcd37b9ef8 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4372,6 +4372,15 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
>   		break;
>   	case DWC2_POWER_DOWN_PARAM_HIBERNATION:
>   	case DWC2_POWER_DOWN_PARAM_NONE:
> +		/*
> +		 * If not hibernation nor partial power down are supported,

    s/not/neither/?

> +		 * clock gating is used to save power.
> +		 */
> +		dwc2_host_enter_clock_gating(hsotg);
> +
> +		/* After entering suspend, hardware is not accessible */
> +		clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> +		break;
>   	default:
>   		goto skip_power_saving;
>   	}
MBR, Sergei
