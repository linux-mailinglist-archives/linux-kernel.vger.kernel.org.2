Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3037FCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhEMR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhEMR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:56:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D28C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:54:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so41043633ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Jy97aMm7VEGQNVs4spkiz3xhAyYCzC385iFjGUTMn8=;
        b=QDXEMRVGDZPGERNVWO+0LDZqnYdDRVmF2ThgP7px72YvKxY1EvaW8emeauyXh5hBAx
         e1lc8ykXc5tpyxmnNkcmNZYVodOa91zsRKdMo15pFdWTGNQt0G/8nNoDLL+x3vMA1aFf
         IjBOlNCAOPTWMYzBqj3+67GqcWXmdxmWh3wNhgZTtk4XBnjpgRdNdvqj/wWv9rGSg+Cp
         T/25gnOzd2AOSRvTGkn+qLtwfvWbbdD2sPgUbVlNyBGgOQHIGo6imy7BSEtBNSxKXFYn
         UzeEPYXenOY6QDZKHpg5WRuw0Dk8hBAyddW07F9ti9P2/zccdID9CshInlXXExpO1r61
         +nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Jy97aMm7VEGQNVs4spkiz3xhAyYCzC385iFjGUTMn8=;
        b=rQR/BKLH6LV6PHiPuQkpM2nKUhGFEw2rw0jgp3E9qLRvclTzyS+YbXjtjDYK3QUrDT
         tDwRbRTwRv0FxWYMZi9EjekshY4V7qUirbgXTK/b42pLF3nlCoQOvsfuCOQE6Gh9KWbQ
         Qbysy4g7cnNc1UKAGsHmaejYQRmYKUgRjgGUs7fDW17kc3uwenSkIXZ1MWQ0qGb1EhWm
         VDbIouhWeQK/iwYzCUw9bOsp3aA3B9G1G+SYQb+21Be/nbNlcBNl0b4ahTKL5bSds3JT
         0viPXe1DrzgqBIigykmGSZAShGXCX5GJuy2WIKcQvTuLd6jiWTffnvQ3cdR6+9iWBE2e
         oxqA==
X-Gm-Message-State: AOAM5307UZD2Tz4GJm0B5hVjX+9SnpsU5CqZ3Ikq7z175kJ2H5HSnzkP
        1PSD9eEIAs4jb8XxkwHSnNyMU4jpQpnGXd63eKWiwQ==
X-Google-Smtp-Source: ABdhPJyjJrIe5NfB/SgNpUbbYhp5PwWZevJfF2nDS2rzDV/COs7JX2gE8nAaUKkvcfbYNdtm7H3JDS1XSpUPuzuF3P0=
X-Received: by 2002:a17:906:c448:: with SMTP id ck8mr13902565ejb.497.1620928467472;
 Thu, 13 May 2021 10:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210407123438.224551-1-mindal@semihalf.com> <20210511030658.GG3425@dragon>
 <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
 <20210513021214.GJ3425@dragon> <20210513141921.i7sfmekbcw2m7vxd@skbuf>
In-Reply-To: <20210513141921.i7sfmekbcw2m7vxd@skbuf>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 13 May 2021 19:54:15 +0200
Message-ID: <CAPv3WKfnWFjfZw39avZBEyUpEsH2f=NCs8VfjeR+wzk4qV3GmA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Kornel Duleba <mindal@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

czw., 13 maj 2021 o 16:19 Vladimir Oltean <vladimir.oltean@nxp.com> napisa=
=C5=82(a):
>
> On Thu, May 13, 2021 at 10:12:15AM +0800, Shawn Guo wrote:
> > On Tue, May 11, 2021 at 09:48:22AM +0000, Claudiu Manoil wrote:
> > > >-----Original Message-----
> > > >From: Shawn Guo <shawnguo@kernel.org>
> > > >Sent: Tuesday, May 11, 2021 6:07 AM
> > > [...]
> > > >Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE wind=
ow
> > > >ranges
> > > >
> > > >+ Claudiu
> > > >
> > > >On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> > > >> Currently all PCIE windows point to bus address 0x0, which does no=
t match
> > > >> the values obtained from hardware during EA.
> > > >> Replace those values with CPU addresses, since in reality we
> > > >> have a 1:1 mapping between the two.
> > > >>
> > > >> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
> > > >
> > > >Claudiu,
> > > >
> > > >Do you have any comment on this?
> > > >
> > >
> > > Well, probing is still working with this change, I've just tested it.
> > >
> > > PCI listing at boot time changes from:
> > >
> > > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 rang=
es:
> > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff =
-> 0x0000000000
> > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff =
-> 0x0000000000
> > >
> > > to:
> > >
> > > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 rang=
es:
> > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff =
-> 0x01f8000000
> > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff =
-> 0x01f8160000
> > >
> > > and looks reasonable.
> > > Adding Vladimir and Alex just in case.
> > >
> > > Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> >
> > Thanks, Claudiu.
> >
> > Kornel,
> >
> > Do we need a Fixes tag for this patch?
> >
> > Shawn
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> I am not sure whether "incorrect data that is unused" deserves a Fixes:
> tag or not, probably not.
>
> Bjorn Helgaas did point out before that "The fact that all these windows
> map to PCI bus address 0 looks broken", so there's that:
>
> https://patchwork.kernel.org/project/linux-pci/cover/20201129230743.30069=
78-1-kw@linux.com/
>
> And while it does look "broken", with the Enhanced Allocation capability
> and the pci-host-ecam-generic driver, there is no address translation
> taking place, so no inbound/outbound windows are configured, so the
> range.pci_addr calculated in devm_of_pci_get_host_bridge_resources() is
> not used for anything except for printing.

...in Linux. Please note Linux device trees can be used as-is by other
projects. Regardless my opinion on how that's unfortunate, FreeBSD
does additional ranges check before performing EA and fails. Since the
current DT description is imo broken and the change is transparent for
Linux, it would be great to get this change merged into tree in case
there are are no objections.

Thanks,
Marcin

>
> FWIW here's a more complete image of what changes with Kornel's patch
> ("-" is before, "+" is after) - again all is limited to the dmesg output.
>
>  pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
>  pci-host-generic 1f0000000.pcie: Parsing ranges property...
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> =
0x01f8000000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f8000000 end 0x01f815ffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f8000000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f8000000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> =
0x01f8160000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f8160000 end 0x01f81cffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f8160000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f8160000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> =
0x01f81d0000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f81d0000 end 0x01f81effff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f81d0000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f81d0000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> =
0x01f81f0000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f81f0000 end 0x01f820ffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f81f0000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f81f0000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> =
0x01f8210000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f8210000 end 0x01f822ffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f8210000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f8210000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> =
0x01f8230000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01f8230000 end 0x01f824ffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01f8230000
> -pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> =
0x0000000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01f8230000 =3D> offset 0x0000000000
> +pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> =
0x01fc000000
>  pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
tmp_res start 0x01fc000000 end 0x01fc3fffff
> -pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x0000000000 =3D> offset 0x01fc000000
> +pci-host-generic 1f0000000.pcie: devm_of_pci_get_host_bridge_resources: =
pci_addr 0x01fc000000 =3D> offset 0x0000000000
>  pci-host-generic 1f0000000.pcie: ECAM at [mem 0x1f0000000-0x1f00fffff] f=
or [bus 00]
>  pci-host-generic 1f0000000.pcie: PCI host bridge to bus 0000:00
>  pci_bus 0000:00: root bus resource [bus 00]
> -pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff] (bus ad=
dress [0x00000000-0x0015ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref] (b=
us address [0x00000000-0x0006ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff] (bus ad=
dress [0x00000000-0x0001ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref] (b=
us address [0x00000000-0x0001ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff] (bus ad=
dress [0x00000000-0x0001ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref] (b=
us address [0x00000000-0x0001ffff])
> -pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff] (bus ad=
dress [0x00000000-0x003fffff])
> +pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff]
> +pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref]
> +pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff]
> +pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref]
> +pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff]
> +pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref]
> +pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff]
>  pci 0000:00:00.0: [1957:e100] type 00 class 0x020001
>  pci 0000:00:00.0: BAR 0: [mem 0x1f8000000-0x1f803ffff 64bit] (from Enhan=
ced Allocation, properties 0x0)
>  pci 0000:00:00.0: BAR 2: [mem 0x1f8160000-0x1f816ffff 64bit pref] (from =
Enhanced Allocation, properties 0x1)
>
> My understanding might be wrong, but it should be possible for the PCIe
> host bridge driver to initialize some of its resources by enumerating
> the functions which have the EA capability, and not require the device
> tree writer to add a "ranges" entry for them at all. Then this discussion
> would be moot - that resource would have no way to be incorrect.
>
> $ lspci -vvv
> 0000:00:00.0 Ethernet controller: Freescale Semiconductor Inc Device e100=
 (rev 01) (prog-if 01)
>         Subsystem: Freescale Semiconductor Inc Device e100
> (...)
>         Capabilities: [9c] Enhanced Allocation (EA): NumEntries=3D4
>                 Entry 0: Enable+ Writable- EntrySize=3D3
>                          BAR Equivalent Indicator: BAR 0
>                          PrimaryProperties: memory space, non-prefetchabl=
e
>                          SecondaryProperties: entry unavailable for use, =
PrimaryProperties should be used
>                          Base: 1f8000000
>                          MaxOffset: 0003ffff
>                 Entry 1: Enable+ Writable- EntrySize=3D3
>                          BAR Equivalent Indicator: BAR 2
>                          PrimaryProperties: memory space, prefetchable
>                          SecondaryProperties: memory space, non-prefetcha=
ble
>                          Base: 1f8160000
>                          MaxOffset: 0000ffff
>                 Entry 2: Enable+ Writable- EntrySize=3D3
>                          BAR Equivalent Indicator: VF-BAR 0
>                          PrimaryProperties: VF memory space, non-prefetch=
able
>                          SecondaryProperties: entry unavailable for use, =
PrimaryProperties should be used
>                          Base: 1f81d0000
>                          MaxOffset: 0000ffff
>                 Entry 3: Enable+ Writable- EntrySize=3D3
>                          BAR Equivalent Indicator: VF-BAR 2
>                          PrimaryProperties: VF memory space, prefetchable
>                          SecondaryProperties: VF memory space, prefetchab=
le
>                          Base: 1f81f0000
>                          MaxOffset: 0000ffff
>
> This information, which is already present in the hardware, needs to be
> duplicated here (now I do see that the 'ranges' property declares them
> larger than they really are, too):
>
>                                   /* PF0-6 BAR0 - non-prefetchable memory=
 */
>                         ranges =3D <0x82000000 0x0 0x00000000  0x1 0xf800=
0000  0x0 0x160000
>                                   /* PF0-6 BAR2 - prefetchable memory */
>                                   0xc2000000 0x0 0x00000000  0x1 0xf81600=
00  0x0 0x070000
>                                   /* PF0: VF0-1 BAR0 - non-prefetchable m=
emory */
>                                   0x82000000 0x0 0x00000000  0x1 0xf81d00=
00  0x0 0x020000
>                                   /* PF0: VF0-1 BAR2 - prefetchable memor=
y */
>                                   0xc2000000 0x0 0x00000000  0x1 0xf81f00=
00  0x0 0x020000
