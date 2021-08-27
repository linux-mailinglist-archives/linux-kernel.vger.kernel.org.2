Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C123F96EF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbhH0J10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbhH0J1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:27:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:26:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso3869380wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wF0uIDIgShpTPEd9rqT4PGDU/K6VDBXfaZiEIVdnuIE=;
        b=bzX8KF9YCz5YCsnxGdeyeJ9my4fTQkap0yMExSSko9O4L6nHW697Tj3RhGHvPQ48x6
         H025eJF6ANFelWU621QnI5yOG5+mNsmbTB13ogTtYu+Q5NnOo+OmXgwW0yyHtg44kzwc
         EIbyIGcOafi5DQoPAKVTiT1z1l9FkYJbtPEDCKuAmoVHcjIMtqn4ukTXhckzl/7zDVK+
         cjROwr50JnNg3T9bWeHGieAdpmRg31Nhj8qxfB906IQ/oy75VWZJf1vprMTvOepmVAyO
         KyDYmYSbqeCLLlKOGsK4q/f910Q03R9/qqVFzntt9O3EU9WaG8vR1LGEO1CMAH7IiGKK
         Q5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wF0uIDIgShpTPEd9rqT4PGDU/K6VDBXfaZiEIVdnuIE=;
        b=auxGPnvPqFW5drWaXN+NH5tfY+WOCBUlnejKSwfPWR8BfeC7KtYejgMlqxGKnKxQ1z
         SvXmgJpCBnTvre6G4jBLhkPC86A80okse3PwujLlfSEhQ5dOkm9BwzB/wRIj9JM8cZ/f
         9WYnF7fPmG2JakxZ/kCJl4FH+t+reXTHRsbWOZkLvFddpfrc61MERO26qER7ORpQbsQL
         YZ0FMcY4ivAPYZcSn1Av2eMmWMphU0eCnyjdPgTBZelqeDyXvBqIMSaX+Adkj839dgry
         Xh5bcpYIfe53faNW2/9r58fU29vRGvi5TQ1jOfOUXi7G2hau/2gdOnEP625HeIvnC4uT
         BhtQ==
X-Gm-Message-State: AOAM530cWiw9rHIfSHjjL7KCTevkZ4dI/z1jBZduANVyU0zgXusx7HqE
        2JG8JVsOTpvRr5AdMiBp3PAeaA==
X-Google-Smtp-Source: ABdhPJwELYQZOkqrkNnnr6bHsLe7bUcq0F3gy7Bs5kj7+uCuI5HrXHevEblv8SQp3623pFUYW54bDw==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr18123424wms.138.1630056393495;
        Fri, 27 Aug 2021 02:26:33 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o21sm4844926wms.32.2021.08.27.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:26:33 -0700 (PDT)
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
 <20210825092107.124419-1-jbrunet@baylibre.com>
 <79bd686d-5c1f-982c-344a-17c10b64a231@gmail.com>
 <9709a13f-46f5-ad53-3d19-86b4954bb0f8@synopsys.com>
 <1jbl5ky7a4.fsf@starbuckisacylon.baylibre.com>
 <a2bbb7eb-f952-bc35-6a58-68b15515c716@synopsys.com>
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
Date:   Fri, 27 Aug 2021 10:38:12 +0200
In-reply-to: <a2bbb7eb-f952-bc35-6a58-68b15515c716@synopsys.com>
Message-ID: <1jk0k7w853.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 27 Aug 2021 at 00:50, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

>>>>> diff --git a/drivers/usb/gadget/function/u_audio.c
>>>>> b/drivers/usb/gadget/function/u_audio.c
>>>>> index 018dd0978995..63d9340f008e 100644
>>>>> --- a/drivers/usb/gadget/function/u_audio.c
>>>>> +++ b/drivers/usb/gadget/function/u_audio.c
>>>>> @@ -230,7 +230,13 @@ static void u_audio_iso_fback_complete(struct
>>>>> usb_ep *ep,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status =3D req->status;
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* i/f shutting down */
>>>>> -=C2=A0=C2=A0=C2=A0 if (!prm->fb_ep_enabled || req->status =3D=3D -ES=
HUTDOWN)
>>>>> +=C2=A0=C2=A0=C2=A0 if (!prm->fb_ep_enabled) {
>>>
>>> prm->fb_ep_enabled is not protected. Potential race problem here?
>>=20
>> Given how the variable is used, I don't think so.
>> Could you please detail ?
>>=20
>
> I'm thinking of this scenario:
>
> Since free_ep_fback() is called in a separate thread,
> u_audio_iso_fback_complete() can come in the middle after
> prm->fb_ep_enabled is cleared but before the usb_ep_dequeue(). So the
> request may be freed before being accessed again in usb_ep_dequeue().
>

You are right - there is short window of opportunity.
Looks like a 2nd separate issue affecting all u_audio endpoints. (Would
be solved by reverting the feedback series)

Fix seems fairly simple.

>> (I don't think this is really related to the current problem though)
>
> It's related to how we go about to solve the problem right?
>
> Can we just check for the req->status for -ECONNRESET and -ESHUTDOWN and
> free the request? Those 2 statuses should be for when the request is
> cancelled and when the endpoint is disabled.
>

The same problem happened on the data endpoint while feedback was being
reviewed. This is why data got fixed, and the feedback endpoint did not.

As explained in the description, the fix is merely aligning what is
done for the different endpoints here.

Some of the people who have worked on this are no USB expert (myself
included) so I'm sure things can be improved. I'd suggest to take the
rework u_audio as a 2nd step.

>>=20
>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(req->buf);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_free_request(ep, r=
eq);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (req->status =3D=3D -ESHUTDOWN)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> @@ -421,9 +427,10 @@ static inline void free_ep_fback(struct
>>>>> uac_rtd_params *prm, struct usb_ep *ep)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prm->fb_ep_enabled =3D false;
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prm->req_fback) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_dequeue(ep, prm->r=
eq_fback);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(prm->req_fback->buf=
);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_ep_free_request(ep, p=
rm->req_fback);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (usb_ep_dequeue(ep, pr=
m->req_fback)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
free(prm->req_fback->buf);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
sb_ep_free_request(ep, prm->req_fback);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prm->req_fback=
 =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=20
>>>
>>> On a separate note, I notice that f_uac2 only queues a single feedback
>>> request at a time for isoc endpoint? Even though the interval is 1ms,
>>> this will easily cause data drop.
>>>
>>> Also, you're ignoring other request error status and still processing
>>> bogus data on request completion? That doesn't seem right.
>>=20
>> Gadget is sendind the feedback data, not processing it. Every data sent
>
> Ah ok.. I missed that it's IN request.
>
>> is OK.  Yes, packets can be missed with the current implementation,
>> meaning the feedback value is not reported as often as initially
>> intended. On slower HW, packets are also missed with 2 requests queued,
>
> 2 is still too low. From our HW testing, minimum should be 4 to minimize
> data loss at 1ms interval.

Maybe 4 should be the default then ?

>
>> not only on the feedback endpoint but also on the playback
>> endpoint. Picking the approriate value is not straight forward. For the
>> feedback endpoint it isn't big deal because, according to the spec, if
>> the feedback is not sent, the host shall assume the value hasn't
>> changed. This why the whole thing works as it is.
>
> Why do this when we can avoid it.

Because it was not known at the time

> We know that there will be data drop
> with the way it's implemented now. There's no option to adjust the
> number of feedback requests either.
>
>>=20
>> I admit things still aren't perfect, but there is progress ...
>>=20
> Thanks for the updates to audio/f_uac2. It's been a long time since
> anyone working on it.
>
> BR,
> Thinh

