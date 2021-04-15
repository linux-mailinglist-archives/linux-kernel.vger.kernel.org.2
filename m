Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C476360593
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhDOJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhDOJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:24:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A81C061574;
        Thu, 15 Apr 2021 02:24:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o16so26332053ljp.3;
        Thu, 15 Apr 2021 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1DJ0GzmXw8sKDsrZ52paH//XCluIfnFmXR68ddtBX0=;
        b=vDoOc5lSA9j5NNrK/w7l0gAncecdDu6kyst7n8cezjygFmOw3ppcWTe6fFeSvLIhHx
         Hq37KSYwg01SjWERH8E9gRuVGgmHE5uWFm8WX4PxCdEYOV1KJP4RVT6NE/WoEiw+Vmk0
         dVRWiTAojRv5aLptzU0J5UkPwdwzt2oI1AjPNu1PENyV6nrcvoDttDiRNqaBGH7fZNF7
         n5q4yQiRgwVrx2TD77FGuakRcWDNVMQoLgwbcynK5LdUXiQTvatbrEHp1wWjP4yqszcs
         mwwM8W6BPmZVhPbZFtiAb54wq+aE/HpK1u5eDYBDtsDuZ0Gdl47G85scyaR2n/p1ZkLU
         uPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F1DJ0GzmXw8sKDsrZ52paH//XCluIfnFmXR68ddtBX0=;
        b=mcKG6UyLvwx4G5vWzO1eZi+dhuMeGGuegPYQ23zJPEZLkSaJG2Y9wbVkbj2+L0IDnL
         CBf9IMVCpYrLmmt7O1+zFk+kCnwvnehDJ2Y+GZWnqhwzchqAroXW4tS49abQGdNGgF4O
         kWSRymnMEEJLJSRyclDbFRX8ULDGBRpTWl3Sw3QV/bks6TXn3BEUnbf5EcSsGL/ZwZ81
         jzW/DvlUpUbB89YrKEh0Glgi4vo8rqxNxjn59EVeKT/JQCRTf6BH0587A2Z1JizjejQT
         jWvdymRbbNXxVjD95Z8414sl7Gg7SiqHFtnAbjOeIbtR4c/+guCn7u/Eb/NOotKJzoVw
         +9/g==
X-Gm-Message-State: AOAM531v1QnjqjmYc97oF4PleU4A5zy0sYYSNn5Eyl5zady210KccCMV
        10C9oxdB1MabIta+vl3AuWSWXFpDwTQ=
X-Google-Smtp-Source: ABdhPJzmXf071xuEXPY4v8pGPVw+S6AUkHCWZfDLCXuC6XrRY9+Xs7O9CD5rp3vzZUu3W2xnGmb2FA==
X-Received: by 2002:a05:651c:1306:: with SMTP id u6mr1275592lja.197.1618478667878;
        Thu, 15 Apr 2021 02:24:27 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.84.170])
        by smtp.gmail.com with ESMTPSA id q19sm584577lfu.258.2021.04.15.02.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:24:27 -0700 (PDT)
Subject: Re: [PATCH 13/15] usb: dwc2: Add exit hibernation mode before
 removing drive
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <d01d23e2473407af37c42acb6ca4815ae5fd256e.1618464534.git.Arthur.Petrosyan@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <6e51ca4c-b479-5ccb-59bd-a767db7118ec@gmail.com>
Date:   Thu, 15 Apr 2021 12:24:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d01d23e2473407af37c42acb6ca4815ae5fd256e.1618464534.git.Arthur.Petrosyan@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.2021 8:41, Artur Petrosyan wrote:

> When dwc2 core is in hibernation mode loading
> driver again causes driver fail. Because in
> that mode registers are not accessible.
> 
> In order to exit from hibernation checking
> dwc2 core power saving state in "dwc2_driver_remove()"
> function. If core is in hibernation, then checking the
> operational mode of the driver. To check whether dwc2 core
> is operating in host mode or device mode there is one way
> which is retrieving the backup value of "gotgctl" and compare
> the "CurMod" value. If previously core entered hibernation
> in host mode then the exit is performed for host if not then
> exit is performed for device mode. The introduced checking
> is because in hibernation state all registers are not
> accessible.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> ---
>   drivers/usb/dwc2/platform.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
> index f8b819cfa80e..2ae4748ed5ec 100644
> --- a/drivers/usb/dwc2/platform.c
> +++ b/drivers/usb/dwc2/platform.c
> @@ -316,8 +316,24 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
>   static int dwc2_driver_remove(struct platform_device *dev)
>   {
>   	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
> +	struct dwc2_gregs_backup *gr;
>   	int ret = 0;
>   
> +	/* Exit Hibernation when driver is removed. */
> +	if (hsotg->hibernated) {
> +		if (gr->gotgctl & GOTGCTL_CURMODE_HOST) {
> +			ret = dwc2_exit_hibernation(hsotg, 0, 0, 1);
> +			if (ret)
> +				dev_err(hsotg->dev,
> +					"exit hibernation failed.\n");
> +		} else {
> +			ret = dwc2_exit_hibernation(hsotg, 0, 0, 0);
> +			if (ret)
> +				dev_err(hsotg->dev,
> +					"exit hibernation failed.\n");

    Again, why duplicate the innermost *if*?

>  +		}
> +	}
> +
>   	/* Exit Partial Power Down when driver is removed. */
>   	if (hsotg->in_ppd) {
>   		ret = dwc2_exit_partial_power_down(hsotg, 0, true);

MBR, Sergei
