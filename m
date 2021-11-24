Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1F45B79A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhKXJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhKXJm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637746757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCwgu/iN8UvUnRGDuVKX8IG1jfgLBB20Ll53mZjRXog=;
        b=Z4VAc+5lRZZHA/7zFIcPtT9uTDkOeAWCU5zNKLawSx5FJ0EsJM7IBjWVN1aCmvs7xn1OCZ
        u3kt2mQ5+at2CAeKHlv6fyZPn/FKTusxpXe7NI0iwoL6amj/IBsQAQTIZQ6p100fpu/8WE
        0jUOFoBZg8TUPppRdrnCebbqGjVJT/w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-skC2DLrTM7i75CUQ-BowQQ-1; Wed, 24 Nov 2021 04:39:15 -0500
X-MC-Unique: skC2DLrTM7i75CUQ-BowQQ-1
Received: by mail-pg1-f197.google.com with SMTP id z10-20020a63e10a000000b003216c70bef7so527509pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCwgu/iN8UvUnRGDuVKX8IG1jfgLBB20Ll53mZjRXog=;
        b=axoLaUZguY7lqhfaUBoeT+NS8kQxOb04TeXSjZaG9IeqNo2XBe+yD5mjYiHhmt0u4A
         ad2iqtiNE0K4HomdEC+ZuzIUrjQEkGPaQurvZrVs2I+8fGYyXKF5mF5wrmbRtuNWqRbE
         GrQW2nWVu8RmjrvLSZqY5pIa+sORCMDy0xCRqKUm+9qRH9S8ITemo4gBtwPSj9ByXdAu
         q6rKzDUYvFyohHHJ1vfzm0RZvjkMvI2FTVO/EAQmoMmgIq8zC7wjdM78FzsK0zNurqMQ
         G1la1Nmp27b7lCAQFY2nsRqcymppJjNtW/g3W33KCJAA6wziIWy3cExaEz91px7GL0Ov
         1KVg==
X-Gm-Message-State: AOAM530Mr0RBasSLvLLI1VQDEz8BblNHaIlIrZ9ktzSAGSCnB/6x1DoU
        YPRjSOE2qCA+Ry1NuGnHETTlV17BM/SzS6ya/8tnKwUcKksCID2aAeZoNFeBq17/O6NJn5f588I
        f6XDlk809mbyYbr9VovuSmMwRNG/z+qJHRkk18Sov
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr13216911pjb.246.1637746754558;
        Wed, 24 Nov 2021 01:39:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhgOpc9n7O9Tx8Ko4L88LDtDV7faKx0HMHpbcxk55uIjDBqdstpusSYpNDQs7xPMtMbZ1FoZSqrENpQtmautA=
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr13216878pjb.246.1637746754313;
 Wed, 24 Nov 2021 01:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20211123191238.12472-1-jose.exposito89@gmail.com>
In-Reply-To: <20211123191238.12472-1-jose.exposito89@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 24 Nov 2021 10:39:02 +0100
Message-ID: <CAO-hwJLB8h6fQRF8UjN3rER_6xS2Shi3ffEr92PhkVCijtYRpQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Do not map BTN_RIGHT/MIDDLE on buttonpads
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jos=C3=A9,

On Tue, Nov 23, 2021 at 8:12 PM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
>
> Hi all,
>
> Historically, libinput has relayed on the INPUT_PROP_BUTTONPAD property
> to detect buttonpads.
>
> Since buttonpads are expected to have only one button (BTN_LEFT),
> recently we added a new rule to detect buttonpads: Where a touchpad
> maps the BTN_RIGHT bit, libinput assumes it is NOT a buttonpad.
>
> However, this change leaded to several false possitives, so we ended up
> reverting it. For more context:
> https://gitlab.freedesktop.org/libinput/libinput/-/issues/704
>
> And for a full list of affected hardware, HID reports and bug reports
> please see:
> https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726
>
> My understanding is that buttonpads should not map BTN_RIGHT and/or
> BTN_MIDDLE and to avoid it I would like to fix the required drivers.

As long as udev intrinsic is happy with it (and it correctly tags the
touchpad as ID_INPUT_something), I'm fine with it.

Also, you might want to point at the specification regarding button
pads: https://docs.microsoft.com/en-us/windows-hardware/design/component-gu=
idelines/touchpad-windows-precision-touchpad-collection#device-capabilities=
-feature-report

The way I read it: if the device exports the Button type value
feature, and it is 0 or 1 (click-pad or pressure-pad), there should
not be discrete buttons.

>
> One option to fix it (this patch) is to clear the bits that might have
> been added because of the HID descriptor on every driver.
> However, since this code will be common to all drivers, I would like to
> ask if you consider it worth it to add a function to handle adding
> properties.
>
> A function similar to input_set_capability but for props could be added
> in input.h/c:
>
>     /**
>      * input_set_property - add a property to the device
>      * @dev: device to add the property to
>      * @property: type of the property (INPUT_PROP_POINTER, INPUT_PROP_DI=
RECT...)
>      *
>      * In addition to setting up corresponding bit in dev->propbit the fu=
nction
>      * might add or remove related capabilities.
>      */
>     void input_set_property(struct input_dev *dev, unsigned int property)
>     {
>             switch (property) {
>             case INPUT_PROP_POINTER:
>             case INPUT_PROP_DIRECT:
>             case INPUT_PROP_SEMI_MT:
>             case INPUT_PROP_TOPBUTTONPAD:
>             case INPUT_PROP_POINTING_STICK:
>             case INPUT_PROP_ACCELEROMETER:
>                     break;
>
>             case INPUT_PROP_BUTTONPAD:
>                     input_set_capability(dev, EV_KEY, BTN_LEFT);
>                     __clear_bit(BTN_RIGHT, dev->keybit);
>                     __clear_bit(BTN_MIDDLE, dev->keybit);
>                     break;
>
>             default:
>                     pr_err("%s: unknown property %u\n", __func__, propert=
y);
>                     dump_stack();
>                     return;
>             }
>
>             __set_bit(property, dev->propbit);
>     }
>     EXPORT_SYMBOL(input_set_property);
>
>
> Which approach do you think is the best?

I think it depends if you plan on fixing just hid-multitouch or the others.
If you have more than one driver, then yes, adding a new symbol in
hid-input.c makes sense. If not, then you are just exposing a new
function we won't know if there are users and we won't be able to
change without care.

Cheers,
Benjamin

>
> Thank you very much in advance,
> Jose
>
>
> Jos=C3=A9 Exp=C3=B3sito (1):
>   HID: multitouch: only map BTN_LEFT on buttonpads
>
>  drivers/hid/hid-multitouch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> --
> 2.25.1
>

