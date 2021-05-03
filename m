Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2AB371B49
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhECQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhECQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:42:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A9C06134C;
        Mon,  3 May 2021 09:37:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so6993845edu.10;
        Mon, 03 May 2021 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IL37xkHGbQoMcjdiJ4z5sJEMMG7cxWpY9a1c3V2dhxE=;
        b=FqlmSywn+OJAdFN6KiAIpND+PnOSnF5VOvVtz+lMdLLFeNoo4VOTgrtHkc75y86ARJ
         oslREnCvNNuPUc+7UR1EaIcYniEgYX3tMOoH80ahTa/YWyLkGJGvSv490Hg+X4mCGPwf
         gMDfqdLwRbRA+y55EuVD36ceuWU4ZH8QzxtM4lpswVgL6j1pt/HC98adtmhU5dhZpipE
         GRyPowOXVHeeEFIkuvPtYQ7obN4TZX+Y/cr3zy2Cn9SKsv3vUpmyjRtmbNjSSbfijvCl
         IGRMKJswo7Cn+seNsBRk/aQLG7567zzEubqzWTaRkzCqkdz9Bijj9QcjBIOf+4guxXYK
         RTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IL37xkHGbQoMcjdiJ4z5sJEMMG7cxWpY9a1c3V2dhxE=;
        b=cctzOmtS91IgaHbIMRQwfMJSlst45I+6p0i26LTEXbRp3uWi7tB20BUKNeG3bPGP1O
         GrboMykYSKpy7Q+qYWiCFjB1zY7DwoDh0owGGoW5w/ihawTrCvzmXji9/0MJy8ATO/BW
         QsjjQfWtCU42CmsoN7Ij/IR1pWq3PJFIyBh4c7pFZAhAapy5q8p/F+onmmYG2ni3Blzp
         zG9+vM5WT8zYA1Y3ra8nZ4hEU5W8Pj3x7V1Ii0l1EE53+oOxjUKDUYdaR/Cm1mWfTpfP
         oZEycZO1PIH06sUBtejOW1O7T239SNnGAv5TihNcDYk1c1p9nGP3mCf2wANM0hea3rOe
         F0hw==
X-Gm-Message-State: AOAM531RXKnEWiFlfU0am4PL/cnOtsnaz2UQGEAVZ2nhshJfpDZz41f2
        mA7bLiNYk6ejJSJqn4fsirbmnON48Q04UMvvdEn7/x5GwoFDQg==
X-Google-Smtp-Source: ABdhPJz/AJv7RCcIWBDMKm3Gdsyf6wf0BUHiYion0nCe5BuMFjFUqoEZ3N8K441OnP/cmQR9EgeCXvCJgLSxYp9g4SU=
X-Received: by 2002:a05:6402:11ca:: with SMTP id j10mr16719655edw.184.1620059872356;
 Mon, 03 May 2021 09:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
 <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
 <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com> <CAFBinCDUc7VG7T9c8snP4ujMMViS0GRdztP6QGJvF9LNESHHCw@mail.gmail.com>
In-Reply-To: <CAFBinCDUc7VG7T9c8snP4ujMMViS0GRdztP6QGJvF9LNESHHCw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 3 May 2021 22:07:41 +0530
Message-ID: <CANAwSgSrQnBs06+DG6x+GMvyjvu-hPFX0J5MQ0yKPBvNaNu98w@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Martin

On Mon, 3 May 2021 at 21:05, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, May 3, 2021 at 5:29 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > +static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_hdmi[] =3D {
> > > > +       { HHI_MEM_PD_REG0, GENMASK(15, 8) },
> > > > +};
> > > > +
> > > the VPU power domain already includes:
> > >   VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> > > whereas VPU_HHI_MEMPD is bits[15:8]
> > >
> > > Having two power domains which are managing the same registers sounds
> > > like it'll be causing some trouble
> > > So for now this is (as I am not even sure what the goal here is):
> > > NACKed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > >
> >
> > Ok, thanks. On the line of Ethernet PD, I tried to add this accordingly=
.
> From what I understand the VPU power domain is special because the
> display pipeline consists of multiple components (HDMI, VPU, ...)
> that's why the handling currently is special
>
> > whenever I try something new it fails. Please ignore this series.
> if the VPU and HDMI power domains were separate (from hardware
> perspective, not from driver perspective) then your change is a good
> step forward.
> in that case VPU_HHI_MEMPD would need to be removed from wherever it's
> currently used -> that means we need to also decide if we want to
> break compatibility with older (before this series) .dtbs
>
>

As per the datasheet S922X Datasheet, HDMI and VPU are different
reg controller and they are independent of each other.

*HHI_MEM_PD_REG0 0x40*

17~16  R/W 0x3 DDR memory PD
*15~8 R/W 0xFF HDMI memory PD*
7~6 R/W 0x3 Reserved
5~4 R/W 0x3 Audio mem PD
3~2 R/W 0x3 Ethernet memory PD
1~0 R/W 0x3 resved

Note: HDMI and AUDIO and Ethernet are also independent of each other.

*HHI_VPU_MEM_PD_REG0 0x41 *

31~30 R/W 0x3 sharp
29~28 R/W 0x3 Deinterlacer =E2=80=93 di_post: 11 =3D power down. 00 =3D nor=
mal operation
27~26 R/W 0x3 Deinterlacer =E2=80=93 di_pre 25~24 R/W 0x3 Vi_di_scaler
23~22 R/W 0x3 afbc_dec1
21~20 R/W 0x3 Srscl super scaler
19~18 R/W 0x3 Vdin1 memory
17~16 R/W 0x3 Vdin0 memory
15~14 R/W 0x3 Osd_scaler memory
13~12 R/W 0x3 Scaler memory
11~10 R/W 0x3 Vpp output fifo
9~8 R/W 0x3 Color management module
7~6 R/W 0x3 Vd2 memory
5~4 R/W 0x3 Vd1 memory
3~2 R/W 0x3 Osd2 memory
1~0 R/W 0x3 Osd1 memory

Below is the output on Odroid N2.

[alarm@archl-on2 ~]$ sudo cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          children
            performance
    /device                                             runtime status
---------------------------------------------------------------------------=
-------------------
HDMI                            on
            0
    /devices/platform/soc/ff600000.bus/ff600000.hdmi-tx  unsupported
             0
AUDIO                           on
            0
    /devices/platform/sound                             unsupported
            0
ETH                             on
            0
    /devices/platform/soc/ff3f0000.ethernet             active
            0
VPU                             on
            0
    /devices/platform/soc/ff900000.vpu                  unsupported
            0

HDMI power domain is ON.
Audio is wrongly mapped.

> Best regards,
> Martin

-Anand
