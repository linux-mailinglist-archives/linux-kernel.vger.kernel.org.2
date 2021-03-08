Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16AC330EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCHNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhCHNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:06:21 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E47C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:06:21 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a9so9027546qkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3JrrXwWADSgvZgB68bLvoI/RkxNlWv5mnUS3xpDfwl4=;
        b=Gb85a/xfbYipZ66rmq5YfwkxhoHqFWepT63E+GvRuUqHGBP9QKT/JwHd9xTvZk67V0
         TB+K0xafNKXaLpozFHhRHJ24wQseaEvt5p60ZgxhAagERKJabXNopDKh0PXCMsO37TIC
         m2JuRFKF+xvuV/KF1HZBxa6517JTOO5R9xl7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3JrrXwWADSgvZgB68bLvoI/RkxNlWv5mnUS3xpDfwl4=;
        b=CRn2YnD0KXkufTnoCyU/4VDbjAIg3aMyiKhFt3O/4ad4oSV8PQrRno9FqLSGilUsYi
         +uNy34ZO/WdU1O9jaancZmyihQIZ7O45HPmX2zqkUpMV2QdaRmrhgumj5CRTTD7jYXol
         0qK6t126uIEV4yoi81WRDhYFk/lKXaznkcZHpx06QlPu/hhsZN38E8XMYzgG/xoRvR/G
         FYCXoGbSR7FNW3yRSmyqjCCR9sueZ4XkcaNknIfcymIXqYOyKTXT+gPMlIe2MjQ66TgK
         96BaHBWP5mI1RSBBEPn394SqgRuqsdyPoZFZSwDQg002DZNtdD5S8NmLhjhTkWRajtI3
         d8cw==
X-Gm-Message-State: AOAM532QlgGgxHTAj1QJy1WR2/dKEMnO6tpxUlgg/HpbAYuwULO6jNnk
        EOs8kebyijNC/4jilRI1jVn/5o1OjlL60L1M8QPE2Q==
X-Google-Smtp-Source: ABdhPJz1u6cjSQ5e7n4Is4pIA/0ot62WSzGvhjIAL0Y7umbZvEOpHs1XdA1hQNrNmLBC0ZnuULrizRg6UlL8RU4rCys=
X-Received: by 2002:a05:620a:228:: with SMTP id u8mr20259137qkm.443.1615208780474;
 Mon, 08 Mar 2021 05:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20210305120930.14297-1-mark-pk.tsai@mediatek.com>
 <CAFr9PXmDp7UwWnT+49Yciy-gvYiQOd3cus0W_QnGKm-LqziHCg@mail.gmail.com>
 <875z24rvaz.wl-maz@kernel.org> <30c45ccea273461ca9552cef01b75de2@mtkmbs05n2.mediatek.inc>
In-Reply-To: <30c45ccea273461ca9552cef01b75de2@mtkmbs05n2.mediatek.inc>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 8 Mar 2021 22:06:05 +0900
Message-ID: <CAFr9PXkK+L0kpEfJsQMVa0R9P3jMDJFHQKCR8jaCuL=Um6G=gQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
To:     =?UTF-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= 
        <Mark-PK.Tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, Daniel Palmer <daniel@thingy.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

On Mon, 8 Mar 2021 at 11:42, Mark-PK Tsai (=E8=94=A1=E6=B2=9B=E5=89=9B)
<Mark-PK.Tsai@mediatek.com> wrote:
> > It seems like the polarity of interrupts is always the same between the=
 MStar intc and the GIC? Low level interrupts are handled in the mstar intc=
 and become high level interrupts to the GIC?
> > I think for the Mstar MSC313(e) and SigmaStar chips all of the internal=
 interrupts are high level so I never noticed this behaviour.
> > I can't remember seeing anything that handled this in the MStar kernel =
code I looked at.
> > Is this specific to a certain chip or does it apply for everything with=
 this intc?
>
> I suppose Mstar SoCs also need this patch which depends on what kind of i=
nterrupt source the HW designer wire to this intc.
> If an interrupt source is active low, we need to set the corresponding bi=
t to reverse the polarity to meet GIC SPI requirement as Marc mentioned.

That makes sense. Looking back at the original MStar driver again they
did handle reversing the polarity but they passed the original
polarity through to the GIC too.
So maybe it never worked properly. :)

I think I can test this with GPIOs that are wired into the mstar intc
on the MStar/SigmaStar chips. I'll get back to you with how that works
out.

Thanks,

Daniel



>
> > The register values being lost if the chip goes into suspend to memory =
makes sense for the MStar chips too I think as everything that is not in th=
e "pmsleep" register group seems to be lost.
>
> There are mask and eoi bits I did not handle here.
> That's because kernel will handle the mask and eoi status when system goi=
ng to suspend/resume in suspend_device_irqs/ resume_device_irqs.
> And all the irqs of Mstar intc are masked by default when the IP powered =
on.
>
>
> Best regards,
> Mark-PK Tsai
>
>
> -----Original Message-----
> From: Marc Zyngier [mailto:maz@kernel.org]
> Sent: Sunday, March 7, 2021 2:28 AM
> To: Daniel Palmer <daniel@0x0f.com>
> Cc: Mark-PK Tsai (=E8=94=A1=E6=B2=9B=E5=89=9B) <Mark-PK.Tsai@mediatek.com=
>; Daniel Palmer <daniel@thingy.jp>; Thomas Gleixner <tglx@linutronix.de>; =
Jason Cooper <jason@lakedaemon.net>; Matthias Brugger <matthias.bgg@gmail.c=
om>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-arm-ke=
rnel <linux-arm-kernel@lists.infradead.org>; linux-mediatek@lists.infradead=
.org; YJ Chiang (=E6=B1=9F=E8=8B=B1=E6=9D=B0) <yj.chiang@mediatek.com>
> Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
>
> On Sat, 06 Mar 2021 17:06:51 +0000,
> Daniel Palmer <daniel@0x0f.com> wrote:
> >
> > Hi Mark-PK,
> >
> > I'm trying to understand the logic behind the changes.
> > It seems like the polarity of interrupts is always the same between
> > the MStar intc and the GIC? Low level interrupts are handled in the
> > mstar intc and become high level interrupts to the GIC?
>
> That's because the GIC only supports level-high input interrupts when the=
y are level triggered (and rising edge when edge triggered).
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
