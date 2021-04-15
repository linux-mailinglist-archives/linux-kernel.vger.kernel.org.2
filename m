Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE536055A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhDOJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhDOJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:12:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB96C061574;
        Thu, 15 Apr 2021 02:12:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so15583841ljc.5;
        Thu, 15 Apr 2021 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWvqsI9bDP94NFY7a0CrpSrstBZeg9rVyS+9OHcqvYk=;
        b=QZ2HATlif07v0vjr7jZHCGM4yPRG0TAKJdfLgZDVZPHgUJE9qyNsZKPZfAiNq+pIcn
         GOEsP8IBJ+2yaNC5A0/W0fL1W2aJbA+98FUSFEwfd202y7A51DeMaNdbdcYOewId53nG
         +Rqs2eRrsrSnlAo6c9TM0yDNg7yx7zdmi1S7zh8BPUD8QJt1d8Mg6ZAepeN+odaXwYKh
         s3n76Oa5FXsyTWxQfPxxQQNqgxDkAA/a6emxmP+Ud51hDVH5wGhLxw3kDlP/Olnf+90C
         yAu7HvxP6KLbv0jitb2MpknYM8GLRmi7NjegJWSqNtdseYNe7s5qnAG+5lLGbYK6r/Uu
         taMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yWvqsI9bDP94NFY7a0CrpSrstBZeg9rVyS+9OHcqvYk=;
        b=CuHQfO0WXSGqYZCqt8ndVRHxsPoWhKNTACQ3v1BICYI2cyFWz5Ww54EFqJg1HJSSRd
         +WdB2nVji/tKO8cPd3UHvRCNPuzPQKvp5dRl/lXTU6k/7Z1YfvdoIyGEa56ZYcLRHTXj
         Vugxe/K0yHnkQw35SGpCP6VosxLncxr4NE1YUkzIDA2AX8gxz6THtVhRhXJSvddEIYEW
         0cTe8v53NPSPoLGjXJ47jf9tSP1zKr7UOGyeCLQA1LGG40AozeVyQ5lxHUO0jMjpwCOa
         rRyKGVOHZhAbicsufsPXg0pHj7cD5heqyjWif6NlnVOO9gpiZELyg+AemXADnfYgIPCL
         OmqA==
X-Gm-Message-State: AOAM531uJg2EjycbdW6jg+Ma4ogdoG0FtJrV32n9dt5EiBKSkphXCuO4
        bfqQ185TJDPaVMcTH3C3dxQ=
X-Google-Smtp-Source: ABdhPJzaaR0Ou1781MJ2Ni/i4B3MZMnik/PlzGdE+fOvJpRUkKeLfKZdCtPul/CguwbgtPfeOJR/fA==
X-Received: by 2002:a2e:9041:: with SMTP id n1mr1196553ljg.127.1618477942094;
        Thu, 15 Apr 2021 02:12:22 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.84.170])
        by smtp.gmail.com with ESMTPSA id d15sm598649lfs.277.2021.04.15.02.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:12:21 -0700 (PDT)
Subject: Re: [PATCH 10/15] usb: dwc2: Allow exit hibernation in urb enqueue
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <65daa916b29e0009083702cb4584c8274e58ddac.1618464534.git.Arthur.Petrosyan@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <8b16e1ea-b8bb-b3fd-29ce-a997579f92eb@gmail.com>
Date:   Thu, 15 Apr 2021 12:12:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <65daa916b29e0009083702cb4584c8274e58ddac.1618464534.git.Arthur.Petrosyan@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.2021 8:40, Artur Petrosyan wrote:

> When core is in hibernation state and an external
> hub is connected, upper layer sends URB enqueue request,
> which results in port reset issue.
> 
> - Added exit from hibernation state to avoid port
> reset issue and process upper layer request properly.
> 
> Signed-off-by: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
> ---
>   drivers/usb/dwc2/hcd.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index cc9ad6cf02d9..3b03b2d73aaa 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -4631,12 +4631,29 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
>   	struct dwc2_qh *qh;
>   	bool qh_allocated = false;
>   	struct dwc2_qtd *qtd;
> +	struct dwc2_gregs_backup *gr;
> +
> +	gr = &hsotg->gr_backup;
>   
>   	if (dbg_urb(urb)) {
>   		dev_vdbg(hsotg->dev, "DWC OTG HCD URB Enqueue\n");
>   		dwc2_dump_urb_info(hcd, urb, "urb_enqueue");
>   	}
>   
> +	if (hsotg->hibernated) {
> +		if (gr->gotgctl & GOTGCTL_CURMODE_HOST) {
> +			retval = dwc2_exit_hibernation(hsotg, 0, 0, 1);
> +			if (retval)
> +				dev_err(hsotg->dev,
> +					"exit hibernation failed.\n");
> +		} else {
> +			retval = dwc2_exit_hibernation(hsotg, 0, 0, 0);
> +			if (retval)
> +				dev_err(hsotg->dev,
> +					"exit hibernation failed.\n");

    Why not put these identical *if*s outside the the outer *if*?


> +		}
> +	}
> +
>   	if (hsotg->in_ppd) {
>   		retval = dwc2_exit_partial_power_down(hsotg, 0, true);
>   		if (retval)

MBR, Sergei
