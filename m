Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC93EA5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhHLNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhHLNsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:48:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845CC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:47:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b7so7343690plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyhelxpd7QUVPAkk5IYGM9KEnUOWxWDMxwO8ECoYdnU=;
        b=Rs4dAv5o9o6YzH/Kos2vl/SACHZatk/nOkTogbL/1EBFQ9n8+ZFw91oSx+CeUKBQ3H
         2m6mLxziThndH+V4UTq3JF0Qt/JuqFap8S5hupa6Ec5y4PXtz7ajadJH4M8D5rAQblUM
         2su3i/xOb5hBn41lp62bfbt0FSGbf+Admw2lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyhelxpd7QUVPAkk5IYGM9KEnUOWxWDMxwO8ECoYdnU=;
        b=bZSFnYawDH3iiRR1zMmBswNB7brDBb2cIXPpCphNNUDqzduOeiPiAZhhKhkrP84vO2
         GggQLGrvD/lkbH0FfKyyGWuagx8Eeb+jEQvTpuQGpvnFUjr/UGfWxskkNU6NToRaGGiQ
         0OeWfFnhp7Y6ILEwzZSaHNGdhIsgJLJtu/Mf3dZLh2BCPDIPDy8GzuLhhsRN+WVVZoBU
         Dg7W9uHheWQJHPAQWncRlieM2iZvF4bXi742xgNL5wfwI4RSUH/MiS0mkBwPcbnhpuXZ
         /oTk2TZaHSSIJrLFfCfAyIEOw3IGXKVuxIbiGh8KDC2BhAEoWUKhX7LmTJDLZmn73T+9
         dOVg==
X-Gm-Message-State: AOAM530nkJSCIDqsICO87FaArXq9hnC6vxJGUbXMQB4wvE/TyMi4DLS8
        2DMxkqQIPnTWOH9in9DadbRWUitM3zl/cORTYx4VkA==
X-Google-Smtp-Source: ABdhPJzinP+pujlw1HqtoYlTgrZfNU12HLzMgQ+D3ezfZIHtqfWhJuEgsvdCWLJhspWCTXhKmsXTVvomNXPsynDbZYk=
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id
 u7-20020aa783870000b0290395a683a0e6mr4295749pfm.12.1628776053473; Thu, 12 Aug
 2021 06:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
 <YRDxTodNNqtnpPpn@kroah.com> <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
 <7b48f4c132a8b4b3819282e961fbe8b3ed753069.camel@mediatek.com>
 <CAATdQgD1paUUmWhiLVq-+zq0V6=RTJw89ggk=R6cBUZO+5dB-Q@mail.gmail.com> <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
In-Reply-To: <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 12 Aug 2021 21:47:22 +0800
Message-ID: <CAATdQgATOhAcr7uMyxAvZCdngMaa-bbG3GDpun11LHOHeLqMjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops sorry I sent a prior mail in HTML.
Resend this mail in plain text.

On Thu, Aug 12, 2021 at 7:49 PM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=B0)
<Chunfeng.Yun@mediatek.com> wrote:
>
> On Thu, 2021-08-12 at 17:31 +0800, Ikjoon Jang wrote:
> > HI,
> >
> > On Wed, Aug 11, 2021 at 5:02 PM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=
=B0)
> > <Chunfeng.Yun@mediatek.com> wrote:
> > >
> > > On Mon, 2021-08-09 at 17:42 +0800, Ikjoon Jang wrote:
> > > > On Mon, Aug 9, 2021 at 5:11 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Aug 09, 2021 at 04:59:29PM +0800, Ikjoon Jang wrote:
> > > > > > xhci-mtk has 64 slots for periodic bandwidth calculations and
> > > > > > each
> > > > > > slot represents byte budgets on a microframe. When an
> > > > > > endpoint's
> > > > > > allocation sits on the boundary of the table, byte budgets'
> > > > > > slot
> > > > > > should be rolled over but the current implementation doesn't.
> > > > > >
> > > > > > This patch applies a 6 bits mask to the microframe index to
> > > > > > handle
> > > > > > its rollover 64 slots and prevent out-of-bounds array access.
> > > > > >
> > > > > > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  drivers/usb/host/xhci-mtk-sch.c | 79 +++++++++------------
> > > > > > ----
> > > > > > --------
> > > > > >  drivers/usb/host/xhci-mtk.h     |  1 +
> > > > > >  2 files changed, 23 insertions(+), 57 deletions(-)
> > > > >
> > > > > Why is this "RFC"?  What needs to be addressed in this change
> > > > > before it
> > > > > can be accepted?
> > > >
> > > > sorry, I had to mention why this is RFC:
> > > >
> > > > I simply don't know about the details of the xhci-mtk internals.
> > > > It was okay from my tests with mt8173 and I think this will be
> > > > harmless
> > > > as this is "better than before".
> > > >
> > > > But when I removed get_esit_boundary(), I really have no idea why
> > > > it was there. I'm wondering if there was another reason of that
> > > > function
> > > > other than just preventing out-of-bounds. Maybe chunfeng can
> > > > answer
> > > > this?
> > >
> > > We use @esit to prevent out-of-bounds array access. it's not a
> > > ring,
> > > can't insert out-of-bounds value into head slot.
> >
> > Thanks, so that function was only for out-of-bounds array access.
> > then I think we just can remove that function and use it as a ring.
> > Can you tell me _why_ it can't be used as a ring?
> Treat it as a period, roll over slot equals to put it into the next
> period.
>
> >
> > I think a transaction (e.g. esit_boundary =3D 7) can start its first
> > SSPLIT
> > from Y_7 (offset =3D 7). But will that allocation be matched with this?
> >
> > -               if ((offset + sch_ep->num_budget_microframes) >
> > esit_boundary)
> > -                       break;
> >
> > I mean I'm not sure why this is needed.
> Prevent out-of-bounds.
>
> >
> > Until now, I couldn't find a way to accept the USB audio headset
> > with a configuration of { INT-IN 64 + ISOC-OUT 384 + ISOC-IN 192 }
> > without this patch.
> what is the interval value of each endpoint?

interrupt ep is 2ms and others are 1ms
Thanks.

>
> >
> > >
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
