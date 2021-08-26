Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BB3F8314
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhHZHZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbhHZHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:25:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B8C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:24:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so1574839wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ioXiDDZsnZZqu0NvWprHFZFLx5epKvcnCTOolUIGP/Y=;
        b=HhMWDaK4apn/MG6mOU3wkyqFYepcMUCbSiw7HbpgRFqdQbXmU5t6wDoEBdZa/7YMMb
         epPfVYjIRAUSwIbfmUr5aCOrh01r6DDLlrpaG3ChC3gmi0YIVIEMdUfUXquG+S35V6n2
         vNhCW3CIaYFulT8GcScx3zKTEI+JM71MaGC7v8QcmFzJQc+KsFQuoj5h1QtYp20mkC5I
         GYER6+SlBbkLDjFkSjZQwMTsQpiupD+PX5lK9gj7YO7xO2GyMmDtSePZxcU7PFclcrJT
         maY0ymngiGwlmL9jRnBu2mZccMi0fNcd4zI/JHl45mOqgg6QAASie0VTp14KhxWNfjjn
         EzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ioXiDDZsnZZqu0NvWprHFZFLx5epKvcnCTOolUIGP/Y=;
        b=J8IgV0eWHVxHingUXEuMoS73k6iHqSfeuTJmGNEpjFcWz3S4VMV+HI60Gy285EMGHu
         2IDKGXcNbfFNbOULvlWPSJMqTrBRB4yLiUhbmo+0jhg2/DYebFGXrAhwSooYBY4ZA5mn
         U6sl0XEto5Dyhz0SVvtTrDFBBxDYFRkAESSHZoZ97OgUQjkUHVLhDy07PZgTp08IQclN
         swVqSz1WYacinPHmJ67zQZn+hfSwfRyufZM/ZBlBkMOOSuKF2EB9ARo0Lskc8h0gj3co
         DC+AM3rk4cGFjBDIQT4PuobURzr6dD+lV1A+YnUUXWsjwqbcO83E8CEZCJkJ5m/EMBGB
         le5A==
X-Gm-Message-State: AOAM533nDQiJ0WbpZoLLrsaMiHpIPjPiNYlQ0PtV9opHlXUWa2LYhCtV
        zalvhehjPvBr2Zoa1reZUoPXRA==
X-Google-Smtp-Source: ABdhPJxWKR6n0tAKwDSQiFMjdsFk4t1J65Us9VNsqDZimykSngWSxv6DrmQA7PmXOGf5jK3wF4Cugg==
X-Received: by 2002:a05:600c:3656:: with SMTP id y22mr12676179wmq.58.1629962682375;
        Thu, 26 Aug 2021 00:24:42 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d9sm2687180wrb.36.2021.08.26.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 00:24:41 -0700 (PDT)
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
User-agent: mu4e 1.6.4; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ferry Toth <fntoth@gmail.com>, Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Date:   Thu, 26 Aug 2021 09:23:42 +0200
In-reply-to: <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
Message-ID: <1jilzsy8g7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 25 Aug 2021 at 22:07, Ferry Toth <fntoth@gmail.com> wrote:

> Hi,
>
> Op 25-08-2021 om 11:21 schreef Jerome Brunet:
>> When the uac2 function is stopped, there seems to be an issue with some
>> platforms (Intel Merrifield at least)
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> ...
>> RIP: 0010:dwc3_gadget_del_and_unmap_request+0x19/0xe0
>> ...
>> Call Trace:
>>   dwc3_remove_requests.constprop.0+0x12f/0x170
>>   __dwc3_gadget_ep_disable+0x7a/0x160
>>   dwc3_gadget_ep_disable+0x3d/0xd0
>>   usb_ep_disable+0x1c/0x70
>>   u_audio_stop_capture+0x79/0x120 [u_audio]
>>   afunc_set_alt+0x73/0x80 [usb_f_uac2]
>>   composite_setup+0x224/0x1b90 [libcomposite]
>>
>> The issue happens only when the gadget is using the sync type "async", n=
ot
>> "adaptive". This indicates that problem is likely coming from the feedba=
ck
>> endpoint, which is only used with async synchronization mode.
>>
>> Update the feedback endpoint free function to release the endpoint the s=
ame
>> way it is done for the data endpoint.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>
>>   Hi Ferry,
>>
>>   Would you mind trying this before reverting the whole thing ?
>>   The HW I have did not show the issue so far so I can't really check
>>   if it helps. Hopefully, it does ...
>
> Tested this evening and confirming that this resolves my issue. I can't s=
ay
> much about the code itself, maybe Thinh?
>
> Would be great if we could get this in instead of reverting the series.
>
> Tested-by:=C2=A0 Ferry Toth <ftoth@exalondelft.nl> (dwc3 / Intel Merrifie=
ld)
>

Thanks for reporting and testing this.
I guess we should also add

Reported-by: Ferry Toth <ftoth@exalondelft.nl>


>>   drivers/usb/gadget/function/u_audio.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/=
function/u_audio.c
>> index 018dd0978995..63d9340f008e 100644
>> --- a/drivers/usb/gadget/function/u_audio.c
>> +++ b/drivers/usb/gadget/function/u_audio.c
>> @@ -230,7 +230,13 @@ static void u_audio_iso_fback_complete(struct usb_e=
p *ep,
>>   	int status =3D req->status;
>>     	/* i/f shutting down */
>> -	if (!prm->fb_ep_enabled || req->status =3D=3D -ESHUTDOWN)
>> +	if (!prm->fb_ep_enabled) {
>> +		kfree(req->buf);
>> +		usb_ep_free_request(ep, req);
>> +		return;
>> +	}
>> +
>> +	if (req->status =3D=3D -ESHUTDOWN)
>>   		return;
>>     	/*
>> @@ -421,9 +427,10 @@ static inline void free_ep_fback(struct uac_rtd_par=
ams *prm, struct usb_ep *ep)
>>   	prm->fb_ep_enabled =3D false;
>>     	if (prm->req_fback) {
>> -		usb_ep_dequeue(ep, prm->req_fback);
>> -		kfree(prm->req_fback->buf);
>> -		usb_ep_free_request(ep, prm->req_fback);
>> +		if (usb_ep_dequeue(ep, prm->req_fback)) {
>> +			kfree(prm->req_fback->buf);
>> +			usb_ep_free_request(ep, prm->req_fback);
>> +		}
>>   		prm->req_fback =3D NULL;
>>   	}
>>=20=20=20

