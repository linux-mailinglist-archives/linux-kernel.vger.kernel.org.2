Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C133F96B3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhH0JPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhH0JPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:15:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F2C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:14:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t42so5138560pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bul2XBNYr2W7qjEGBkEooccb8RDlBWjlNLT/gh1cvl0=;
        b=SEeQltv+gWkf4WKKwQtBVy+3a+FHo9EYzZ02BCgRVgIX5Ze2aIGZkyfFX3+Ohe+ocF
         w99OdsCZNeFD9ZJYjy7PIWvca6d92r4NTXWtHtsrK+hzsLzSqrODu9Ost5G7ejp5sh0d
         fTQRiyX2LVkUHtC7HFWv9Wo/mxC2twW2WMKbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bul2XBNYr2W7qjEGBkEooccb8RDlBWjlNLT/gh1cvl0=;
        b=cWIM+YGb3pnWFBZhrVd5Ot+P0N+DUsKfQR6wOQ11sj8yppxzXIdXPP81IFckD7y+03
         3WeGnA/ibC8klSNQXX9J0gTiw3I8WKjNgXva+ZtoEv/P/ZzK4e97kLGXAQuecO7uGyCP
         5EDGjkb/YUZSja3188sh8SnUpo7XZ9/yuq5EmU95+bBs8i7YOgTNHFdb6k51sT3YQViB
         vGi6v4mGAC/Q5M8K2h4pa+29aiQighARu0AaL9Xkt65x5C2RFRyTT/KA3yyFKsmInRRr
         18+NiWRRx2VG3+up0xIsobX41ez/G6dBvffOS5rAUCryDEkAvqilZxhC3i6acHO71og3
         Sg9Q==
X-Gm-Message-State: AOAM5303AI9zhYDS8OPlppF065oeGaXYL6r2GnUvJQJpu80/0mXcmu+O
        DvxGv7KSOyZtHcQa+UnDaVDtMdzlCiKIkQpLidCzoA==
X-Google-Smtp-Source: ABdhPJwmxL3HzsVntC18e8cdVE9YrLF+iRuENEYMaXfgIc8qYHjOL7VABV1L2+5PpXzA+c+19W4vykGQJyghGL/+P9w=
X-Received: by 2002:a63:5559:: with SMTP id f25mr7035771pgm.299.1630055668026;
 Fri, 27 Aug 2021 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
 <20210826025144.51992-3-chunfeng.yun@mediatek.com> <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
 <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
In-Reply-To: <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 27 Aug 2021 17:14:17 +0800
Message-ID: <CAATdQgA+4VC7J1LMZYOZMV-OTjMGjO=9bJZ7uaCu_MMF-20T1w@mail.gmail.com>
Subject: Re: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by bw_budget_table
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?UTF-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?UTF-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 2:49 PM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=B0)
<Chunfeng.Yun@mediatek.com> wrote:
>
> On Thu, 2021-08-26 at 19:54 +0800, Ikjoon Jang wrote:
> > Hi Chunfeng,
> >
> > On Thu, Aug 26, 2021 at 10:52 AM Chunfeng Yun <
> > chunfeng.yun@mediatek.com> wrote:
> > >
> > > Use @bw_budget_table[] to update fs bus bandwidth due to
> > > not all microframes consume @bw_cost_per_microframe, see
> > > setup_sch_info().
> > >
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v2: new patch, move from another series
> > > ---
> > >  drivers/usb/host/xhci-mtk-sch.c | 17 +++++++----------
> > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/xhci-mtk-sch.c
> > > b/drivers/usb/host/xhci-mtk-sch.c
> > > index cffcaf4dfa9f..83abd28269ca 100644
> > > --- a/drivers/usb/host/xhci-mtk-sch.c
> > > +++ b/drivers/usb/host/xhci-mtk-sch.c
> > > @@ -458,8 +458,8 @@ static int check_fs_bus_bw(struct
> > > mu3h_sch_ep_info *sch_ep, int offset)
> > >                  * Compared with hs bus, no matter what ep type,
> > >                  * the hub will always delay one uframe to send
> > > data
> > >                  */
> > > -               for (j =3D 0; j < sch_ep->cs_count; j++) {
> > > -                       tmp =3D tt->fs_bus_bw[base + j] + sch_ep-
> > > >bw_cost_per_microframe;
> > > +               for (j =3D 0; j < sch_ep->num_budget_microframes;
> > > j++) {
> > > +                       tmp =3D tt->fs_bus_bw[base + j] + sch_ep-
> > > >bw_budget_table[j];
> >
> > I'm worrying about this case with two endpoints,
> > * EP1OUT: isochronous, maxpacket=3D192: bw_budget_table[] =3D { 188, 18=
8,
> > 0, ... }
> > * EP2IN: interrupt, maxpacket=3D64: bw_budget_table[] =3D { 0, 0, 64, 6=
4,
> > ... }
> > (Is this correct bw_budget_table contents for those eps?)
> Yes, ep1out isoc use two uframe, ep2in intr use a extra cs;
> >
> > I'm not sure if it's okay for those two endpoints to be allocated
> > on the same u-frame slot.
> > Can you please check if this is okay for xhci-mtk?
> Already test it this afternoon, can transfer data rightly on our dvt
> env.
>
> > (I feel like I already asked the same questions many times.)
> Yes, as said before, prefer to use bw_budget_table[], if there is
> issue, we can fix it by building this table.

So do you mean such an allocation shouldn't be a problem by IP design?

This patch starts to allow such an allocation (again).
But i remember my earlier tests showed that when those two eps
in the above example are allocated on the same u-frame slot,
xhci-mtk puts "SSPLIT for EP2" between
"SSPLIT-start and SSPLIT-end for EP1OUT transaction",
which is a spec violation. Hub will generate bit stuffing errors on the
full-speed bus.


>
> Thanks
> >
> >
> > >                         if (tmp > FS_PAYLOAD_MAX)
> > >                                 return -ESCH_BW_OVERFLOW;
> > >                 }
> > > @@ -534,21 +534,18 @@ static void update_sch_tt(struct
> > > mu3h_sch_ep_info *sch_ep, bool used)
> > >  {
> > >         struct mu3h_sch_tt *tt =3D sch_ep->sch_tt;
> > >         u32 base, num_esit;
> > > -       int bw_updated;
> > >         int i, j;
> > >
> > >         num_esit =3D XHCI_MTK_MAX_ESIT / sch_ep->esit;
> > >
> > > -       if (used)
> > > -               bw_updated =3D sch_ep->bw_cost_per_microframe;
> > > -       else
> > > -               bw_updated =3D -sch_ep->bw_cost_per_microframe;
> > > -
> > >         for (i =3D 0; i < num_esit; i++) {
> > >                 base =3D sch_ep->offset + i * sch_ep->esit;
> > >
> > > -               for (j =3D 0; j < sch_ep->cs_count; j++)
> > > -                       tt->fs_bus_bw[base + j] +=3D bw_updated;
> > > +               for (j =3D 0; j < sch_ep->num_budget_microframes;
> > > j++)
> > > +                       if (used)
> > > +                               tt->fs_bus_bw[base + j] +=3D sch_ep-
> > > >bw_budget_table[j];
> > > +                       else
> > > +                               tt->fs_bus_bw[base + j] -=3D sch_ep-
> > > >bw_budget_table[j];
> > >         }
> > >
> > >         if (used)
> > > --
> > > 2.18.0
> > >
