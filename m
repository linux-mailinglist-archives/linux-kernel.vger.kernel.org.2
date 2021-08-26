Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E723F8359
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhHZHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhHZHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:50:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:49:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso5049482wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=i5C1b7eICKbpr8yxlTHz9aejFkB8KKSfixjOrODhRJY=;
        b=Bzbf3OU7mvwXektUcznqIEckQICSwo6bvjOj8JARN+Jujcz3ngJ86BT1BfQqdadO8j
         mVx9kD7hdm1GWCoYakSNwB8MwrTNQzp3HbFF8lHV1S/rVoOVLtrR2tV6Jbdd6poWScI9
         FxtFvea7ARdKjQOZPii8FWEN2HSnbbg/OkctLKQc1iSP5FoaG8oGcHHnvQ4+eKFOYSvI
         Aw5oPlOBdo6lkqY3HYsfpA7o3BvEnyEWeMHffzBVW7eGcKvXIaiew3Vgrtyht9Zjf1cZ
         Kef43GAFZEv/A/A5SRtIqM7RpBLeX1gUuq51gjMeyC6A9IlARQ/1Z7yKUoK9yHc3M+KP
         Nx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=i5C1b7eICKbpr8yxlTHz9aejFkB8KKSfixjOrODhRJY=;
        b=IVObufVmD40X2rWHH/du/OX71v++Hz8PtsGeHiMA7ptz/Bcc1mAsElPazlpuAgaYKf
         tzlQUID40Z8DxRxNg9xFcF5rhexGJAs5tpNwVj1PAAI6VEgJTSF07bQdRdjZgNCt1FWl
         pbpU7gTpqCT6PMIHkLiOMfLSZARpvG1CDe2EPMXLdfeC262Z1uf8SejxWTNaAkgiwkdE
         fyiT3JDnyQm/9SZSYZT2Nm2gJrpe7TT1e7kN8TJm28JMNWH2VR2HqhyR9IdgazhHo/41
         +y8FdcxvJdl9XS9l44k12nS/pEigtbYQ20ojADmFfQCZT9AHHavw5n02hfuIcdU3+Nxg
         HAhw==
X-Gm-Message-State: AOAM532tA3WS8sPGYIXlQrhEnCJQiNPH6BYoFimF8+RsoIxpCZEcVcOz
        w6gfbEO04Z97hshWopYUvZ9TJg==
X-Google-Smtp-Source: ABdhPJy/804PaAz1SWnMTOKwRSDBPPAVRXqRKmYmGYjLZ0o9nni4GLrCErcLvY6+CKOSGZWcZ7/rDQ==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr12838375wma.125.1629964195346;
        Thu, 26 Aug 2021 00:49:55 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d9sm2773524wrb.36.2021.08.26.00.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 00:49:54 -0700 (PDT)
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
 <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
User-agent: mu4e 1.6.4; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Ferry Toth <fntoth@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Date:   Thu, 26 Aug 2021 09:25:22 +0200
In-reply-to: <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
Message-ID: <1jbl5ky7a4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 25 Aug 2021 at 21:42, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Ferry Toth wrote:
>> Hi,
>>=20
>> Op 25-08-2021 om 11:21 schreef Jerome Brunet:
>>> When the uac2 function is stopped, there seems to be an issue with some
>>> platforms (Intel Merrifield at least)
>>>
>
> The issue isn't hardware specific.

While the actual bug isnt, the report was (given the issue did not show
up during initial testing but did show on Ferry's HW)
Merely citing the bug report from Ferry here

>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>>> ...
>>> RIP: 0010:dwc3_gadget_del_and_unmap_request+0x19/0xe0
>>> ...
>>> Call Trace:
>>> =C2=A0 dwc3_remove_requests.constprop.0+0x12f/0x170
>>> =C2=A0 __dwc3_gadget_ep_disable+0x7a/0x160
>>> =C2=A0 dwc3_gadget_ep_disable+0x3d/0xd0
>>> =C2=A0 usb_ep_disable+0x1c/0x70
>>> =C2=A0 u_audio_stop_capture+0x79/0x120 [u_audio]
>>> =C2=A0 afunc_set_alt+0x73/0x80 [usb_f_uac2]
>>> =C2=A0 composite_setup+0x224/0x1b90 [libcomposite]
>>>
>>> The issue happens only when the gadget is using the sync type "async",
>>> not
>>> "adaptive". This indicates that problem is likely coming from the
>>> feedback
>>> endpoint, which is only used with async synchronization mode.
>
> This does not describe the actual problem. The problem is that the
> usb_ep_dequeue() can be an asynchronous call, and we can't free the
> request until its completion (from cancellation).

Indeed. I was not sure at the time.

>
>>>
>>> Update the feedback endpoint free function to release the endpoint the
>>> same
>>> way it is done for the data endpoint.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>
>>> =C2=A0 Hi Ferry,
>>>
>>> =C2=A0 Would you mind trying this before reverting the whole thing ?
>>> =C2=A0 The HW I have did not show the issue so far so I can't really ch=
eck
>>> =C2=A0 if it helps. Hopefully, it does ...
>>=20
>> Tested this evening and confirming that this resolves my issue. I can't
>> say much about the code itself, maybe Thinh?
>
> Sure. I can take a look.
>
>>=20
>> Would be great if we could get this in instead of reverting the series.
>>=20
>> Tested-by:=C2=A0 Ferry Toth <ftoth@exalondelft.nl> (dwc3 / Intel Merrifi=
eld)
>>=20
>>> =C2=A0 drivers/usb/gadget/function/u_audio.c | 15 +++++++++++----
>>> =C2=A0 1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/u_audio.c
>>> b/drivers/usb/gadget/function/u_audio.c
>>> index 018dd0978995..63d9340f008e 100644
>>> --- a/drivers/usb/gadget/function/u_audio.c
>>> +++ b/drivers/usb/gadget/function/u_audio.c
>>> @@ -230,7 +230,13 @@ static void u_audio_iso_fback_complete(struct
>>> usb_ep *ep,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status =3D req->status;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* i/f shutting down */
>>> -=C2=A0=C2=A0=C2=A0 if (!prm->fb_ep_enabled || req->status =3D=3D -ESHU=
TDOWN)
>>> +=C2=A0=C2=A0=C2=A0 if (!prm->fb_ep_enabled) {
>
> prm->fb_ep_enabled is not protected. Potential race problem here?

Given how the variable is used, I don't think so.
Could you please detail ?

(I don't think this is really related to the current problem though)

>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(req->buf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_free_request(ep, req=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (req->status =3D=3D -ESHUTDOWN)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> @@ -421,9 +427,10 @@ static inline void free_ep_fback(struct
>>> uac_rtd_params *prm, struct usb_ep *ep)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prm->fb_ep_enabled =3D false;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prm->req_fback) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_dequeue(ep, prm->req=
_fback);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(prm->req_fback->buf);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_free_request(ep, prm=
->req_fback);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (usb_ep_dequeue(ep, prm-=
>req_fback)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfr=
ee(prm->req_fback->buf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb=
_ep_free_request(ep, prm->req_fback);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prm->req_fback =
=3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=20
>
> On a separate note, I notice that f_uac2 only queues a single feedback
> request at a time for isoc endpoint? Even though the interval is 1ms,
> this will easily cause data drop.
>
> Also, you're ignoring other request error status and still processing
> bogus data on request completion? That doesn't seem right.

Gadget is sendind the feedback data, not processing it. Every data sent
is OK.  Yes, packets can be missed with the current implementation,
meaning the feedback value is not reported as often as initially
intended. On slower HW, packets are also missed with 2 requests queued,
not only on the feedback endpoint but also on the playback
endpoint. Picking the approriate value is not straight forward. For the
feedback endpoint it isn't big deal because, according to the spec, if
the feedback is not sent, the host shall assume the value hasn't
changed. This why the whole thing works as it is.

I admit things still aren't perfect, but there is progress ...

>
> BR,
> Thinh

