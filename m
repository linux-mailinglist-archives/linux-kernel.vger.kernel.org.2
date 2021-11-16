Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5484531EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhKPMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235896AbhKPMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637064796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mla+rQ+WFHoxUA/puCp/B5Joyk+fWSSuxWnEdTY0A+4=;
        b=CtzC5CTiV2h6bbiRtlx78aVSJ6gmbni9BS9OJZUoZ7QT8JzpxCnVkmYwC6NEMvnRolMd14
        xv4yGldELH0k2Jwdj483mmqBZ1H+1wLC39YrcBYWnTD86HCSiVtlJtOBDP//Hbsf3BR7Ji
        t3ueO2/vws3NboGKZlWlTZgB3d99Oqs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-UZIAWljqNNKfMSNRSxUw0w-1; Tue, 16 Nov 2021 07:13:15 -0500
X-MC-Unique: UZIAWljqNNKfMSNRSxUw0w-1
Received: by mail-pj1-f70.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso1475146pjf.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mla+rQ+WFHoxUA/puCp/B5Joyk+fWSSuxWnEdTY0A+4=;
        b=m8RkHcFZZ9jRVUv2TwmQC7WDGvHndFW5nDMQyaTJ6QwEnmpqoRL2/USSnFUWFEi2jo
         Y/n9BblvRLJ4D5Siy4dELNuZTnhDnJXDBp0UJZqhYO5+BvN1BJrsjKRL9U6v29k1uc9M
         gE1QEp+W2OxsVDuqQ7BYgdcGb2QFztdAFuzRGkXHWhiPTejbXU2f7fvawKOp2zeufDiZ
         Hg7KMXllSVPirWyAAGuU3ZYZl6CgPZv0gDOT2xyHpBpacvJ86jHx9JPjrt985neuUYN7
         sb5aBP8LZeTpkR974GzJi7nZnxEKSwMxlXfzyXqzR9VVbJkZJV/ux2InO34olExMeRND
         I1Iw==
X-Gm-Message-State: AOAM530wl5/WpbYIaU6IAE3bKu8oDOZsHHJ1Qhnu2rsSgoc347WdMdFA
        uVgjE3vWke7MZ+cKyrx84XDXxUVMK7liBmWeKFbLrHVqcFib0ur2RzY5BzrniJrmu4Vv9c4KZuv
        KmKlJuhyQVMv9KvmtQOOCMpD4bGsldB84iyRrahLU
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr73443802pjb.246.1637064794466;
        Tue, 16 Nov 2021 04:13:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2q8bp1EeTPmi8KDeYcbeVToggmyBX37vXDx90Onc2Hs8BcFKdLqCWKtawha/5X6PnGesRqOnMHKvtb74FISY=
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr73443754pjb.246.1637064794207;
 Tue, 16 Nov 2021 04:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20211112135511.29573-1-linux@zary.sk> <202111150937.31306.linux@zary.sk>
 <CAO-hwJ+B3er4PdNh1Nq3iGC+1bC1Gd0NZZ+UkRvGDXocTiXrXg@mail.gmail.com> <202111161207.00633.linux@zary.sk>
In-Reply-To: <202111161207.00633.linux@zary.sk>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 16 Nov 2021 13:13:03 +0100
Message-ID: <CAO-hwJ+huX5wFQjwzZ+o9zOonCuifiyQ2rZosTWW7or09_SfiA@mail.gmail.com>
Subject: Re: [PATCH] hid-multitouch: Fix Iiyama ProLite T1931SAW (0eef:0001 again!)
To:     Ondrej Zary <linux@zary.sk>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:07 PM Ondrej Zary <linux@zary.sk> wrote:
>
> On Tuesday 16 November 2021, Benjamin Tissoires wrote:
> > On Mon, Nov 15, 2021 at 9:37 AM Ondrej Zary <linux@zary.sk> wrote:
> > >
> > > On Friday 12 November 2021, Benjamin Tissoires wrote:
> > > > Hi Ondrej,
> > > >
> > > > On Fri, Nov 12, 2021 at 3:00 PM Ondrej Zary <linux@zary.sk> wrote:
> > > > >
> > > > > Iiyama ProLite T1931SAW does not work with Linux - input devices are
> > > > > created but cursor does not move.
> > > > >
> > > > > It has the infamous 0eef:0001 ID which has been reused for various
> > > > > devices before.
> > > > >
> > > > > It seems to require export_all_inputs = true.
> > > > > Add it to mt_devices[] as MT_CLS_WIN_8 to fix the problem.
> > > > > Hopefully there are no HID devices using this ID that will break.
> > > > > It should not break non-HID devices (handled by usbtouchscreen).
> > > >
> > > > Hmm, this is worrisome. I am pretty sure there were some eGalax 0001
> > > > devices that were Win 7 compatible and I am not sure if they are
> > > > compatible with Win8...
> > > >
> > > > I guess that if you have to set MT_CLS_WIN_8, the device is not
> > > > detected as such. so how about you use:
> > > > MT_CLS_EXPORT_ALL_INPUTS instead, (to keep MT_CLS_DEFAULT for those
> > > > devices), and restrict the VID/PID matching to the non Win8 devices:
> > >
> > > It works with MT_CLS_EXPORT_ALL_INPUTS.
> > >
> > > > HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_DWAV,
> > > > USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
> > >
> > > But does not match HID_GROUP_GENERIC.
> >
> > Sorry, it should have been HID_GROUP_MULTITOUCH
>
> That's exactly how MT_USB_DEVICE is defined:
> #define MT_USB_DEVICE(v, p)     HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH, v, p)

Oops, sorry. That's what happens when I rely too much on my memory and
don't check the code :(

>
> So it's equal to MT_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
> Will that match only non-Win8 devices?

Nope, you're correct, it will only match non-Win8 devices.
So the only comment I have on your patch is to use
MT_CLS_EXPORT_ALL_INPUTS instead of MT_CLS_WIN_8.

Cheers,
Benjamin

>
> > Cheers,
> > Benjamin
> >
> > >
> > > >
> > > > ?
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > > > >
> > > > > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > > > > ---
> > > > >  drivers/hid/hid-multitouch.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > > > > index e1afddb7b33d..099daf590392 100644
> > > > > --- a/drivers/hid/hid-multitouch.c
> > > > > +++ b/drivers/hid/hid-multitouch.c
> > > > > @@ -1888,6 +1888,11 @@ static const struct hid_device_id mt_devices[] = {
> > > > >                 MT_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
> > > > >                         USB_DEVICE_ID_CVTOUCH_SCREEN) },
> > > > >
> > > > > +       /* eGalax devices (SAW) */
> > > > > +       { .driver_data = MT_CLS_WIN_8,
> > > > > +               MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
> > > > > +                       USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER) },
> > > > > +
> > > > >         /* eGalax devices (resistive) */
> > > > >         { .driver_data = MT_CLS_EGALAX,
> > > > >                 MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
> > > > > --
> > > > > Ondrej Zary
> > > > >
> > > >
> > > >
> > >
> > >
> > >
> > > --
> > > Ondrej Zary
> > >
> >
> >
>
>
>
> --
> Ondrej Zary
>

