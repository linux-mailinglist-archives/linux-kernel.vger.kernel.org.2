Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0A409723
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbhIMPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbhIMPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:22:16 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D0C0F0037
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 07:18:21 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mPmmp-00038i-52; Mon, 13 Sep 2021 10:18:19 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id D036D5600F9; Mon, 13 Sep 2021 10:18:18 -0400 (EDT)
Date:   Mon, 13 Sep 2021 10:18:18 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210913141818.GA27911@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 04:58:27PM -0700, Linus Torvalds wrote:
 > So 5.15 isn't shaping up to be a particularly large release, at least
 > in number of commits. At only just over 10k non-merge commits, this is
 > in fact the smallest rc1 we have had in the 5.x series. We're usually
 > hovering in the 12-14k commit range.

This release takes over two minutes longer to boot on one my machines than 5.14.
The time just seems to be unaccounted for, even with initcall_debug

[    2.190051] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.190057] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.190239] acpi PNP0A08:00: _OSC: platform does not support [PME]
[    2.190360] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    2.190362] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    2.190783] PCI host bridge to bus 0000:00
[    2.190785] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.190787] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.190789] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    2.190790] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    2.190792] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    2.190794] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    2.190795] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    2.190797] pci_bus 0000:00: root bus resource [mem 0xbf200000-0xfeafffff window]
[    2.190799] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.190828] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x10 @ 1
[    2.190833] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x10 took 0 usecs
[    2.190836] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    2.190851] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.190855] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.190950] pci 0000:00:01.0: calling  quirk_no_aersid+0x0/0x10 @ 1
[    2.190953] pci 0000:00:01.0: quirk_no_aersid+0x0/0x10 took 0 usecs
[    2.190955] pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
[    2.190972] pci 0000:00:01.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.190975] pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.190978] pci 0000:00:01.0: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    2.190981] pci 0000:00:01.0: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    2.190993] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.191233] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
[    2.191240] pci 0000:00:02.0: reg 0x10: [mem 0xdf000000-0xdf3fffff 64bit]
[    2.191244] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    2.191248] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    2.191256] pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.191260] pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.191339] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
[    2.191345] pci 0000:00:03.0: reg 0x10: [mem 0xdfe34000-0xdfe37fff 64bit]
[    2.191356] pci 0000:00:03.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.191359] pci 0000:00:03.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.191450] pci 0000:00:14.0: [8086:8cb1] type 00 class 0x0c0330
[    2.191463] pci 0000:00:14.0: reg 0x10: [mem 0xdfe20000-0xdfe2ffff 64bit]
[    2.191492] pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.191495] pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.191514] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.191592] pci 0000:00:16.0: [8086:8cba] type 00 class 0x078000
[    2.191606] pci 0000:00:16.0: reg 0x10: [mem 0xdfe3e000-0xdfe3e00f 64bit]
[    2.191637] pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.191640] pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.191660] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    2.191790] pci 0000:00:19.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[    2.191794] pci 0000:00:19.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[    2.191797] pci 0000:00:19.0: [8086:15a1] type 00 class 0x020000
[    2.191807] pci 0000:00:19.0: reg 0x10: [mem 0xdfe00000-0xdfe1ffff]
[    2.191814] pci 0000:00:19.0: reg 0x14: [mem 0xdfe3c000-0xdfe3cfff]
[    2.191820] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    2.191844] pci 0000:00:19.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.191847] pci 0000:00:19.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.191869] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    2.191953] pci 0000:00:1a.0: [8086:8cad] type 00 class 0x0c0320
[    2.191966] pci 0000:00:1a.0: reg 0x10: [mem 0xdfe3b000-0xdfe3b3ff]
[    2.192007] pci 0000:00:1a.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.192010] pci 0000:00:1a.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.192038] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    2.192121] pci 0000:00:1b.0: [8086:8ca0] type 00 class 0x040300
[    2.192132] pci 0000:00:1b.0: reg 0x10: [mem 0xdfe30000-0xdfe33fff 64bit]
[    2.192158] pci 0000:00:1b.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.192161] pci 0000:00:1b.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.192187] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    2.192313] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x10 @ 1
[    2.192316] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x10 took 0 usecs
[    2.192318] pci 0000:00:1c.0: [8086:8c90] type 01 class 0x060400
[    2.192353] pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.192356] pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.192359] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    2.192362] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    2.192387] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.192615] pci 0000:00:1c.3: calling  quirk_no_aersid+0x0/0x10 @ 1
[    2.192618] pci 0000:00:1c.3: quirk_no_aersid+0x0/0x10 took 0 usecs
[    2.192620] pci 0000:00:1c.3: [8086:8c96] type 01 class 0x060400
[    2.192656] pci 0000:00:1c.3: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.192659] pci 0000:00:1c.3: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.192662] pci 0000:00:1c.3: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    2.192664] pci 0000:00:1c.3: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    2.192689] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    2.192914] pci 0000:00:1c.4: calling  quirk_no_aersid+0x0/0x10 @ 1
[    2.192917] pci 0000:00:1c.4: quirk_no_aersid+0x0/0x10 took 0 usecs
[    2.192919] pci 0000:00:1c.4: [8086:8c98] type 01 class 0x060400
[    2.192954] pci 0000:00:1c.4: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.192957] pci 0000:00:1c.4: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.192960] pci 0000:00:1c.4: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    2.192962] pci 0000:00:1c.4: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    2.192988] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    2.193213] pci 0000:00:1c.6: calling  quirk_no_aersid+0x0/0x10 @ 1
[    2.193215] pci 0000:00:1c.6: quirk_no_aersid+0x0/0x10 took 0 usecs
[    2.193217] pci 0000:00:1c.6: [8086:8c9c] type 01 class 0x060400
[    2.193253] pci 0000:00:1c.6: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.193256] pci 0000:00:1c.6: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.193259] pci 0000:00:1c.6: calling  pci_fixup_transparent_bridge+0x0/0x20 @ 1
[    2.193261] pci 0000:00:1c.6: pci_fixup_transparent_bridge+0x0/0x20 took 0 usecs
[    2.193286] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    2.193515] pci 0000:00:1d.0: [8086:8ca6] type 00 class 0x0c0320
[    2.193528] pci 0000:00:1d.0: reg 0x10: [mem 0xdfe3a000-0xdfe3a3ff]
[    2.193570] pci 0000:00:1d.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.193573] pci 0000:00:1d.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.193601] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    2.193688] pci 0000:00:1f.0: [8086:8cc4] type 00 class 0x060100
[    2.193754] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.193757] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.193855] pci 0000:00:1f.2: [8086:8c82] type 00 class 0x010601
[    2.193864] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    2.193870] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    2.193875] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    2.193881] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    2.193886] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    2.193892] pci 0000:00:1f.2: reg 0x24: [mem 0xdfe39000-0xdfe397ff]
[    2.193901] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.193904] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.193923] pci 0000:00:1f.2: PME# supported from D3hot
[    2.193997] pci 0000:00:1f.3: [8086:8ca2] type 00 class 0x0c0500
[    2.194010] pci 0000:00:1f.3: reg 0x10: [mem 0xdfe38000-0xdfe380ff 64bit]
[    2.194025] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    2.194039] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.194042] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.194093] pci 0000:01:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[    2.194097] pci 0000:01:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[    2.194100] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[    2.194109] pci 0000:01:00.0: reg 0x10: [mem 0xd0080000-0xd00fffff 64bit pref]
[    2.194113] pci 0000:01:00.0: reg 0x18: [io  0xe020-0xe03f]
[    2.194121] pci 0000:01:00.0: reg 0x20: [mem 0xd0104000-0xd0107fff 64bit pref]
[    2.194126] pci 0000:01:00.0: reg 0x30: [mem 0xdfd80000-0xdfdfffff pref]
[    2.194136] pci 0000:01:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[    2.194139] pci 0000:01:00.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[    2.194164] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold

* stall here for 86 seconds *

[   88.675114] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
[   88.675118] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[   88.675125] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[   88.675127] pci 0000:01:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[   88.675252] pci 0000:01:00.1: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[   88.675255] pci 0000:01:00.1: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[   88.675258] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[   88.675267] pci 0000:01:00.1: reg 0x10: [mem 0xd0000000-0xd007ffff 64bit pref]
[   88.675272] pci 0000:01:00.1: reg 0x18: [io  0xe000-0xe01f]
[   88.675280] pci 0000:01:00.1: reg 0x20: [mem 0xd0100000-0xd0103fff 64bit pref]
[   88.675284] pci 0000:01:00.1: reg 0x30: [mem 0xdfd00000-0xdfd7ffff pref]
[   88.675295] pci 0000:01:00.1: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[   88.675298] pci 0000:01:00.1: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[   88.675324] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold

* stall again for 98 seconds *

[  186.595114] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
[  186.595117] pci 0000:01:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[  186.595124] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[  186.595126] pci 0000:01:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[  186.595242] pci 0000:00:01.0: PCI bridge to [bus 01]
[  186.595245] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[  186.595247] pci 0000:00:01.0:   bridge window [mem 0xdfd00000-0xdfdfffff]
[  186.595249] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd01fffff 64bit pref]
[  186.595251] pci 0000:00:01.0: bridge has subordinate 01 but max busn 02
[  186.595296] pci 0000:02:00.0: [144d:a800] type 00 class 0x010601
[  186.595351] pci 0000:02:00.0: reg 0x24: [mem 0xdfc10000-0xdfc11fff]
[  186.595361] pci 0000:02:00.0: reg 0x30: [mem 0xdfc00000-0xdfc0ffff pref]
[  186.595425] pci 0000:02:00.0: PME# supported from D3hot D3cold
[  186.735107] pci 0000:02:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
[  186.735140] pci 0000:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 16.000 Gb/s with 5.0 GT/s PCIe x4 link)
[  186.735255] pci 0000:00:1c.0: PCI bridge to [bus 02]
[  186.735260] pci 0000:00:1c.0:   bridge window [mem 0xdfc00000-0xdfcfffff]
[  186.735310] pci 0000:03:00.0: [1b21:1187] type 01 class 0x060400
[  186.735360] pci 0000:03:00.0: enabling Extended Tags
[  186.735422] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[  186.735567] pci 0000:00:1c.3: PCI bridge to [bus 03-0b]
[  186.735570] pci 0000:00:1c.3:   bridge window [io  0xb000-0xcfff]
[  186.735573] pci 0000:00:1c.3:   bridge window [mem 0xdf400000-0xdf9fffff]
[  186.735649] pci 0000:04:01.0: [1b21:1187] type 01 class 0x060400
[  186.735702] pci 0000:04:01.0: enabling Extended Tags
[  186.735762] pci 0000:04:01.0: PME# supported from D0 D3hot D3cold
[  186.735848] pci 0000:04:02.0: [1b21:1187] type 01 class 0x060400
[  186.735901] pci 0000:04:02.0: enabling Extended Tags
[  186.735961] pci 0000:04:02.0: PME# supported from D0 D3hot D3cold
[  186.736048] pci 0000:04:03.0: [1b21:1187] type 01 class 0x060400
[  186.736100] pci 0000:04:03.0: enabling Extended Tags
[  186.736160] pci 0000:04:03.0: PME# supported from D0 D3hot D3cold
[  186.736243] pci 0000:04:04.0: [1b21:1187] type 01 class 0x060400
[  186.736296] pci 0000:04:04.0: enabling Extended Tags
[  186.736355] pci 0000:04:04.0: PME# supported from D0 D3hot D3cold
[  186.736439] pci 0000:04:05.0: [1b21:1187] type 01 class 0x060400
[  186.736492] pci 0000:04:05.0: enabling Extended Tags
[  186.736551] pci 0000:04:05.0: PME# supported from D0 D3hot D3cold
[  186.736635] pci 0000:04:06.0: [1b21:1187] type 01 class 0x060400
[  186.736688] pci 0000:04:06.0: enabling Extended Tags
[  186.736747] pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
[  186.736830] pci 0000:04:07.0: [1b21:1187] type 01 class 0x060400
[  186.736883] pci 0000:04:07.0: enabling Extended Tags
[  186.736943] pci 0000:04:07.0: PME# supported from D0 D3hot D3cold
[  186.737024] pci 0000:03:00.0: PCI bridge to [bus 04-0b]
[  186.737030] pci 0000:03:00.0:   bridge window [io  0xb000-0xcfff]
[  186.737034] pci 0000:03:00.0:   bridge window [mem 0xdf400000-0xdf9fffff]
[  186.737071] pci 0000:04:01.0: PCI bridge to [bus 05]
[  186.737153] pci 0000:06:00.0: [14e4:43b1] type 00 class 0x028000
[  186.737183] pci 0000:06:00.0: reg 0x10: [mem 0xdf600000-0xdf607fff 64bit]
[  186.737202] pci 0000:06:00.0: reg 0x18: [mem 0xdf400000-0xdf5fffff 64bit]
[  186.737372] pci 0000:06:00.0: supports D1 D2
[  186.737374] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  186.737516] pci 0000:04:02.0: PCI bridge to [bus 06]
[  186.737524] pci 0000:04:02.0:   bridge window [mem 0xdf400000-0xdf6fffff]
[  186.737586] pci 0000:07:00.0: calling  fixup_mpss_256+0x0/0x20 @ 1
[  186.737590] pci 0000:07:00.0: fixup_mpss_256+0x0/0x20 took 0 usecs
[  186.737593] pci 0000:07:00.0: [1b21:0612] type 00 class 0x010601
[  186.737617] pci 0000:07:00.0: reg 0x10: [io  0xc050-0xc057]
[  186.737630] pci 0000:07:00.0: reg 0x14: [io  0xc040-0xc043]
[  186.737643] pci 0000:07:00.0: reg 0x18: [io  0xc030-0xc037]
[  186.737657] pci 0000:07:00.0: reg 0x1c: [io  0xc020-0xc023]
[  186.737670] pci 0000:07:00.0: reg 0x20: [io  0xc000-0xc01f]
[  186.737683] pci 0000:07:00.0: reg 0x24: [mem 0xdf900000-0xdf9001ff]
[  186.737851] pci 0000:04:03.0: PCI bridge to [bus 07]
[  186.737857] pci 0000:04:03.0:   bridge window [io  0xc000-0xcfff]
[  186.737860] pci 0000:04:03.0:   bridge window [mem 0xdf900000-0xdf9fffff]
[  186.737899] pci 0000:04:04.0: PCI bridge to [bus 08]
[  186.737943] pci 0000:04:05.0: PCI bridge to [bus 09]
[  186.738025] pci 0000:0a:00.0: calling  quirk_f0_vpd_link+0x0/0x60 @ 1
[  186.738028] pci 0000:0a:00.0: quirk_f0_vpd_link+0x0/0x60 took 0 usecs
[  186.738031] pci 0000:0a:00.0: [8086:1539] type 00 class 0x020000
[  186.738058] pci 0000:0a:00.0: reg 0x10: [mem 0xdf800000-0xdf81ffff]
[  186.738082] pci 0000:0a:00.0: reg 0x18: [io  0xb000-0xb01f]
[  186.738095] pci 0000:0a:00.0: reg 0x1c: [mem 0xdf820000-0xdf823fff]
[  186.738159] pci 0000:0a:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x50 @ 1
[  186.738162] pci 0000:0a:00.0: quirk_igfx_skip_te_disable+0x0/0x50 took 0 usecs
[  186.738265] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
[  186.738397] pci 0000:04:06.0: PCI bridge to [bus 0a]
[  186.738403] pci 0000:04:06.0:   bridge window [io  0xb000-0xbfff]
[  186.738407] pci 0000:04:06.0:   bridge window [mem 0xdf800000-0xdf8fffff]
[  186.738448] pci 0000:04:07.0: PCI bridge to [bus 0b]
[  186.738540] pci 0000:0c:00.0: calling  fixup_mpss_256+0x0/0x20 @ 1
[  186.738543] pci 0000:0c:00.0: fixup_mpss_256+0x0/0x20 took 0 usecs
[  186.738546] pci 0000:0c:00.0: [1b21:0612] type 00 class 0x010601
[  186.738563] pci 0000:0c:00.0: reg 0x10: [io  0xd050-0xd057]
[  186.738572] pci 0000:0c:00.0: reg 0x14: [io  0xd040-0xd043]
[  186.738582] pci 0000:0c:00.0: reg 0x18: [io  0xd030-0xd037]
[  186.738591] pci 0000:0c:00.0: reg 0x1c: [io  0xd020-0xd023]
[  186.738601] pci 0000:0c:00.0: reg 0x20: [io  0xd000-0xd01f]
[  186.738610] pci 0000:0c:00.0: reg 0x24: [mem 0xdfb00000-0xdfb001ff]
[  186.738799] pci 0000:00:1c.4: PCI bridge to [bus 0c]
[  186.738802] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[  186.738805] pci 0000:00:1c.4:   bridge window [mem 0xdfb00000-0xdfbfffff]
[  186.738855] pci 0000:0d:00.0: [1b21:1142] type 00 class 0x0c0330
[  186.738881] pci 0000:0d:00.0: reg 0x10: [mem 0xdfa00000-0xdfa07fff 64bit]
[  186.739001] pci 0000:0d:00.0: PME# supported from D3cold
[  186.739136] pci 0000:00:1c.6: PCI bridge to [bus 0d]
[  186.739140] pci 0000:00:1c.6:   bridge window [mem 0xdfa00000-0xdfafffff]
[  186.739160] pci_bus 0000:00: on NUMA node 0


* boot seems to continue as normal from here *


I did a bisect, which landed in the VPD rework that Heiner landed in
this merge window.   Specifically it ended up on ...


git bisect start
# good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
git bisect good 7d2a07b769330c34b4deabeed939325c77a7ec2f
# bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
git bisect bad 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
# good: [1b4f3dfb4792f03b139edf10124fcbeb44e608e6] Merge tag 'usb-serial-5.15-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next                                              
git bisect good 1b4f3dfb4792f03b139edf10124fcbeb44e608e6
# good: [c793011242d182e5f12800c12dbaf37af80be735] Merge tag 'pinctrl-v5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl                                                              
git bisect good c793011242d182e5f12800c12dbaf37af80be735
# good: [5e6a5845dd651b00754a62edec2f0a439182024d] Merge tag 'gpio-updates-for-v5.15' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux                                                                 
git bisect good 5e6a5845dd651b00754a62edec2f0a439182024d
# bad: [0f4b9289bad354b606190a4cd54d5222b4e41d98] Merge tag 'docs-5.15-2' of git://git.lwn.net/linux
git bisect bad 0f4b9289bad354b606190a4cd54d5222b4e41d98
# good: [626bf91a292e2035af5b9d9cce35c5c138dfe06d] Merge tag 'net-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net                                                                           
git bisect good 626bf91a292e2035af5b9d9cce35c5c138dfe06d
# bad: [49832c819ab85b33b7a2a1429c8d067e82be2977] Makefile: use -Wno-main in the full kernel tree
git bisect bad 49832c819ab85b33b7a2a1429c8d067e82be2977
# bad: [739c4747a25af3a2571f69e4709f2b476a17d5d4] Merge branch 'pci/misc'
git bisect bad 739c4747a25af3a2571f69e4709f2b476a17d5d4
# bad: [2c208abd4f9efac02622d8f3c9989f4b7b1ad973] PCI/VPD: Use unaligned access helpers
git bisect bad 2c208abd4f9efac02622d8f3c9989f4b7b1ad973
# bad: [f240e15097c5004811a58f2cbc170bf90d06d0a9] tg3: Read VPD with pci_vpd_alloc()
git bisect bad f240e15097c5004811a58f2cbc170bf90d06d0a9
# good: [d27f7344ba89897d0ce6ebe0c9eecbe214f9bb8f] PCI/VPD: Reorder pci_read_vpd(), pci_write_vpd()
git bisect good d27f7344ba89897d0ce6ebe0c9eecbe214f9bb8f
# bad: [fe7568cf2f2dc3a0783f6ffdb3802c1ce2085466] PCI/VPD: Treat invalid VPD like missing VPD capability
git bisect bad fe7568cf2f2dc3a0783f6ffdb3802c1ce2085466
# good: [22ff2bcec704a7a8c43a998251e0757cd2de66e1] PCI/VPD: Remove struct pci_vpd.valid member
git bisect good 22ff2bcec704a7a8c43a998251e0757cd2de66e1
# bad: [7bac54497c3e3b2ca37b7043f1fa78586540f10e] PCI/VPD: Determine VPD size in pci_vpd_init()
git bisect bad 7bac54497c3e3b2ca37b7043f1fa78586540f10e
# good: [fd00faa375fbb9d46ae0730d0faf4a3006301005] PCI/VPD: Embed struct pci_vpd in struct pci_dev
git bisect good fd00faa375fbb9d46ae0730d0faf4a3006301005
# first bad commit: [7bac54497c3e3b2ca37b7043f1fa78586540f10e] PCI/VPD: Determine VPD size in pci_vpd_init()   

7bac54497c3e3b2ca37b7043f1fa78586540f10e is the first bad commit
commit 7bac54497c3e3b2ca37b7043f1fa78586540f10e
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sun Aug 8 19:22:52 2021 +0200

    PCI/VPD: Determine VPD size in pci_vpd_init()

    Determine VPD size in pci_vpd_init().

    Quirks set dev->vpd.len to a non-zero value, so they cause us to skip the
    dynamic size calculation.  Prerequisite is that we move the quirks from
    FINAL to HEADER so they are run before pci_vpd_init().

    Link: https://lore.kernel.org/r/cc4a6538-557a-294d-4f94-e6d1d3c91589@gmail.com
    Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


Which unfortunately doesn't revert cleanly I can't test it reverted in
isolation.

My guess is there's something quirky about the PCI bus on this machine
that causes stalls until we hit timeout, but I'm not sure where to begin
debugging this.

There's nothing too exotic on this machine:

00:00.0 Host bridge: Intel Corporation 4th Gen Core Processor DRAM Controller (rev 06)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor PCI Express x16 Controller (rev 06)
00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor Integrated Graphics Controller (rev 06)
00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller (rev 06)
00:14.0 USB controller: Intel Corporation 9 Series Chipset Family USB xHCI Controller
00:16.0 Communication controller: Intel Corporation 9 Series Chipset Family ME Interface #1
00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V
00:1a.0 USB controller: Intel Corporation 9 Series Chipset Family USB EHCI Controller #2
00:1b.0 Audio device: Intel Corporation 9 Series Chipset Family HD Audio Controller
00:1c.0 PCI bridge: Intel Corporation 9 Series Chipset Family PCI Express Root Port 1 (rev d0)
00:1c.3 PCI bridge: Intel Corporation 9 Series Chipset Family PCI Express Root Port 4 (rev d0)
00:1c.4 PCI bridge: Intel Corporation 9 Series Chipset Family PCI Express Root Port 5 (rev d0)
00:1c.6 PCI bridge: Intel Corporation 9 Series Chipset Family PCI Express Root Port 7 (rev d0)
00:1d.0 USB controller: Intel Corporation 9 Series Chipset Family USB EHCI Controller #1
00:1f.0 ISA bridge: Intel Corporation Z97 Chipset LPC Controller
00:1f.2 SATA controller: Intel Corporation 9 Series Chipset Family SATA Controller [AHCI Mode]
00:1f.3 SMBus: Intel Corporation 9 Series Chipset Family SMBus Controller
01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
02:00.0 SATA controller: Samsung Electronics Co Ltd XP941 PCIe SSD (rev 01)
03:00.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:01.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:02.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:03.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:04.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:05.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:06.0 PCI bridge: ASMedia Technology Inc. Device 1187
04:07.0 PCI bridge: ASMedia Technology Inc. Device 1187
06:00.0 Network controller: Broadcom Inc. and subsidiaries BCM4352 802.11ac Wireless Network Adapter (rev 03)
07:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02)
0a:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
0c:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02)
0d:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller


	Dave

