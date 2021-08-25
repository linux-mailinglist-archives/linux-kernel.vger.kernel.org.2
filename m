Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1123F7D02
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbhHYUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhHYUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:08:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69150C061757;
        Wed, 25 Aug 2021 13:07:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i21so968391ejd.2;
        Wed, 25 Aug 2021 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MezRDNf2kH9JeRo+6fb87WqyF4nzbzthCut3DvYsYm4=;
        b=i0dNRUorfc18/0esc9Pcc50YmwX20/EyrjDXyWaQXmQYGDa8kGYNJ0aDNwGS6V/AtH
         TQ8U+HDC3OsLkNeqC98HbfrzAF2bKVqH2A6qfqllGyz5yHdfrtMtaXQ2q5ri8/t2Bji1
         Io6ypsVMPYLCDzzk0Yh9WPQsA/Eqnkp3NRodLihCsWxIHkD1dcJ1LUlW/Am9B9yIcMeT
         V0wvjzv7VY4pw7+CJkIGBzMWGWXvfIAUYW6uJtqbhRCrfL98bklu1GnovjprYEEe0ADp
         z0H/YH4z8vHyYTvvhcx3im+2iArXYdjY8y5E0zUNsp4dU2kR5TJlYoQuwUuBeUD2wvjg
         Grwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MezRDNf2kH9JeRo+6fb87WqyF4nzbzthCut3DvYsYm4=;
        b=QT0kwEC6OALhRJE5PN9aN8FEJTvObiay4+CIC04ZWsc8uHcq42FAERPDcHj9aF0Z9m
         IW/OaqKJTWb5O3cX9YgyenlLx3m5TCPvxMmsAb+54q3AnPOim15yTyfjSEuQLEVnWmRg
         HsFp034t1JtgfGPp/D3HO05oXrYQySI/O9zylw1zAdLORCijg1/yXqYkB0SKjFO0sehG
         hYvQePXYERWnl2VAjMdknOFhdjGa5ktqcl0ily3dgEiY9Dcx5ol3OmPKFkxaYo4jga1c
         xWC+oxFBSqukCUj0B6LeWGBGrYghWDePs3sysom5My9wQ2mCaK8+2MpvsU+St+kimye8
         zffA==
X-Gm-Message-State: AOAM531BKHKBdHlWi4r9o5Od+lPY9QgqkWQ7Bn8gzqN6ozfylq6ijlca
        Ti573p9axSqT1nt9Orwqvis=
X-Google-Smtp-Source: ABdhPJxQIOXkfPEM+oUo0BuPMpswYtXSXSnPP7hSF3fGstrY1QYv/1X7wjH1aLZnoJYeyvCZZaoTnA==
X-Received: by 2002:a17:906:a59:: with SMTP id x25mr385137ejf.33.1629922042824;
        Wed, 25 Aug 2021 13:07:22 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:2090:c45b:fc0a:29b3? ([2001:981:6fec:1:2090:c45b:fc0a:29b3])
        by smtp.gmail.com with ESMTPSA id b15sm280006ejq.83.2021.08.25.13.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 13:07:22 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
Date:   Wed, 25 Aug 2021 22:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825092107.124419-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 25-08-2021 om 11:21 schreef Jerome Brunet:
> When the uac2 function is stopped, there seems to be an issue with some
> platforms (Intel Merrifield at least)
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> ...
> RIP: 0010:dwc3_gadget_del_and_unmap_request+0x19/0xe0
> ...
> Call Trace:
>   dwc3_remove_requests.constprop.0+0x12f/0x170
>   __dwc3_gadget_ep_disable+0x7a/0x160
>   dwc3_gadget_ep_disable+0x3d/0xd0
>   usb_ep_disable+0x1c/0x70
>   u_audio_stop_capture+0x79/0x120 [u_audio]
>   afunc_set_alt+0x73/0x80 [usb_f_uac2]
>   composite_setup+0x224/0x1b90 [libcomposite]
>
> The issue happens only when the gadget is using the sync type "async", not
> "adaptive". This indicates that problem is likely coming from the feedback
> endpoint, which is only used with async synchronization mode.
>
> Update the feedback endpoint free function to release the endpoint the same
> way it is done for the data endpoint.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
>   Hi Ferry,
>
>   Would you mind trying this before reverting the whole thing ?
>   The HW I have did not show the issue so far so I can't really check
>   if it helps. Hopefully, it does ...

Tested this evening and confirming that this resolves my issue. I can't 
say much about the code itself, maybe Thinh?

Would be great if we could get this in instead of reverting the series.

Tested-by:  Ferry Toth <ftoth@exalondelft.nl> (dwc3 / Intel Merrifield)

>   drivers/usb/gadget/function/u_audio.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
> index 018dd0978995..63d9340f008e 100644
> --- a/drivers/usb/gadget/function/u_audio.c
> +++ b/drivers/usb/gadget/function/u_audio.c
> @@ -230,7 +230,13 @@ static void u_audio_iso_fback_complete(struct usb_ep *ep,
>   	int status = req->status;
>   
>   	/* i/f shutting down */
> -	if (!prm->fb_ep_enabled || req->status == -ESHUTDOWN)
> +	if (!prm->fb_ep_enabled) {
> +		kfree(req->buf);
> +		usb_ep_free_request(ep, req);
> +		return;
> +	}
> +
> +	if (req->status == -ESHUTDOWN)
>   		return;
>   
>   	/*
> @@ -421,9 +427,10 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
>   	prm->fb_ep_enabled = false;
>   
>   	if (prm->req_fback) {
> -		usb_ep_dequeue(ep, prm->req_fback);
> -		kfree(prm->req_fback->buf);
> -		usb_ep_free_request(ep, prm->req_fback);
> +		if (usb_ep_dequeue(ep, prm->req_fback)) {
> +			kfree(prm->req_fback->buf);
> +			usb_ep_free_request(ep, prm->req_fback);
> +		}
>   		prm->req_fback = NULL;
>   	}
>   
