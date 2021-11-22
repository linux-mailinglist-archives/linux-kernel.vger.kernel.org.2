Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C344459474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhKVSDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbhKVSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:03:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35121C061746
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:00:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so14786637plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPRIzIO1KU1C8ddWgPhsEVGDbn+IqG9pEsiY3iUL+kg=;
        b=Zcu9qfXQX0R7+qzMKtbV1oEdOE5LSB9Gk3P/wnswXrS4cdSDpBapfS17On8yyd5YWk
         97RuP2i7Cco7g1O96NWY/+XRYJau6Wp3B2ThtxabqLwVgP2RvjqxWDrsgSGM+jZvlJHj
         XnYArcBi/pGJCjaU+vbDEYF4Hb0zmtlXXPq7lP20xOGh3+/n/Tju37+5WqIFp9ln1GLO
         C8LhaZQytVK/tu0m+xn4+bxzsNqRMoSKeShbBuwbBSRXoHt3Pj8+eMMQ/Q8TwqvaGjAf
         6hJJa4KoImEWZXjdRE/q1CQwTQ1B0sLdQhqzjEbCWY4g+YF5S1hGlk3P7JcAWN+OQDoK
         IdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPRIzIO1KU1C8ddWgPhsEVGDbn+IqG9pEsiY3iUL+kg=;
        b=UvKKFAxGKdvN0zfOodF4ZHXS0mS0K1PvDalzxN/AAyCmnrSQ1kqg6UomZq4bUreTkY
         3QDnVpCdllDkzxIwUZprp2/T+1IAy00HtOHrCO+4HWEeXmdRTAWSt7yk3WJSFhYZnq6C
         xwuy71dXVj14ERK+g0VBkOKab0QYGFH1i7qyxDFIMCvor1WOhrzIA1PbN8Ge1r6tXpvb
         e2WRmA1DBIXgBOJTAezowMqehkm4hvgS4drWxOfRcHM/ve7gvK2nbVpC7VlIwLJ6lZWR
         Vq+FNlikz0CgaAxkoYvYwPlSUG9BlwZErfYQqZaX9V7zs9wVA/gHlRQcGrQQ6s6j1e27
         iCHA==
X-Gm-Message-State: AOAM530KYPCQ/pYYzAeHZkf8/0tpYOT4prr3sFDmb5LvAvnekLVRHKGb
        h1q0D85D97YfFgB9RaQzC/1QXXFXogi8RKl3dYnieQ==
X-Google-Smtp-Source: ABdhPJzFYhddKOv75da/hXSGfqKI28nkNxkqEbk14PeIDjEryksJCyoaXULDtDYHYZ2pT8c/SkMY893apkASPrlUBg0=
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr33669521pjb.155.1637604001558;
 Mon, 22 Nov 2021 10:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
 <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
 <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
 <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
 <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com>
 <CAHCN7xKJBHY1o94VDkBaXXFjMUm=5WoshddT4DVWD04aiPV8MA@mail.gmail.com> <CAHCN7xKpjVWiTvXpYH11kaHX=0Figh=ALQS4qnUroGCu-q3NNA@mail.gmail.com>
In-Reply-To: <CAHCN7xKpjVWiTvXpYH11kaHX=0Figh=ALQS4qnUroGCu-q3NNA@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 22 Nov 2021 09:59:50 -0800
Message-ID: <CAJ+vNU37=qPuuNaSsvRntKU5wbVZoOtS_tAx7En6EMGfKN=QLg@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
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

On Sun, Nov 21, 2021 at 7:25 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Sun, Nov 21, 2021 at 8:34 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Sun, Nov 21, 2021 at 8:21 AM Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > > I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
> > > >
> > > > Since the driver sending SMCC commands to ATF isn't doing that, I
> > > > assume it's safe to use the linux power-domain drivers with the ATF
> > > > from NXP's kernel.
> > > >
> > > > If you can point me to the repo you think I should be using, I'll give it a try.
> > >
> > > Do you know if the mainline TF-A repo v2.5 works too?
> > > https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5
> >
> > That's good to know.
> >
> > I just built it into U-Boot:
> >
> > NOTICE:  BL31: v2.5(release):v2.5
> > NOTICE:  BL31: Built : 08:24:13, Nov 21 2021
> >
> > The Etnaviv driver is still loading without hanging
> >
> > root@beacon-imx8mn-kit:~# dmesg |grep -i etna
> > [   12.393936] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
> > [   12.400676] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> > [   12.641297] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0
> >
> >
>
> Tim,
>
> Which version of Nano do you have?  Not all Nano SoC's have a GPU from
> looking at the datasheet [1] .  I am using MIMX8MN2CVTIZAA (Nano Solo)
>
> [1] - https://www.nxp.com/docs/en/data-sheet/IMX8MNIEC.pdf
>

Adam,

The board I have here has MIMX8MN5CVTIZAA so i.MX 8M Nano QuadLite
with 'No GPU' as you expected.

So I have to add the following to keep my board from hanging after your series:
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 236f425e1570..0d256a607b7c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -251,6 +251,10 @@
        };
 };

+&gpu {
+       status = "disabled";
+};
+
 &i2c1 {
        clock-frequency = <100000>;
        pinctrl-names = "default";

This situation is similar to the one I encountered with the
imx8mm-venice-gw7901 where adding the GPC node caused my board (which
did not power the GPU) to hang until I added disables to the
device-tree with commit 7973009235e2 ("arm64: dts:
imx8mm-venice-gw7901.dts: disable pgc_gpumix"). It feels painful to
have to add patches to keep things from hanging after additional
functionality is added to dt but perhaps that is more common than I
think esp for SoC's like IMX8M which have a lot of lingering support
still coming in.

I don't mind at all submitting the above patch to fix my board after
your series is accepted as I think that having an IMX8MN with 'no gpu'
is perhaps less likely than having one with a GPU and thus we probably
shouldn't mark the node as disabled and force everyone that has a GPU
to go and enable it.

I wonder however if we should think about adding something to etnaviv
to check the capability so that the same dt could be used with both
CPU variants?

At any rate for now let's keep the ball rolling!

For the series:
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com> (tested on imx8mm-venice-gw7902)

Best regards,

Tim
