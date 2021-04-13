Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43535DB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhDMJZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhDMJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:25:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B67C061574;
        Tue, 13 Apr 2021 02:25:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so9181317lfd.9;
        Tue, 13 Apr 2021 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUD7ih0zcL0WnnSk7Y2BKIMuf6sKAqQpIrLyKqmuvtA=;
        b=pLWBtRC+f65fKX3WcO62qKUhlpfq4ykJlSBwbYB3FvHSTgHpftNSCvmSSWwOxgv3kG
         vweaRgppcJ+wref1Z7X56zd75Oy50OWGnMYD+E8q/kgT/IKUEazQYm1P5WlVVFwaW3p3
         twpt46aObgeldZRz3d/0OlWBNKGcPR6M2TGiippXv8oggf/DPZLUMFGkSmYkqagz0jPD
         0IDzF9hajHMI4Jfj6+g4onJzbfS+WQvAybgQVow7wbQq3qsMGdDi7ASry8QWMTWga+uW
         UaqWEBN9TE1isMbm2SuPXProA3bnJ7TZTULq7w+D8gcNLFF0+3XIU4uLynEwANOedPI+
         Fnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hUD7ih0zcL0WnnSk7Y2BKIMuf6sKAqQpIrLyKqmuvtA=;
        b=Leke82LTa/fEoz2leXnut3daqMXxtGk0/8x92doeRqrq1A38gNA6liZtkFp2VU/5iX
         q4nrSso9nSWFEryJRX3RjF/nH+cdyrtMIu4vmWRP8hNrBpNl6nL+ARtJT9cifXWd3uk3
         beSX3HmO/wnAjmNLZ0zm0Mm/tgY9D8O5WK5Elson1CbNaOuANm5oxI0wcqY5w5gQyt+g
         7rZIbo6pfHKRu19rW0vs1XKqGccERRuGFobQtUZ2XoizIIzLX3Okl/FPJLOGrnwYuS3t
         q6QIoSlHNTpm9jnMkAUO+hg+rJvmYdoxufkspg3wASuYiq+JqYEEZ6aivSa6B7CLaKBy
         vlKw==
X-Gm-Message-State: AOAM530j+X3/8tkBVdJupZOuVvm1XBdC+2yUBLna3h6Cqlhu3/MD1fH8
        y9JxHXWfW/Jcdp4DQrwigskfpVbymjc=
X-Google-Smtp-Source: ABdhPJwWvhaKrRmmvZNydJEuhhgCJVufdSwZZC5wx7qL//GqDkWe7ZUVq31o+P5tXJrcXU6g9mJCRQ==
X-Received: by 2002:a19:2387:: with SMTP id j129mr18236448lfj.478.1618305925285;
        Tue, 13 Apr 2021 02:25:25 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.152])
        by smtp.gmail.com with ESMTPSA id f11sm3639914ljo.57.2021.04.13.02.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 02:25:25 -0700 (PDT)
Subject: Re: [PATCH 03/12] usb: dwc2: Allow entering clock gating from
 USB_SUSPEND interrupt
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <58dc1c1805b583fa87f9615e9d17e9ff88644718.1618297800.git.Arthur.Petrosyan@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <4aace947-826f-7e45-f2f8-2bbfaf9f1420@gmail.com>
Date:   Tue, 13 Apr 2021 12:25:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <58dc1c1805b583fa87f9615e9d17e9ff88644718.1618297800.git.Arthur.Petrosyan@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2021 10:16, Artur Petrosyan wrote:

> If core doesn't support hibernation or partial power
> down power saving options, power can still be saved
> using clock gating on all the clocks.
> 
> - Added entering clock gating state from USB_SUSPEND
>    interrupt.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> ---
>   drivers/usb/dwc2/core_intr.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
> index 8c0152b514be..ab7fe303c0f9 100644
> --- a/drivers/usb/dwc2/core_intr.c
> +++ b/drivers/usb/dwc2/core_intr.c
> @@ -529,14 +529,18 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
>   				/* Ask phy to be suspended */
>   				if (!IS_ERR_OR_NULL(hsotg->uphy))
>   					usb_phy_set_suspend(hsotg->uphy, true);
> -			}
> -
> -			if (hsotg->hw_params.hibernation) {
> +			} else if (hsotg->hw_params.hibernation) {
>   				ret = dwc2_enter_hibernation(hsotg, 0);
>   				if (ret && ret != -ENOTSUPP)
>   					dev_err(hsotg->dev,
>   						"%s: enter hibernation failed\n",
>   						__func__);
> +			} else {
> +				/*
> +				 * If not hibernation nor partial power down are supported,

    s/not/neither/?

[...]

MBR, Sergei
