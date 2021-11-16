Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD3452FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhKPLMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhKPLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637060959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HL9hhLdIrLyUpBuE4w+BC97fd9zpve2OyGyAHsqNBwE=;
        b=DEC4tYVqVE97FFFuwOk91/GtZN1xD2nGcA0K3Pfuk1kN83eX2c4qMIzAW7FqXsitywfPFR
        H4xhqjlKnjY7xGm92W1Rm65P3Kyxac4+XFeorqFwi0zsWI4vERAMhuh86lZoQ4TZo1a/qQ
        0N9Cy+lkzXFvKtQF+SAA9+GJt7vGh7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Md9CVOOyOx2JCDlNQcitPA-1; Tue, 16 Nov 2021 06:09:18 -0500
X-MC-Unique: Md9CVOOyOx2JCDlNQcitPA-1
Received: by mail-wr1-f71.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so4414790wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HL9hhLdIrLyUpBuE4w+BC97fd9zpve2OyGyAHsqNBwE=;
        b=OU+Ts9Iu5IEL/f5TU51FaWDPFc4UpjFZDlPUWoMSKJbrRgSLrLxjJ1/51jYut8s7Mf
         aXHIzXo5FAqCkaEf2GU0ttGb/mCA16/sacMmIQF0r658ctkt+1UTZA7NqLW66v5qzF8p
         nX7zg9rvMYRASlAVstyo8fsK8arYMCZiklGUEUKFtznZE+Sd3hDJHtJxBBX6XYyF/z7f
         4f1p1OP0mZKCn2gyYmNX4niNmgY5Na40qU8EpmII3sZy5I4tozLeSaAOrWEF6/hAcT6m
         dIRiFfXtfk4n/20xbxJJh/Te3nxbIl5zmdkZNjamNrYCDj7yiJZ5mOdQAN11yghxV00x
         nYcA==
X-Gm-Message-State: AOAM533Dc2PUrVOQAT3RreFt2y72YPMPNP2FyCMRYYgUIFSSYL+OPpmV
        fyoHxSqeoXPfMbsEe7V4uLVaVHVLzQpAkyX4FXlavMTVg6Jacyhe/n4NG+CfFF++oulRhy3jHtC
        zxQbX8+2uC5kMEp2gkspZE2WsxLMjGOcBZJsK/LKC
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr8196476wrm.229.1637060956897;
        Tue, 16 Nov 2021 03:09:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTgah4x2G9O8O+iUz5EmWC3uhlRWC07X48xzTEYzOUA98ZreV80VeBn9mcy5hBafA5uvas47+J9y5b040RUo4=
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr8196441wrm.229.1637060956649;
 Tue, 16 Nov 2021 03:09:16 -0800 (PST)
MIME-Version: 1.0
References: <CABvMjLTVZaU8vMW__2BDo6FnjFa_bsh2S-kEmg=KV4KTsFiUzA@mail.gmail.com>
 <CACO55tuDQ9UC2rr=_Hsowvujk49oNK1zWfHj3jMnhEqsTAnh0Q@mail.gmail.com> <CABvMjLSFLpG4=+tE3Sr2wfRsEuKLXMm++Xx+JNmA8YXptgzkmw@mail.gmail.com>
In-Reply-To: <CABvMjLSFLpG4=+tE3Sr2wfRsEuKLXMm++Xx+JNmA8YXptgzkmw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 16 Nov 2021 12:09:05 +0100
Message-ID: <CACO55tu5V1pF-Ox937Auq6vSreFTfz3gkaz0zg6Zk+ydyVpZwg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/core: fix the uninitialized use in nvkm_ioctl_map()
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 6:58 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> Hi Karol:
> Thanks for the feedback, the patch might be too old to apply to the
> latest code tree. Let me check and get back to you soon.
>

sorry, that's not what I meant. It used whitespaces instead of tabs
and the headers were also a bit broken. I just suspect that when
sending it something went wrong or so.

> On Sat, Nov 13, 2021 at 12:22 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > something seems to have messed with the patch so it doesn't apply correctly.
> >
> > On Thu, Jun 17, 2021 at 9:39 AM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> > >
> > > In function nvkm_ioctl_map(), the variable "type" could be
> > > uninitialized if "nvkm_object_map()" returns error code,
> > > however, it does not check the return value and directly
> > > use the "type" in the if statement, which is potentially
> > > unsafe.
> > >
> > > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > > b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > > index d777df5a64e6..7f2e8482f167 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > > @@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
> > >                 ret = nvkm_object_map(object, data, size, &type,
> > >                                       &args->v0.handle,
> > >                                       &args->v0.length);
> > > +               if (ret)
> > > +                       return ret;
> > >                 if (type == NVKM_OBJECT_MAP_IO)
> > >                         args->v0.type = NVIF_IOCTL_MAP_V0_IO;
> > >                 else
> > > --
> > > 2.17.1
> > >
> >
>
>
> --
> Kind Regards,
>
> Yizhuo Zhai
>
> Computer Science, Graduate Student
> University of California, Riverside
>

