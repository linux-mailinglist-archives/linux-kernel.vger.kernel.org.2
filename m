Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEA35EC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhDNE6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhDNE6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:58:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:58:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m13so19340322oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wlThZ4jNN0ioF2MfnY6FzqbFzlJiNHXBqSEAZPxP5c=;
        b=fkTXcIz5ARD1tpQ3/hc6cpGa2PSlG+mX8CDlC2L9Uyz00nkQrfYB16rA5c0xMOuQEJ
         7QV9sq23vGqw4A8ScmkCcFwQZoMVgsHAZ/6S38kQ4yJxJK+laZWl/iK/wmRDUgxci4i4
         +cfRh9g1/SR5IMP7cMB3zOMUiNA5xNMeRmB2RQ3fdmS40kO/lpebbCg+YMA0CVIO0OVc
         KHimNsOmKfyTgbixW9d1/1xOFHMtcXyRQRq2TMXNEzjpSRTzqb0zGBR5HJHRDe0SBvmn
         pdKI1ApPqFSoURuQLBReEdBcyQx+Lt0Vlu0f0wGSf8o0hjIXfNiO5iQ1E3QDGnjVBIrt
         Hm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wlThZ4jNN0ioF2MfnY6FzqbFzlJiNHXBqSEAZPxP5c=;
        b=qYCSmCfpEtiT3q1gYnP75Z+qE7wYIvXrAIbTdMSK2QhyDTNzHA73NDGQkDrX25QtC5
         RYrzBoTec6cBABSh7i2e0IMD1mlyXd4T2reIVhyHsbRHrT9mvyihR+03Bp19xzpB+Uko
         HjoCv8QiNKyBCcza/XSU7v53SyCuHW4gEBZY2myp/LSRypB4EDCfBxtaBlRj7ki4SYcY
         cvUzYx1AARyUediDhr7Idqi6xR86ac8DbFyquTTzKdE2h4OS1Jp3gDFfZJESkdoaDpjv
         Iq9V4pjwPy9BwjAJQfGr0PqmNlojvtR3tEcTRoK4kaFPvyGIUNnIy2blIH/yAiKK/t2M
         +BAw==
X-Gm-Message-State: AOAM531LhCdDiFYUP5/JNIdvelKf/r/heCMR7rrMMrtcatUbHXV7stTg
        CF1ZXG0IMPjxxt+I6cD60KzUeepe/ZiDXEqszW0=
X-Google-Smtp-Source: ABdhPJyflmQuHtPJKfX0BCNH9gEATBADpNyW9Um35LMgFBQF97+cgtCKd9vueR4ADNQEw71QaZojEVvGDDJOU1vep9o=
X-Received: by 2002:a05:6808:286:: with SMTP id z6mr1022160oic.149.1618376281556;
 Tue, 13 Apr 2021 21:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210410173331.57949-1-ilya.lipnitskiy@gmail.com>
 <CAMhs-H_GVj1DnhutUBo=Sdr38A8h9WnaJ7KX_-ge550qbujP7w@mail.gmail.com> <CALCv0x3qc5MVP0fm3HWD2CF27tX8z=g1A9T+yR15teU3jgOg6Q@mail.gmail.com>
In-Reply-To: <CALCv0x3qc5MVP0fm3HWD2CF27tX8z=g1A9T+yR15teU3jgOg6Q@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 14 Apr 2021 06:57:50 +0200
Message-ID: <CAMhs-H-3+u0emL7oMex3ErgsD5=FtWQSuPXnLJT8axz+2y2oOw@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: stop using of_pci_range_to_resource
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Siddhant Gupta <siddhantgupta416@gmail.com>,
        Selvakumar Elangovan <selvakumar16197@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Illya,

On Wed, Apr 14, 2021 at 6:10 AM Ilya Lipnitskiy
<ilya.lipnitskiy@gmail.com> wrote:
>
> Hi Sergio,
>
> Just as an aside, are you planning to move staging/mt7621-pci into
> arch/mips/pci at some point? This driver seems more maintained (by
> you!) than many in-tree drivers...

Yes, I am planning to move it and maintain it. There is minor stuff
that must be changed before that but I hope to give that all a try
after the next merge window.

Best regards,
    Sergio Paracuellos
> Ilya
>
> On Sat, Apr 10, 2021 at 12:23 PM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi Ilya,
> >
> > On Sat, Apr 10, 2021 at 7:33 PM Ilya Lipnitskiy
> > <ilya.lipnitskiy@gmail.com> wrote:
> > >
> > > The logic here was already overriding the erroneous IO addresses
> > > returned from of_pci_range_to_resource, which is the bulk of the logic.
> > >
> > > So stop using it altogether and initialize the fields explicitly, as
> > > done in aeba3731b150 ("powerpc/pci: Fix IO space breakage after
> > > of_pci_range_to_resource() change").
> > >
> > > Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
> > > Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  drivers/staging/mt7621-pci/pci-mt7621.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > Looks good to me, thanks! I have also tested this in gnubee pc1
> > platform with no regressions at all when io bars are assigned:
> >
> > [   16.378956] mt7621-pci 1e140000.pcie: host bridge /pcie@1e140000 ranges:
> > [   16.392405] mt7621-pci 1e140000.pcie:      MEM
> > 0x0060000000..0x006fffffff -> 0x0000000000
> > [   16.408796] mt7621-pci 1e140000.pcie:       IO
> > 0x001e160000..0x001e16ffff -> 0x0000000000
> > [   16.425264] mt7621-pci-phy 1e149000.pcie-phy: PHY for 0xbe149000
> > (dual port = 1)
> > [   16.440452] mt7621-pci-phy 1e14a000.pcie-phy: PHY for 0xbe14a000
> > (dual port = 0)
> > [   16.678713] mt7621-pci 1e140000.pcie: PCIE0 enabled
> > [   16.688435] mt7621-pci 1e140000.pcie: PCIE1 enabled
> > [   16.698160] mt7621-pci 1e140000.pcie: PCIE2 enabled
> > [   16.707886] mt7621-pci 1e140000.pcie: PCI coherence region base:
> > 0x60000000, mask/settings: 0xf0000002
> > [   16.726623] mt7621-pci 1e140000.pcie: PCI host bridge to bus 0000:00
> > [   16.739309] pci_bus 0000:00: root bus resource [io  0x1e160000-0x1e16ffff]
> > [   16.753008] pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
> > [   16.766709] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [   16.777649] pci_bus 0000:00: root bus resource [mem
> > 0x60000000-0x6fffffff] (bus address [0x00000000-0x0fffffff])
> > [   16.797986] pci 0000:00:00.0: [0e8d:0801] type 01 class 0x060400
> > [   16.809973] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
> > [   16.822467] pci 0000:00:00.0: reg 0x14: initial BAR value 0x00000000 invalid
> > [   16.836511] pci 0000:00:00.0: reg 0x14: [mem size 0x00010000]
> > [   16.848048] pci 0000:00:00.0: supports D1
> > [   16.856051] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > [   16.867943] pci 0000:00:01.0: [0e8d:0801] type 01 class 0x060400
> > [   16.879960] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x7fffffff]
> > [   16.892454] pci 0000:00:01.0: reg 0x14: initial BAR value 0x00000000 invalid
> > [   16.906497] pci 0000:00:01.0: reg 0x14: [mem size 0x00010000]
> > [   16.918040] pci 0000:00:01.0: supports D1
> > [   16.926031] pci 0000:00:01.0: PME# supported from D0 D1 D3hot
> > [   16.937903] pci 0000:00:02.0: [0e8d:0801] type 01 class 0x060400
> > [   16.949915] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x7fffffff]
> > [   16.962412] pci 0000:00:02.0: reg 0x14: initial BAR value 0x00000000 invalid
> > [   16.976466] pci 0000:00:02.0: reg 0x14: [mem size 0x00010000]
> > [   16.987991] pci 0000:00:02.0: supports D1
> > [   16.995986] pci 0000:00:02.0: PME# supported from D0 D1 D3hot
> > [   17.008716] pci 0000:00:00.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [   17.024695] pci 0000:00:01.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [   17.040654] pci 0000:00:02.0: bridge configuration invalid ([bus
> > 00-00]), reconfiguring
> > [   17.056868] pci 0000:01:00.0: [1b21:0611] type 00 class 0x010185
> > [   17.068882] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x0007]
> > [   17.080003] pci 0000:01:00.0: reg 0x14: [io  0x0000-0x0003]
> > [   17.091115] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x0007]
> > [   17.102238] pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x0003]
> > [   17.113350] pci 0000:01:00.0: reg 0x20: [io  0x0000-0x000f]
> > [   17.124463] pci 0000:01:00.0: reg 0x24: initial BAR value 0x00000000 invalid
> > [   17.138508] pci 0000:01:00.0: reg 0x24: [mem size 0x00000200]
> > [   17.150115] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000
> > Gb/s with 5.0 GT/s PCIe x1 link)
> > [   17.204594] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > [   17.215109] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > [   17.227257] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> > [   17.240785] pci 0000:00:00.0:   bridge window [mem
> > 0x60000000-0x600fffff pref]
> > [   17.255183] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > [   17.268648] pci 0000:02:00.0: [1b21:0611] type 00 class 0x010185
> > [   17.280671] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
> > [   17.291785] pci 0000:02:00.0: reg 0x14: [io  0x0000-0x0003]
> > [   17.302898] pci 0000:02:00.0: reg 0x18: [io  0x0000-0x0007]
> > [   17.314012] pci 0000:02:00.0: reg 0x1c: [io  0x0000-0x0003]
> > [   17.325127] pci 0000:02:00.0: reg 0x20: [io  0x0000-0x000f]
> > [   17.336241] pci 0000:02:00.0: reg 0x24: initial BAR value 0x00000000 invalid
> > [   17.350279] pci 0000:02:00.0: reg 0x24: [mem size 0x00000200]
> > [   17.361893] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s PCIe x1 link at 0000:00:01.0 (capable of 4.000
> > Gb/s with 5.0 GT/s PCIe x1 link)
> > [   17.414591] pci 0000:00:01.0: PCI bridge to [bus 02-ff]
> > [   17.425063] pci 0000:00:01.0:   bridge window [io  0x0000-0x0fff]
> > [   17.437206] pci 0000:00:01.0:   bridge window [mem 0x60000000-0x600fffff]
> > [   17.450733] pci 0000:00:01.0:   bridge window [mem
> > 0x60000000-0x600fffff pref]
> > [   17.465130] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> > [   17.478583] pci 0000:03:00.0: [1b21:0611] type 00 class 0x010185
> > [   17.490604] pci 0000:03:00.0: reg 0x10: [io  0x0000-0x0007]
> > [   17.501717] pci 0000:03:00.0: reg 0x14: [io  0x0000-0x0003]
> > [   17.512831] pci 0000:03:00.0: reg 0x18: [io  0x0000-0x0007]
> > [   17.523945] pci 0000:03:00.0: reg 0x1c: [io  0x0000-0x0003]
> > [   17.535060] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x000f]
> > [   17.546174] pci 0000:03:00.0: reg 0x24: initial BAR value 0x00000000 invalid
> > [   17.560211] pci 0000:03:00.0: reg 0x24: [mem size 0x00000200]
> > [   17.571825] pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s PCIe x1 link at 0000:00:02.0 (capable of 4.000
> > Gb/s with 5.0 GT/s PCIe x1 link)
> > [   17.624582] pci 0000:00:02.0: PCI bridge to [bus 03-ff]
> > [   17.635043] pci 0000:00:02.0:   bridge window [io  0x0000-0x0fff]
> > [   17.647188] pci 0000:00:02.0:   bridge window [mem 0x60000000-0x600fffff]
> > [   17.660710] pci 0000:00:02.0:   bridge window [mem
> > 0x60000000-0x600fffff pref]
> > [   17.675104] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> > [   17.688358] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
> > [   17.701534] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000]
> > [   17.715406] pci 0000:00:01.0: BAR 0: no space for [mem size 0x80000000]
> > [   17.728585] pci 0000:00:01.0: BAR 0: failed to assign [mem size 0x80000000]
> > [   17.742456] pci 0000:00:02.0: BAR 0: no space for [mem size 0x80000000]
> > [   17.755638] pci 0000:00:02.0: BAR 0: failed to assign [mem size 0x80000000]
> > [   17.769514] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
> > [   17.783039] pci 0000:00:00.0: BAR 9: assigned [mem
> > 0x60100000-0x601fffff pref]
> > [   17.797429] pci 0000:00:01.0: BAR 8: assigned [mem 0x60200000-0x602fffff]
> > [   17.810958] pci 0000:00:01.0: BAR 9: assigned [mem
> > 0x60300000-0x603fffff pref]
> > [   17.825360] pci 0000:00:02.0: BAR 8: assigned [mem 0x60400000-0x604fffff]
> > [   17.838886] pci 0000:00:02.0: BAR 9: assigned [mem
> > 0x60500000-0x605fffff pref]
> > [   17.853279] pci 0000:00:00.0: BAR 1: assigned [mem 0x60600000-0x6060ffff]
> > [   17.866814] pci 0000:00:01.0: BAR 1: assigned [mem 0x60610000-0x6061ffff]
> > [   17.880346] pci 0000:00:02.0: BAR 1: assigned [mem 0x60620000-0x6062ffff]
> > [   17.893880] pci 0000:00:00.0: BAR 7: assigned [io  0x1e160000-0x1e160fff]
> > [   17.907410] pci 0000:00:01.0: BAR 7: assigned [io  0x1e161000-0x1e161fff]
> > [   17.920935] pci 0000:00:02.0: BAR 7: assigned [io  0x1e162000-0x1e162fff]
> > [   17.934474] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
> > [   17.948008] pci 0000:01:00.0: BAR 4: assigned [io  0x1e160000-0x1e16000f]
> > [   17.961542] pci 0000:01:00.0: BAR 0: assigned [io  0x1e160010-0x1e160017]
> > [   17.975072] pci 0000:01:00.0: BAR 2: assigned [io  0x1e160018-0x1e16001f]
> > [   17.988605] pci 0000:01:00.0: BAR 1: assigned [io  0x1e160020-0x1e160023]
> > [   18.002138] pci 0000:01:00.0: BAR 3: assigned [io  0x1e160024-0x1e160027]
> > [   18.015673] pci 0000:00:00.0: PCI bridge to [bus 01]
> > [   18.025572] pci 0000:00:00.0:   bridge window [io  0x1e160000-0x1e160fff]
> > [   18.039096] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> > [   18.052623] pci 0000:00:00.0:   bridge window [mem
> > 0x60100000-0x601fffff pref]
> > [   18.067026] pci 0000:02:00.0: BAR 5: assigned [mem 0x60200000-0x602001ff]
> > [   18.080562] pci 0000:02:00.0: BAR 4: assigned [io  0x1e161000-0x1e16100f]
> > [   18.094092] pci 0000:02:00.0: BAR 0: assigned [io  0x1e161010-0x1e161017]
> > [   18.107625] pci 0000:02:00.0: BAR 2: assigned [io  0x1e161018-0x1e16101f]
> > [   18.121158] pci 0000:02:00.0: BAR 1: assigned [io  0x1e161020-0x1e161023]
> > [   18.134694] pci 0000:02:00.0: BAR 3: assigned [io  0x1e161024-0x1e161027]
> > [   18.148225] pci 0000:00:01.0: PCI bridge to [bus 02]
> > [   18.158117] pci 0000:00:01.0:   bridge window [io  0x1e161000-0x1e161fff]
> > [   18.171643] pci 0000:00:01.0:   bridge window [mem 0x60200000-0x602fffff]
> > [   18.185170] pci 0000:00:01.0:   bridge window [mem
> > 0x60300000-0x603fffff pref]
> > [   18.199591] pci 0000:03:00.0: BAR 5: assigned [mem 0x60400000-0x604001ff]
> > [   18.213127] pci 0000:03:00.0: BAR 4: assigned [io  0x1e162000-0x1e16200f]
> > [   18.226664] pci 0000:03:00.0: BAR 0: assigned [io  0x1e162010-0x1e162017]
> > [   18.240199] pci 0000:03:00.0: BAR 2: assigned [io  0x1e162018-0x1e16201f]
> > [   18.253751] pci 0000:03:00.0: BAR 1: assigned [io  0x1e162020-0x1e162023]
> > [   18.267286] pci 0000:03:00.0: BAR 3: assigned [io  0x1e162024-0x1e162027]
> > [   18.280814] pci 0000:00:02.0: PCI bridge to [bus 03]
> > [   18.290713] pci 0000:00:02.0:   bridge window [io  0x1e162000-0x1e162fff]
> > [   18.304243] pci 0000:00:02.0:   bridge window [mem 0x60400000-0x604fffff]
> > [   18.317773] pci 0000:00:02.0:   bridge window [mem
> > 0x60500000-0x605fffff pref]
> >
> > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Best regards,
> >     Sergio Paracuellos
