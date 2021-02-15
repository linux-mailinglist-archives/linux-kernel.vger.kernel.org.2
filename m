Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FC31B5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 08:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBOHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 02:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 02:55:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA9C061756;
        Sun, 14 Feb 2021 23:54:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p21so8708417lfu.11;
        Sun, 14 Feb 2021 23:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WDFAfN0/BngAiZ8QhhfDwFmcBbrp6aqzidWsx+GK2iQ=;
        b=HFne1yf8n/jjGu79UZRlMh3uu5FpXp8TMGHkMHNxCxgXRklLbNHiNooISp0Gd/5TSj
         iLcz3Ed78Ea1lI5Uc52qo6TlDm9egiUn1H01qCMfZLGWat4jqyoJh0gRzs6sPVZeNnNQ
         xdcUMDLYkxv5pMgIlqa4y40xaEBGLPZ4uB1g0vF7sxSbQLJjMA1bMmips3tc8Ge3RGTs
         6rpf0l7DXUo5ltB2qYHtwvfvyKC0tp+OxEGFfvfatS0xc/bHwV19NJCvWew/bEX7CLy2
         tkjmdJvRYtW9dEguJoR8QUPzzgxq+biSK/zFHqBevbGA0+rXwiN2Zx0He7cdhilEOpXd
         CgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WDFAfN0/BngAiZ8QhhfDwFmcBbrp6aqzidWsx+GK2iQ=;
        b=rd68AQCZZOIiAjwnuiX++hH7EqbA7LmtBbuM3wa7PRpd9S/V5lEl7VT87m11ZMowlL
         ykgMxFkMWOHSPLosDFwzIy2DJ48Cuq6hh/yo28GlusG2GYJ6XKOr9n6XLJbKtku6mbth
         Rn5m/w6vat1kMqnXMlzJWQbEoQOnO98Bctwkypryg2maRUtMUzOkCvf24AbW0PjqZsdB
         38sVgxhQeQltIQDDQT+hJ2w+ojrQnLe7ehE+MieX6EKZ/ZoHbL5n5T9g5d9v3aMZ22BC
         lo8PoO195MnAjt7aJJvPtSHUqqiVDgzAXGfc0D+PDrEE0UZgdsH0i42O85keC17Z9Oy6
         AZFg==
X-Gm-Message-State: AOAM530pyS3bVA0099Fy8T993b07zmQ/sjijsPfiYCbTlYexA8g79dES
        BUTcFXi6WiEnfii2YGrU8ttU6TP7Gyw=
X-Google-Smtp-Source: ABdhPJwTfhmk4JzCVUk+MR8xpBkDuTn9R7ByQ7WSf/HZho0kteDRwV18WM+GiiAv2ypJ7Pgzr1T/kQ==
X-Received: by 2002:ac2:43d2:: with SMTP id u18mr7881922lfl.439.1613375694123;
        Sun, 14 Feb 2021 23:54:54 -0800 (PST)
Received: from [192.168.1.100] ([178.176.74.220])
        by smtp.gmail.com with ESMTPSA id u23sm522525ljd.28.2021.02.14.23.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 23:54:53 -0800 (PST)
Subject: Re: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
 <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <b7d4174f-e441-58a6-25ee-fb89dd78844f@gmail.com>
Date:   Mon, 15 Feb 2021 10:54:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.02.2021 5:38, Daehwan Jung wrote:

> It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.
> It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>   drivers/usb/dwc3/gadget.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index aebcf8e..4a4b93b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2229,7 +2229,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>   	 */
>   	ret = pm_runtime_get_sync(dwc->dev);
>   	if (!ret || ret < 0) {

    BTW, this can be shortened to (ret <= 0)...

> -		pm_runtime_put(dwc->dev);
> +		pm_runtime_put_sync_suspend(dwc->dev);
>   		return 0;
>   	}
>   

MBR, Sergei
