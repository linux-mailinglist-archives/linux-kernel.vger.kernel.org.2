Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DA3FB015
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 05:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhH3Du3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhH3Du2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 23:50:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C25C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:49:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fs6so8539168pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xd5yJwKt1hvq4WFoSQExGBW6PX7FM9F2aTtlw2PPNgY=;
        b=ODVUQWj14e/o8PyewpgAxwqPLPtNZxpcvYC7MQqgubN1OZCRQtPlikZPOuHN8zA+IJ
         AmMTMTtAN7CuB0VSOA/tB8UnW3E3LRwBSCrC4hUcaQenqGasINce2kIBeYcVbtSdJ9cu
         1Q8b8N+K08CnfXfINsRxo+rpJvIGJR1Y7DLjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xd5yJwKt1hvq4WFoSQExGBW6PX7FM9F2aTtlw2PPNgY=;
        b=C5rm+Dn4anDfJROeotcQKmnAbkByHRwNVAFHLO8qWk1yrHd0mJPcoLjKO5Mc3Z51IY
         XhSDzV5jKSgeukqRbjkH/Wi4ojdLEFaKmMSgbbami6Mj/RcEaZQU+iB2JN1nIgoA59EX
         PAs8PUtbHwm6HjU7hBGj3WPHbUj5dOKKLQKJxFuX27ixWrWiG6l/pwWCKUk19g3k70M5
         oeabH9RccB//KMCq8uOcb8OPm7D+Ek9BLrhvUq5lhWg4wyuRXvz7mEYhpColN8Ts21+t
         yabG7IQZkM2IOPO05tDbqAPzHEB1rq4ugbiFNHfuKFaMYCjdPwoAcAvsGHaHTp5VERW9
         C3eA==
X-Gm-Message-State: AOAM533ubbBdwsilic8DYAjb6s8wPph84ATUYTeot/3Q3tRfbKz+3Dg+
        t0EIl0KV8G+dkT3bmnQ3tUiJtIwlSKKSsn7eH/vuHA==
X-Google-Smtp-Source: ABdhPJxmwutWcvcGGTYek4J59y438R2Xw4VTIh9M3kBeplPDNHz99ge8PjQssGX5CCkpqjUVqqBAm7H1m2cmZJsH460=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr19994569plo.49.1630295374896; Sun, 29
 Aug 2021 20:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
 <20210826025144.51992-3-chunfeng.yun@mediatek.com> <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
 <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
 <CAATdQgA+4VC7J1LMZYOZMV-OTjMGjO=9bJZ7uaCu_MMF-20T1w@mail.gmail.com> <18cb18d7d0ea4a3bb46921aca88c53646f1b3764.camel@mediatek.com>
In-Reply-To: <18cb18d7d0ea4a3bb46921aca88c53646f1b3764.camel@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 30 Aug 2021 11:49:24 +0800
Message-ID: <CAATdQgDKuO+bM7_tMy59ghhhjrgCp53kHgYbgEciriHNF3uKuA@mail.gmail.com>
Subject: Re: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by bw_budget_table
To:     =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
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

On Fri, Aug 27, 2021 at 5:49 PM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=B0)
<Chunfeng.Yun@mediatek.com> wrote:
>
> On Fri, 2021-08-27 at 17:14 +0800, Ikjoon Jang wrote:
> > On Fri, Aug 27, 2021 at 2:49 PM Chunfeng Yun (=E4=BA=91=E6=98=A5=E5=B3=
=B0)
> > <Chunfeng.Yun@mediatek.com> wrote:
> > >
> > > On Thu, 2021-08-26 at 19:54 +0800, Ikjoon Jang wrote:
> > > > Hi Chunfeng,
> > > >
> > > > On Thu, Aug 26, 2021 at 10:52 AM Chunfeng Yun <
> > > > chunfeng.yun@mediatek.com> wrote:
> > > > >
> > > > > Use @bw_budget_table[] to update fs bus bandwidth due to
> > > > > not all microframes consume @bw_cost_per_microframe, see
> > > > > setup_sch_info().
> > > > >
> > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > ---
> > > > > v2: new patch, move from another series
> > > > > ---
> > > > >  drivers/usb/host/xhci-mtk-sch.c | 17 +++++++----------
> > > > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/host/xhci-mtk-sch.c
> > > > > b/drivers/usb/host/xhci-mtk-sch.c
> > > > > index cffcaf4dfa9f..83abd28269ca 100644
> > > > > --- a/drivers/usb/host/xhci-mtk-sch.c
> > > > > +++ b/drivers/usb/host/xhci-mtk-sch.c
> > > > > @@ -458,8 +458,8 @@ static int check_fs_bus_bw(struct
> > > > > mu3h_sch_ep_info *sch_ep, int offset)
> > > > >                  * Compared with hs bus, no matter what ep
> > > > > type,
> > > > >                  * the hub will always delay one uframe to send
> > > > > data
> > > > >                  */
> > > > > -               for (j =3D 0; j < sch_ep->cs_count; j++) {
> > > > > -                       tmp =3D tt->fs_bus_bw[base + j] + sch_ep-
> > > > > > bw_cost_per_microframe;
> > > > >
> > > > > +               for (j =3D 0; j < sch_ep->num_budget_microframes;
> > > > > j++) {
> > > > > +                       tmp =3D tt->fs_bus_bw[base + j] + sch_ep-
> > > > > > bw_budget_table[j];
> > > >
> > > > I'm worrying about this case with two endpoints,
> > > > * EP1OUT: isochronous, maxpacket=3D192: bw_budget_table[] =3D { 188=
,
> > > > 188,
> > > > 0, ... }
> > > > * EP2IN: interrupt, maxpacket=3D64: bw_budget_table[] =3D { 0, 0, 6=
4,
> > > > 64,
> > > > ... }
> > > > (Is this correct bw_budget_table contents for those eps?)
> > >
> > > Yes, ep1out isoc use two uframe, ep2in intr use a extra cs;
> > > >
> > > > I'm not sure if it's okay for those two endpoints to be allocated
> > > > on the same u-frame slot.
> > > > Can you please check if this is okay for xhci-mtk?
> > >
> > > Already test it this afternoon, can transfer data rightly on our
> > > dvt
> > > env.
> > >
> > > > (I feel like I already asked the same questions many times.)
> > >
> > > Yes, as said before, prefer to use bw_budget_table[], if there is
> > > issue, we can fix it by building this table.
> >
> > So do you mean such an allocation shouldn't be a problem by IP
> > design?
> Yes, at least on our dvt platform

Did you check that your side also has a similar allocation
(SSPLIT-all sits between SSPLIT-start ~ -end for another ep)?
My audio headset doesn't work properly with this scheme.

>
> >
> > This patch starts to allow such an allocation (again).
> > But i remember my earlier tests showed that when those two eps
> > in the above example are allocated on the same u-frame slot,
> > xhci-mtk puts "SSPLIT for EP2" between
> > "SSPLIT-start and SSPLIT-end for EP1OUT transaction",
> > which is a spec violation.
>
> Which section in usb2.0 spec?

I think that's just a basic rule - if software wants to send 192 bytes
through a full-speed bus, HC should send OUT/DATA 192 bytes
continuously without inserting any other packets during that 192 bytes.
and usb2 11.14.2 mentions that TT has separated
Start-Split and Complete-Split buffers
but not tracked each transaction per endpoint basis.

>
> > Hub will generate bit stuffing errors on the
> > full-speed bus.
> which platform?

I remember it was mt8173.

And for bit stuffing errors I mentioned in the earlier mail.
when I read the spec again, 11.21 mentions that bit stuffing error
is generated when _a microframe_ should be passed without
corresponding SSPLIT-mid/end. So this is not the case and also
I'm not sure what will happen on the full-speed bus, sorry.
In my case what I can be sure of is that the audio output was
broken with those allotments.

What is the xhci-mtk's policy when there are more than two EPs
marked as the same u-frame offset like in the above example?

>
> >
> >
> > >
> > > Thanks
> > > >
> > > >
> > > > >                         if (tmp > FS_PAYLOAD_MAX)
> > > > >                                 return -ESCH_BW_OVERFLOW;
> > > > >                 }
> > > > > @@ -534,21 +534,18 @@ static void update_sch_tt(struct
> > > > > mu3h_sch_ep_info *sch_ep, bool used)
> > > > >  {
> > > > >         struct mu3h_sch_tt *tt =3D sch_ep->sch_tt;
> > > > >         u32 base, num_esit;
> > > > > -       int bw_updated;
> > > > >         int i, j;
> > > > >
> > > > >         num_esit =3D XHCI_MTK_MAX_ESIT / sch_ep->esit;
> > > > >
> > > > > -       if (used)
> > > > > -               bw_updated =3D sch_ep->bw_cost_per_microframe;
> > > > > -       else
> > > > > -               bw_updated =3D -sch_ep->bw_cost_per_microframe;
> > > > > -
> > > > >         for (i =3D 0; i < num_esit; i++) {
> > > > >                 base =3D sch_ep->offset + i * sch_ep->esit;
> > > > >
> > > > > -               for (j =3D 0; j < sch_ep->cs_count; j++)
> > > > > -                       tt->fs_bus_bw[base + j] +=3D bw_updated;
> > > > > +               for (j =3D 0; j < sch_ep->num_budget_microframes;
> > > > > j++)
> > > > > +                       if (used)
> > > > > +                               tt->fs_bus_bw[base + j] +=3D
> > > > > sch_ep-
> > > > > > bw_budget_table[j];
> > > > >
> > > > > +                       else
> > > > > +                               tt->fs_bus_bw[base + j] -=3D
> > > > > sch_ep-
> > > > > > bw_budget_table[j];
> > > > >
> > > > >         }
> > > > >
> > > > >         if (used)
> > > > > --
> > > > > 2.18.0
> > > > >
