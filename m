Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D73FB304
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhH3JUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbhH3JUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:20:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90473C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:19:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso14156830wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Kak39hRCW/zGxMNdH5YFQMMLorXe5QQMuaf9kMAooZw=;
        b=JyRQu4fejwHuGUaBSLG0Se8AF/uny9/eB7XVI9gJMBIuOr04VJ3o2u2ujH3cqd3Emd
         M+d+nCQeDsyNOpM2dPDQjYELPLxdVLUkdOX/v/W9iyG5y8yrNqGfRZVApIDmRVXNB5Sv
         cXsfxDv6SEjq4f4lU7pwbhY4X7u3Mz1uz30QHNlVcqEiUn+n29N2RH3Ehpr9k0t6/J6E
         vEgt0TrdZTuEVl8cRfFR/bmKLjFc1fvXHHE3rY6H8WAxnGIZLREolowATkQCO3F4iyTa
         jFsNzDkETfXp714KJuwJqggCLVfqQhwb3lza/whn2SpF4OPlE10BboSmRydsVR97Rl5N
         bdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=Kak39hRCW/zGxMNdH5YFQMMLorXe5QQMuaf9kMAooZw=;
        b=gxSWQbQO2N/1r1r/8Z2sBxFIuuG3Oh3W81G33QRLcZ9pJEi3h6Y2ZNghrszTm44rO/
         fFV0pxoB1BMP01z1UOcQw6+lwf3xz87yNFkuYGKLBW8B0s/CrUo8371jkDFcEZkzYnQL
         ARwJqOy7B5hrkdIxrqQWe9zr/cQ9LdlLLJRaL7g65UsBXjBMcdZ+9kzX0XVL+L9CDtpT
         fZUblnvUNVedi27Pk4aZi8ZTaajLAP9/tdHWqmcLlO8RIRyXt62c/snpvLIn9Yu4Y50e
         9o90e+3EHRPswA7WTufByb2PtWr+dLl/ycNKidi4EAIe6q0dhvzWj4PascYDg6pW8tws
         z1qg==
X-Gm-Message-State: AOAM532I0BlX9OTZ82yx54biCLVTAi5mDgfUaTxYTCWZvW7BvqzgMnb2
        KucVLE0q8pN1eWUPDWxyHAa5lQ==
X-Google-Smtp-Source: ABdhPJwFqMwCyidKMOqm8PiJzqLhGkt0459dz/o2vtJu2TJzDaMEyV3nqryr/URN4CH0gT0k9eofFA==
X-Received: by 2002:a7b:c850:: with SMTP id c16mr31863954wml.22.1630315166179;
        Mon, 30 Aug 2021 02:19:26 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm6460003wmi.24.2021.08.30.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:19:25 -0700 (PDT)
References: <20210827092927.366482-1-jbrunet@baylibre.com>
 <3c62d031-7334-3984-e002-f3eef1fa3b3b@synopsys.com>
User-agent: mu4e 1.6.4; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: u_audio: fix race condition on endpoint stop
Date:   Mon, 30 Aug 2021 11:10:25 +0200
In-reply-to: <3c62d031-7334-3984-e002-f3eef1fa3b3b@synopsys.com>
Message-ID: <1jr1ebguht.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 27 Aug 2021 at 23:59, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Jerome Brunet wrote:
>> If the endpoint completion callback is call right after the ep_enabled flag
>> is cleared and before usb_ep_dequeue() is call, we could do a double free
>> on the request and the associated buffer.
>> 
>> Fix this by clearing ep_enabled after all the endpoint requests have been
>> dequeued.
>> 
>> Fixes: 7de8681be2cd ("usb: gadget: u_audio: Free requests only after callback")
>> Reported-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/usb/gadget/function/u_audio.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
>> index 63d9340f008e..9e5c950612d0 100644
>> --- a/drivers/usb/gadget/function/u_audio.c
>> +++ b/drivers/usb/gadget/function/u_audio.c
>> @@ -394,8 +394,6 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
>>  	if (!prm->ep_enabled)
>>  		return;
>>  
>> -	prm->ep_enabled = false;
>> -
>>  	audio_dev = uac->audio_dev;
>>  	params = &audio_dev->params;
>>  
>> @@ -413,6 +411,8 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
>>  		}
>>  	}
>>  
>> +	prm->ep_enabled = false;
>> +
>
> Hm... this looks a little odd. If the cancelled request completes before
> prm->ep_enabled = false, then the audio driver will re-queue the
> request. It will eventually be freed later when the endpoint is disabled
> and when the controller driver completes and gives back any outstanding
> request. But is this what you intended? If it is, why even usb_ep_dequeue()?
>

Yes, it is what I intended. It's a quick way to address the problem you
have reported.

> Also, another concern I have is I don't see any lock or memory barrier
> when writing/reading prm->ep_enabled. Are we always reading
> prm->ep_enabled in the right order as we expected?
>
> Would it be simpler to free the request base on the request completion
> status as suggested?

I can see that it would be better. It would use the framework the way it
was intended which is certainly better. I just can't do it right now.

>
> BR,
> Thinh
>
>>  	if (usb_ep_disable(ep))
>>  		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
>>  }
>> @@ -424,8 +424,6 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
>>  	if (!prm->fb_ep_enabled)
>>  		return;
>>  
>> -	prm->fb_ep_enabled = false;
>> -
>>  	if (prm->req_fback) {
>>  		if (usb_ep_dequeue(ep, prm->req_fback)) {
>>  			kfree(prm->req_fback->buf);
>> @@ -434,6 +432,8 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
>>  		prm->req_fback = NULL;
>>  	}
>>  
>> +	prm->fb_ep_enabled = false;
>> +
>>  	if (usb_ep_disable(ep))
>>  		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
>>  }
>> 

