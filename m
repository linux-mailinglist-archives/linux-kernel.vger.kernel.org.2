Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B76381A16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhEORNM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 May 2021 13:13:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEORNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:13:10 -0400
Received: from 'smile.earth' ([95.89.5.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNfgZ-1m75Ju3aah-00P6xf; Sat, 15 May 2021 19:11:49 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-kernel@vger.kernel.org
Cc:     tom.l.nguyen@intel.com, yanmin.zhang@intel.com,
        andrew.patterson@hp.com
Subject: Re: AMD PCI Bridge: Hardware error from APEI
Date:   Sat, 15 May 2021 19:11:44 +0200
Message-ID: <21925848.JRBQYbQsak@xrated>
In-Reply-To: <2149597.8uJZFlvqrj@xrated>
References: <2559180.cUrjzdZFCD@xrated> <7789846.exkBBusKcl@xrated>
 <2149597.8uJZFlvqrj@xrated>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:RbSoOpSnyCkg+aObww/MfQ105diDdcB708fwrMT238dK9G+GD/Y
 zJGRIr6vJvj4EOLSBifqGGsdM7x7uMbtIFpF4kfjEr6cqz8Z8LfwWIhqZkN7bJC4VCEA6Vu
 Qd/EQDhqCzwoFnUbBh+UPPHoRghwf3zFUgRWffWRJ3bxLMG0hQHDjQ7NEHzY8arn6bKbRFg
 7JWl8LhGVE36eFjb5Lp0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+lQowsmyZcs=:w57q0GbMJDCpI1XRhn7/YH
 QHnSIpzWb3EdHxPCWmOt5xU3v94aYb/nxhmx3klOa7cFEnPGQlvPi+DedAwz0En7Geb+AVVxw
 MV8XAYin39DvoReLkmlAV6QI4F/6aMhkMTVV1oAuaGEYEZ6NfwWwogymhP3qK/ggGgQBwJ0mP
 uH6Sb/iSRBdLo6ijA3dnqGIH7z8HyBKyER1JZobXU0Gm1fvd9S2134Gv+6bgj9R4GkEN0KS4V
 LtPUVOxjK5wKIvtPC9exMfyI3mSZGsrnsMy9N/8k+mVZ9kpkqIMBa0KGMynpxceBy33+wJne/
 +W8+MRRyvd4BEfhVQr+WIB6fIbo/THPncMAN7cMmNRB47vpXWkXvg6oPWC/y7H/tzHBx2YcCi
 7FyqTlMcGnwzOihGnf0KuN07tap9bwvpAgg3271Gij8I8OMvlfkFg2iJ8AKmd7+eeevHBpqGC
 VLScPbpo8tD2LC107NPbgmjtpHZPY9heMZTKZgzN06h2J7l5PQRjgLn0vDq/FJDwOyIGavX4u
 meqdIw5t9vj9hp0pSenuOM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

since my bug record got *no* attraction since a couple of month, I decided to 
pull some people into the loop.

This is about:
https://bugzilla.kernel.org/show_bug.cgi?id=209331

This issue is immanent since 5.3.18 (first tested version) up to 5.12.2.
5.12.4 is in preparation (but I'm pretty confident to reproduce it as well.

This might be some bad hardware interaction, but given, any attempt to 
*disable* these messages failed, I would call this a general issue.

See: https://bugzilla.kernel.org/show_bug.cgi?id=209331#c2

I would like to know, how to get to the bottom of it, and if all attempts 
fail, how to disable this behavior.

Sure, this is a production system, but I'm able and prepared to conduct the 
necessary tests/actions of course.

Thanks,
Pete

Am Mittwoch, 15. Juli 2020, 10:11:11 CEST schrieb Hans-Peter Jansen:
> Am Samstag, 11. Juli 2020, 18:32:21 CEST schrieben Sie:
> > Am Dienstag, 7. Juli 2020, 08:56:41 CEST schrieben Sie:
> > > Am Samstag, 27. Juni 2020, 20:23:35 CEST schrieben Sie:
> > > > Dear hacker from the order of the penguins,
> > > > 
> > > > we're facing a disturbing issue here after swapping a motherboard of a
> > > > mission critical system:
> > > > 
> > > > Specs:
> > > > ASUS KNPA-U16 with an AMD EPYC 7261, 2x32 GB Kingston KSM26RD4/32MEI
> > > > (officially supported RAM modules)
> > > > 
> > > > openSUSE 15.1, Kernel 5.7.5
> > > 
> > > Not sure, how to proceed with this one?
> > > 
> > > After 9½ days uptime, it cumulated about 34,000 incidents:
> > > 
> > > [...]
> > > 
> > > Needless so say, that this is no permanent solution.
> > > 
> > > Any ideas anybody?
> > 
> > After swapping the PCIe slot for the Digital Devices Max S8 4/8, the error
> > has moved:
> > 
> > 2020-07-11T18:25:34.380002+02:00 tyrex kernel: [  889.223783]
> > {20}[Hardware
> > Error]: Hardware error from APEI Generic Hardware Error Source: 4
> > 2020-07-11T18:25:34.380025+02:00 tyrex kernel: [  889.223787]
> > {20}[Hardware
> > Error]: It has been corrected by h/w and requires no further action
> > 2020-07-11T18:25:34.380028+02:00 tyrex kernel: [  889.223789]
> > {20}[Hardware
> > Error]: event severity: corrected 2020-07-11T18:25:34.380031+02:00 tyrex
> > kernel: [  889.223791] {20}[Hardware Error]:  Error 0, type: corrected
> > 2020-07-11T18:25:34.380032+02:00 tyrex kernel: [  889.223793]
> > {20}[Hardware
> > Error]:  fru_text: PcieError 2020-07-11T18:25:34.380034+02:00 tyrex
> > kernel:
> > [  889.223795] {20}[Hardware Error]:   section_type: PCIe error
> > 2020-07-11T18:25:34.380577+02:00 tyrex kernel: [  889.223796]
> > {20}[Hardware
> > Error]:   port_type: 4, root port 2020-07-11T18:25:34.380586+02:00 tyrex
> > kernel: [  889.223798] {20}[Hardware Error]:   version: 0.2
> > 2020-07-11T18:25:34.380588+02:00 tyrex kernel: [  889.223800]
> > {20}[Hardware
> > Error]:   command: 0x0407, status: 0x0010 2020-07-11T18:25:34.380590+02:00
> > tyrex kernel: [  889.223802] {20}[Hardware Error]:   device_id:
> > 0000:40:03.1 2020-07-11T18:25:34.380591+02:00 tyrex kernel: [  889.223803]
> > {20}[Hardware Error]:   slot: 16 2020-07-11T18:25:34.380593+02:00 tyrex
> > kernel: [  889.223804] {20}[Hardware Error]:   secondary_bus: 0x41
> > 2020-07-11T18:25:34.380595+02:00 tyrex kernel: [  889.223806]
> > {20}[Hardware
> > Error]:   vendor_id: 0x1022, device_id: 0x1453
> > 2020-07-11T18:25:34.380597+02:00 tyrex kernel: [  889.223808]
> > {20}[Hardware
> > Error]:   class_code: 060400 2020-07-11T18:25:34.380599+02:00 tyrex
> > kernel:
> > [  889.223810] {20}[Hardware Error]:   bridge: secondary_status: 0x2000,
> > control: 0x0012 2020-07-11T18:25:34.380601+02:00 tyrex kernel: [
> > 889.223908] pcieport 0000:40:03.1: AER: aer_status: 0x00001000, aer_mask:
> > 0x00006000 2020-07-11T18:25:34.380603+02:00 tyrex kernel: [  889.223912]
> > pcieport 0000:40:03.1: AER:    [12] Timeout
> > 2020-07-11T18:25:34.380605+02:00 tyrex kernel: [  889.223915] pcieport
> > 0000:40:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID
> > 
> > It looks like the system is creating such devices on demand:
> > 
> > 40:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> > 00h-0fh) PCIe GPP Bridge (prog-if 00 [Normal decode]) Flags: bus master,
> > fast devsel, latency 0, IRQ 39, NUMA node 2 Bus: primary=40, secondary=41,
> > subordinate=41, sec-latency=0 I/O behind bridge: None
> > 
> >         Memory behind bridge: e5d00000-e5dfffff [size=1M]
> >         Prefetchable memory behind bridge: None
> >         Capabilities: [50] Power Management version 3
> >         Capabilities: [58] Express Root Port (Slot+), MSI 00
> >         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >         Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
> > 
> > Family 17h (Models 00h-0fh) PCIe GPP Bridge Capabilities: [c8]
> > HyperTransport: MSI Mapping Enable+ Fixed+ Capabilities: [100] Vendor
> > Specific Information: ID=0001 Rev=1 Len=010 <?> Capabilities: [150]
> > Advanced Error Reporting
> > 
> >         Capabilities: [270] #19
> >         Capabilities: [2a0] Access Control Services
> >         Capabilities: [370] L1 PM Substates
> >         Capabilities: [380] Downstream Port Containment
> >         Capabilities: [3c4] #23
> >         Kernel driver in use: pcieport
> > 
> > in order to handle:
> > 
> > 41:00.0 Multimedia controller: Digital Devices GmbH Max
> > 
> >         Subsystem: Digital Devices GmbH Max S8 4/8
> >         Flags: bus master, fast devsel, latency 0, IRQ 181, NUMA node 2
> >         Memory at e5d00000 (64-bit, non-prefetchable) [size=64K]
> >         Capabilities: [50] Power Management version 3
> >         Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit+
> >         Capabilities: [90] Express Endpoint, MSI 00
> >         Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0
> > 
> > Len=00c <?> Kernel driver in use: ddbridge
> > 
> >         Kernel modules: ddbridge
> 
> Here's the initialization sequence of these devices:
> 
> Jul 13 12:19:27 tyrex kernel: pci 0000:40:03.1: [1022:1453] type 01 class
> 0x060400 Jul 13 12:19:27 tyrex kernel: pci 0000:40:03.1: PME# supported
> from D0 D3hot D3cold Jul 13 12:19:27 tyrex kernel: pci 0000:41:00.0:
> [dd01:0007] type 00 class 0x048000 Jul 13 12:19:27 tyrex kernel: pci
> 0000:41:00.0: reg 0x10: [mem 0xe5d00000-0xe5d0ffff 64bit] Jul 13 12:19:27
> tyrex kernel: pci 0000:40:03.1: PCI bridge to [bus 41] Jul 13 12:19:27
> tyrex kernel: pci 0000:40:03.1:   bridge window [mem 0xe5d00000-0xe5dfffff]
> Jul 13 12:19:27 tyrex kernel: pci 0000:40:03.1: PCI bridge to [bus 41] Jul
> 13 12:19:27 tyrex kernel: pci 0000:40:03.1:   bridge window [mem
> 0xe5d00000-0xe5dfffff] Jul 13 12:19:27 tyrex kernel: pci 0000:40:03.1:
> Adding to iommu group 41 Jul 13 12:19:27 tyrex kernel: pci 0000:41:00.0:
> Adding to iommu group 47 Jul 13 12:19:27 tyrex kernel: pcieport
> 0000:40:03.1: PME: Signaling with IRQ 39 Jul 13 12:19:27 tyrex kernel:
> pcieport 0000:40:03.1: AER: enabled with IRQ 39 Jul 13 12:19:27 tyrex
> kernel: pcieport 0000:40:03.1: DPC: error containment capabilities: Int Msg
> #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
> 
> The last line is somewhat suspicious, but hard to decipher:
> 
> DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+
> SwTrigger+ RP PIO Log 6, DL_ActiveErr+
> 
> I'm pretty sure, this is related, but the deeper meaning is denied me.
> 
> Would be nice, if some enlightened person could shed some light
> into this abyss.
> 
> Pete




