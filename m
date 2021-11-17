Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11514547CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhKQNzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:55:41 -0500
Received: from mail.yujinakao.com ([107.191.43.40]:56212 "EHLO
        mail.yujinakao.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhKQNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:55:40 -0500
Received: from localhost (150-66-79-63m5.mineo.jp [150.66.79.63])
        by mail.yujinakao.com (Postfix) with ESMTPSA id 31C8C7D3D6;
        Wed, 17 Nov 2021 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yujinakao.com;
        s=201707; t=1637157160;
        bh=GNcpBuSJNvNzueC8EyDVLkEnJgI1G1PdA9LPnVwrdyI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iDgwM88XHGo3ZjNAaJe6m8LlyW6STjakONDw++CulK2/6KtpEb7okF/rqfb1cVJw7
         tE4LEXyKgXcufQlIlpCGfo5ZCYL1TvMLsoxgkw+gLWK65WypGXmR/q7Z6YU1el5/pj
         cWidEeR0Ii4lgXEwV6J4Ec5cxD8m/O2xsPCKba16Og7U/fBQNzr+MZgXsGw4EmpUJ2
         GJvAUQwLifs5jVeSbgvKwq0fQLVmv0R5B7yh3Clz7TAcSs93Wfz/5C4SS9EtDL7r7g
         j+AgTMaXSa79GgFBxkE8qi3any51cUvESEGEnV+vA+veJHVsX/BqHdluEppT/scbGI
         xRcUeyCca20qw==
From:   Yuji Nakao <contact@yujinakao.com>
To:     Marc Zyngier <maz@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
In-Reply-To: <8735nv880m.wl-maz@kernel.org>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
 <YZQ+GhRR+CPbQ5dX@rocinante> <8735nv880m.wl-maz@kernel.org>
Date:   Wed, 17 Nov 2021 22:52:43 +0900
Message-ID: <87sfvuvqhg.fsf@yujinakao.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc Zyngier <maz@kernel.org> writes:

> Hi Krzysztof, Yugi,
>
> On Tue, 16 Nov 2021 23:26:18 +0000,
> Krzysztof Wilczy=C5=84ski <kw@linux.com> wrote:
>>=20
>> [+CC Arnd, Bjorn, Marc and Sasha for visibility]
>>=20
>> Hello Damien and Yuji,
>>=20
>> [...]
>> > > I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[=
1]
>> > > from v5.14.16 to v5.15.2 the other day, and the boot process stalled
>> > > with the following message.
>> > >=20
>> > > ```shell
>> > > :: running early hook [udev]
>> > > Starting version 249.6-3-arch
>> > > :: running hook [udev]
>> > > :: Triggering uevents...
>> > > Waiting 10 seconds for device /dev/sda3 ...
>> > > ERROR: device '/dev/sda3' not found. Skipping fsck.
>> > > :: mounting '/dev/sda' on real root
>> > > mount: /new_root: no filesystem type specified.
>> > > You are now being dropped into an emergency shell.
>> > > sh: can't access tty; job control turned off
>> > > [rootfs ]#
>> > > ```
>> > >=20
>> > > In the emergency shell there's no `sda` devices when I type `$ ls
>> > > /dev/`. By downgrading the kernel, boot process works properly.
>> > >=20
>> > > See also Arch Linux bug tracker[2]. There are similar reports on
>> > > Apple devices.
>> > >=20
>> > > `dmesg` output in the emergency shell is attached. I guess this issu=
e is
>> > > related to libata, so CCed to Damien Le Moal.
>> >=20
>> > I think that this problem is due to recent PCI subsystem changes which=
 broke Mac
>> > support. The problem show up as the interrupts not being delivered, wh=
ich in
>> > turn result in the kernel assuming that the drive is not working (see =
the
>> > timeout error messages in your dmesg output). Hence your boot drive de=
tection
>> > fails and no rootfs to mount.
>> >=20
>> > Adding linux-pci list.
>> >=20
>> >=20
>> >=20
>> > >=20
>> > > Regards.
>> > >=20
>> > > [1] https://archlinux.org/packages/core/x86_64/linux/
>> > > [2] https://bugs.archlinux.org/task/72734
>>=20
>> The error in the dmesg output (see [2] where the log file is attached)
>> looks similar to the problem reported a week or so ago, as per:
>>=20
>>   https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f878e2f6=
@xenosoft.de/
>>=20
>> The problematic commits where reverted by Bjorn and the Pull Request that
>> did it was accepted, as per:
>>=20
>>   https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelgaas/
>>=20
>> Thus, this would made its way into 5.16-rc1, I suppose.  We might have to
>> back-port this to the stable and long-term kernels.
>>=20
>> Yuji, could you, if you have some time to spare, try the 5.16-rc1 to see=
 if
>> this have gotten better on your system?
>
> I'm afraid you have the wrong end of the stick on this one.
>
> The issue is reported on 5.15, and the issue you are pointing at was
> introduced during the 5.16 merge window. The problematic commit wasn't
> reverted, but instead fixed in 10a20b34d735 ("of/irq: Don't ignore
> interrupt-controller when interrupt-map failed").
>
> The issue is instead very close to the one reported at [1], for which
> we have a very conservative workaround in 5.16-rc1 (commits
> 2226667a145d and f21082fb20db). Looking at the dmesg log provided by
> Yugi, you find the following nugget:
>
> [    0.378564] pci 0000:00:0a.0: [10de:0d88] type 00 class 0x010601
>
> Oh look, a NVIDIA AHCI controller, probably similar enough to the one
> discussed in the issue reported by Rui.
>
> Yugi, could you please test the patch below on top of 5.16-rc1?
>
> Thanks,
>
> 	M.
>
> [1] https://lore.kernel.org/r/CALjTZvbzYfBuLB+H=3Dfj2J+9=3DDxjQ2Uqcy0if_P=
vmJ-nU-qEgkg@mail.gmail.com
>
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..cd88eddf614d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5857,3 +5857,4 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *p=
dev)
>  	pdev->dev_flags |=3D PCI_DEV_FLAGS_HAS_MSI_MASKING;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fi=
xup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0d88, nvidia_ion_ahci_fi=
xup);
>
> --=20
> Without deviation from the norm, progress is not possible.

I installed plane 5.16-rc1 using pre-built image[1] by linux-mainline
aur package[2] maintainer and 5.16-rc1 with the patch provided from
Mark. Both versions succeeded to boot. Thank you for quick
investigation. I'll wait for backporting the fix.

[1] https://wiki.archlinux.org/title/Unofficial_user_repositories#miffe
[2] https://aur.archlinux.org/packages/linux-mainline/

For the record, I attach each dmesg log.
5.16-rc1 dmesg

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=dmesg_v5.16-rc1.log
Content-Transfer-Encoding: quoted-printable
Content-Description: dmesg_v5.16-rc1.log

[    0.000000] microcode: microcode updated early to revision 0xa0b, date =
=3D 2010-09-28
[    0.000000] Linux version 5.16.0-rc1-1-mainline (linux-mainline@archlinu=
x) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun, 14 =
Nov 2021 23:35:58 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-mainline.img root=3D/dev/sda3 rw ipv6.disable=3D1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 by=
tes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1520
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f000000-0x000000007effffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000007f718fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f719000-0x000000007f938fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007f939000-0x000000007f953fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f954000-0x000000007f96afff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007f96b000-0x000000007f96efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f96f000-0x000000007f99afff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f99b000-0x000000007f9affff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f9b0000-0x000000007f9dafff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f9db000-0x000000007fef8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fef9000-0x000000007fefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000093200000-0x0000000093200fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x6e8da018-0x6e8e8c57] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6e8da018-0x6e8e8c57] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6e8d9018-0x6e8d9984] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6e8d9018-0x6e8d9984] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ff=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000006e8d90=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000006e8d9018-0x000000006e8d99=
84] usable
[    0.000000] reserve setup_data: [mem 0x000000006e8d9985-0x000000006e8da0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000006e8da018-0x000000006e8e8c=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000006e8e8c58-0x000000006effff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000006f000000-0x000000007effff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f000000-0x000000007f718f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f719000-0x000000007f938f=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f939000-0x000000007f953f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f954000-0x000000007f96af=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007f96b000-0x000000007f96ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f96f000-0x000000007f99af=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f99b000-0x000000007f9aff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f9b0000-0x000000007f9daf=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f9db000-0x000000007fef8f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fef9000-0x000000007fefff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000093200000-0x0000000093200f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffc00000-0x00000000ffffff=
ff] reserved
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=3D0x7f96a000 ACPI 2.0=3D0x7f96a014 SMBIOS=3D0x7f71=
a000=20
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookAir3,1/Mac-942452F5819B1C1B, BIOS    =
MBA31.88Z.0061.B07.1201241641 01/24/12
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1397.150 MHz processor
[    0.000027] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000035] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000053] last_pfn =3D 0x7fef9 max_arch_pfn =3D 0x400000000
[    0.001560] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
=20=20
[    0.030088] Secure boot disabled
[    0.030095] RAMDISK: [mem 0x67e98000-0x68ae5fff]
[    0.030108] ACPI: Early table checksum verification disabled
[    0.030116] ACPI: RSDP 0x000000007F96A014 000024 (v02 APPLE )
[    0.030127] ACPI: XSDT 0x000000007F96A1C0 000084 (v01 APPLE  Apple00  00=
000061      01000013)
[    0.030143] ACPI: FACP 0x000000007F968000 0000F4 (v04 APPLE  Apple00  00=
000061 Loki 0000005F)
[    0.030158] ACPI: DSDT 0x000000007F95B000 00572C (v01 APPLE  MacBookA 00=
030001 INTL 20061109)
[    0.030169] ACPI: FACS 0x000000007F71E000 000040
[    0.030177] ACPI: FACS 0x000000007F71E000 000040
[    0.030186] ACPI: HPET 0x000000007F967000 000038 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030196] ACPI: APIC 0x000000007F966000 000068 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030206] ACPI: APIC 0x000000007F965000 000068 (v02 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030216] ACPI: ASF! 0x000000007F963000 0000A5 (v32 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030226] ACPI: SBST 0x000000007F962000 000030 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030236] ACPI: ECDT 0x000000007F961000 000053 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030245] ACPI: SSDT 0x000000007F958000 000107 (v01 APPLE  SataAhci 00=
001000 INTL 20061109)
[    0.030255] ACPI: SSDT 0x000000007F957000 000024 (v01 APPLE  Apple    00=
001000 INTL 20061109)
[    0.030265] ACPI: SSDT 0x000000007F955000 00008A (v01 APPLE  NoSDCard 00=
001000 INTL 20061109)
[    0.030275] ACPI: SSDT 0x000000007F954000 0004DC (v01 APPLE  CpuPm    00=
003000 INTL 20061109)
[    0.030284] ACPI: MCFG 0x000000007F964000 00003C (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.030292] ACPI: Reserving FACP table memory at [mem 0x7f968000-0x7f968=
0f3]
[    0.030297] ACPI: Reserving DSDT table memory at [mem 0x7f95b000-0x7f960=
72b]
[    0.030300] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e=
03f]
[    0.030303] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e=
03f]
[    0.030306] ACPI: Reserving HPET table memory at [mem 0x7f967000-0x7f967=
037]
[    0.030310] ACPI: Reserving APIC table memory at [mem 0x7f966000-0x7f966=
067]
[    0.030313] ACPI: Reserving APIC table memory at [mem 0x7f965000-0x7f965=
067]
[    0.030316] ACPI: Reserving ASF! table memory at [mem 0x7f963000-0x7f963=
0a4]
[    0.030319] ACPI: Reserving SBST table memory at [mem 0x7f962000-0x7f962=
02f]
[    0.030322] ACPI: Reserving ECDT table memory at [mem 0x7f961000-0x7f961=
052]
[    0.030325] ACPI: Reserving SSDT table memory at [mem 0x7f958000-0x7f958=
106]
[    0.030328] ACPI: Reserving SSDT table memory at [mem 0x7f957000-0x7f957=
023]
[    0.030331] ACPI: Reserving SSDT table memory at [mem 0x7f955000-0x7f955=
089]
[    0.030334] ACPI: Reserving SSDT table memory at [mem 0x7f954000-0x7f954=
4db]
[    0.030338] ACPI: Reserving MCFG table memory at [mem 0x7f964000-0x7f964=
03b]
[    0.030346] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.030348] ACPI: If "acpi_apic_instance=3D2" works better, notify linux=
-acpi@vger.kernel.org
[    0.030360] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.030458] No NUMA configuration found
[    0.030460] Faking a node at [mem 0x0000000000000000-0x000000007fef8fff]
[    0.030470] NODE_DATA(0) allocated [mem 0x7fef5000-0x7fef8fff]
[    0.030524] Zone ranges:
[    0.030526]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.030532]   DMA32    [mem 0x0000000001000000-0x000000007fef8fff]
[    0.030536]   Normal   empty
[    0.030540]   Device   empty
[    0.030543] Movable zone start for each node
[    0.030545] Early memory node ranges
[    0.030546]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.030550]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.030553]   node   0: [mem 0x0000000000100000-0x000000006effffff]
[    0.030557]   node   0: [mem 0x000000007f000000-0x000000007f718fff]
[    0.030560]   node   0: [mem 0x000000007f939000-0x000000007f953fff]
[    0.030563]   node   0: [mem 0x000000007f96b000-0x000000007f96efff]
[    0.030566]   node   0: [mem 0x000000007f99b000-0x000000007f9affff]
[    0.030569]   node   0: [mem 0x000000007f9db000-0x000000007fef8fff]
[    0.030573] Initmem setup node 0 [mem 0x0000000000001000-0x000000007fef8=
fff]
[    0.030585] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.030589] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.030665] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.048743] On node 0, zone DMA32: 32768 pages in unavailable ranges
[    0.048773] On node 0, zone DMA32: 544 pages in unavailable ranges
[    0.048778] On node 0, zone DMA32: 23 pages in unavailable ranges
[    0.048783] On node 0, zone DMA32: 44 pages in unavailable ranges
[    0.048839] On node 0, zone DMA32: 43 pages in unavailable ranges
[    0.048852] On node 0, zone DMA32: 263 pages in unavailable ranges
[    0.049183] ACPI: PM-Timer IO Port: 0x408
[    0.049203] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.049209] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.049228] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-=
23
[    0.049236] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.049241] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.049251] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.049254] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.049268] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.049324] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.049330] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0=
x0008ffff]
[    0.049336] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.049341] PM: hibernation: Registered nosave memory: [mem 0x6e8d9000-0=
x6e8d9fff]
[    0.049346] PM: hibernation: Registered nosave memory: [mem 0x6e8d9000-0=
x6e8d9fff]
[    0.049349] PM: hibernation: Registered nosave memory: [mem 0x6e8da000-0=
x6e8dafff]
[    0.049354] PM: hibernation: Registered nosave memory: [mem 0x6e8e8000-0=
x6e8e8fff]
[    0.049359] PM: hibernation: Registered nosave memory: [mem 0x6f000000-0=
x7effffff]
[    0.049365] PM: hibernation: Registered nosave memory: [mem 0x7f719000-0=
x7f938fff]
[    0.049371] PM: hibernation: Registered nosave memory: [mem 0x7f954000-0=
x7f96afff]
[    0.049377] PM: hibernation: Registered nosave memory: [mem 0x7f96f000-0=
x7f99afff]
[    0.049382] PM: hibernation: Registered nosave memory: [mem 0x7f9b0000-0=
x7f9dafff]
[    0.049387] [mem 0x93201000-0xffbfffff] available for PCI devices
[    0.049392] Booting paravirtualized kernel on bare hardware
[    0.049399] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.067013] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:2 n=
r_node_ids:1
[    0.067934] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u1048576
[    0.067955] pcpu-alloc: s212992 r8192 d28672 u1048576 alloc=3D1*2097152
[    0.067962] pcpu-alloc: [0] 0 1=20
[    0.068024] Fallback order for Node 0: 0=20
[    0.068033] Built 1 zonelists, mobility grouping on.  Total pages: 450425
[    0.068037] Policy zone: DMA32
[    0.068041] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline.img root=3D/dev/sda3 rw ipv6.disable=3D1
[    0.069024] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)
[    0.069482] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.070540] mem auto-init: stack:byref_all(zero), heap alloc:on, heap fr=
ee:off
[    0.092125] Memory: 1692676K/1830948K available (16392K kernel code, 207=
5K rwdata, 10900K rodata, 1796K init, 3840K bss, 138012K reserved, 0K cma-r=
eserved)
[    0.092147] random: get_random_u64 called from __kmem_cache_create+0x2a/=
0x560 with crng_init=3D0
[    0.092541] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.092580] Kernel/User page tables isolation: enabled
[    0.092630] ftrace: allocating 44896 entries in 176 pages
[    0.132654] ftrace: allocated 176 pages with 3 groups
[    0.132914] Dynamic Preempt: full
[    0.132978] rcu: Preemptible hierarchical RCU implementation.
[    0.132980] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.132982] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D2.
[    0.132986] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.132989] 	Trampoline variant of Tasks RCU enabled.
[    0.132990] 	Rude variant of Tasks RCU enabled.
[    0.132992] 	Tracing variant of Tasks RCU enabled.
[    0.132994] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.132997] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.144349] NR_IRQS: 20736, nr_irqs: 440, preallocated irqs: 16
[    0.144879] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.144978] spurious 8259A interrupt: IRQ7.
[    0.145017] Console: colour dummy device 80x25
[    0.145057] printk: console [tty0] enabled
[    0.145110] ACPI: Core revision 20210930
[    0.145333] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 76450417870 ns
[    0.145359] APIC: Switch to symmetric I/O mode setup
[    0.145881] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.162027] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x14239c11e51, max_idle_ns: 440795262321 ns
[    0.162039] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2795.72 BogoMIPS (lpj=3D4657166)
[    0.162046] pid_max: default: 32768 minimum: 301
[    0.190708] LSM: Security Framework initializing
[    0.190732] landlock: Up and running.
[    0.190736] Yama: becoming mindful.
[    0.190757] LSM support for eBPF active
[    0.190800] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)
[    0.190821] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
[    0.191465] CPU0: Thermal monitoring enabled (TM2)
[    0.191489] process: using mwait in idle threads
[    0.191495] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.191499] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.191509] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.191513] Spectre V2 : Mitigation: Full generic retpoline
[    0.191516] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.191518] Speculative Store Bypass: Vulnerable
[    0.191524] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.197412] Freeing SMP alternatives memory: 36K
[    0.304571] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     U9400  @ 1.40G=
Hz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.305100] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, In=
tel PMU driver.
[    0.305137] ... version:                2
[    0.305140] ... bit width:              40
[    0.305142] ... generic registers:      2
[    0.305144] ... value mask:             000000ffffffffff
[    0.305147] ... max period:             000000007fffffff
[    0.305150] ... fixed-purpose events:   3
[    0.305152] ... event mask:             0000000700000003
[    0.305368] rcu: Hierarchical SRCU implementation.
[    0.305368] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.305368] smp: Bringing up secondary CPUs ...
[    0.305368] x86: Booting SMP configuration:
[    0.305368] .... node  #0, CPUs:      #1
[    0.314120] smp: Brought up 1 node, 2 CPUs
[    0.314120] smpboot: Max logical packages: 1
[    0.314120] smpboot: Total of 2 processors activated (5590.45 BogoMIPS)
[    0.318953] devtmpfs: initialized
[    0.318953] x86/mm: Memory block size: 128MB
[    0.319505] ACPI: PM: Registering ACPI NVS region [mem 0x0008f000-0x0008=
ffff] (4096 bytes)
[    0.319505] ACPI: PM: Registering ACPI NVS region [mem 0x7f719000-0x7f93=
8fff] (2228224 bytes)
[    0.319505] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.319505] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.319505] pinctrl core: initialized pinctrl subsystem
[    0.319505] PM: RTC time: 00:00:10, date: 2001-01-01
[    0.319721] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.320033] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.320118] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations
[    0.320201] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.320222] audit: initializing netlink subsys (disabled)
[    0.320244] audit: type=3D2000 audit(978307210.173:1): state=3Dinitializ=
ed audit_enabled=3D0 res=3D1
[    0.320244] thermal_sys: Registered thermal governor 'fair_share'
[    0.320244] thermal_sys: Registered thermal governor 'bang_bang'
[    0.320244] thermal_sys: Registered thermal governor 'step_wise'
[    0.320244] thermal_sys: Registered thermal governor 'user_space'
[    0.320244] thermal_sys: Registered thermal governor 'power_allocator'
[    0.322071] cpuidle: using governor ladder
[    0.322084] cpuidle: using governor menu
[    0.322214] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.322218] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.322660] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000=
-0xf02fffff] (base 0xf0000000)
[    0.322673] PCI: not using MMCONFIG
[    0.322682] PCI: Using configuration type 1 for base access
[    0.326879] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.326931] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.326931] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.326931] ACPI: Disabled all _OSI OS vendors
[    0.326931] ACPI: Added _OSI(Module Device)
[    0.326931] ACPI: Added _OSI(Processor Device)
[    0.326931] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.326931] ACPI: Added _OSI(Processor Aggregator Device)
[    0.326931] ACPI: Added _OSI(Linux-Dell-Video)
[    0.326931] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.326931] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.326931] ACPI: Added _OSI(Darwin)
[    0.338225] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.339115] ACPI: EC: EC started
[    0.339118] ACPI: EC: interrupt blocked
[    0.342830] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.342835] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.343315] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.346228] ACPI: Dynamic OEM Table Load:
[    0.346246] ACPI: SSDT 0xFFFF9E06011BC800 0001FB (v01 APPLE  Cpu0Ist  00=
003000 INTL 20061109)
[    0.349722] ACPI: Dynamic OEM Table Load:
[    0.349739] ACPI: SSDT 0xFFFF9E060130D800 0005A6 (v01 APPLE  Cpu0Cst  00=
003001 INTL 20061109)
[    0.351817] ACPI: Dynamic OEM Table Load:
[    0.351832] ACPI: SSDT 0xFFFF9E060134F600 0000C8 (v01 APPLE  Cpu1Ist  00=
003000 INTL 20061109)
[    0.352950] ACPI: Dynamic OEM Table Load:
[    0.352963] ACPI: SSDT 0xFFFF9E060134CD80 000085 (v01 APPLE  Cpu1Cst  00=
003000 INTL 20061109)
[    0.354330] ACPI: Interpreter enabled
[    0.354375] ACPI: PM: (supports S0 S3 S4 S5)
[    0.354379] ACPI: Using IOAPIC for interrupt routing
[    0.354448] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000=
-0xf02fffff] (base 0xf0000000)
[    0.355295] PCI: MMCONFIG at [mem 0xf0000000-0xf02fffff] reserved in ACP=
I motherboard resources
[    0.355318] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.355913] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.355930] ACPI: Enabled 2 GPEs in block 20 to 5F
[    0.382492] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.382510] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SH=
PCHotplug AER PCIeCapability LTR DPC]
[    0.382536] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-02] only partially covers this bridge
[    0.383211] PCI host bridge to bus 0000:00
[    0.383217] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.383223] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.383227] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000ffff=
f window]
[    0.383232] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]
[    0.383237] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.383273] pci 0000:00:00.0: [10de:0d60] type 00 class 0x060000
[    0.383583] pci 0000:00:00.1: [10de:0d68] type 00 class 0x050000
[    0.383915] pci 0000:00:01.0: [10de:0d6d] type 00 class 0x050000
[    0.384152] pci 0000:00:01.1: [10de:0d6e] type 00 class 0x050000
[    0.384451] pci 0000:00:01.2: [10de:0d6f] type 00 class 0x050000
[    0.384686] pci 0000:00:01.3: [10de:0d70] type 00 class 0x050000
[    0.384925] pci 0000:00:02.0: [10de:0d71] type 00 class 0x050000
[    0.385165] pci 0000:00:02.1: [10de:0d72] type 00 class 0x050000
[    0.385407] pci 0000:00:03.0: [10de:0d80] type 00 class 0x060100
[    0.385426] pci 0000:00:03.0: reg 0x10: [io  0x2100-0x21ff]
[    0.385636] pci 0000:00:03.1: [10de:0d7b] type 00 class 0x050000
[    0.385886] pci 0000:00:03.2: [10de:0d79] type 00 class 0x0c0500
[    0.385905] pci 0000:00:03.2: reg 0x10: [io  0x2000-0x20ff]
[    0.385917] pci 0000:00:03.2: reg 0x14: [mem 0x93286000-0x93287fff]
[    0.385942] pci 0000:00:03.2: reg 0x20: [io  0x2240-0x227f]
[    0.385953] pci 0000:00:03.2: reg 0x24: [io  0x2200-0x223f]
[    0.386007] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.386203] pci 0000:00:03.3: [10de:0d69] type 00 class 0x050000
[    0.386475] pci 0000:00:03.4: [10de:0d7a] type 00 class 0x0b4000
[    0.386511] pci 0000:00:03.4: reg 0x10: [mem 0x93200000-0x9327ffff]
[    0.386823] pci 0000:00:04.0: [10de:0d9c] type 00 class 0x0c0310
[    0.386842] pci 0000:00:04.0: reg 0x10: [mem 0x9328a000-0x9328afff]
[    0.386922] pci 0000:00:04.0: supports D1 D2
[    0.386926] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.387832] pci 0000:00:04.1: [10de:0d9d] type 00 class 0x0c0320
[    0.387853] pci 0000:00:04.1: reg 0x10: [mem 0x9328b100-0x9328b1ff]
[    0.387941] pci 0000:00:04.1: supports D1 D2
[    0.387945] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.389052] pci 0000:00:06.0: [10de:0d9c] type 00 class 0x0c0310
[    0.389073] pci 0000:00:06.0: reg 0x10: [mem 0x93289000-0x93289fff]
[    0.389154] pci 0000:00:06.0: supports D1 D2
[    0.389158] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.390059] pci 0000:00:06.1: [10de:0d9d] type 00 class 0x0c0320
[    0.390079] pci 0000:00:06.1: reg 0x10: [mem 0x9328b000-0x9328b0ff]
[    0.390167] pci 0000:00:06.1: supports D1 D2
[    0.390171] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.391254] pci 0000:00:08.0: [10de:0d94] type 00 class 0x040300
[    0.391272] pci 0000:00:08.0: reg 0x10: [mem 0x93280000-0x93283fff]
[    0.391351] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.391799] pci 0000:00:0a.0: [10de:0d88] type 00 class 0x010601
[    0.391817] pci 0000:00:0a.0: reg 0x10: [io  0x2298-0x229f]
[    0.391828] pci 0000:00:0a.0: reg 0x14: [io  0x22a4-0x22a7]
[    0.391838] pci 0000:00:0a.0: reg 0x18: [io  0x2290-0x2297]
[    0.391848] pci 0000:00:0a.0: reg 0x1c: [io  0x22a0-0x22a3]
[    0.391858] pci 0000:00:0a.0: reg 0x20: [io  0x2280-0x228f]
[    0.391868] pci 0000:00:0a.0: reg 0x24: [mem 0x93284000-0x93285fff]
[    0.392833] pci 0000:00:0b.0: [10de:0d75] type 00 class 0x050000
[    0.392851] pci 0000:00:0b.0: reg 0x10: [mem 0x93288000-0x93288fff]
[    0.393076] pci 0000:00:15.0: [10de:0d9b] type 01 class 0x060400
[    0.393226] pci 0000:00:15.0: enabling Extended Tags
[    0.393417] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393676] pci 0000:00:17.0: [10de:0d76] type 01 class 0x060400
[    0.393751] pci 0000:00:17.0: PME# supported from D0 D3hot D3cold
[    0.394169] pci 0000:01:00.0: [14e4:4353] type 00 class 0x028000
[    0.394202] pci 0000:01:00.0: reg 0x10: [mem 0x93100000-0x93103fff 64bit]
[    0.394273] pci 0000:01:00.0: enabling Extended Tags
[    0.394373] pci 0000:01:00.0: supports D1 D2
[    0.394377] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.394637] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.394665] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.394709] pci_bus 0000:02: extended config space not accessible
[    0.394779] pci 0000:02:00.0: [10de:08a2] type 00 class 0x030000
[    0.394796] pci 0000:02:00.0: reg 0x10: [mem 0x92000000-0x92ffffff]
[    0.394810] pci 0000:02:00.0: reg 0x14: [mem 0x80000000-0x8fffffff 64bit=
 pref]
[    0.394824] pci 0000:02:00.0: reg 0x1c: [mem 0x90000000-0x91ffffff 64bit=
 pref]
[    0.394834] pci 0000:02:00.0: reg 0x24: [io  0x1000-0x107f]
[    0.394844] pci 0000:02:00.0: reg 0x30: [mem 0x93000000-0x9301ffff pref]
[    0.394865] pci 0000:02:00.0: Enabling HDA controller
[    0.394871] pci 0000:02:00.0: BAR 1: assigned to efifb
[    0.396937] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.396947] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.396953] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.396960] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff=
 64bit pref]
[    0.398065] ACPI: PCI: Interrupt link LNK1 configured for IRQ 16
[    0.398425] ACPI: PCI: Interrupt link LNK2 configured for IRQ 17
[    0.398793] ACPI: PCI: Interrupt link LNK3 configured for IRQ 18
[    0.399151] ACPI: PCI: Interrupt link LNK4 configured for IRQ 19
[    0.399509] ACPI: PCI: Interrupt link Z00J configured for IRQ 21
[    0.399868] ACPI: PCI: Interrupt link Z00K configured for IRQ 21
[    0.400225] ACPI: PCI: Interrupt link Z00L configured for IRQ 21
[    0.400582] ACPI: PCI: Interrupt link Z00M configured for IRQ 21
[    0.400939] ACPI: PCI: Interrupt link LSMB configured for IRQ 22
[    0.401294] ACPI: PCI: Interrupt link LUS0 configured for IRQ 17
[    0.401650] ACPI: PCI: Interrupt link LUS2 configured for IRQ 17
[    0.402008] ACPI: PCI: Interrupt link LMAC configured for IRQ 17
[    0.402375] ACPI: PCI: Interrupt link LAZA configured for IRQ 20
[    0.402730] ACPI: PCI: Interrupt link LGPU configured for IRQ 16
[    0.403078] ACPI: PCI: Interrupt link LPID configured for IRQ 0
[    0.403082] ACPI: PCI: Interrupt link LPID disabled
[    0.403436] ACPI: PCI: Interrupt link LSI0 configured for IRQ 18
[    0.403792] ACPI: PCI: Interrupt link Z000 configured for IRQ 18
[    0.404148] ACPI: PCI: Interrupt link Z001 configured for IRQ 22
[    0.404494] ACPI: PCI: Interrupt link LPMU configured for IRQ 0
[    0.404498] ACPI: PCI: Interrupt link LPMU disabled
[    0.405145] ACPI: EC: interrupt unblocked
[    0.405149] ACPI: EC: event unblocked
[    0.405158] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.405162] ACPI: EC: GPE=3D0x57
[    0.405166] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.405171] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.405326] iommu: Default domain type: Translated=20
[    0.405330] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.405412] pci 0000:02:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.405412] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.405412] pci 0000:02:00.0: vgaarb: setting as boot device
[    0.405412] vgaarb: loaded
[    0.405890] SCSI subsystem initialized
[    0.405914] libata version 3.00 loaded.
[    0.405914] ACPI: bus type USB registered
[    0.405914] usbcore: registered new interface driver usbfs
[    0.405914] usbcore: registered new interface driver hub
[    0.405914] usbcore: registered new device driver usb
[    0.405914] pps_core: LinuxPPS API ver. 1 registered
[    0.405914] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.405914] PTP clock support registered
[    0.405914] EDAC MC: Ver: 3.0.0
[    0.405914] Registered efivars operations
[    0.405914] NetLabel: Initializing
[    0.405914] NetLabel:  domain hash size =3D 128
[    0.405914] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.405914] NetLabel:  unlabeled traffic allowed by default
[    0.405914] PCI: Using ACPI for IRQ routing
[    0.405914] PCI: pci_cache_line_size set to 64 bytes
[    0.405968] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.405973] e820: reserve RAM buffer [mem 0x6e8d9018-0x6fffffff]
[    0.405977] e820: reserve RAM buffer [mem 0x6e8da018-0x6fffffff]
[    0.405981] e820: reserve RAM buffer [mem 0x6f000000-0x6fffffff]
[    0.405984] e820: reserve RAM buffer [mem 0x7f719000-0x7fffffff]
[    0.405988] e820: reserve RAM buffer [mem 0x7f954000-0x7fffffff]
[    0.405993] e820: reserve RAM buffer [mem 0x7f96f000-0x7fffffff]
[    0.405997] e820: reserve RAM buffer [mem 0x7f9b0000-0x7fffffff]
[    0.406000] e820: reserve RAM buffer [mem 0x7fef9000-0x7fffffff]
[    0.410253] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.410264] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31, 31
[    0.410277] hpet0: 4 comparators, 64-bit 25.000000 MHz counter
[    0.412223] clocksource: Switched to clocksource tsc-early
[    0.440642] VFS: Disk quotas dquot_6.6.0
[    0.440686] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.440840] pnp: PnP ACPI init
[    0.441175] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.441639] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.442054] system 00:02: [io  0x0400-0x047f] has been reserved
[    0.442061] system 00:02: [io  0x0480-0x04ff] has been reserved
[    0.442066] system 00:02: [io  0x0500-0x057f] has been reserved
[    0.442075] system 00:02: [io  0x0580-0x05ff] has been reserved
[    0.442080] system 00:02: [io  0x0800-0x087f] has been reserved
[    0.442084] system 00:02: [io  0x0880-0x08ff] has been reserved
[    0.442090] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.442095] system 00:02: [io  0x0295-0x0296] has been reserved
[    0.443355] pnp: PnP ACPI: found 4 devices
[    0.447135] pci 0000:02:00.0: assigning 36 device properties
[    0.447191] pci 0000:00:08.0: assigning 4 device properties
[    0.451747] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.451903] NET: Registered PF_INET protocol family
[    0.452158] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)
[    0.454063] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2,=
 16384 bytes, linear)
[    0.454141] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)
[    0.454302] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, =
linear)
[    0.454382] TCP: Hash tables configured (established 16384 bind 16384)
[    0.454552] MPTCP token hash table entries: 2048 (order: 3, 49152 bytes,=
 linear)
[    0.454608] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.454650] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, li=
near)
[    0.454745] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.454763] NET: Registered PF_XDP protocol family
[    0.454807] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.454829] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.454855] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.454861] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.454867] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.454873] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff=
 64bit pref]
[    0.454881] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.454886] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.454890] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff windo=
w]
[    0.454894] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]
[    0.454899] pci_bus 0000:01: resource 1 [mem 0x93100000-0x931fffff]
[    0.454904] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.454908] pci_bus 0000:02: resource 1 [mem 0x92000000-0x930fffff]
[    0.454912] pci_bus 0000:02: resource 2 [mem 0x80000000-0x91ffffff 64bit=
 pref]
[    0.456247] ACPI: \_SB_.PCI0.LUS0: Enabled at IRQ 23
[    0.457454] ACPI: \_SB_.PCI0.LUS2: Enabled at IRQ 23
[    0.458669] ACPI: \_SB_.PCI0.Z000: Enabled at IRQ 20
[    0.459840] ACPI: \_SB_.PCI0.Z001: Enabled at IRQ 19
[    0.460334] PCI: CLS 256 bytes, default 64
[    0.460497] Trying to unpack rootfs image as initramfs...
[    0.469100] Initialise system trusted keyrings
[    0.469129] Key type blacklist registered
[    0.469265] workingset: timestamp_bits=3D41 max_order=3D19 bucket_order=
=3D0
[    0.473436] zbud: loaded
[    0.497975] Key type asymmetric registered
[    0.497987] Asymmetric key parser 'x509' registered
[    0.498124] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 242)
[    0.498294] io scheduler mq-deadline registered
[    0.498298] io scheduler kyber registered
[    0.498410] io scheduler bfq registered
[    0.500021] ACPI: \_SB_.PCI0.Z00J: Enabled at IRQ 22
[    0.500418] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.500779] Monitor-Mwait will be used to enter C-1 state
[    0.500803] Monitor-Mwait will be used to enter C-2 state
[    0.500816] Monitor-Mwait will be used to enter C-3 state
[    0.500826] ACPI: \_PR_.CPU0: Found 3 idle states
[    0.501335] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.501479] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    0.501569] ACPI: button: Lid Switch [LID0]
[    0.501649] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.501702] ACPI: button: Power Button [PWRB]
[    0.501798] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.501848] ACPI: button: Sleep Button [SLPB]
[    0.501955] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.502040] ACPI: button: Power Button [PWRF]
[    0.502825] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.507188] Non-volatile memory driver v1.3
[    0.507194] Linux agpgart interface v0.103
[    0.507197] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.507199] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    0.507253] ACPI: bus type drm_connector registered
[    0.508274] ahci 0000:00:0a.0: version 3.0
[    0.509177] ACPI: \_SB_.PCI0.LSI0: Enabled at IRQ 18
[    0.509343] ahci 0000:00:0a.0: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x=
1 impl SATA mode
[    0.509353] ahci 0000:00:0a.0: flags: 64bit ncq sntf pm led pio slum par=
t apst=20
[    0.509803] scsi host0: ahci
[    0.509966] ata1: SATA max UDMA/133 abar m8192@0x93284000 port 0x9328410=
0 irq 24
[    0.510092] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.510119] ehci-pci: EHCI PCI platform driver
[    0.510545] ehci-pci 0000:00:04.1: EHCI Host Controller
[    0.510560] ehci-pci 0000:00:04.1: new USB bus registered, assigned bus =
number 1
[    0.510576] ehci-pci 0000:00:04.1: debug port 1
[    0.510628] ehci-pci 0000:00:04.1: disable ppcd for nvidia mcp89
[    0.510661] ehci-pci 0000:00:04.1: irq 23, io mem 0x9328b100
[    0.520906] ehci-pci 0000:00:04.1: USB 2.0 started, EHCI 1.10
[    0.521064] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.521072] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.521077] usb usb1: Product: EHCI Host Controller
[    0.521081] usb usb1: Manufacturer: Linux 5.16.0-rc1-1-mainline ehci_hcd
[    0.521085] usb usb1: SerialNumber: 0000:00:04.1
[    0.521383] hub 1-0:1.0: USB hub found
[    0.521405] hub 1-0:1.0: 6 ports detected
[    0.522516] ehci-pci 0000:00:06.1: EHCI Host Controller
[    0.522530] ehci-pci 0000:00:06.1: new USB bus registered, assigned bus =
number 2
[    0.522546] ehci-pci 0000:00:06.1: debug port 1
[    0.522590] ehci-pci 0000:00:06.1: disable ppcd for nvidia mcp89
[    0.522624] ehci-pci 0000:00:06.1: irq 19, io mem 0x9328b000
[    0.534268] ehci-pci 0000:00:06.1: USB 2.0 started, EHCI 1.10
[    0.534446] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.534454] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.534459] usb usb2: Product: EHCI Host Controller
[    0.534463] usb usb2: Manufacturer: Linux 5.16.0-rc1-1-mainline ehci_hcd
[    0.534466] usb usb2: SerialNumber: 0000:00:06.1
[    0.534769] hub 2-0:1.0: USB hub found
[    0.534793] hub 2-0:1.0: 6 ports detected
[    0.535487] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.535499] ohci-pci: OHCI PCI platform driver
[    0.535923] ohci-pci 0000:00:04.0: OHCI PCI host controller
[    0.535938] ohci-pci 0000:00:04.0: new USB bus registered, assigned bus =
number 3
[    0.535991] ohci-pci 0000:00:04.0: irq 23, io mem 0x9328a000
[    0.593015] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 5.16
[    0.593030] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.593035] usb usb3: Product: OHCI PCI host controller
[    0.593039] usb usb3: Manufacturer: Linux 5.16.0-rc1-1-mainline ohci_hcd
[    0.593042] usb usb3: SerialNumber: 0000:00:04.0
[    0.593348] hub 3-0:1.0: USB hub found
[    0.593369] hub 3-0:1.0: 6 ports detected
[    0.594549] ohci-pci 0000:00:06.0: OHCI PCI host controller
[    0.594563] ohci-pci 0000:00:06.0: new USB bus registered, assigned bus =
number 4
[    0.594639] ohci-pci 0000:00:06.0: irq 20, io mem 0x93289000
[    0.607651] Freeing initrd memory: 12600K
[    0.632773] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 5.16
[    0.632787] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.632792] usb usb4: Product: OHCI PCI host controller
[    0.632796] usb usb4: Manufacturer: Linux 5.16.0-rc1-1-mainline ohci_hcd
[    0.632799] usb usb4: SerialNumber: 0000:00:06.0
[    0.633126] hub 4-0:1.0: USB hub found
[    0.633146] hub 4-0:1.0: 6 ports detected
[    0.633801] uhci_hcd: USB Universal Host Controller Interface driver
[    0.633948] usbcore: registered new interface driver usbserial_generic
[    0.633961] usbserial: USB Serial support registered for generic
[    0.634372] rtc_cmos 00:03: RTC can wake from S4
[    0.634972] rtc_cmos 00:03: registered as rtc0
[    0.635065] rtc_cmos 00:03: setting system clock to 2001-01-01T00:00:11 =
UTC (978307211)
[    0.635108] rtc_cmos 00:03: alarms up to one year, y3k, 242 bytes nvram,=
 hpet irqs
[    0.635274] intel_pstate: CPU model not supported
[    0.635326] ledtrig-cpu: registered to indicate activity on CPUs
[    0.635732] efifb: probing for efifb
[    0.635767] efifb: No BGRT, not showing boot graphics
[    0.635769] efifb: framebuffer at 0x80010000, using 6144k, total 6144k
[    0.635774] efifb: mode is 1366x768x32, linelength=3D8192, pages=3D1
[    0.635778] efifb: scrolling: redraw
[    0.635779] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.635884] fbcon: Deferring console take-over
[    0.635888] fb0: EFI VGA frame buffer device
[    0.635929] hid: raw HID events driver (C) Jiri Kosina
[    0.636110] drop_monitor: Initializing network drop monitor service
[    0.636270] Initializing XFRM netlink socket
[    0.636279] IPv6: Loaded, but administratively disabled, reboot required=
 to enable
[    0.636284] NET: Registered PF_PACKET protocol family
[    0.636725] microcode: sig=3D0x1067a, pf=3D0x80, revision=3D0xa0b
[    0.636740] microcode: Microcode Update Driver: v2.2.
[    0.636750] IPI shorthand broadcast: enabled
[    0.636780] sched_clock: Marking stable (635855762, 684151)->(646179782,=
 -9639869)
[    0.637079] registered taskstats version 1
[    0.637258] Loading compiled-in X.509 certificates
[    0.650166] Loaded X.509 cert 'Build time autogenerated kernel key: 12b7=
d12bc392e2baef079894db94d644400c2527'
[    0.650671] zswap: loaded using pool lz4/z3fold
[    0.651019] Key type ._fscrypt registered
[    0.651023] Key type .fscrypt registered
[    0.651026] Key type fscrypt-provisioning registered
[    0.654301] PM:   Magic number: 1:0:0
[    0.654720] RAS: Correctable Errors collector initialized.
[    0.746253] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.746824] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.746875] ata1.00: ATA-8: APPLE SSD TS064C, CJAA0201, max UDMA/100
[    0.746881] ata1.00: 118489088 sectors, multi 16: LBA48=20
[    0.747351] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.747402] ata1.00: configured for UDMA/100
[    0.747705] scsi 0:0:0:0: Direct-Access     ATA      APPLE SSD TS064C 02=
01 PQ: 0 ANSI: 5
[    0.748231] sd 0:0:0:0: [sda] 118489088 512-byte logical blocks: (60.7 G=
B/56.5 GiB)
[    0.748261] sd 0:0:0:0: [sda] Write Protect is off
[    0.748267] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.748311] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.752020]  sda: sda1 sda2 sda3
[    0.762944] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.769155] Freeing unused decrypted memory: 2036K
[    0.770298] Freeing unused kernel image (initmem) memory: 1796K
[    0.770388] Write protecting the kernel read-only data: 30720k
[    0.772228] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.773351] Freeing unused kernel image (rodata/data gap) memory: 1388K
[    0.886919] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.886931] rodata_test: all tests were successful
[    0.886965] x86/mm: Checking user space page tables
[    0.972700] usb 3-1: new full-speed USB device number 2 using ohci-pci
[    0.996005] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.996019] Run /init as init process
[    0.996022]   with arguments:
[    0.996028]     /init
[    0.996031]   with environment:
[    0.996033]     HOME=3D/
[    0.996036]     TERM=3Dlinux
[    1.036019] random: fast init done
[    1.086038] clocksource: timekeeping watchdog on CPU1: Marking clocksour=
ce 'tsc-early' as unstable because the skew is too large:
[    1.086044] clocksource:                       'hpet' wd_nsec: 506668280=
 wd_now: 1913e44 wd_last: cff6f1 mask: ffffffff
[    1.086050] clocksource:                       'tsc-early' cs_nsec: 4254=
52597 cs_now: 69c4116da cs_last: 678d2f175 mask: ffffffffffffffff
[    1.086055] clocksource:                       'tsc-early' is current cl=
ocksource.
[    1.086061] tsc: Marking TSC unstable due to clocksource watchdog
[    1.086073] TSC found unstable after boot, most likely due to broken BIO=
S. Use 'tsc=3Dunstable'.
[    1.086075] sched_clock: Marking unstable (1085388640, 684151)<-(1095712=
612, -9639869)
[    1.088270] clocksource: Switched to clocksource hpet
[    1.447167] usb 3-1: New USB device found, idVendor=3D04fe, idProduct=3D=
0008, bcdDevice=3D 1.02
[    1.447175] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.447181] usb 3-1: Product: Generic USB Hub
[    1.447185] usb 3-1: Manufacturer: Chicony
[    1.450237] hub 3-1:1.0: USB hub found
[    1.453160] hub 3-1:1.0: 3 ports detected
[    1.762115] usb 3-1.1: new full-speed USB device number 3 using ohci-pci
[    1.879154] usb 3-1.1: New USB device found, idVendor=3D04fe, idProduct=
=3D0006, bcdDevice=3D 1.02
[    1.879163] usb 3-1.1: New USB device strings: Mfr=3D3, Product=3D4, Ser=
ialNumber=3D0
[    1.879168] usb 3-1.1: Product: PFU-65 USB Keyboard
[    1.879171] usb 3-1.1: Manufacturer: Chicony
[    2.052127] usb 3-5: new full-speed USB device number 4 using ohci-pci
[    2.196633] fbcon: Taking over console
[    2.196943] Console: switching to colour frame buffer device 170x48
[    2.292076] usb 3-5: New USB device found, idVendor=3D0a5c, idProduct=3D=
4500, bcdDevice=3D 1.00
[    2.292089] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.292095] usb 3-5: Product: BRCM2070 Hub
[    2.292099] usb 3-5: Manufacturer: Apple Inc.
[    2.295183] hub 3-5:1.0: USB hub found
[    2.298071] hub 3-5:1.0: 3 ports detected
[    2.511097] input: Chicony PFU-65 USB Keyboard as /devices/pci0000:00/00=
00:00:04.0/usb3/3-1/3-1.1/3-1.1:1.0/0003:04FE:0006.0001/input/input4
[    2.574627] hid-generic 0003:04FE:0006.0001: input,hidraw0: USB HID v1.0=
0 Keyboard [Chicony PFU-65 USB Keyboard] on usb-0000:00:04.0-1.1/input0
[    2.574720] usbcore: registered new interface driver usbhid
[    2.574725] usbhid: USB HID core driver
[    2.585418] usb 1-6: new high-speed USB device number 4 using ehci-pci
[    2.618806] usb 3-5.1: new full-speed USB device number 5 using ohci-pci
[    2.735206] usb 3-5.1: New USB device found, idVendor=3D05ac, idProduct=
=3D820a, bcdDevice=3D 1.00
[    2.735219] usb 3-5.1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    2.746149] input: HID 05ac:820a as /devices/pci0000:00/0000:00:04.0/usb=
3/3-5/3-5.1/3-5.1:1.0/0003:05AC:820A.0002/input/input5
[    2.746185] usb 1-6: New USB device found, idVendor=3D05ac, idProduct=3D=
850a, bcdDevice=3D 6.25
[    2.746193] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.746198] usb 1-6: Product: Built-in iSight
[    2.746202] usb 1-6: Manufacturer: Apple Inc.
[    2.746205] usb 1-6: SerialNumber: CCGA9SAZ4UDF9KF0
[    2.802663] hid-generic 0003:05AC:820A.0002: input,hidraw1: USB HID v1.1=
1 Keyboard [HID 05ac:820a] on usb-0000:00:04.0-5.1/input0
[    2.885611] usb 3-5.2: new full-speed USB device number 6 using ohci-pci
[    3.015208] usb 3-5.2: New USB device found, idVendor=3D05ac, idProduct=
=3D820b, bcdDevice=3D 1.00
[    3.015220] usb 3-5.2: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    3.026331] input: HID 05ac:820b as /devices/pci0000:00/0000:00:04.0/usb=
3/3-5/3-5.2/3-5.2:1.0/0003:05AC:820B.0003/input/input6
[    3.026524] hid-generic 0003:05AC:820B.0003: input,hidraw2: USB HID v1.1=
1 Mouse [HID 05ac:820b] on usb-0000:00:04.0-5.2/input0
[    3.105402] usb 3-5.3: new full-speed USB device number 7 using ohci-pci
[    3.232080] usb 3-5.3: New USB device found, idVendor=3D05ac, idProduct=
=3D821b, bcdDevice=3D 0.42
[    3.232092] usb 3-5.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    3.232097] usb 3-5.3: Product: Bluetooth USB Host Controller
[    3.232102] usb 3-5.3: Manufacturer: Apple Inc.
[    3.433186] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, no debug enabled
[    3.436838] XFS (sda3): Mounting V5 Filesystem
[    3.482170] XFS (sda3): Ending clean mount
[    3.652160] systemd[1]: System time before build time, advancing clock.
[    3.957409] random: crng init done
[    3.957439] systemd[1]: Successfully credited entropy passed from boot l=
oader.
[    3.961196] systemd[1]: systemd 249.6-3-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKB=
COMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    3.979099] systemd[1]: Detected architecture x86-64.
[    3.984713] systemd[1]: Hostname set to <archmba>.
[    4.635165] systemd[1]: /usr/lib/systemd/system/mbpfan.service:10: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/mbpfan.pid =E2=86=92 /run/mbpfan.pid; please update the unit file accordin=
gly.
[    4.716395] systemd[1]: Queued start job for default target Graphical In=
terface.
[    4.719123] systemd[1]: Created slice Slice /system/getty.
[    4.720221] systemd[1]: Created slice Slice /system/modprobe.
[    4.721211] systemd[1]: Created slice Slice /system/syncthing.
[    4.722143] systemd[1]: Created slice Slice /system/systemd-fsck.
[    4.722902] systemd[1]: Created slice User and Session Slice.
[    4.723252] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    4.723581] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    4.724154] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    4.724451] systemd[1]: Reached target Local Encrypted Volumes.
[    4.724711] systemd[1]: Reached target Path Units.
[    4.724896] systemd[1]: Reached target Remote File Systems.
[    4.725066] systemd[1]: Reached target Slice Units.
[    4.725275] systemd[1]: Reached target System Time Set.
[    4.725518] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.725846] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.726267] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.729840] systemd[1]: Listening on Process Core Dump Socket.
[    4.730869] systemd[1]: Listening on Journal Audit Socket.
[    4.731291] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.731759] systemd[1]: Listening on Journal Socket.
[    4.732713] systemd[1]: Listening on Network Service Netlink Socket.
[    4.735310] systemd[1]: Listening on udev Control Socket.
[    4.735923] systemd[1]: Listening on udev Kernel Socket.
[    4.738470] systemd[1]: Mounting Huge Pages File System...
[    4.740936] systemd[1]: Mounting POSIX Message Queue File System...
[    4.743475] systemd[1]: Mounting Kernel Debug File System...
[    4.746149] systemd[1]: Mounting Kernel Trace File System...
[    4.749248] systemd[1]: Starting Create List of Static Device Nodes...
[    4.755301] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    4.758230] systemd[1]: Starting Load Kernel Module configfs...
[    4.761024] systemd[1]: Starting Load Kernel Module drm...
[    4.763908] systemd[1]: Starting Load Kernel Module fuse...
[    4.786679] systemd[1]: Starting Set Up Additional Binary Formats...
[    4.787032] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[    4.794007] systemd[1]: Starting Journal Service...
[    4.810762] fuse: init (API version 7.35)
[    4.811233] systemd[1]: Starting Load Kernel Modules...
[    4.813928] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.814325] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[    4.830226] systemd[1]: Starting Coldplug All udev Devices...
[    4.850781] systemd[1]: Mounted Huge Pages File System.
[    4.855274] systemd[1]: Mounted POSIX Message Queue File System.
[    4.857190] systemd[1]: Mounted Kernel Debug File System.
[    4.858975] systemd[1]: Mounted Kernel Trace File System.
[    4.861321] systemd[1]: Finished Create List of Static Device Nodes.
[    4.863899] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[    4.866238] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    4.866893] systemd[1]: Finished Load Kernel Module configfs.
[    4.869864] xfs filesystem being remounted at / supports timestamps unti=
l 2038 (0x7fffffff)
[    4.869995] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    4.870760] systemd[1]: Finished Load Kernel Module drm.
[    4.874378] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    4.875711] systemd[1]: Finished Load Kernel Module fuse.
[    4.879040] audit: type=3D1130 audit(1636644286.223:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[    4.879078] audit: type=3D1131 audit(1636644286.223:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[    4.880039] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.886058] audit: type=3D1130 audit(1636644286.229:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-remount-fs comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[    4.886529] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount=
 request for /proc/sys/fs/binfmt_misc, triggered by 188 (systemd-binfmt)
[    4.892390] systemd[1]: Mounting Arbitrary Executable File Formats File =
System...
[    4.902270] systemd[1]: Mounting FUSE Control File System...
[    4.906094] Asymmetric key parser 'pkcs8' registered
[    4.919255] systemd[1]: Mounting Kernel Configuration File System...
[    4.929089] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[    4.937188] systemd[1]: Starting Rebuild Hardware Database...
[    4.949101] systemd[1]: Starting Load/Save Random Seed...
[    4.953408] systemd[1]: Starting Create System Users...
[    4.966873] systemd[1]: Finished Load Kernel Modules.
[    4.976614] audit: type=3D1130 audit(1636644286.319:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-modules-load comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    4.981810] systemd[1]: Mounted Arbitrary Executable File Formats File S=
ystem.
[    4.984050] systemd[1]: Mounted FUSE Control File System.
[    4.998156] systemd[1]: Finished Set Up Additional Binary Formats.
[    5.000651] audit: type=3D1130 audit(1636644286.343:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-binfmt comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    5.001591] systemd[1]: Mounted Kernel Configuration File System.
[    5.018395] systemd[1]: Finished Load/Save Random Seed.
[    5.022695] audit: type=3D1130 audit(1636644286.366:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-random-seed comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    5.023178] systemd[1]: Condition check resulted in First Boot Complete =
being skipped.
[    5.035917] systemd[1]: Starting Apply Kernel Variables...
[    5.044874] systemd[1]: Finished Create System Users.
[    5.046608] audit: type=3D1130 audit(1636644286.389:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysusers comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    5.056005] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.074312] systemd[1]: Finished Apply Kernel Variables.
[    5.076054] audit: type=3D1130 audit(1636644286.419:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    5.153288] systemd[1]: Finished Create Static Device Nodes in /dev.
[    5.155023] audit: type=3D1130 audit(1636644286.496:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup-de=
v comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[    5.155292] systemd[1]: Reached target Preparation for Local File System=
s.
[    5.157009] systemd[1]: Condition check resulted in Virtual Machine and =
Container Storage (Compatibility) being skipped.
[    5.187335] systemd[1]: Started Journal Service.
[    5.207516] systemd-journald[189]: Received client request to flush runt=
ime journal.
[    5.209752] systemd-journald[189]: File /var/log/journal/e45c5aa8f438494=
79ae7ac2035f163b3/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.
[    5.323782] kauditd_printk_skb: 2 callbacks suppressed
[    5.323789] audit: type=3D1130 audit(1636644286.666:13): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[    6.643448] audit: type=3D1130 audit(1636644287.986:14): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hwdb-update comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    6.645933] audit: type=3D1334 audit(1636644287.989:15): prog-id=3D13 op=
=3DLOAD
[    6.646168] audit: type=3D1334 audit(1636644287.989:16): prog-id=3D14 op=
=3DLOAD
[    6.646178] audit: type=3D1334 audit(1636644287.989:17): prog-id=3D15 op=
=3DLOAD
[    6.779471] audit: type=3D1130 audit(1636644288.123:18): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    7.120819] smbus_hc ACPI0001:00: SBS HC: offset =3D 0x20, query_bit =3D=
 0x10
[    7.173302] ACPI: video: [Firmware Bug]: ACPI(IGPU) defines _DOD but not=
 _DOS
[    7.173435] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  =
post: no)
[    7.173990] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:2a/LNXVIDEO:00/input/input7
[    7.451807] bcma-pci-bridge 0000:01:00.0: bus0: Found chip with id 43224=
, rev 0x01 and package 0x08
[    7.451837] bcma-pci-bridge 0000:01:00.0: bus0: Core 0 found: ChipCommon=
 (manuf 0x4BF, id 0x800, rev 0x22, class 0x0)
[    7.451857] bcma-pci-bridge 0000:01:00.0: bus0: Core 1 found: IEEE 802.1=
1 (manuf 0x4BF, id 0x812, rev 0x17, class 0x0)
[    7.451886] bcma-pci-bridge 0000:01:00.0: bus0: Core 2 found: PCIe (manu=
f 0x4BF, id 0x820, rev 0x0F, class 0x0)
[    7.480949] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    7.548292] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (batt=
ery present)
[    7.585743] bcma-pci-bridge 0000:01:00.0: bus0: Bus registered
[    7.651912] Adding 4194300k swap on /dev/sda2.  Priority:-2 extents:1 ac=
ross:4194300k SSFS
[    7.878297] audit: type=3D1130 audit(1636644289.219:19): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\=
x2duuid-B890\x2d55BD comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" host=
name=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    8.081938] audit: type=3D1130 audit(1636644289.423:20): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddracut-shutdown comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    8.279103] audit: type=3D1130 audit(1636644289.623:21): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup co=
mm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termi=
nal=3D? res=3Dsuccess'
[    8.320639] audit: type=3D1127 audit(1636644289.663:22): pid=3D267 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D' comm=3D"systemd-update-utmp=
" exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[    8.695580] applesmc: key=3D323 fan=3D1 temp=3D27 index=3D26 acc=3D0 lux=
=3D0 kbd=3D0
[    8.699133] applesmc applesmc.768: hwmon_device_register() is deprecated=
. Please convert the driver to use hwmon_device_register_with_info().
[    9.094822] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    9.095010] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.095326] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    9.110706] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    9.137923] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.146310] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.147994] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.203596] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    9.205165] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.212355] intel_powerclamp: No package C-state available
[    9.213901] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.214026] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.214254] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.214708] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.223779] snd_hda_intel 0000:00:08.0: enabling device (0000 -> 0002)
[    9.224735] ACPI: \_SB_.PCI0.LAZA: Enabled at IRQ 20
[    9.224754] snd_hda_intel 0000:00:08.0: Disabling MSI
[    9.224759] snd_hda_intel 0000:00:08.0: position_fix set to 1 for device=
 10de:cb89
[    9.239843] intel_powerclamp: No package C-state available
[    9.360921] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.370733] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.375491] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.381883] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.405738] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: lin=
e_outs=3D2 (0xb/0xa/0x0/0x0/0x0) type:speaker
[    9.405753] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=3D0 (0x0/0=
x0/0x0/0x0/0x0)
[    9.405759] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=3D1 (0x9/0x0/0x=
0/0x0/0x0)
[    9.405764] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=3D0x0
[    9.405768] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=3D0x10/0x0
[    9.405772] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[    9.405776] snd_hda_codec_cirrus hdaudioC0D0:      Mic=3D0xd
[    9.482998] input: HDA NVidia Headphone as /devices/pci0000:00/0000:00:0=
8.0/sound/card0/input9
[    9.483157] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input10
[    9.483302] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input11
[    9.483444] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input12
[    9.881003] ACPI Warning: \_SB.PCI0.IXVE.IGPU._DSM: Argument #4 type mis=
match - Found [Buffer], ACPI requires [Package] (20210930/nsarguments-61)
[    9.881329] ACPI: \_SB_.PCI0.IXVE.IGPU: failed to evaluate _DSM
[    9.881409] nouveau 0000:02:00.0: enabling device (0006 -> 0007)
[    9.886789] ACPI: \_SB_.PCI0.LGPU: Enabled at IRQ 16
[    9.887259] checking generic (80010000 600000) vs hw (92000000 1000000)
[    9.887265] checking generic (80010000 600000) vs hw (80000000 10000000)
[    9.887268] fb0: switching to nouveau from EFI VGA
[    9.890221] Console: switching to colour dummy device 80x25
[    9.891888] nouveau 0000:02:00.0: vgaarb: deactivate vga console
[    9.893023] nouveau 0000:02:00.0: NVIDIA MCP89 (0af100a2)
[    9.949352] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.949685] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[    9.949830] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[    9.958759] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[    9.982120] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[    9.989939] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[   10.011396] nouveau 0000:02:00.0: bios: version 70.89.13.00.00
[   10.053343] NET: Registered PF_ALG protocol family
[   10.127658] nouveau 0000:02:00.0: fb: 256 MiB stolen system memory
[   10.210717] nouveau 0000:02:00.0: bus: MMIO write of 0000807f FAULT at 1=
00c18
[   10.371170] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   10.490438] nouveau 0000:02:00.0: bus: MMIO write of 0000807e FAULT at 1=
00c1c
[   10.493192] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.493294] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[   10.493302] cfg80211: failed to load regulatory.db
[   10.908799] Support for cores revisions 0x17 and 0x18 disabled by module=
 param allhwsupport=3D0. Try b43.allhwsupport=3D1
[   10.908822] b43: probe of bcma0:1 failed with error -524
[   10.911718] Broadcom 43xx driver loaded [ Features: PNLS ]
[   11.017637] brcmsmac bcma0:1: mfg 4bf core 812 rev 23 class 0 irq 22
[   11.020430] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   11.095451] cryptd: max_cpu_qlen set to 1000
[   11.139880] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos enabled: f=
alse (implement)
[   11.139915] brcmsmac bcma0:1: brcms_ops_config: change power-save mode: =
false (implement)
[   11.237317] kauditd_printk_skb: 28 callbacks suppressed
[   11.237324] audit: type=3D1130 audit(1636644292.576:49): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   11.280937] audit: type=3D1130 audit(1636644292.623:50): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsshd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   11.302885] audit: type=3D1130 audit(1636644292.646:51): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsyncthing@archmba comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[   11.389844] audit: type=3D1130 audit(1636644292.729:52): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-user-sessions com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   11.407979] audit: type=3D1130 audit(1636644292.749:53): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dgetty@tty1 comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   11.415242] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[   11.447520] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos enabled: f=
alse (implement)
[   11.447554] brcmsmac bcma0:1: brcms_ops_config: change power-save mode: =
false (implement)
[   11.489102] audit: type=3D1130 audit(1636644292.833:54): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@1000 com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   11.587114] audit: type=3D1101 audit(1636644292.929:55): pid=3D647 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"archmba" exe=3D"/usr/lib=
/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   11.587130] audit: type=3D1103 audit(1636644292.929:56): pid=3D647 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
? acct=3D"archmba" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dfailed'
[   11.587138] audit: type=3D1006 audit(1636644292.929:57): pid=3D647 uid=
=3D0 old-auid=3D4294967295 auid=3D1000 tty=3D(none) old-ses=3D4294967295 se=
s=3D1 res=3D1
[   11.587145] audit: type=3D1300 audit(1636644292.929:57): arch=3Dc000003e=
 syscall=3D1 success=3Dyes exit=3D4 a0=3D9 a1=3D7ffddd1900a0 a2=3D4 a3=3D3e=
8 items=3D0 ppid=3D1 pid=3D647 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D1 comm=3D"(syste=
md)" exe=3D"/usr/lib/systemd/systemd" key=3D(null)
[   11.672186] wlan0: authenticate with 80:22:a7:34:50:c0
[   11.674063] wlan0: send auth to 80:22:a7:34:50:c0 (try 1/3)
[   11.679879] wlan0: authenticated
[   11.682261] wlan0: associate with 80:22:a7:34:50:c0 (try 1/3)
[   11.688061] wlan0: RX AssocResp from 80:22:a7:34:50:c0 (capab=3D0x431 st=
atus=3D0 aid=3D4)
[   11.688589] brcmsmac bcma0:1: brcmsmac: brcms_ops_bss_info_changed: asso=
ciated
[   11.688609] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos enabled: t=
rue (implement)
[   11.688635] wlan0: associated
[   11.693361] brcmsmac bcma0:1: brcms_ops_bss_info_changed: arp filtering:=
 1 addresses (implement)
[   11.700529] systemd-journald[189]: File /var/log/journal/e45c5aa8f438494=
79ae7ac2035f163b3/user-1000.journal corrupted or uncleanly shut down, renam=
ing and replacing.
[   11.702399] brcmsmac bcma0:1: brcms_ops_bss_info_changed: arp filtering:=
 0 addresses (implement)
[   11.714926] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211: AC_VO txop =
exceeded phylen 159/256 dur 1778/1504
[   11.735640] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211: AC_VO txop =
exceeded phylen 137/256 dur 1602/1504
[   11.743099] brcmsmac bcma0:1: brcms_ops_bss_info_changed: arp filtering:=
 1 addresses (implement)
[   12.196087] usbcore: registered new device driver apple-mfi-fastcharge
[   12.519012] mc: Linux media interface: v0.10
[   12.740922] videodev: Linux video capture interface: v2.00
[   13.083433] nouveau 0000:02:00.0: DRM: VRAM: 256 MiB
[   13.083445] nouveau 0000:02:00.0: DRM: GART: 1048576 MiB
[   13.083453] nouveau 0000:02:00.0: DRM: TMDS table version 2.0
[   13.083459] nouveau 0000:02:00.0: DRM: DCB version 4.0
[   13.083464] nouveau 0000:02:00.0: DRM: DCB outp 00: 040001b6 0f220010
[   13.083471] nouveau 0000:02:00.0: DRM: DCB outp 01: 020112a6 0f220010
[   13.083476] nouveau 0000:02:00.0: DRM: DCB outp 02: 02011262 00020010
[   13.083481] nouveau 0000:02:00.0: DRM: DCB conn 00: 00002047
[   13.083486] nouveau 0000:02:00.0: DRM: DCB conn 01: 00101146
[   13.097355] nouveau 0000:02:00.0: DRM: MM: using M2MF for buffer copies
[   13.260972] usb 1-6: Found UVC 1.00 device Built-in iSight (05ac:850a)
[   13.285683] input: Built-in iSight: Built-in iSigh as /devices/pci0000:0=
0/0000:00:04.1/usb1/1-6/1-6:1.0/input/input13
[   13.286327] usbcore: registered new interface driver uvcvideo
[   13.700392] nouveau 0000:02:00.0: DRM: allocated 1366x768 fb: 0x50000, b=
o 00000000d2d8b523
[   13.702007] fbcon: nouveau (fb0) is primary device
[   13.726632] mousedev: PS/2 mouse device common for all mice
[   13.817400] Console: switching to colour frame buffer device 170x48
[   13.922570] nouveau 0000:02:00.0: [drm] fb0: nouveau frame buffer device
[   13.956574] [drm] Initialized nouveau 1.3.1 20120801 for 0000:02:00.0 on=
 minor 0
[   14.290499] Bluetooth: Core ver 2.22
[   14.291924] NET: Registered PF_BLUETOOTH protocol family
[   14.291929] Bluetooth: HCI device and connection manager initialized
[   14.291940] Bluetooth: HCI socket layer initialized
[   14.291946] Bluetooth: L2CAP socket layer initialized
[   14.291959] Bluetooth: SCO socket layer initialized
[   14.577404] usbcore: registered new interface driver btusb
[   14.618011] usb 3-5.1: USB disconnect, device number 5
[   14.711034] Bluetooth: hci0: BCM: chip id 19 build 0848
[   14.714029] Bluetooth: hci0: BCM: product 05ac:821b
[   14.717030] Bluetooth: hci0: BCM: features 0x07
[   14.735033] Bluetooth: hci0: Apple Bluetooth Device
[   14.840003] usb 3-5.2: USB disconnect, device number 6

--=-=-=
Content-Type: text/plain


5.16-rc1-patched dmesg

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=dmesg_v5.16-rc1-patched.log
Content-Transfer-Encoding: quoted-printable
Content-Description: dmesg_v5.16-rc1-patched.log

[    0.000000] microcode: microcode updated early to revision 0xa0b, date =
=3D 2010-09-28
[    0.000000] Linux version 5.16.0-rc1-1-mainline-patched (linux-mainline-=
patched@archlinux) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP =
PREEMPT Wed, 17 Nov 2021 10:55:05 +0000
[    0.000000] Command line: initrd=3D\intel-ucode.img initrd=3D\initramfs-=
linux-mainline-patched.img root=3D/dev/sda3 rw ipv6.disable=3D1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 by=
tes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1520
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f000000-0x000000007effffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000007f718fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f719000-0x000000007f938fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007f939000-0x000000007f953fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f954000-0x000000007f96afff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007f96b000-0x000000007f96dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f96e000-0x000000007f99afff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f99b000-0x000000007f9affff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f9b0000-0x000000007f9dafff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007f9db000-0x000000007fef8fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fef9000-0x000000007fefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000093200000-0x0000000093200fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x6cd69018-0x6cd77c57] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6cd69018-0x6cd77c57] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6cd68018-0x6cd68984] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x6cd68018-0x6cd68984] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000008ef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008ff=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000000090000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000006cd680=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000006cd68018-0x000000006cd689=
84] usable
[    0.000000] reserve setup_data: [mem 0x000000006cd68985-0x000000006cd690=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000006cd69018-0x000000006cd77c=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000006cd77c58-0x000000006effff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000006f000000-0x000000007effff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f000000-0x000000007f718f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f719000-0x000000007f938f=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007f939000-0x000000007f953f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f954000-0x000000007f96af=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007f96b000-0x000000007f96df=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f96e000-0x000000007f99af=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f99b000-0x000000007f9aff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007f9b0000-0x000000007f9daf=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007f9db000-0x000000007fef8f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007fef9000-0x000000007fefff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000093200000-0x0000000093200f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ffc00000-0x00000000ffffff=
ff] reserved
[    0.000000] efi: EFI v1.10 by Apple
[    0.000000] efi: ACPI=3D0x7f96a000 ACPI 2.0=3D0x7f96a014 SMBIOS=3D0x7f71=
a000=20
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Apple Inc. MacBookAir3,1/Mac-942452F5819B1C1B, BIOS    =
MBA31.88Z.0061.B07.1201241641 01/24/12
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1397.125 MHz processor
[    0.000026] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000035] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000053] last_pfn =3D 0x7fef9 max_arch_pfn =3D 0x400000000
[    0.001560] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
=20=20
[    0.029656] Secure boot disabled
[    0.029663] RAMDISK: [mem 0x67f32000-0x68b7bfff]
[    0.029676] ACPI: Early table checksum verification disabled
[    0.029685] ACPI: RSDP 0x000000007F96A014 000024 (v02 APPLE )
[    0.029696] ACPI: XSDT 0x000000007F96A1C0 000084 (v01 APPLE  Apple00  00=
000061      01000013)
[    0.029711] ACPI: FACP 0x000000007F968000 0000F4 (v04 APPLE  Apple00  00=
000061 Loki 0000005F)
[    0.029726] ACPI: DSDT 0x000000007F95B000 00572C (v01 APPLE  MacBookA 00=
030001 INTL 20061109)
[    0.029736] ACPI: FACS 0x000000007F71E000 000040
[    0.029745] ACPI: FACS 0x000000007F71E000 000040
[    0.029753] ACPI: HPET 0x000000007F967000 000038 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029764] ACPI: APIC 0x000000007F966000 000068 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029773] ACPI: APIC 0x000000007F965000 000068 (v02 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029783] ACPI: ASF! 0x000000007F963000 0000A5 (v32 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029793] ACPI: SBST 0x000000007F962000 000030 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029803] ACPI: ECDT 0x000000007F961000 000053 (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029813] ACPI: SSDT 0x000000007F958000 000107 (v01 APPLE  SataAhci 00=
001000 INTL 20061109)
[    0.029823] ACPI: SSDT 0x000000007F957000 000024 (v01 APPLE  Apple    00=
001000 INTL 20061109)
[    0.029832] ACPI: SSDT 0x000000007F955000 00008A (v01 APPLE  NoSDCard 00=
001000 INTL 20061109)
[    0.029842] ACPI: SSDT 0x000000007F954000 0004DC (v01 APPLE  CpuPm    00=
003000 INTL 20061109)
[    0.029852] ACPI: MCFG 0x000000007F964000 00003C (v01 APPLE  Apple00  00=
000001 Loki 0000005F)
[    0.029860] ACPI: Reserving FACP table memory at [mem 0x7f968000-0x7f968=
0f3]
[    0.029864] ACPI: Reserving DSDT table memory at [mem 0x7f95b000-0x7f960=
72b]
[    0.029868] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e=
03f]
[    0.029871] ACPI: Reserving FACS table memory at [mem 0x7f71e000-0x7f71e=
03f]
[    0.029874] ACPI: Reserving HPET table memory at [mem 0x7f967000-0x7f967=
037]
[    0.029877] ACPI: Reserving APIC table memory at [mem 0x7f966000-0x7f966=
067]
[    0.029880] ACPI: Reserving APIC table memory at [mem 0x7f965000-0x7f965=
067]
[    0.029883] ACPI: Reserving ASF! table memory at [mem 0x7f963000-0x7f963=
0a4]
[    0.029886] ACPI: Reserving SBST table memory at [mem 0x7f962000-0x7f962=
02f]
[    0.029889] ACPI: Reserving ECDT table memory at [mem 0x7f961000-0x7f961=
052]
[    0.029892] ACPI: Reserving SSDT table memory at [mem 0x7f958000-0x7f958=
106]
[    0.029895] ACPI: Reserving SSDT table memory at [mem 0x7f957000-0x7f957=
023]
[    0.029898] ACPI: Reserving SSDT table memory at [mem 0x7f955000-0x7f955=
089]
[    0.029901] ACPI: Reserving SSDT table memory at [mem 0x7f954000-0x7f954=
4db]
[    0.029904] ACPI: Reserving MCFG table memory at [mem 0x7f964000-0x7f964=
03b]
[    0.029912] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.029915] ACPI: If "acpi_apic_instance=3D2" works better, notify linux=
-acpi@vger.kernel.org
[    0.029927] ACPI: DMI detected to setup _OSI("Darwin"): Apple hardware
[    0.030024] No NUMA configuration found
[    0.030027] Faking a node at [mem 0x0000000000000000-0x000000007fef8fff]
[    0.030036] NODE_DATA(0) allocated [mem 0x7fef5000-0x7fef8fff]
[    0.030090] Zone ranges:
[    0.030093]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.030098]   DMA32    [mem 0x0000000001000000-0x000000007fef8fff]
[    0.030103]   Normal   empty
[    0.030106]   Device   empty
[    0.030109] Movable zone start for each node
[    0.030111] Early memory node ranges
[    0.030112]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.030117]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.030120]   node   0: [mem 0x0000000000100000-0x000000006effffff]
[    0.030123]   node   0: [mem 0x000000007f000000-0x000000007f718fff]
[    0.030126]   node   0: [mem 0x000000007f939000-0x000000007f953fff]
[    0.030129]   node   0: [mem 0x000000007f96b000-0x000000007f96dfff]
[    0.030132]   node   0: [mem 0x000000007f99b000-0x000000007f9affff]
[    0.030135]   node   0: [mem 0x000000007f9db000-0x000000007fef8fff]
[    0.030139] Initmem setup node 0 [mem 0x0000000000001000-0x000000007fef8=
fff]
[    0.030151] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.030155] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.030232] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.048325] On node 0, zone DMA32: 32768 pages in unavailable ranges
[    0.048355] On node 0, zone DMA32: 544 pages in unavailable ranges
[    0.048359] On node 0, zone DMA32: 23 pages in unavailable ranges
[    0.048365] On node 0, zone DMA32: 45 pages in unavailable ranges
[    0.048420] On node 0, zone DMA32: 43 pages in unavailable ranges
[    0.048433] On node 0, zone DMA32: 263 pages in unavailable ranges
[    0.048764] ACPI: PM-Timer IO Port: 0x408
[    0.048784] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.048791] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.048810] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-=
23
[    0.048818] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.048823] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.048833] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.048837] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.048850] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.048905] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.048911] PM: hibernation: Registered nosave memory: [mem 0x0008f000-0=
x0008ffff]
[    0.048917] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.048922] PM: hibernation: Registered nosave memory: [mem 0x6cd68000-0=
x6cd68fff]
[    0.048927] PM: hibernation: Registered nosave memory: [mem 0x6cd68000-0=
x6cd68fff]
[    0.048930] PM: hibernation: Registered nosave memory: [mem 0x6cd69000-0=
x6cd69fff]
[    0.048935] PM: hibernation: Registered nosave memory: [mem 0x6cd77000-0=
x6cd77fff]
[    0.048940] PM: hibernation: Registered nosave memory: [mem 0x6f000000-0=
x7effffff]
[    0.048946] PM: hibernation: Registered nosave memory: [mem 0x7f719000-0=
x7f938fff]
[    0.048951] PM: hibernation: Registered nosave memory: [mem 0x7f954000-0=
x7f96afff]
[    0.048957] PM: hibernation: Registered nosave memory: [mem 0x7f96e000-0=
x7f99afff]
[    0.048962] PM: hibernation: Registered nosave memory: [mem 0x7f9b0000-0=
x7f9dafff]
[    0.048967] [mem 0x93201000-0xffbfffff] available for PCI devices
[    0.048972] Booting paravirtualized kernel on bare hardware
[    0.048979] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.066581] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:2 n=
r_node_ids:1
[    0.067503] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u1048576
[    0.067524] pcpu-alloc: s212992 r8192 d28672 u1048576 alloc=3D1*2097152
[    0.067532] pcpu-alloc: [0] 0 1=20
[    0.067593] Fallback order for Node 0: 0=20
[    0.067603] Built 1 zonelists, mobility grouping on.  Total pages: 450424
[    0.067607] Policy zone: DMA32
[    0.067610] Kernel command line: initrd=3D\intel-ucode.img initrd=3D\ini=
tramfs-linux-mainline-patched.img root=3D/dev/sda3 rw ipv6.disable=3D1
[    0.068590] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)
[    0.069049] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.070106] mem auto-init: stack:byref_all(zero), heap alloc:on, heap fr=
ee:off
[    0.091698] Memory: 1692696K/1830944K available (16392K kernel code, 207=
5K rwdata, 10900K rodata, 1796K init, 3840K bss, 137988K reserved, 0K cma-r=
eserved)
[    0.091720] random: get_random_u64 called from __kmem_cache_create+0x2a/=
0x560 with crng_init=3D0
[    0.092116] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.092155] Kernel/User page tables isolation: enabled
[    0.092204] ftrace: allocating 44896 entries in 176 pages
[    0.132228] ftrace: allocated 176 pages with 3 groups
[    0.132488] Dynamic Preempt: full
[    0.132553] rcu: Preemptible hierarchical RCU implementation.
[    0.132556] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.132557] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D2.
[    0.132561] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.132564] 	Trampoline variant of Tasks RCU enabled.
[    0.132565] 	Rude variant of Tasks RCU enabled.
[    0.132567] 	Tracing variant of Tasks RCU enabled.
[    0.132569] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.132572] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.143977] NR_IRQS: 20736, nr_irqs: 440, preallocated irqs: 16
[    0.144506] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.144625] Console: colour dummy device 80x25
[    0.144666] printk: console [tty0] enabled
[    0.144718] ACPI: Core revision 20210930
[    0.144940] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 76450417870 ns
[    0.144967] APIC: Switch to symmetric I/O mode setup
[    0.145487] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.161635] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x142384679a2, max_idle_ns: 440795236310 ns
[    0.161647] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2795.67 BogoMIPS (lpj=3D4657083)
[    0.161654] pid_max: default: 32768 minimum: 301
[    0.190593] LSM: Security Framework initializing
[    0.190617] landlock: Up and running.
[    0.190621] Yama: becoming mindful.
[    0.190642] LSM support for eBPF active
[    0.190686] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)
[    0.190706] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
[    0.191343] CPU0: Thermal monitoring enabled (TM2)
[    0.191367] process: using mwait in idle threads
[    0.191374] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.191378] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.191387] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.191392] Spectre V2 : Mitigation: Full generic retpoline
[    0.191394] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.191396] Speculative Store Bypass: Vulnerable
[    0.191403] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.197292] Freeing SMP alternatives memory: 36K
[    0.304445] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     U9400  @ 1.40G=
Hz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.304972] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, In=
tel PMU driver.
[    0.304976] ... version:                2
[    0.304976] ... bit width:              40
[    0.304976] ... generic registers:      2
[    0.304976] ... value mask:             000000ffffffffff
[    0.304976] ... max period:             000000007fffffff
[    0.304976] ... fixed-purpose events:   3
[    0.304976] ... event mask:             0000000700000003
[    0.304976] rcu: Hierarchical SRCU implementation.
[    0.304976] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.304976] smp: Bringing up secondary CPUs ...
[    0.304976] x86: Booting SMP configuration:
[    0.304976] .... node  #0, CPUs:      #1
[    0.313730] smp: Brought up 1 node, 2 CPUs
[    0.313730] smpboot: Max logical packages: 1
[    0.313730] smpboot: Total of 2 processors activated (5590.35 BogoMIPS)
[    0.318548] devtmpfs: initialized
[    0.318548] x86/mm: Memory block size: 128MB
[    0.319113] ACPI: PM: Registering ACPI NVS region [mem 0x0008f000-0x0008=
ffff] (4096 bytes)
[    0.319113] ACPI: PM: Registering ACPI NVS region [mem 0x7f719000-0x7f93=
8fff] (2228224 bytes)
[    0.319113] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.319113] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.319113] pinctrl core: initialized pinctrl subsystem
[    0.319113] PM: RTC time: 13:23:23, date: 2021-11-17
[    0.319330] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.319640] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.319725] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations
[    0.319808] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.319828] audit: initializing netlink subsys (disabled)
[    0.319851] audit: type=3D2000 audit(1637155403.173:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.319851] thermal_sys: Registered thermal governor 'fair_share'
[    0.319851] thermal_sys: Registered thermal governor 'bang_bang'
[    0.319851] thermal_sys: Registered thermal governor 'step_wise'
[    0.319851] thermal_sys: Registered thermal governor 'user_space'
[    0.319851] thermal_sys: Registered thermal governor 'power_allocator'
[    0.321658] cpuidle: using governor ladder
[    0.321672] cpuidle: using governor menu
[    0.321804] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.321808] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.322247] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000=
-0xf02fffff] (base 0xf0000000)
[    0.322260] PCI: not using MMCONFIG
[    0.322269] PCI: Using configuration type 1 for base access
[    0.326458] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.326512] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.326512] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.326512] ACPI: Disabled all _OSI OS vendors
[    0.326512] ACPI: Added _OSI(Module Device)
[    0.326512] ACPI: Added _OSI(Processor Device)
[    0.326512] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.326512] ACPI: Added _OSI(Processor Aggregator Device)
[    0.326512] ACPI: Added _OSI(Linux-Dell-Video)
[    0.326512] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.326512] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.326512] ACPI: Added _OSI(Darwin)
[    0.337809] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.338702] ACPI: EC: EC started
[    0.338705] ACPI: EC: interrupt blocked
[    0.341704] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.341710] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.342192] ACPI: BIOS _OSI(Darwin) query honored via DMI
[    0.345837] ACPI: Dynamic OEM Table Load:
[    0.345855] ACPI: SSDT 0xFFFF949FC11BEE00 0001FB (v01 APPLE  Cpu0Ist  00=
003000 INTL 20061109)
[    0.348575] ACPI: Dynamic OEM Table Load:
[    0.348591] ACPI: SSDT 0xFFFF949FC130D000 0005A6 (v01 APPLE  Cpu0Cst  00=
003001 INTL 20061109)
[    0.350666] ACPI: Dynamic OEM Table Load:
[    0.350680] ACPI: SSDT 0xFFFF949FC134EE00 0000C8 (v01 APPLE  Cpu1Ist  00=
003000 INTL 20061109)
[    0.351799] ACPI: Dynamic OEM Table Load:
[    0.351813] ACPI: SSDT 0xFFFF949FC134BB40 000085 (v01 APPLE  Cpu1Cst  00=
003000 INTL 20061109)
[    0.353180] ACPI: Interpreter enabled
[    0.353227] ACPI: PM: (supports S0 S3 S4 S5)
[    0.353231] ACPI: Using IOAPIC for interrupt routing
[    0.353300] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xf0000000=
-0xf02fffff] (base 0xf0000000)
[    0.354149] PCI: MMCONFIG at [mem 0xf0000000-0xf02fffff] reserved in ACP=
I motherboard resources
[    0.354173] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.354739] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.354756] ACPI: Enabled 2 GPEs in block 20 to 5F
[    0.382704] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.382722] acpi PNP0A08:00: _OSC: OS assumes control of [PCIeHotplug SH=
PCHotplug AER PCIeCapability LTR DPC]
[    0.382748] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-02] only partially covers this bridge
[    0.383423] PCI host bridge to bus 0000:00
[    0.383429] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.383435] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.383440] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000ffff=
f window]
[    0.383444] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]
[    0.383449] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.383486] pci 0000:00:00.0: [10de:0d60] type 00 class 0x060000
[    0.383797] pci 0000:00:00.1: [10de:0d68] type 00 class 0x050000
[    0.384127] pci 0000:00:01.0: [10de:0d6d] type 00 class 0x050000
[    0.384364] pci 0000:00:01.1: [10de:0d6e] type 00 class 0x050000
[    0.384664] pci 0000:00:01.2: [10de:0d6f] type 00 class 0x050000
[    0.384899] pci 0000:00:01.3: [10de:0d70] type 00 class 0x050000
[    0.385147] pci 0000:00:02.0: [10de:0d71] type 00 class 0x050000
[    0.385387] pci 0000:00:02.1: [10de:0d72] type 00 class 0x050000
[    0.385621] pci 0000:00:03.0: [10de:0d80] type 00 class 0x060100
[    0.385640] pci 0000:00:03.0: reg 0x10: [io  0x2100-0x21ff]
[    0.385849] pci 0000:00:03.1: [10de:0d7b] type 00 class 0x050000
[    0.386100] pci 0000:00:03.2: [10de:0d79] type 00 class 0x0c0500
[    0.386119] pci 0000:00:03.2: reg 0x10: [io  0x2000-0x20ff]
[    0.386131] pci 0000:00:03.2: reg 0x14: [mem 0x93286000-0x93287fff]
[    0.386156] pci 0000:00:03.2: reg 0x20: [io  0x2240-0x227f]
[    0.386167] pci 0000:00:03.2: reg 0x24: [io  0x2200-0x223f]
[    0.386221] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.386417] pci 0000:00:03.3: [10de:0d69] type 00 class 0x050000
[    0.386689] pci 0000:00:03.4: [10de:0d7a] type 00 class 0x0b4000
[    0.386724] pci 0000:00:03.4: reg 0x10: [mem 0x93200000-0x9327ffff]
[    0.387036] pci 0000:00:04.0: [10de:0d9c] type 00 class 0x0c0310
[    0.387055] pci 0000:00:04.0: reg 0x10: [mem 0x9328a000-0x9328afff]
[    0.387135] pci 0000:00:04.0: supports D1 D2
[    0.387139] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.388047] pci 0000:00:04.1: [10de:0d9d] type 00 class 0x0c0320
[    0.388068] pci 0000:00:04.1: reg 0x10: [mem 0x9328b100-0x9328b1ff]
[    0.388156] pci 0000:00:04.1: supports D1 D2
[    0.388160] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.389271] pci 0000:00:06.0: [10de:0d9c] type 00 class 0x0c0310
[    0.389291] pci 0000:00:06.0: reg 0x10: [mem 0x93289000-0x93289fff]
[    0.389372] pci 0000:00:06.0: supports D1 D2
[    0.389376] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.390277] pci 0000:00:06.1: [10de:0d9d] type 00 class 0x0c0320
[    0.390298] pci 0000:00:06.1: reg 0x10: [mem 0x9328b000-0x9328b0ff]
[    0.390386] pci 0000:00:06.1: supports D1 D2
[    0.390390] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.391476] pci 0000:00:08.0: [10de:0d94] type 00 class 0x040300
[    0.391494] pci 0000:00:08.0: reg 0x10: [mem 0x93280000-0x93283fff]
[    0.391573] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.392030] pci 0000:00:0a.0: [10de:0d88] type 00 class 0x010601
[    0.392048] pci 0000:00:0a.0: reg 0x10: [io  0x2298-0x229f]
[    0.392059] pci 0000:00:0a.0: reg 0x14: [io  0x22a4-0x22a7]
[    0.392069] pci 0000:00:0a.0: reg 0x18: [io  0x2290-0x2297]
[    0.392079] pci 0000:00:0a.0: reg 0x1c: [io  0x22a0-0x22a3]
[    0.392089] pci 0000:00:0a.0: reg 0x20: [io  0x2280-0x228f]
[    0.392099] pci 0000:00:0a.0: reg 0x24: [mem 0x93284000-0x93285fff]
[    0.393055] pci 0000:00:0b.0: [10de:0d75] type 00 class 0x050000
[    0.393073] pci 0000:00:0b.0: reg 0x10: [mem 0x93288000-0x93288fff]
[    0.393298] pci 0000:00:15.0: [10de:0d9b] type 01 class 0x060400
[    0.393447] pci 0000:00:15.0: enabling Extended Tags
[    0.393638] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.393896] pci 0000:00:17.0: [10de:0d76] type 01 class 0x060400
[    0.393971] pci 0000:00:17.0: PME# supported from D0 D3hot D3cold
[    0.394373] pci 0000:01:00.0: [14e4:4353] type 00 class 0x028000
[    0.394407] pci 0000:01:00.0: reg 0x10: [mem 0x93100000-0x93103fff 64bit]
[    0.394478] pci 0000:01:00.0: enabling Extended Tags
[    0.394579] pci 0000:01:00.0: supports D1 D2
[    0.394582] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.394843] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.394870] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.394915] pci_bus 0000:02: extended config space not accessible
[    0.394992] pci 0000:02:00.0: [10de:08a2] type 00 class 0x030000
[    0.395009] pci 0000:02:00.0: reg 0x10: [mem 0x92000000-0x92ffffff]
[    0.395023] pci 0000:02:00.0: reg 0x14: [mem 0x80000000-0x8fffffff 64bit=
 pref]
[    0.395037] pci 0000:02:00.0: reg 0x1c: [mem 0x90000000-0x91ffffff 64bit=
 pref]
[    0.395047] pci 0000:02:00.0: reg 0x24: [io  0x1000-0x107f]
[    0.395057] pci 0000:02:00.0: reg 0x30: [mem 0x93000000-0x9301ffff pref]
[    0.395079] pci 0000:02:00.0: Enabling HDA controller
[    0.395085] pci 0000:02:00.0: BAR 1: assigned to efifb
[    0.397138] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.397147] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.397153] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.397160] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff=
 64bit pref]
[    0.398260] ACPI: PCI: Interrupt link LNK1 configured for IRQ 16
[    0.398630] ACPI: PCI: Interrupt link LNK2 configured for IRQ 17
[    0.398989] ACPI: PCI: Interrupt link LNK3 configured for IRQ 18
[    0.399346] ACPI: PCI: Interrupt link LNK4 configured for IRQ 19
[    0.399704] ACPI: PCI: Interrupt link Z00J configured for IRQ 21
[    0.400060] ACPI: PCI: Interrupt link Z00K configured for IRQ 21
[    0.400418] ACPI: PCI: Interrupt link Z00L configured for IRQ 21
[    0.400775] ACPI: PCI: Interrupt link Z00M configured for IRQ 21
[    0.401132] ACPI: PCI: Interrupt link LSMB configured for IRQ 22
[    0.401488] ACPI: PCI: Interrupt link LUS0 configured for IRQ 17
[    0.401853] ACPI: PCI: Interrupt link LUS2 configured for IRQ 17
[    0.402208] ACPI: PCI: Interrupt link LMAC configured for IRQ 17
[    0.402564] ACPI: PCI: Interrupt link LAZA configured for IRQ 20
[    0.402919] ACPI: PCI: Interrupt link LGPU configured for IRQ 16
[    0.403265] ACPI: PCI: Interrupt link LPID configured for IRQ 0
[    0.403270] ACPI: PCI: Interrupt link LPID disabled
[    0.403623] ACPI: PCI: Interrupt link LSI0 configured for IRQ 18
[    0.403979] ACPI: PCI: Interrupt link Z000 configured for IRQ 18
[    0.404336] ACPI: PCI: Interrupt link Z001 configured for IRQ 22
[    0.404682] ACPI: PCI: Interrupt link LPMU configured for IRQ 0
[    0.404687] ACPI: PCI: Interrupt link LPMU disabled
[    0.405429] ACPI: EC: interrupt unblocked
[    0.405433] ACPI: EC: event unblocked
[    0.405441] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.405445] ACPI: EC: GPE=3D0x57
[    0.405449] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization comp=
lete
[    0.405454] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions =
and events
[    0.405611] iommu: Default domain type: Translated=20
[    0.405616] iommu: DMA domain TLB invalidation policy: lazy mode=20
[    0.405658] pci 0000:02:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.405658] pci 0000:02:00.0: vgaarb: bridge control possible
[    0.405658] pci 0000:02:00.0: vgaarb: setting as boot device
[    0.405658] vgaarb: loaded
[    0.405658] SCSI subsystem initialized
[    0.405658] libata version 3.00 loaded.
[    0.405658] ACPI: bus type USB registered
[    0.405658] usbcore: registered new interface driver usbfs
[    0.405658] usbcore: registered new interface driver hub
[    0.405658] usbcore: registered new device driver usb
[    0.405658] pps_core: LinuxPPS API ver. 1 registered
[    0.405658] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.405658] PTP clock support registered
[    0.405658] EDAC MC: Ver: 3.0.0
[    0.405658] Registered efivars operations
[    0.405658] NetLabel: Initializing
[    0.405658] NetLabel:  domain hash size =3D 128
[    0.405658] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.405658] NetLabel:  unlabeled traffic allowed by default
[    0.405658] PCI: Using ACPI for IRQ routing
[    0.405658] PCI: pci_cache_line_size set to 64 bytes
[    0.405658] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.405658] e820: reserve RAM buffer [mem 0x6cd68018-0x6fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x6cd69018-0x6fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x6f000000-0x6fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x7f719000-0x7fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x7f954000-0x7fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x7f96e000-0x7fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x7f9b0000-0x7fffffff]
[    0.405658] e820: reserve RAM buffer [mem 0x7fef9000-0x7fffffff]
[    0.410492] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.410504] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31, 31
[    0.410517] hpet0: 4 comparators, 64-bit 25.000000 MHz counter
[    0.411830] clocksource: Switched to clocksource tsc-early
[    0.440191] VFS: Disk quotas dquot_6.6.0
[    0.440235] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.440392] pnp: PnP ACPI init
[    0.440740] system 00:00: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.441191] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.441604] system 00:02: [io  0x0400-0x047f] has been reserved
[    0.441611] system 00:02: [io  0x0480-0x04ff] has been reserved
[    0.441616] system 00:02: [io  0x0500-0x057f] has been reserved
[    0.441625] system 00:02: [io  0x0580-0x05ff] has been reserved
[    0.441629] system 00:02: [io  0x0800-0x087f] has been reserved
[    0.441634] system 00:02: [io  0x0880-0x08ff] has been reserved
[    0.441640] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.441644] system 00:02: [io  0x0295-0x0296] has been reserved
[    0.442908] pnp: PnP ACPI: found 4 devices
[    0.446682] pci 0000:02:00.0: assigning 36 device properties
[    0.446738] pci 0000:00:08.0: assigning 4 device properties
[    0.451294] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.451451] NET: Registered PF_INET protocol family
[    0.451705] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)
[    0.453608] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2,=
 16384 bytes, linear)
[    0.453686] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)
[    0.453849] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, =
linear)
[    0.453971] TCP: Hash tables configured (established 16384 bind 16384)
[    0.454188] MPTCP token hash table entries: 2048 (order: 3, 49152 bytes,=
 linear)
[    0.454245] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.454279] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, li=
near)
[    0.454375] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.454394] NET: Registered PF_XDP protocol family
[    0.454439] pci 0000:00:15.0: PCI bridge to [bus 01]
[    0.454461] pci 0000:00:15.0:   bridge window [mem 0x93100000-0x931fffff]
[    0.454487] pci 0000:00:17.0: PCI bridge to [bus 02]
[    0.454492] pci 0000:00:17.0:   bridge window [io  0x1000-0x1fff]
[    0.454498] pci 0000:00:17.0:   bridge window [mem 0x92000000-0x930fffff]
[    0.454504] pci 0000:00:17.0:   bridge window [mem 0x80000000-0x91ffffff=
 64bit pref]
[    0.454512] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.454517] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.454521] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff windo=
w]
[    0.454525] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]
[    0.454530] pci_bus 0000:01: resource 1 [mem 0x93100000-0x931fffff]
[    0.454535] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.454539] pci_bus 0000:02: resource 1 [mem 0x92000000-0x930fffff]
[    0.454543] pci_bus 0000:02: resource 2 [mem 0x80000000-0x91ffffff 64bit=
 pref]
[    0.455787] ACPI: \_SB_.PCI0.LUS0: Enabled at IRQ 23
[    0.456995] ACPI: \_SB_.PCI0.LUS2: Enabled at IRQ 23
[    0.458210] ACPI: \_SB_.PCI0.Z000: Enabled at IRQ 20
[    0.459383] ACPI: \_SB_.PCI0.Z001: Enabled at IRQ 19
[    0.459879] PCI: CLS 256 bytes, default 64
[    0.460041] Trying to unpack rootfs image as initramfs...
[    0.468081] Initialise system trusted keyrings
[    0.468111] Key type blacklist registered
[    0.468239] workingset: timestamp_bits=3D41 max_order=3D19 bucket_order=
=3D0
[    0.472369] zbud: loaded
[    0.496252] Key type asymmetric registered
[    0.496263] Asymmetric key parser 'x509' registered
[    0.496401] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 242)
[    0.496563] io scheduler mq-deadline registered
[    0.496567] io scheduler kyber registered
[    0.496680] io scheduler bfq registered
[    0.498238] ACPI: \_SB_.PCI0.Z00J: Enabled at IRQ 22
[    0.498670] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.499040] Monitor-Mwait will be used to enter C-1 state
[    0.499063] Monitor-Mwait will be used to enter C-2 state
[    0.499076] Monitor-Mwait will be used to enter C-3 state
[    0.499086] ACPI: \_PR_.CPU0: Found 3 idle states
[    0.499596] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.499745] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    0.499841] ACPI: button: Lid Switch [LID0]
[    0.499922] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.499975] ACPI: button: Power Button [PWRB]
[    0.500071] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.500122] ACPI: button: Sleep Button [SLPB]
[    0.500233] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.500318] ACPI: button: Power Button [PWRF]
[    0.501110] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.505479] Non-volatile memory driver v1.3
[    0.505485] Linux agpgart interface v0.103
[    0.505488] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.505490] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    0.505545] ACPI: bus type drm_connector registered
[    0.506559] ahci 0000:00:0a.0: version 3.0
[    0.507467] ACPI: \_SB_.PCI0.LSI0: Enabled at IRQ 18
[    0.507643] ahci 0000:00:0a.0: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x=
1 impl SATA mode
[    0.507653] ahci 0000:00:0a.0: flags: 64bit ncq sntf pm led pio slum par=
t apst=20
[    0.508115] scsi host0: ahci
[    0.508279] ata1: SATA max UDMA/133 abar m8192@0x93284000 port 0x9328410=
0 irq 24
[    0.508397] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.508421] ehci-pci: EHCI PCI platform driver
[    0.508849] ehci-pci 0000:00:04.1: EHCI Host Controller
[    0.508864] ehci-pci 0000:00:04.1: new USB bus registered, assigned bus =
number 1
[    0.508880] ehci-pci 0000:00:04.1: debug port 1
[    0.508933] ehci-pci 0000:00:04.1: disable ppcd for nvidia mcp89
[    0.508964] ehci-pci 0000:00:04.1: irq 23, io mem 0x9328b100
[    0.519170] ehci-pci 0000:00:04.1: USB 2.0 started, EHCI 1.10
[    0.519327] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.519335] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.519340] usb usb1: Product: EHCI Host Controller
[    0.519344] usb usb1: Manufacturer: Linux 5.16.0-rc1-1-mainline-patched =
ehci_hcd
[    0.519348] usb usb1: SerialNumber: 0000:00:04.1
[    0.519653] hub 1-0:1.0: USB hub found
[    0.519676] hub 1-0:1.0: 6 ports detected
[    0.520799] ehci-pci 0000:00:06.1: EHCI Host Controller
[    0.520813] ehci-pci 0000:00:06.1: new USB bus registered, assigned bus =
number 2
[    0.520829] ehci-pci 0000:00:06.1: debug port 1
[    0.520873] ehci-pci 0000:00:06.1: disable ppcd for nvidia mcp89
[    0.520908] ehci-pci 0000:00:06.1: irq 19, io mem 0x9328b000
[    0.532516] ehci-pci 0000:00:06.1: USB 2.0 started, EHCI 1.10
[    0.532694] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.16
[    0.532702] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.532707] usb usb2: Product: EHCI Host Controller
[    0.532711] usb usb2: Manufacturer: Linux 5.16.0-rc1-1-mainline-patched =
ehci_hcd
[    0.532715] usb usb2: SerialNumber: 0000:00:06.1
[    0.532999] hub 2-0:1.0: USB hub found
[    0.533021] hub 2-0:1.0: 6 ports detected
[    0.533731] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.533743] ohci-pci: OHCI PCI platform driver
[    0.534163] ohci-pci 0000:00:04.0: OHCI PCI host controller
[    0.534178] ohci-pci 0000:00:04.0: new USB bus registered, assigned bus =
number 3
[    0.534233] ohci-pci 0000:00:04.0: irq 23, io mem 0x9328a000
[    0.591283] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 5.16
[    0.591298] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.591303] usb usb3: Product: OHCI PCI host controller
[    0.591307] usb usb3: Manufacturer: Linux 5.16.0-rc1-1-mainline-patched =
ohci_hcd
[    0.591311] usb usb3: SerialNumber: 0000:00:04.0
[    0.591615] hub 3-0:1.0: USB hub found
[    0.591636] hub 3-0:1.0: 6 ports detected
[    0.592819] ohci-pci 0000:00:06.0: OHCI PCI host controller
[    0.592834] ohci-pci 0000:00:06.0: new USB bus registered, assigned bus =
number 4
[    0.592910] ohci-pci 0000:00:06.0: irq 20, io mem 0x93289000
[    0.607382] Freeing initrd memory: 12584K
[    0.632286] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 5.16
[    0.632299] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.632304] usb usb4: Product: OHCI PCI host controller
[    0.632308] usb usb4: Manufacturer: Linux 5.16.0-rc1-1-mainline-patched =
ohci_hcd
[    0.632311] usb usb4: SerialNumber: 0000:00:06.0
[    0.632635] hub 4-0:1.0: USB hub found
[    0.632654] hub 4-0:1.0: 6 ports detected
[    0.633308] uhci_hcd: USB Universal Host Controller Interface driver
[    0.633426] usbcore: registered new interface driver usbserial_generic
[    0.633439] usbserial: USB Serial support registered for generic
[    0.633864] rtc_cmos 00:03: RTC can wake from S4
[    0.634465] rtc_cmos 00:03: registered as rtc0
[    0.634557] rtc_cmos 00:03: setting system clock to 2021-11-17T13:23:24 =
UTC (1637155404)
[    0.634599] rtc_cmos 00:03: alarms up to one year, y3k, 242 bytes nvram,=
 hpet irqs
[    0.634763] intel_pstate: CPU model not supported
[    0.634814] ledtrig-cpu: registered to indicate activity on CPUs
[    0.635220] efifb: probing for efifb
[    0.635255] efifb: No BGRT, not showing boot graphics
[    0.635257] efifb: framebuffer at 0x80010000, using 6144k, total 6144k
[    0.635261] efifb: mode is 1366x768x32, linelength=3D8192, pages=3D1
[    0.635265] efifb: scrolling: redraw
[    0.635267] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.635371] fbcon: Deferring console take-over
[    0.635375] fb0: EFI VGA frame buffer device
[    0.635417] hid: raw HID events driver (C) Jiri Kosina
[    0.635597] drop_monitor: Initializing network drop monitor service
[    0.635759] Initializing XFRM netlink socket
[    0.635768] IPv6: Loaded, but administratively disabled, reboot required=
 to enable
[    0.635772] NET: Registered PF_PACKET protocol family
[    0.636214] microcode: sig=3D0x1067a, pf=3D0x80, revision=3D0xa0b
[    0.636229] microcode: Microcode Update Driver: v2.2.
[    0.636238] IPI shorthand broadcast: enabled
[    0.636268] sched_clock: Marking stable (635363756, 663728)->(646568409,=
 -10540925)
[    0.636566] registered taskstats version 1
[    0.636755] Loading compiled-in X.509 certificates
[    0.649761] Loaded X.509 cert 'Build time autogenerated kernel key: dec5=
ebe1682e4bbd650bd4e35368707656149814'
[    0.650269] zswap: loaded using pool lz4/z3fold
[    0.650604] Key type ._fscrypt registered
[    0.650609] Key type .fscrypt registered
[    0.650611] Key type fscrypt-provisioning registered
[    0.653891] PM:   Magic number: 13:509:382
[    0.654314] RAS: Correctable Errors collector initialized.
[    0.749069] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.749640] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.749701] ata1.00: ATA-8: APPLE SSD TS064C, CJAA0201, max UDMA/100
[    0.749707] ata1.00: 118489088 sectors, multi 16: LBA48=20
[    0.750225] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.750274] ata1.00: configured for UDMA/100
[    0.750572] scsi 0:0:0:0: Direct-Access     ATA      APPLE SSD TS064C 02=
01 PQ: 0 ANSI: 5
[    0.751091] sd 0:0:0:0: [sda] 118489088 512-byte logical blocks: (60.7 G=
B/56.5 GiB)
[    0.751121] sd 0:0:0:0: [sda] Write Protect is off
[    0.751126] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.751172] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.758261]  sda: sda1 sda2 sda3
[    0.776238] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.782432] Freeing unused decrypted memory: 2036K
[    0.783564] Freeing unused kernel image (initmem) memory: 1796K
[    0.783654] Write protecting the kernel read-only data: 30720k
[    0.785493] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.786616] Freeing unused kernel image (rodata/data gap) memory: 1388K
[    0.899826] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.899838] rodata_test: all tests were successful
[    0.899873] x86/mm: Checking user space page tables
[    0.966005] usb 3-1: new full-speed USB device number 2 using ohci-pci
[    1.008681] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.008694] Run /init as init process
[    1.008697]   with arguments:
[    1.008700]     /init
[    1.008703]   with environment:
[    1.008705]     HOME=3D/
[    1.008708]     TERM=3Dlinux
[    1.029322] random: fast init done
[    1.079351] clocksource: timekeeping watchdog on CPU1: Marking clocksour=
ce 'tsc-early' as unstable because the skew is too large:
[    1.079357] clocksource:                       'hpet' wd_nsec: 506673960=
 wd_now: 1911291 wd_last: cfcab0 mask: ffffffff
[    1.079363] clocksource:                       'tsc-early' cs_nsec: 4191=
78720 cs_now: 79de8fe94 cs_last: 77b00c290 mask: ffffffffffffffff
[    1.079368] clocksource:                       'tsc-early' is current cl=
ocksource.
[    1.079376] tsc: Marking TSC unstable due to clocksource watchdog
[    1.079384] TSC found unstable after boot, most likely due to broken BIO=
S. Use 'tsc=3Dunstable'.
[    1.079386] sched_clock: Marking unstable (1078720368, 663728)<-(1089924=
973, -10540925)
[    1.080362] clocksource: Switched to clocksource hpet
[    1.353453] usb 3-1: New USB device found, idVendor=3D04fe, idProduct=3D=
0008, bcdDevice=3D 1.02
[    1.353463] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.353468] usb 3-1: Product: Generic USB Hub
[    1.353471] usb 3-1: Manufacturer: Chicony
[    1.356514] hub 3-1:1.0: USB hub found
[    1.359454] hub 3-1:1.0: 3 ports detected
[    1.668397] usb 3-1.1: new full-speed USB device number 3 using ohci-pci
[    1.785466] usb 3-1.1: New USB device found, idVendor=3D04fe, idProduct=
=3D0006, bcdDevice=3D 1.02
[    1.785474] usb 3-1.1: New USB device strings: Mfr=3D3, Product=3D4, Ser=
ialNumber=3D0
[    1.785479] usb 3-1.1: Product: PFU-65 USB Keyboard
[    1.785482] usb 3-1.1: Manufacturer: Chicony
[    1.958404] usb 3-5: new full-speed USB device number 4 using ohci-pci
[    2.197421] usb 3-5: New USB device found, idVendor=3D0a5c, idProduct=3D=
4500, bcdDevice=3D 1.00
[    2.197430] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.197434] usb 3-5: Product: BRCM2070 Hub
[    2.197438] usb 3-5: Manufacturer: Apple Inc.
[    2.200519] hub 3-5:1.0: USB hub found
[    2.203435] hub 3-5:1.0: 3 ports detected
[    2.228224] fbcon: Taking over console
[    2.228475] Console: switching to colour frame buffer device 170x48
[    2.521690] usb 3-5.1: new full-speed USB device number 5 using ohci-pci
[    2.549199] input: Chicony PFU-65 USB Keyboard as /devices/pci0000:00/00=
00:00:04.0/usb3/3-1/3-1.1/3-1.1:1.0/0003:04FE:0006.0001/input/input4
[    2.561677] usb 1-6: new high-speed USB device number 4 using ehci-pci
[    2.605374] hid-generic 0003:04FE:0006.0001: input,hidraw0: USB HID v1.0=
0 Keyboard [Chicony PFU-65 USB Keyboard] on usb-0000:00:04.0-1.1/input0
[    2.605475] usbcore: registered new interface driver usbhid
[    2.605479] usbhid: USB HID core driver
[    2.665389] usb 3-5.1: New USB device found, idVendor=3D05ac, idProduct=
=3D820a, bcdDevice=3D 1.00
[    2.665401] usb 3-5.1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    2.676589] input: HID 05ac:820a as /devices/pci0000:00/0000:00:04.0/usb=
3/3-5/3-5.1/3-5.1:1.0/0003:05AC:820A.0002/input/input5
[    2.725587] usb 1-6: New USB device found, idVendor=3D05ac, idProduct=3D=
850a, bcdDevice=3D 6.25
[    2.725602] usb 1-6: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.725607] usb 1-6: Product: Built-in iSight
[    2.725611] usb 1-6: Manufacturer: Apple Inc.
[    2.725615] usb 1-6: SerialNumber: CCGA9SAZ4UDF9KF0
[    2.732285] hid-generic 0003:05AC:820A.0002: input,hidraw1: USB HID v1.1=
1 Keyboard [HID 05ac:820a] on usb-0000:00:04.0-5.1/input0
[    2.815020] usb 3-5.2: new full-speed USB device number 6 using ohci-pci
[    2.941507] usb 3-5.2: New USB device found, idVendor=3D05ac, idProduct=
=3D820b, bcdDevice=3D 1.00
[    2.941519] usb 3-5.2: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    2.952395] input: HID 05ac:820b as /devices/pci0000:00/0000:00:04.0/usb=
3/3-5/3-5.2/3-5.2:1.0/0003:05AC:820B.0003/input/input6
[    2.952593] hid-generic 0003:05AC:820B.0003: input,hidraw2: USB HID v1.1=
1 Mouse [HID 05ac:820b] on usb-0000:00:04.0-5.2/input0
[    3.038362] usb 3-5.3: new full-speed USB device number 7 using ohci-pci
[    3.170507] usb 3-5.3: New USB device found, idVendor=3D05ac, idProduct=
=3D821b, bcdDevice=3D 0.42
[    3.170520] usb 3-5.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    3.170525] usb 3-5.3: Product: Bluetooth USB Host Controller
[    3.170529] usb 3-5.3: Manufacturer: Apple Inc.
[    3.595014] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, no debug enabled
[    3.598869] XFS (sda3): Mounting V5 Filesystem
[    3.645034] XFS (sda3): Ending clean mount
[    3.649879] xfs filesystem being mounted at /new_root supports timestamp=
s until 2038 (0x7fffffff)
[    4.120764] random: crng init done
[    4.120794] systemd[1]: Successfully credited entropy passed from boot l=
oader.
[    4.124815] systemd[1]: systemd 249.6-3-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKB=
COMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    4.142036] systemd[1]: Detected architecture x86-64.
[    4.147438] systemd[1]: Hostname set to <archmba>.
[    4.785002] systemd[1]: /usr/lib/systemd/system/mbpfan.service:10: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/mbpfan.pid =E2=86=92 /run/mbpfan.pid; please update the unit file accordin=
gly.
[    4.865084] systemd[1]: Queued start job for default target Graphical In=
terface.
[    4.867791] systemd[1]: Created slice Slice /system/getty.
[    4.868906] systemd[1]: Created slice Slice /system/modprobe.
[    4.869891] systemd[1]: Created slice Slice /system/syncthing.
[    4.870795] systemd[1]: Created slice Slice /system/systemd-fsck.
[    4.871593] systemd[1]: Created slice User and Session Slice.
[    4.871965] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    4.872298] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    4.872856] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    4.873146] systemd[1]: Reached target Local Encrypted Volumes.
[    4.873387] systemd[1]: Reached target Path Units.
[    4.873562] systemd[1]: Reached target Remote File Systems.
[    4.873734] systemd[1]: Reached target Slice Units.
[    4.873934] systemd[1]: Reached target System Time Set.
[    4.874120] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.874452] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.874882] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.878526] systemd[1]: Listening on Process Core Dump Socket.
[    4.879510] systemd[1]: Listening on Journal Audit Socket.
[    4.879934] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.880405] systemd[1]: Listening on Journal Socket.
[    4.881335] systemd[1]: Listening on Network Service Netlink Socket.
[    4.883835] systemd[1]: Listening on udev Control Socket.
[    4.884491] systemd[1]: Listening on udev Kernel Socket.
[    4.887293] systemd[1]: Mounting Huge Pages File System...
[    4.889695] systemd[1]: Mounting POSIX Message Queue File System...
[    4.892336] systemd[1]: Mounting Kernel Debug File System...
[    4.894958] systemd[1]: Mounting Kernel Trace File System...
[    4.898091] systemd[1]: Starting Create List of Static Device Nodes...
[    4.904276] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    4.907243] systemd[1]: Starting Load Kernel Module configfs...
[    4.910015] systemd[1]: Starting Load Kernel Module drm...
[    4.912865] systemd[1]: Starting Load Kernel Module fuse...
[    4.925378] systemd[1]: Starting Set Up Additional Binary Formats...
[    4.925807] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[    4.945308] systemd[1]: Starting Journal Service...
[    4.948821] systemd[1]: Starting Load Kernel Modules...
[    4.958688] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.960232] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[    4.963920] systemd[1]: Starting Coldplug All udev Devices...
[    4.993263] systemd[1]: Mounted Huge Pages File System.
[    5.005779] fuse: init (API version 7.35)
[    5.006097] systemd[1]: Mounted POSIX Message Queue File System.
[    5.008032] systemd[1]: Mounted Kernel Debug File System.
[    5.009844] systemd[1]: Mounted Kernel Trace File System.
[    5.018431] systemd[1]: Finished Create List of Static Device Nodes.
[    5.021052] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[    5.023421] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    5.024345] systemd[1]: Finished Load Kernel Module configfs.
[    5.026701] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    5.027484] systemd[1]: Finished Load Kernel Module drm.
[    5.029774] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    5.031398] systemd[1]: Finished Load Kernel Module fuse.
[    5.033440] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount=
 request for /proc/sys/fs/binfmt_misc, triggered by 186 (systemd-binfmt)
[    5.035922] systemd[1]: Mounting Arbitrary Executable File Formats File =
System...
[    5.039905] systemd[1]: Mounting FUSE Control File System...
[    5.044472] systemd[1]: Mounting Kernel Configuration File System...
[    5.051970] systemd[1]: Mounted FUSE Control File System.
[    5.061205] systemd[1]: Mounted Arbitrary Executable File Formats File S=
ystem.
[    5.063307] systemd[1]: Mounted Kernel Configuration File System.
[    5.169130] xfs filesystem being remounted at / supports timestamps unti=
l 2038 (0x7fffffff)
[    5.173735] systemd[1]: Finished Set Up Additional Binary Formats.
[    5.186795] audit: type=3D1130 audit(1637155409.049:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-binfmt comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    5.187886] systemd[1]: Finished Remount Root and Kernel File Systems.
[    5.189561] audit: type=3D1130 audit(1637155409.052:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-remount-fs comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[    5.189969] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[    5.194369] systemd[1]: Starting Rebuild Hardware Database...
[    5.194938] Asymmetric key parser 'pkcs8' registered
[    5.206740] systemd[1]: Starting Load/Save Random Seed...
[    5.228665] systemd[1]: Starting Create System Users...
[    5.233783] systemd[1]: Finished Load Kernel Modules.
[    5.236610] audit: type=3D1130 audit(1637155409.099:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-modules-load comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    5.254728] systemd[1]: Finished Coldplug All udev Devices.
[    5.260063] audit: type=3D1130 audit(1637155409.122:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-trigger comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    5.261256] systemd[1]: Finished Load/Save Random Seed.
[    5.268838] audit: type=3D1130 audit(1637155409.132:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-random-seed comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    5.269466] systemd[1]: Condition check resulted in First Boot Complete =
being skipped.
[    5.272435] systemd[1]: Starting Apply Kernel Variables...
[    5.302959] systemd[1]: Finished Create System Users.
[    5.304697] audit: type=3D1130 audit(1637155409.165:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysusers comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    5.305690] systemd[1]: Finished Apply Kernel Variables.
[    5.307265] audit: type=3D1130 audit(1637155409.169:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    5.309710] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.410209] systemd[1]: Started Journal Service.
[    5.415062] audit: type=3D1130 audit(1637155409.275:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    5.430727] audit: type=3D1130 audit(1637155409.292:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup-de=
v comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[    5.434137] systemd-journald[187]: Received client request to flush runt=
ime journal.
[    5.741045] audit: type=3D1130 audit(1637155409.602:11): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[    7.018942] audit: type=3D1130 audit(1637155410.882:12): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hwdb-update comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    7.021372] audit: type=3D1334 audit(1637155410.882:13): prog-id=3D13 op=
=3DLOAD
[    7.021510] audit: type=3D1334 audit(1637155410.882:14): prog-id=3D14 op=
=3DLOAD
[    7.021634] audit: type=3D1334 audit(1637155410.882:15): prog-id=3D15 op=
=3DLOAD
[    7.153404] audit: type=3D1130 audit(1637155411.015:16): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    7.496110] smbus_hc ACPI0001:00: SBS HC: offset =3D 0x20, query_bit =3D=
 0x10
[    7.550968] ACPI: video: [Firmware Bug]: ACPI(IGPU) defines _DOD but not=
 _DOS
[    7.551047] ACPI: video: Video Device [IGPU] (multi-head: yes  rom: no  =
post: no)
[    7.551396] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:2a/LNXVIDEO:00/input/input7
[    7.775898] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    7.852559] ACPI: Smart Battery System [SBS0]: Battery Slot [BAT0] (batt=
ery present)
[    7.942775] bcma-pci-bridge 0000:01:00.0: bus0: Found chip with id 43224=
, rev 0x01 and package 0x08
[    7.942808] bcma-pci-bridge 0000:01:00.0: bus0: Core 0 found: ChipCommon=
 (manuf 0x4BF, id 0x800, rev 0x22, class 0x0)
[    7.942828] bcma-pci-bridge 0000:01:00.0: bus0: Core 1 found: IEEE 802.1=
1 (manuf 0x4BF, id 0x812, rev 0x17, class 0x0)
[    7.942856] bcma-pci-bridge 0000:01:00.0: bus0: Core 2 found: PCIe (manu=
f 0x4BF, id 0x820, rev 0x0F, class 0x0)
[    8.046549] Adding 4194300k swap on /dev/sda2.  Priority:-2 extents:1 ac=
ross:4194300k SSFS
[    8.157832] audit: type=3D1130 audit(1637155412.019:17): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\=
x2duuid-B890\x2d55BD comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" host=
name=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    8.294705] audit: type=3D1130 audit(1637155412.155:18): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddracut-shutdown comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    8.681999] bcma-pci-bridge 0000:01:00.0: bus0: Bus registered
[    8.898509] applesmc: key=3D323 fan=3D1 temp=3D27 index=3D26 acc=3D0 lux=
=3D0 kbd=3D0
[    8.898746] applesmc applesmc.768: hwmon_device_register() is deprecated=
. Please convert the driver to use hwmon_device_register_with_info().
[    9.186513] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.188198] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.189952] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.204114] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.204349] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    9.205419] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    9.213460] xfs filesystem being remounted at /run/systemd/unit-root/etc=
 supports timestamps until 2038 (0x7fffffff)
[    9.226432] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.226781] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.227148] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.227362] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.260997] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/systemd/linger supports timestamps until 2038 (0x7fffffff)
[    9.269387] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.316758] xfs filesystem being remounted at /run/systemd/unit-root/var=
/cache/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.322575] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.325708] xfs filesystem being remounted at /run/systemd/unit-root/var=
/log/private/dnscrypt-proxy supports timestamps until 2038 (0x7fffffff)
[    9.339610] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[    9.966829] snd_hda_intel 0000:00:08.0: enabling device (0000 -> 0002)
[    9.967770] ACPI: \_SB_.PCI0.LAZA: Enabled at IRQ 20
[    9.967792] snd_hda_intel 0000:00:08.0: Disabling MSI
[    9.967797] snd_hda_intel 0000:00:08.0: position_fix set to 1 for device=
 10de:cb89
[   10.102089] snd_hda_codec_cirrus hdaudioC0D0: autoconfig for CS4206: lin=
e_outs=3D2 (0xb/0xa/0x0/0x0/0x0) type:speaker
[   10.102104] snd_hda_codec_cirrus hdaudioC0D0:    speaker_outs=3D0 (0x0/0=
x0/0x0/0x0/0x0)
[   10.102110] snd_hda_codec_cirrus hdaudioC0D0:    hp_outs=3D1 (0x9/0x0/0x=
0/0x0/0x0)
[   10.102115] snd_hda_codec_cirrus hdaudioC0D0:    mono: mono_out=3D0x0
[   10.102119] snd_hda_codec_cirrus hdaudioC0D0:    dig-out=3D0x10/0x0
[   10.102123] snd_hda_codec_cirrus hdaudioC0D0:    inputs:
[   10.102126] snd_hda_codec_cirrus hdaudioC0D0:      Mic=3D0xd
[   10.150277] ACPI Warning: \_SB.PCI0.IXVE.IGPU._DSM: Argument #4 type mis=
match - Found [Buffer], ACPI requires [Package] (20210930/nsarguments-61)
[   10.150607] ACPI: \_SB_.PCI0.IXVE.IGPU: failed to evaluate _DSM
[   10.150703] nouveau 0000:02:00.0: enabling device (0006 -> 0007)
[   10.151341] ACPI: \_SB_.PCI0.LGPU: Enabled at IRQ 16
[   10.151515] checking generic (80010000 600000) vs hw (92000000 1000000)
[   10.151522] checking generic (80010000 600000) vs hw (80000000 10000000)
[   10.151526] fb0: switching to nouveau from EFI VGA
[   10.153782] Console: switching to colour dummy device 80x25
[   10.153926] nouveau 0000:02:00.0: vgaarb: deactivate vga console
[   10.154097] nouveau 0000:02:00.0: NVIDIA MCP89 (0af100a2)
[   10.186764] input: HDA NVidia Headphone as /devices/pci0000:00/0000:00:0=
8.0/sound/card0/input9
[   10.186901] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input10
[   10.187023] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input11
[   10.187146] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:08.0/sound/card0/input12
[   10.230884] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[   10.231040] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[   10.231146] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[   10.234143] xfs filesystem being remounted at /run/systemd/unit-root/etc=
/iwd supports timestamps until 2038 (0x7fffffff)
[   10.241630] intel_powerclamp: No package C-state available
[   10.257474] xfs filesystem being remounted at /run/systemd/unit-root/var=
/lib/iwd supports timestamps until 2038 (0x7fffffff)
[   10.258875] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[   10.317257] NET: Registered PF_ALG protocol family
[   10.395975] intel_powerclamp: No package C-state available
[   10.413199] nouveau 0000:02:00.0: bios: version 70.89.13.00.00
[   10.498052] nouveau 0000:02:00.0: fb: 256 MiB stolen system memory
[   10.581127] nouveau 0000:02:00.0: bus: MMIO write of 0000807f FAULT at 1=
00c18
[   10.664219] nouveau 0000:02:00.0: bus: MMIO write of 0000807e FAULT at 1=
00c1c
[   10.734809] kauditd_printk_skb: 33 callbacks suppressed
[   10.734816] audit: type=3D1130 audit(1637155414.595:50): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dalsa-restore comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[   11.157936] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[   11.179684] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.179792] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[   11.179800] cfg80211: failed to load regulatory.db
[   11.338873] cryptd: max_cpu_qlen set to 1000
[   11.454491] audit: type=3D1130 audit(1637155415.315:51): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   11.468027] audit: type=3D1130 audit(1637155415.329:52): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsshd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   11.489418] audit: type=3D1130 audit(1637155415.352:53): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsyncthing@archmba comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
[   11.540430] audit: type=3D1130 audit(1637155415.402:54): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-user-sessions com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   11.549821] xfs filesystem being remounted at /run/systemd/unit-root/var=
/tmp supports timestamps until 2038 (0x7fffffff)
[   11.560382] audit: type=3D1130 audit(1637155415.422:55): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dgetty@tty1 comm=3D"system=
d" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   11.635899] audit: type=3D1130 audit(1637155415.499:56): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@1000 com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   11.720894] audit: type=3D1101 audit(1637155415.582:57): pid=3D620 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=
=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"archmba" exe=3D"/usr/lib=
/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   11.720921] audit: type=3D1103 audit(1637155415.582:58): pid=3D620 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D=
? acct=3D"archmba" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dfailed'
[   11.720930] audit: type=3D1006 audit(1637155415.582:59): pid=3D620 uid=
=3D0 old-auid=3D4294967295 auid=3D1000 tty=3D(none) old-ses=3D4294967295 se=
s=3D1 res=3D1
[   11.761790] Support for cores revisions 0x17 and 0x18 disabled by module=
 param allhwsupport=3D0. Try b43.allhwsupport=3D1
[   11.761817] b43: probe of bcma0:1 failed with error -524
[   11.786464] Broadcom 43xx driver loaded [ Features: PNLS ]
[   12.510863] usbcore: registered new device driver apple-mfi-fastcharge
[   12.850563] mc: Linux media interface: v0.10
[   12.884345] brcmsmac bcma0:1: mfg 4bf core 812 rev 23 class 0 irq 22
[   12.886318] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   12.955461] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos enabled: f=
alse (implement)
[   12.955496] brcmsmac bcma0:1: brcms_ops_config: change power-save mode: =
false (implement)
[   13.157568] wlan0: authenticate with 80:22:a7:34:50:c0
[   13.159434] wlan0: send auth to 80:22:a7:34:50:c0 (try 1/3)
[   13.161028] wlan0: authenticated
[   13.161990] wlan0: associate with 80:22:a7:34:50:c0 (try 1/3)
[   13.166240] wlan0: RX AssocResp from 80:22:a7:34:50:c0 (capab=3D0x431 st=
atus=3D0 aid=3D5)
[   13.166775] brcmsmac bcma0:1: brcmsmac: brcms_ops_bss_info_changed: asso=
ciated
[   13.166795] brcmsmac bcma0:1: brcms_ops_bss_info_changed: qos enabled: t=
rue (implement)
[   13.166818] wlan0: associated
[   13.189334] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211: AC_VO txop =
exceeded phylen 159/256 dur 1778/1504
[   13.205306] brcmsmac bcma0:1: wl0: brcms_c_d11hdrs_mac80211: AC_VO txop =
exceeded phylen 137/256 dur 1602/1504
[   13.256523] brcmsmac bcma0:1: brcms_ops_bss_info_changed: arp filtering:=
 1 addresses (implement)
[   13.462454] videodev: Linux video capture interface: v2.00
[   13.780298] nouveau 0000:02:00.0: DRM: VRAM: 256 MiB
[   13.780311] nouveau 0000:02:00.0: DRM: GART: 1048576 MiB
[   13.780319] nouveau 0000:02:00.0: DRM: TMDS table version 2.0
[   13.780324] nouveau 0000:02:00.0: DRM: DCB version 4.0
[   13.780329] nouveau 0000:02:00.0: DRM: DCB outp 00: 040001b6 0f220010
[   13.780336] nouveau 0000:02:00.0: DRM: DCB outp 01: 020112a6 0f220010
[   13.780340] nouveau 0000:02:00.0: DRM: DCB outp 02: 02011262 00020010
[   13.780346] nouveau 0000:02:00.0: DRM: DCB conn 00: 00002047
[   13.780350] nouveau 0000:02:00.0: DRM: DCB conn 01: 00101146
[   13.821923] nouveau 0000:02:00.0: DRM: MM: using M2MF for buffer copies
[   13.983958] usb 1-6: Found UVC 1.00 device Built-in iSight (05ac:850a)
[   14.030287] input: Built-in iSight: Built-in iSigh as /devices/pci0000:0=
0/0000:00:04.1/usb1/1-6/1-6:1.0/input/input13
[   14.033367] usbcore: registered new interface driver uvcvideo
[   14.602338] nouveau 0000:02:00.0: DRM: allocated 1366x768 fb: 0x50000, b=
o 00000000fb5f723e
[   14.606143] fbcon: nouveau (fb0) is primary device
[   14.759990] Console: switching to colour frame buffer device 170x48
[   14.830068] mousedev: PS/2 mouse device common for all mice
[   14.864073] nouveau 0000:02:00.0: [drm] fb0: nouveau frame buffer device
[   14.893477] [drm] Initialized nouveau 1.3.1 20120801 for 0000:02:00.0 on=
 minor 0
[   15.505388] Bluetooth: Core ver 2.22
[   15.506871] NET: Registered PF_BLUETOOTH protocol family
[   15.506878] Bluetooth: HCI device and connection manager initialized
[   15.506888] Bluetooth: HCI socket layer initialized
[   15.506894] Bluetooth: L2CAP socket layer initialized
[   15.506906] Bluetooth: SCO socket layer initialized
[   15.976864] usbcore: registered new interface driver btusb
[   16.018268] usb 3-5.1: USB disconnect, device number 5
[   16.097301] Bluetooth: hci0: BCM: chip id 19 build 0848
[   16.100294] Bluetooth: hci0: BCM: product 05ac:821b
[   16.103297] Bluetooth: hci0: BCM: features 0x07
[   16.121302] Bluetooth: hci0: Apple Bluetooth Device
[   16.246277] usb 3-5.2: USB disconnect, device number 6

--=-=-=
Content-Type: text/plain


Regards.
Yuji Nakao

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJKBAEBCAA0FiEETYVHHTrlVWkmzOhy22IiAuK1hSMFAmGVCSsWHGNvbnRhY3RA
eXVqaW5ha2FvLmNvbQAKCRDbYiIC4rWFI5PQEACjjdZ/SCvABW+huAposh/7wEcC
/b4ndoEYZBE7Jm6eh5X1Em2JLJW11si8jlXl46q8vwE6RcHRAAKm9fNx4DeOU9Mf
VZBbteXxDmTQ7syGveajhyxgspYrIQsyWbAzpBm6gJjSUGNLRtYV+IAs4M+wTOk6
ytS00zVWjsghBuYxaw+w2D1gaihk+gM98jBpZGK/tRVvRdWNwALfs3u9Yo0FxZFM
w002ZYd0/PiGJTiPDSe3jp3oWNY+JFFExBwtiiryzjzxOJ+QkmiMuClHHkkQNJwD
8m91NkRfiyKO7HgSyaRWrLGy1HACzy0IIjToWq8+pym52KN7eLvBUJfUz5GAxyqu
dMf3BypcbQPLZHc88aEFwznsbn6DepV059W0hs4/e24OtxGbN4F+H3AEdDGR64u3
uSTOthfZvuU8lE3plgWy5pE2RylTwbrgWpyOEgzecGA3ezVzu6jxHep6QVdQXSsQ
C+Q5Tw92qp8FnEjZZNbet1c05ywk/ElQ+Yh2xFUe6vTPftfNz68DRFV1bjY8Jtlo
m9tSqfQB9swsQoiATpDeTHvkerIyvM/qUWq3ZbKmv4+vjNV5TTKq+buurw/pr70A
9UhOgqoOQ6OGknMj6uHbCXAhqi9hU6cg7/2c3ksHdP6Ob3+0HqLA0u3ouX1UqQ75
W/LqkNg9V2/d5udZFA==
=LeU4
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
