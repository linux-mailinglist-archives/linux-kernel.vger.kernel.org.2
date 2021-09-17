Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F040FD98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhIQQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbhIQQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:11:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278EC061574;
        Fri, 17 Sep 2021 09:10:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b15so16606857lfe.7;
        Fri, 17 Sep 2021 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zo7Kfu8UASbfOIxzSXjB/ZC/wcwccqd9kdursu9/738=;
        b=nqSY8F9cra8tnW2PVoYEx+0pPbCHqw/TTz+TWhX+WpXzPvmFd30kvkE4tgMwmoQ6Ib
         G2EJXJcETjXHUuhZBioUvcwYvFx1317dJ7vlRw9VjUwqAz/+/95Lyjr0zlAKh2nV3GiK
         AjXsLjtWR/sWMtUqztKh0Ld6lMZFFZYJ//feCDrav81r42quErifa4+FMKoejhL6Nhvj
         LcTTMGmCV+I0AXMGOyYp9PD8L9jbzBGY3K171DZlGaNzxpYc96AgnLupbB7BhNhJPZ7l
         0EvJISFXWjFXjZa9w+J+QdQIBLAjpvq+UqQIzHSPE0nEPYMMeojJfyO4q7LbsdSGSJsB
         z/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zo7Kfu8UASbfOIxzSXjB/ZC/wcwccqd9kdursu9/738=;
        b=4UvY1/UfuGg0rxYLuLKdB5T2LRCyvVwNgYTKJ1LxsIlFVogocRUsyg+8avfkHUk2Mh
         QygdFtWHwwrDNArBIOAVsJQpQ6h/Y7Ur1Ib2mNFcoEeqyauGAVeaZKfPBlCp9giMj4KZ
         GaMqEeY3Ts2UfaKmtoI/mGr5byMSX8jrHYaB1gCe1D2vxA1I64kX70sMHhhrKZaYIgEG
         ifmQBhwL+Vb3S5PC4FC8OgHJ11FQ3raS0uFXie4EgIDKHCmVZQINfd5MfjQeLMSCdN8U
         cOd9GNu7ug7dh+g8x5Fch5+9uVbt0NGFiBRDKSufasXR70oHizm7YiMaDYo0CJKk4Fpf
         j+Vw==
X-Gm-Message-State: AOAM533MANbSPaAyk9x/ucWs0NRT2xzUhHhjyIM7szYyiC4PNPOK2AOK
        +YLE5jTwqAzv6Xscka9vVQE/jm+lUZQZU7oplIZb9uvLbdRcQalT
X-Google-Smtp-Source: ABdhPJxP7ZE7dWbbEQ+3KNsObJWIfvWnJmHi2r9uJZFD8gWvYPp6CIPGvX//YnQ/Dm6ZPQajl0DsFlRx95QpeUx7PmA=
X-Received: by 2002:a19:c38b:: with SMTP id t133mr8505200lff.196.1631895032908;
 Fri, 17 Sep 2021 09:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
 <7e7ee4244ababc0a46e0875222c7e37d@walle.cc> <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
 <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com> <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de>
In-Reply-To: <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Fri, 17 Sep 2021 18:10:21 +0200
Message-ID: <CAEyMn7aa=-UKvUz4pWOWZJbPh7TTgzmDpmNKOTYM5g0G54xU2Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Am Fr., 17. Sept. 2021 um 13:44 Uhr schrieb Lucas Stach
<l.stach@pengutronix.de>:
>
> Am Freitag, dem 17.09.2021 um 09:28 +0200 schrieb Heiko Thiery:
> > Hi Frieder,
> >
> > Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
> > <frieder.schrempf@kontron.de>:
> > >
> > > On 15.09.21 14:05, Michael Walle wrote:
> > > > Am 2021-09-15 14:03, schrieb Heiko Thiery:
> > > > > The buck2 output of the PMIC is the VDD core voltage of the cpu.
> > > > > Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> > > > > property to avoid this.
> > > >
> > > > Mh, have this ever worked? Is there a commit which introduced a regression?
> > >
> > > Yes, this did work before, even without 'regulator-always-on'. I
> > > currently don't understand why this is needed. The regulator is
> > > referenced in the CPU nodes as 'cpu-supply'. This should be enough to
> > > not disable it as long as the CPU is up.
> >
> > I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
> > same issue:
> >
> > [ 31.716031] vdd-5v: disabling
> > [ 31.719032] rst-usb-eth2: disabling
> > [ 31.722553] buck2: disabling
> >
> > While on that I tried to compare with other boards and see that they
> > also have the cpu-voltage marked as "regulator-always-on". The only
> > exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
> > has not set this property.
> >
> > I agree with you and don't understand why this is happening. Has
> > anyone else an explanation?
> >
> > [1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L319
> >
> Maybe your kernel config is missing the cpufreq driver, so you don't
> have a consumer of the regulator?
>
> Marking the regulator as always-on seems like the right thing to do,
> you don't want to depend on a consumer showing up to make sure that
> your CPU voltage isn't cut...

shouldn't it be that the node cpu-supply here is a consumer of the
referenced voltage?

-- 
Heiko
