Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C83F3B91
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhHURCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHURCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:02:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329EC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:02:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q2so12366206pgt.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrX1C2u1Acg0x62CQ0RePaJzn5DDLf3h8Xdu3YCej7k=;
        b=jXu98Fq7FiwgBZ1hQpkjk+4oYEbE8GpwNM+LUBqYmyvzTYUoRMHqVz1lBUQx1ykoSS
         x92Y1Ii7PA9x+8Q8zOUslCTmL6ml9NWNO7ofXk9wkELjQIesdo2Duax2omt1j4oyAIp3
         TRgzqtNX4wUHiXKzEAAW++gU4jg90cmvCgNBPUkIU/vDyEzDAWG0Y9GyEu5R4aiM5FDC
         zQfcnIpfj8liJeqXuTiGqUPmaWcVyS3w23HLrDZg6mziAhdc3J+ZamiZWlODKOw4iRuh
         mMyTd52DcIrk/k6ej7MsyER6z6JT5szs9vhBK+lTdT0K1/dt2xse2jogmXakMLFIatYS
         yKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrX1C2u1Acg0x62CQ0RePaJzn5DDLf3h8Xdu3YCej7k=;
        b=XjhxdIvC2TsYdkVYfUog8PHHjTpxSdnD56AA5FIWAcWAnHTAQI8LhGfWTr7J6nRsPm
         UF4YfDg+q6wfjAxq5PTP3ygfrjSGwk5t/O1/KFmzJQbqXFENA8Bbz6MBKK4nnz2fFvSk
         zfo1rriUI+JhQpaXHlSRYHuJfwZIvGL1qW9Fvmj3/Edf4uxRVFwZcUKD7CBvTnPJ24sv
         Rc95NW5g8QukP82x/nAOwzyHITsphx1EBdsyiESdmmNFElC4rQGn/7cEPUrcPg9S/IcP
         OQAPBjToM7pPHH2m04eEm/GwJes2dBubEMlapUHVJEKcFLt5Wi871GRhRjF7GAXr41yy
         LTrw==
X-Gm-Message-State: AOAM533LuQ6ihvJOui4KZk4+dHk2gCcYdR8knWq6xcNd5X75ecbtzuRD
        PnqmCfgPIDPqakfmEMh+wLjCq/R0b0gXNO+m/8D7kW1TxW5IcQ==
X-Google-Smtp-Source: ABdhPJx00tsYkPjFkmrEWDDQQvG1u+sHP3Ix62shFwjUjm3gwJyPQN8Wql/QaIy13JiZWc8ir2cIX8QqO2dE20wi7jI=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr24348001pgu.82.1629565320118;
 Sat, 21 Aug 2021 10:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210821105615.6307-1-phil@philpotter.co.uk> <f151ef3c-d625-a937-2096-afae4fee20f1@gmail.com>
In-Reply-To: <f151ef3c-d625-a937-2096-afae4fee20f1@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:01:49 +0100
Message-ID: <CAA=Fs0mSomgGme9Rfg3vQhtHq6xiFBWis3C4t9zB8rQ7MbZEjA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: r8188eu: change declaration of Efuse_Read1ByteFromFakeContent
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 12:03, Michael Straube <straube.linux@gmail.com> wrote:
>
> On 8/21/21 12:56 PM, Phillip Potter wrote:
> > Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> > from core/rtw_efuse.c, as the function is defined in full directly
> > after this and therefore this forward declaration is redundant.
> >
> > In addition, convert the storage class of the function to static, as the
> > function is only used with rtw_efuse.c, and tidy up the signature
> > alignment.
> >
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >
> > V1: Removed forward declaration.
> > V2: Takes account of feedback from Michael Straube and Fabio M. De
> >      Francesco to make storage class of the function static.
> >
> > ---
> >   drivers/staging/r8188eu/core/rtw_efuse.c | 14 +++-----------
> >   1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> > index decccf7622f0..c1c70648f5bc 100644
> > --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> > +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> > @@ -29,17 +29,9 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
> >   #define REG_EFUSE_CTRL              0x0030
> >   #define EFUSE_CTRL                  REG_EFUSE_CTRL          /*  E-Fuse Control. */
> >   /*  */
> > -
> > -bool
> > -Efuse_Read1ByteFromFakeContent(
> > -                     struct adapter *pAdapter,
> > -                     u16 Offset,
> > -             u8 *Value);
> > -bool
> > -Efuse_Read1ByteFromFakeContent(
> > -                     struct adapter *pAdapter,
> > -                     u16 Offset,
> > -             u8 *Value)
> > +static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
> > +                                        u16 Offset,
> > +                                        u8 *Value)
> >   {
> >       if (Offset >= EFUSE_MAX_HW_SIZE)
> >               return false;
> >
>
> Looks good to me.
>
> Acked-by: Michael Straube<straube.linux@gmail.com>
>
>
> Thanks,
>
> Michael

Thanks Michael.

Regards,
Phil
