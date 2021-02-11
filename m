Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59331883D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhBKKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:34:06 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:35343 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBKKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:31:00 -0500
Received: by mail-ej1-f43.google.com with SMTP id a9so9278400ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPyvQUHLX1Tn5p9iynyrC2X5bIUlPY0d5Hn4CW229v0=;
        b=jJUKf3sOdqi3kyHzAIYHxO5fnKL3g6lVlID8/6OqYPQXDJhebHRHM1gzpi/FNZAZJL
         Nox98ysmz1lTK9YWv7oKQn6viwNSHKtYpedewwQF7/Czlmnx59AAjlUaCjnXfZ2DRW7z
         j3b3XzrUVLWRy0ryZGVrHMlJhWiJ8+fVEjtna17j4NfG1mGhw7dXrW+b7TohKuDMp+h5
         7FmFYUGioTfjUB1GyDNU7i9R44qj2wOF9a1FQBYgbQRlMFFIwFGYvQpcuJF118BDGZqz
         tay5GBsA4wgNbTXQJY3n5JZIIn9m2sGH2cFCXtyTx1fnxsV0qnB/LR/zYDgi1XjDVOIO
         Td/w==
X-Gm-Message-State: AOAM532Yz/i0bImQi87aCIbcOyf5pkPW/JGqwlD/bWr813K3747tzzV/
        VPIIWLy2aHAXii1j2I7zl1Jg4XYzb4nSwA==
X-Google-Smtp-Source: ABdhPJyLpfcKJtkxjxUON5x/jHPvRTRQmDDMTivTDU6vq3svzJCNIlyLEcS6rI8xsS6nTajAA4EasA==
X-Received: by 2002:a17:906:fc5:: with SMTP id c5mr7617927ejk.538.1613039417420;
        Thu, 11 Feb 2021 02:30:17 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id p32sm3573279edd.96.2021.02.11.02.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 02:30:17 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id y9so9198014ejp.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:30:17 -0800 (PST)
X-Received: by 2002:a17:906:4bc2:: with SMTP id x2mr8060170ejv.143.1613039416861;
 Thu, 11 Feb 2021 02:30:16 -0800 (PST)
MIME-Version: 1.0
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com> <20210211075715.GD2696@kadam>
In-Reply-To: <20210211075715.GD2696@kadam>
From:   karthek <mail@karthek.com>
Date:   Thu, 11 Feb 2021 16:00:04 +0530
X-Gmail-Original-Message-ID: <CAJ5zXr3ONFFHL7g8Xt=BjM9SJK16HEwiqhkBPTbrBTwa=DDqog@mail.gmail.com>
Message-ID: <CAJ5zXr3ONFFHL7g8Xt=BjM9SJK16HEwiqhkBPTbrBTwa=DDqog@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should i send them as patch series?

On Thu, Feb 11, 2021 at 1:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Feb 11, 2021 at 12:40:41AM +0530, karthik alapati wrote:
> > @@ -867,10 +845,8 @@ static void PHY_HandleSwChnlAndSetBW8723B(
> >       if (bSetBandWidth)
> >               pHalData->bSetChnlBW = true;
> >
> > -     if (!pHalData->bSetChnlBW && !pHalData->bSwChnl) {
> > -             /* DBG_871X("<= PHY_HandleSwChnlAndSetBW8812: bSwChnl %d, bSetChnlBW %d\n", pHalData->bSwChnl, pHalData->bSetChnlBW); */
> > +     if (!pHalData->bSetChnlBW && !pHalData->bSwChnl)
> >               return;
> > -     }
>
> In this case, the + line is correct.  Good job.
>
> >
> >
> >       if (pHalData->bSwChnl) {
> > @@ -929,9 +905,7 @@ void PHY_SetSwChnlBWMode8723B(
> >       u8 Offset80
> >  )
> >  {
> > -     /* DBG_871X("%s() ===>\n", __func__); */
> >
> >       PHY_HandleSwChnlAndSetBW8723B(Adapter, true, true, channel, Bandwidth, Offset40, Offset80, channel);
> >
> > -     /* DBG_871X("<==%s()\n", __func__); */
>
> Please delete the blank lines as well.
>
> regards,
> dan carpenter
>
