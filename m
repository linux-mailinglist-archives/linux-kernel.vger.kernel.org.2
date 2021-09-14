Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E663D40A9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhINI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:57:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:56:06 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m9so7866131qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmC8BFtcIlu9tQDDEKEhJinzoMTwWxx2bKO3/mR5MTk=;
        b=JPSceBsmY+QUXryhoZVm4DgV8iWoUmwYcm18FTyzDrk/eV5SFl9eUANl11xbIdpeLo
         gtwHfP4cONJSlsxSLTw8FmABzzJeGsIulJ8YrNvKUzr50G2ZajaCLMz8T7yCj/f03oHY
         tqZsivBj1WD5sd+t7ujW3drsfawHE2PLbsQXbwY28NXxvWyXw/8vC20IqCjNcC/VG7PP
         PBaiNWXyfgcPyfA90eo27E29zCd72LrvwSpJVmjl8CHEcd8ZYW1b4oxqGZW79v8G/feL
         WRqirc2Rp4Lc55pyP60D0D/mgZqsRGBNAAVL13jpvLZEVnTpzQ+RFGgV0/4m+LwkCLjB
         czSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmC8BFtcIlu9tQDDEKEhJinzoMTwWxx2bKO3/mR5MTk=;
        b=FvNzL0AQoM7B4MnNbs7wJsnGabd3d0zbjt8ZWUfWkFb2SM7/RCqrRShcCrqqgiov8k
         0vPswaXl9kzn3T72NJBJH06oNTMJ/ssox0TiDGexKoYp2fKxD54tZ4JtsPa27sP6JoQp
         8hcTaMZ3iPKPtSZLjOkVtV5DHi++JpeERNHCUeGpLpmDCI3CEyrIqiy9qJ2N27lRPtlZ
         qmRHnr4OiIhFzZspH4hvELNkGQPG0I+NQHTWiRMgXw3FMOQ3VruuwMiJUWX4ADQqeJYv
         NQ54Mn7cL2I7F3lmXKC/F8tPD6QwS+UrCq8x47HHy69pF4RN7wT7BCDnP/47fgluxddT
         Xcrg==
X-Gm-Message-State: AOAM532eLC+Vu8COS7qb4+RERYw8uXDPJb7w3dJ5pdtXensVXIu+oer6
        0Gwueks/3vaDrV9TQzV2oWs5G2BnYdNW+JFJZx1RjIoN
X-Google-Smtp-Source: ABdhPJyMESNiGETQ+IsMCvvHJh6G9CiPmXvtgztSYZvFfT9hrfiEN26fn2I7eW7z6QdmoFTMJpHOtPRP78t81PX+xvQ=
X-Received: by 2002:ac8:4156:: with SMTP id e22mr3638684qtm.308.1631609766079;
 Tue, 14 Sep 2021 01:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210819055227.140980-1-liuxiwei@inspur.com> <CANFuQ7A5jLXftmfLn_W93MuDF8heL88BPQRL_rkYk+bj0_Db0w@mail.gmail.com>
 <CACPK8XfbJbU8zPzTri3o+zbSf82iUuGUXmFL5TwsdPHKLnTNTQ@mail.gmail.com>
In-Reply-To: <CACPK8XfbJbU8zPzTri3o+zbSf82iUuGUXmFL5TwsdPHKLnTNTQ@mail.gmail.com>
From:   George Liu <liuxiwei1013@gmail.com>
Date:   Tue, 14 Sep 2021 16:55:55 +0800
Message-ID: <CANFuQ7A6xbM571ds+aq-QUmLxUZ-FUjKukPqGV-irt8X_j=fkw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
To:     Joel Stanley <joel@jms.id.au>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        George Liu <liuxiwei@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Tue, Sep 14, 2021 at 4:45 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 14 Sept 2021 at 08:16, George Liu <liuxiwei1013@gmail.com> wrote:
> >
> > Hey Joel:
> > do you have any comments at this patch?
> >
> > Thx -- George Liu
> >
> > On Thu, Aug 19, 2021 at 1:52 PM George Liu <liuxiwei1013@gmail.com> wrote:
> > >
> > > Signed-off-by: George Liu <liuxiwei@inspur.com>
>
> It looks okay to me.
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> I have applied it for 5.16.
>
> > > ---
> > >  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > index 1752f3250e44..d0c3acbf6c8c 100644
> > > --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > > @@ -3,6 +3,7 @@
> > >  #include "aspeed-g5.dtsi"
> > >  #include <dt-bindings/gpio/aspeed-gpio.h>
> > >  #include <dt-bindings/leds/leds-pca955x.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > >
> > >  / {
> > >         model = "FP5280G2 BMC";
> > > @@ -902,4 +903,10 @@ fan@7 {
> > >
> > >  };
> > >
> > > +&kcs3 {
> > > +       status = "okay";
> > > +       aspeed,lpc-io-reg = <0xca2>;
> > > +       aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > > +};
> > > +
> > >  #include "ibm-power9-dual.dtsi"
> > > --
> > > 2.30.2
> > >
