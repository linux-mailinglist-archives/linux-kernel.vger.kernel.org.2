Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5140A988
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhINIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhINIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:46:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:45:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id u4so10716310qta.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iK9P8vIFFT9oL8kQTe19y5v8KSqHawUgdc7tgu6jnMk=;
        b=Cvn9Hen1/zE/gCFNdbOMTSnCeR6Aaqfbmqxiwpzv7qfd+HzLbclvWSoFLy7wrbgTvN
         NHoUf1vWsKtIlAcIz8r9ZxQbR7l8T5lbAtczKvCpz+1zGAuKERCwBVPdRTK8OKSyUwdk
         FjMAXQ1I8T8JmOjhkX0l+QcQ5LWaNvrQD2T/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iK9P8vIFFT9oL8kQTe19y5v8KSqHawUgdc7tgu6jnMk=;
        b=qWrvJ8uLlNY8I7qf1mfadsEMV0Ij/U6kJrUjPhF84XsGSbQDfwzoQhMLbtZ7T+pwR4
         KMcq06+1j43zpK1gF+Cgf9MoA6TcagnwlaPC0Vt61bq9cqJC9LgEb2ydIN8iDiA7NPl0
         gp9j05qnbppUuxwGKZCQWovPlncaR5LdUe70Lbbm9guuuLJcHwb0Kvg3u/OeSFSOTLEl
         4Ljl+qZafUq2BknzRUDt3WcUDu5oR8Sf57NABE8A2Amb4960uVLCl5skn/wsnzd+bzyo
         yata/MhSaKnfryP7TovaFru1kCFJKbcR5jGu6VwKzQKdVutkCIBLKMVYy1K9PyqGqpZC
         G9lw==
X-Gm-Message-State: AOAM531rNn/4Z3NWCa5gYn/jKw/4ki7JrFC4OM6DP4nE0xhOD8lM0dG/
        ZtxjNyC1txu1QLmRtD2J43rxfpzi405s1JY8j78=
X-Google-Smtp-Source: ABdhPJwCWePNRUMT/Z0Tlj9D9n6UOcZX8cM3kXTZaf8wa4u/vSDJ52fustyWsztQJwELkActhXZKT85BQMHRjNmGVZQ=
X-Received: by 2002:ac8:7dca:: with SMTP id c10mr3452405qte.259.1631609125669;
 Tue, 14 Sep 2021 01:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210819055227.140980-1-liuxiwei@inspur.com> <CANFuQ7A5jLXftmfLn_W93MuDF8heL88BPQRL_rkYk+bj0_Db0w@mail.gmail.com>
In-Reply-To: <CANFuQ7A5jLXftmfLn_W93MuDF8heL88BPQRL_rkYk+bj0_Db0w@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 14 Sep 2021 08:45:13 +0000
Message-ID: <CACPK8XfbJbU8zPzTri3o+zbSf82iUuGUXmFL5TwsdPHKLnTNTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
To:     George Liu <liuxiwei1013@gmail.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        George Liu <liuxiwei@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sept 2021 at 08:16, George Liu <liuxiwei1013@gmail.com> wrote:
>
> Hey Joel:
> do you have any comments at this patch?
>
> Thx -- George Liu
>
> On Thu, Aug 19, 2021 at 1:52 PM George Liu <liuxiwei1013@gmail.com> wrote:
> >
> > Signed-off-by: George Liu <liuxiwei@inspur.com>

It looks okay to me.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I have applied it for 5.16.

> > ---
> >  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > index 1752f3250e44..d0c3acbf6c8c 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > @@ -3,6 +3,7 @@
> >  #include "aspeed-g5.dtsi"
> >  #include <dt-bindings/gpio/aspeed-gpio.h>
> >  #include <dt-bindings/leds/leds-pca955x.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> >
> >  / {
> >         model = "FP5280G2 BMC";
> > @@ -902,4 +903,10 @@ fan@7 {
> >
> >  };
> >
> > +&kcs3 {
> > +       status = "okay";
> > +       aspeed,lpc-io-reg = <0xca2>;
> > +       aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > +};
> > +
> >  #include "ibm-power9-dual.dtsi"
> > --
> > 2.30.2
> >
