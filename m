Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECD4583B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhKUNKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKUNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:10:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F393C061574;
        Sun, 21 Nov 2021 05:07:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so19941259eds.10;
        Sun, 21 Nov 2021 05:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOf/MXbkL6S1fotajTZYpA72N3k/4R0mBR9AVrqDkm0=;
        b=DXCP48+OgGFzlMkgNzZItA1wtq+3NywF2T6ZMUmOvhMNgwQT0bb3enb5/mp4EAXHxd
         tWjIFNTumIZHzUHsE6l/PQiKh5misDZpJ3bEbKLUFfTjEUcgHlCE3CBPqA0PTnKniC1E
         jtA4VBysy081mivRU608wfF/mGVDfOnvARdCtsvJL8BJRbFuHALi+IRRl6cWnkwhJbjr
         o9KsKCrhFWzxHImLTy5z97ijQnJfRweCpgBrdaYJGEzPhO7cnwbhnZ2SPupbgN8j7aXb
         lR/nnnZZTbWtpY/U53BHTlAHDRljZc1HgqbBNcqOzL13yh7KkggUhrx+6V3PWuWL2r7E
         ZDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOf/MXbkL6S1fotajTZYpA72N3k/4R0mBR9AVrqDkm0=;
        b=vZc0LeN76/5Yq2qrnQvYeyAf8Qi4bcGq5fXsluJge1Lkj+0kweHnTpMgzUZYDWkT7J
         qFiHu3sr6DSDGWbK/rwbsgBc4l+TtB4B2KwUIS9wIBPNu7gH4Yghjk4DDcVnt538uZW3
         iBffZwKjl67iGPJ90zK9DzZCW+1CLbCZrM3H4QiCm5X7sTRjSBX7BKWFgPpKH1ys7L60
         V951DCruFAEn5RRA5gbEndvuQSoAoRlC7+3TtfIlGAf9XWZlhydRUR4px+6/q54YWTO4
         jbLZm1rSmGE1s5BPKlQZiJzR01UJT+uqVA89EEjH6VUnLr8fp8HWVCoaKiEoKC7P7xRk
         zjPA==
X-Gm-Message-State: AOAM531g/Cy+4w7RVXZD1b+IkXNq2isswLpqkGBZGKxBeCzJAAoi6YWL
        C1ZSMa04AoxtJwrvAUQbnrdkRnfl9uK9AMFdCZo=
X-Google-Smtp-Source: ABdhPJxOX22xc20EVjo7d2t/Yx6aCS8wiybzcJ9fn13Hy4wz8bryaz4V6MvE02GQMmUAzB5sd4KtK/GtSKP3SrSoZoY=
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr31087258ejc.336.1637500067726;
 Sun, 21 Nov 2021 05:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com> <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
In-Reply-To: <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 21 Nov 2021 07:07:35 -0600
Message-ID: <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        ariel.dalessandro@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:27 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, Nov 16, 2021 at 10:04 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Tue, Nov 16, 2021 at 11:57 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Thu, Nov 4, 2021 at 9:18 AM Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> > > > different in others.  With the blk-ctrl driver for Mini in place,
> > > > this series expands the blk-ctrl driver to support the Nano which
> > > > opens the door for additional functions in the future.  As part of
> > > > this series, it also addresses some issues in the GPCv2 driver and
> > > > finally adds support for enabling USB and GPU.
> > > >
> > > > V3:  Fixes an the yaml example
> > > > V2:  Fixes the clock count in the blk-ctrl
> > > >
> > > > Adam Ford (9):
> > > >   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
> > > >   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
> > > >   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
> > > >   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
> > > >   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
> > > >   arm64: dts: imx8mn: add GPC node
> > > >   arm64: dts: imx8mn: put USB controller into power-domains
> > > >   arm64: dts: imx8mn: add DISP blk-ctrl
> > > >   arm64: dts: imx8mn: Enable GPU
> > > >
> > > >  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     |  97 +++++++++++++++++
> > > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 103 ++++++++++++++++++
> > > >  drivers/soc/imx/gpcv2.c                       |  26 +++++
> > > >  drivers/soc/imx/imx8m-blk-ctrl.c              |  75 ++++++++++++-
> > > >  include/dt-bindings/power/imx8mn-power.h      |   5 +
> > > >  5 files changed, 305 insertions(+), 1 deletion(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> > > >
> > >
> > > Adam,
> > >
> > > Thanks for the patches. I'm not sure how best to test this but on an
> > > imx8mm-venice-gw7902 which has USB, but no display.
> > >
> > > I find that if DRM_ETNAVIV is enabled I hang at 'etnaviv etnaviv:
> > > bound 38000000.gpu (ops 0xffff800010964748)'.
> >
> > Thanks for testing this.
> >
> > Does your board send power to the GPU?  I recall someone somewhere
> > didn't power theirGPU, but I can't remember who and/or what board was
> > being discussed.
>
> Yes, the imx8mm-venice-gw7902 does have the GPU powered (the
> imx8mm-venice-gw7901 was the one that did not).

I cannot replicate your issue.  I applied the patch series to
5.16-rc1, and it's still working for me.

root@beacon-imx8mn-kit:~# dmesg |grep viv
[   11.323660] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
[   11.480543] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
[   11.747576] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0

After booting, I connected a USB drive and it enumerated.

[  152.328228] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
[  152.351885] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[  152.363859] hub 1-0:1.0: USB hub found
[  152.371560] hub 1-0:1.0: 1 port detected
[  153.075902] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[  153.244124] usb-storage 1-1:1.0: USB Mass Storage device detected
[  153.263651] scsi host0: usb-storage 1-1:1.0
[  154.277997] scsi 0:0:0:0: Direct-Access     SanDisk  Cruzer
  1.00 PQ: 0 ANSI: 6
[  154.292357] sd 0:0:0:0: [sda] 247529472 512-byte logical blocks:
(127 GB/118 GiB)
[  154.309246] sd 0:0:0:0: [sda] Write Protect is off
[  154.319237] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  154.359113]  sda: sda1
[  154.366975] sd 0:0:0:0: [sda] Attached SCSI removable disk

root@beacon-imx8mn-kit:~# lsusb
Bus 001 Device 002: ID 0781:5530 SanDisk Corp. Cruzer
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

I am not sure where to go from here.

>
> Tim
>
> >
> > I'll run some more tests on the latest 5.16-rc1 to see if I can
> > replicate your issue.
> >
> > adam
> > >
> > > If DRM_ETNAVIV is not enabled:
> > > - boots fine
> > > - usb works
> > > - soft reboot works (does not hang)
> >
> > At least we have some progress.  :-)
> >
> > adam
> > >
> > > Best regards,
> > >
> > > Tim
