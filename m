Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A9458477
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhKUP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbhKUP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:28:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909DC061574;
        Sun, 21 Nov 2021 07:25:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so32041741edx.2;
        Sun, 21 Nov 2021 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gtxI8IIzGZy9mmgGYtQQGOD2eBhGj6FELnSJoh3FsU=;
        b=CiRJhzuNdBDA4E+jx46OI4WQ/rFqHqMZIzN1Okb1YN0m1ds3J80mkOWf1dZEJS4gua
         FTgRYMpyoVDZ9RQaoVVOnXi/DhynOucGu45PNHQamzxjM0c1ROOQNBAuqRSgj62Lb4kQ
         ZWtbd0FRcm3CjKK8PTMqvim2ks8iH+CmNu82E7iP9tI7cVnOKQxibSGXVRIVXPXRp4HC
         fSWOluBWbi7AWKvzbpi13JQcWP1pqcvV1Lnj5xX6/lFjRVVO57BpFB3TPgp8IIwOg7iO
         xVdpvTJjqP4GVVLZCXjrvagSPh/LBAONj5+g1vwLQn2hbmLLrZTx03QteJkPaeszn5Eo
         8f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gtxI8IIzGZy9mmgGYtQQGOD2eBhGj6FELnSJoh3FsU=;
        b=fmOOonn1ctFrfblc51EkLpaHmDevcAS9HUnrLsJqUP86FRwgPRVw4zawqn6mHqHiGS
         2UT7sMCzvs3rg92dmWZSYqD9tmz8sau4kge9zsXeMaZlYsKc8v8C6h6UDnuhzxIt+O/z
         2MoHKudWEEphgJ1D/lzSx1nRimmPOVaj3zsdeVQ55ucuEhLSY/6V/hVM0RHZdwy+DJ3v
         BEP0/gnpE/5HlYdtkGkkn8XYo6QPtDPqeCmvV3DL3I2CnlRQStl0V2vhDXH7pSoFx9qj
         KKvAnvCwbz7NKNsKgYsbU08Y77OX53VJps9F9o+X+0yKAmIpy8e/kZ1YEuWNVQsx6mLF
         EaqA==
X-Gm-Message-State: AOAM533yemCCHXpmjR4TT0TDskzCgIaz/WaFeTk4pozXsljZAnXWrlXI
        Wnfw4pnT8LIsO2b/okaDcQIJbqdCcUymVvR0qV8=
X-Google-Smtp-Source: ABdhPJxif1vATYSq+z/TzxeDu3Znwtenq/rs8YF4DS9rhvIQbCF6GCNNN0fUC0w3d7mbSq7GaST3ybw2/11oNLlWFxw=
X-Received: by 2002:a17:906:1993:: with SMTP id g19mr31108272ejd.50.1637508330910;
 Sun, 21 Nov 2021 07:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
 <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
 <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
 <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
 <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com> <CAHCN7xKJBHY1o94VDkBaXXFjMUm=5WoshddT4DVWD04aiPV8MA@mail.gmail.com>
In-Reply-To: <CAHCN7xKJBHY1o94VDkBaXXFjMUm=5WoshddT4DVWD04aiPV8MA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 21 Nov 2021 09:25:19 -0600
Message-ID: <CAHCN7xKpjVWiTvXpYH11kaHX=0Figh=ALQS4qnUroGCu-q3NNA@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 8:34 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Sun, Nov 21, 2021 at 8:21 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Adam,
> >
> > On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > > I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
> > >
> > > Since the driver sending SMCC commands to ATF isn't doing that, I
> > > assume it's safe to use the linux power-domain drivers with the ATF
> > > from NXP's kernel.
> > >
> > > If you can point me to the repo you think I should be using, I'll give it a try.
> >
> > Do you know if the mainline TF-A repo v2.5 works too?
> > https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5
>
> That's good to know.
>
> I just built it into U-Boot:
>
> NOTICE:  BL31: v2.5(release):v2.5
> NOTICE:  BL31: Built : 08:24:13, Nov 21 2021
>
> The Etnaviv driver is still loading without hanging
>
> root@beacon-imx8mn-kit:~# dmesg |grep -i etna
> [   12.393936] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
> [   12.400676] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> [   12.641297] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0
>
>

Tim,

Which version of Nano do you have?  Not all Nano SoC's have a GPU from
looking at the datasheet [1] .  I am using MIMX8MN2CVTIZAA (Nano Solo)

[1] - https://www.nxp.com/docs/en/data-sheet/IMX8MNIEC.pdf

adam

>
> >
> > Thanks
