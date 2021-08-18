Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2283EF825
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhHRCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhHRCoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:44:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A952C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 19:43:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so891796plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IdX62Qy1ac9xod4fIunCnDc2laglCBN/1fg/fcapW7I=;
        b=G6tJIDNDlZydQbdTY2UVKCARnR0cLR1jeU/0tSmRwID/hjR9YhYy5LOmm5/F9bq1uW
         qfPDBB3+IufGPZoTw7UhHEeYTi7OMB7dSK9c5x7RHgdS71Ij/33jgOe1S/lda7Z6O8pQ
         L7LYM4eS0atmpRtU/sYu/tWSgx3FYDiNIA6X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IdX62Qy1ac9xod4fIunCnDc2laglCBN/1fg/fcapW7I=;
        b=DAO0bEcHt+3ZK+RZrsS3qNrtjOTSq+0H9pArSALdcoWWLplqbpS0MSnL9GoELEIu8O
         uxQUo2c8RKzZQHX0JrC4h4txuFK3MNzzuN9s/iYwI8IJEYHoqKTH6GI2iBx1H+XRJILd
         fCmj8q2nuUye16ZHDkiXAe8NaWG43hRncQa2FELV5oeygDpqTjjvVFPSa7SONIIlhqON
         WAlH3zvV1x6q8bLlhsnnmwIuzvbzkNt+3GFJD9qPeCexaJ/mNja0yqMxWEH4DiYOUSkh
         aBqEC0BZnj+3GVed8WKV/YCC9mWN5l2Art/FEBNQs1xweqDIOxirTWAp+w8neTeYDwrm
         W7ww==
X-Gm-Message-State: AOAM533o9FCgFhsH0XEBRAgjVoktTfZfRWxOugn6ZAmaAaLD0vVigPeb
        mTyEqtRnFLcRrLvut3K48rCHhiF2/igMvRxUROoYtg==
X-Google-Smtp-Source: ABdhPJwgboGY7D2y/Zi68e8tvtNReZvQqvGbrT7qKSNk+cE6BASGnMkYk2/EYNENuEnG5CXBjupeV5V6s5a3ZKXxDgU=
X-Received: by 2002:a17:90b:4905:: with SMTP id kr5mr6634228pjb.112.1629254616776;
 Tue, 17 Aug 2021 19:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
 <YRDxTodNNqtnpPpn@kroah.com> <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
 <7b48f4c132a8b4b3819282e961fbe8b3ed753069.camel@mediatek.com>
 <CAATdQgD1paUUmWhiLVq-+zq0V6=RTJw89ggk=R6cBUZO+5dB-Q@mail.gmail.com> <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
In-Reply-To: <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 18 Aug 2021 10:43:25 +0800
Message-ID: <CAATdQgC_aukAA3-=cuiOAQGzu_Ztvo4BsMbRv2hCGZpUeOAJVg@mail.gmail.com>
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

Hi Chunfeng,

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

If it was for preventing drivers from out-of-bound array access,
I couldn't find any reasons why we cannot remove the above lines.
So can I know if it was just for preventing xhci-mtk drivers from
out-of-bounds array access?

If xhci-mtk HC itself can continue the transaction from Y_7 to (Y+1)_n;
including the case of Y=3D=3D63, I think it's just okay to rollover to (Y+1=
).

If it's prohibited by xhci-mtk hw, or if you think this patch is not
allowed by any other reasons, can you please  tell me what
kinds of problems can happen with this patch?

Otherwise, please consider minimizing the bw constraints from
xhci-mtk-sch on your side. Note that we're still having other usb
audio headsets which cannot be configured with xhci-mtk
even with this patch.

Thanks.

>
> >
> > Until now, I couldn't find a way to accept the USB audio headset
> > with a configuration of { INT-IN 64 + ISOC-OUT 384 + ISOC-IN 192 }
> > without this patch.
> what is the interval value of each endpoint?
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
