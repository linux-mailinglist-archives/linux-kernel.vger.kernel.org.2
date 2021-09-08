Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2968403285
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbhIHCNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:13:52 -0400
Received: from mout.web.de ([212.227.15.4]:33751 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235450AbhIHCNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631067158;
        bh=zswctVVCqOWtJW0l4rn2Lh0rawYYkETcPJRW5lUdXu0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OM+PnriRRFqGFhB8cCOr2V4bVh2leD+Mf3GR+BbTHFT/XgAXZvCM9Dht8hqjCG5MQ
         kIqvQiyCY30kl9KZ4KlhcQqB5/wrxBzSJswvDqJXcVSm3tumr9F/DkGxpWnkelgImL
         8r7tjee6xSE2oG8/V1wvPBJwRa3rhpYSye1g2SVo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([185.159.157.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMGyA-1mh6e00WNq-00JSKe; Wed, 08
 Sep 2021 04:12:38 +0200
Subject: Re: [Bisected Regression] OLPC XO-1.5: Internal drive and SD card
 (mmcblk*) gone since commit ea718c699055
To:     Saravana Kannan <saravanak@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de>
 <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <97044cb9-b7a9-d8af-93e7-d33a81a1cfe2@web.de>
Date:   Wed, 8 Sep 2021 04:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9tfYXbyfSSG1tqTbBl5GRqhtz4duSfN6bpVl1VMyWjMH/o5NLtS
 FBH+/qWU6pNI+C5LQ8QRPHBrGZeCp6YvAeOQeGmBKeXgk5zbDV7LyKON/ISh+qY0+mlnujn
 odHDzGP4ovM6NWLpKBsprlct/D1jLbvzGnt+ISDM3bY3eEtJ0INJqtyPR3SW/OgPzxXHxxo
 5KOezcX3zjStvRcwdH3Bg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKXo2+ypzxU=:Wfl7W82J/rQKWyFVShuZtI
 rDOhOfuPYwdJWb2Z4nm+0MZUODp7fYuovuD5tbNlExbfqTLv0mqXpWkMbBFa61izXf1f0QuL/
 +y6l3RO6t92z319Qza0QVI6iWOTOM9SwWpRPRm6kgMfkn2+ysyqbI4Oepry4hbXrdHNpkMdg4
 TElRu80at9Mh3vPsFSyr1bjIil23rC6DiZOZnlt6yw/p9/NM1OL7sEoVqB4xuSrLCiH/TDr86
 FsKpHgcxW2tz/8MR6TZPmdWUC3p4SceEfWK0RJSQsaMWObih7uUP9wkuZiB/7x13oRCDnYmRp
 tNqG0do/0YRfLmqkbFpqgjXw4ibZhcE4F9KoKh4qZeNbVs5eb01bIIMYlzOJJmUgLqqvYgfxW
 sMPps/uS/k3UE1Hq339+EXk71vkAhpbBhidK9uoQlb+B6EVpDoyBfNB77Q2HGLNb0zZnT7btH
 pAMtyN2x2FT32GfeuKFmoM9B2QC8ylJn/k2ipQi8vt1fZ7x8J1ugOtOND8jfGwV6doJNV4Z+u
 E+kChnxoM/7sqearJmqo6pIAJSqBDdlcznUvEKtViYj5WutziNIal7RXPb/QVO4fOJsQVB+rB
 a3S4XdZinNSu7VNXMx7ThCN80AUh5epOjQPFpBSmf9qh/9v9Ahr/fWcrE4enoadGhG+bv81X8
 tZbSkpqgxLjSIiuDzm/ZnDx4M4il3igUpeConenY+1bf7wwYHlgd1wQyjxiyfxqBWw0WxCm7h
 xXwagY13WcalkoWr6QHcn5fDhchot9jXWdvlv24v6N4RqbXTKjICu02iToiNmjkqoXZr+QHWK
 0FTiP5MzKRuI0sgdTTQjCwqoFRuNpW4IU7KG32w3NigJBlymXUJeA1ohEZf95uA6Magj3TBns
 i66NhUWZt5Vjscj4T6zwKGmx4y9RSUNt+38EYjqdm/sVmLcYDgqBKTMHkGawunSDPxb5G7Lml
 VkWRZwrbamAvz/EMzbIE9FYg676hixpBvepg61uxjESdP3+PRwoLBaNl6cqxji0JLmn9ZxyeS
 BG20zL0Kbhp4cOKXUm6IptZ3qu1FfNF1X3X4q0LPAGX8qy/2o95wsKW6LH0ZdwjDNhZ4bgEUy
 Rnu7pvd5k+OxSCeHaYceJ41D9VVtsNac0P8MaBkQFlqqkhoAwh1210kJA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2021 00.05, Saravana Kannan wrote:
> On Sun, Sep 5, 2021 at 1:15 AM Andre Muller <andre.muller@web.de> wrote:
>>
>> With linux-5.13 and linux-5.14, the internal drive and SD card reader a=
re gone from the XO-1.5. I bisected the issue to come up with ea718c699055=
:
>>
>> # first bad commit: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "=
Revert "driver core: Set fw_devlink=3Don by default""
>>
>> The /dev/mmcblk* nodes are not generated since this patch.
>>
>> Please find the output of lspsi -vv and lshw below.
>>
>> I will be happy to provide more info and/or test patches.
>
> Hi Andre,
>
> Can you point me to the dts file in upstream that corresponds to this sy=
stem?
>
> Also, if you can give the output of:
> cat /sys/kernel/debug/devices_deferred

Hi Saravana,


/sys/kernel/debug/devices_deferred is empty.
I used the last good commit b6f617.

The XO-1.5 has an x86 compatible VIA C7 processor.
It uses the VX855 chip for about all I/O tasks, including SDIO.
I am not aware of a device tree file for it.

It is a bit of a strange beast, it uses OFW to initialize the hardware and=
 provide a FORTH shell.
Which also is the boot manager, configured via FORTH scripts.

 From the linux side of the fence, dmesg's line 2 is:

"OFW detected in memory, cif @ 0xff83ae68 (reserving top 8MB)"

AIUI, this mechanism is used in lieu of a device tree file, like UEFI on m=
ost x86 hardware.
But my understanding of device trees is severely limited, I might be allwr=
ong.


Anyway, the firmware source is here:
http://dev.laptop.org/git/users/quozl/openfirmware/

This file is the closest dt-analogous thing for the XO-1.5 I can find ther=
ein:
cpu/x86/pc/olpc/via/devices.fth

My machine runs the latest version:
http://wiki.laptop.org/go/OLPC_Firmware_q3c17

The XO-1.5 hardware specs are here:
http://wiki.laptop.org/images/f/f0/CL1B_Hdwe_Design_Spec.pdf
http://wiki.laptop.org/go/Hardware_specification_1.5

Would the .config or dmesg help?

Thank you,
Andre

>
> Thanks,
> Saravana
>
>>
>> Thank you,
>> Andre M=C3=BCller
>>
>> =3D=3D=3D
>>
>> # lspci -vv
>>
>> 00:00.0 Host bridge: VIA Technologies, Inc. VX855/VX875 Host Bridge: Ho=
st Control (rev 03)
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Host Bridge: Host =
Control
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32, Cache Line Size: 32 bytes
>>
>> 00:00.1 Host bridge: VIA Technologies, Inc. VX855/VX875 Error Reporting
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Error Reporting
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:00.2 Host bridge: VIA Technologies, Inc. VX855/VX875 Host Bus Contro=
l
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Host Bus Control
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:00.3 Host bridge: VIA Technologies, Inc. VX855/VX875 DRAM Bus Contro=
l
>>           Subsystem: QUANTA Computer Inc VX855/VX875 DRAM Bus Control
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0
>>
>> 00:00.4 Host bridge: VIA Technologies, Inc. VX855/VX875 Power Managemen=
t Control
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Power Management C=
ontrol
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:00.5 PIC: VIA Technologies, Inc. VX855/VX875 APIC and Central Traffi=
c Control (prog-if 20 [IO(X)-APIC])
>>           Subsystem: QUANTA Computer Inc VX855/VX875 APIC and Central T=
raffic Control
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:00.6 Host bridge: VIA Technologies, Inc. VX855/VX875 Scratch Registe=
rs
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Scratch Registers
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:00.7 Host bridge: VIA Technologies, Inc. VX855/VX875 North-South Mod=
ule Interface Control
>>           Subsystem: QUANTA Computer Inc VX855/VX875 North-South Module=
 Interface Control
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>
>> 00:01.0 VGA compatible controller: VIA Technologies, Inc. VX855/VX875 C=
hrome 9 HCM Integrated Graphics (prog-if 00 [VGA controller])
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Chrome 9 HCM Integ=
rated Graphics
>>           Device tree node: /sys/firmware/devicetree/base/pci/display@1
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32
>>           Interrupt: pin A routed to IRQ 16
>>           Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D6=
4M]
>>           Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=
=3D16M]
>>           Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
>>           Capabilities: [60] Power Management version 2
>>                   Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,=
D1-,D2-,D3hot-,D3cold-)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>>                   Address: 00000000  Data: 0000
>>           Kernel driver in use: viafb
>>
>> 00:0c.0 SD Host controller: VIA Technologies, Inc. SDIO Host Controller=
 (rev 10) (prog-if 01)
>>           Subsystem: QUANTA Computer Inc SDIO Host Controller
>>           Device tree node: /sys/firmware/devicetree/base/pci/sd@c
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0
>>           Interrupt: pin A routed to IRQ 22
>>           Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=
=3D256]
>>           Region 1: Memory at 80001000 (32-bit, non-prefetchable) [size=
=3D256]
>>           Region 2: Memory at 80002000 (32-bit, non-prefetchable) [size=
=3D256]
>>           Capabilities: [80] Power Management version 2
>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0=
+,D1+,D2+,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Kernel driver in use: sdhci-pci
>>
>> 00:10.0 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1=
 Controller (rev a0) (prog-if 00 [UHCI])
>>           Subsystem: QUANTA Computer Inc VT82xx/62xx UHCI USB 1.1 Contr=
oller
>>           Device tree node: /sys/firmware/devicetree/base/pci/usb@10
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32, Cache Line Size: 32 bytes
>>           Interrupt: pin A routed to IRQ 20
>>           Region 4: I/O ports at 8000 [size=3D32]
>>           Capabilities: [80] Power Management version 2
>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0=
+,D1+,D2+,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Kernel driver in use: uhci_hcd
>>
>> 00:10.1 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1=
 Controller (rev a0) (prog-if 00 [UHCI])
>>           Subsystem: QUANTA Computer Inc VT82xx/62xx UHCI USB 1.1 Contr=
oller
>>           Device tree node: /sys/firmware/devicetree/base/pci/usb@10,1
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32, Cache Line Size: 32 bytes
>>           Interrupt: pin B routed to IRQ 22
>>           Region 4: I/O ports at 8020 [size=3D32]
>>           Capabilities: [80] Power Management version 2
>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0=
+,D1+,D2+,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Kernel driver in use: uhci_hcd
>>
>> 00:10.2 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1=
 Controller (rev a0) (prog-if 00 [UHCI])
>>           Subsystem: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Co=
ntroller
>>           Device tree node: /sys/firmware/devicetree/base/pci/usb@10,2
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32, Cache Line Size: 32 bytes
>>           Interrupt: pin C routed to IRQ 21
>>           Region 4: I/O ports at 8040 [size=3D32]
>>           Capabilities: [80] Power Management version 2
>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0=
+,D1+,D2+,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Kernel driver in use: uhci_hcd
>>
>> 00:10.4 USB controller: VIA Technologies, Inc. USB 2.0 (rev 90) (prog-i=
f 20 [EHCI])
>>           Subsystem: QUANTA Computer Inc USB 2.0
>>           Device tree node: /sys/firmware/devicetree/base/pci/usb@10,4
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 32, Cache Line Size: 64 bytes
>>           Interrupt: pin D routed to IRQ 23
>>           Region 0: Memory at 80003000 (32-bit, non-prefetchable) [size=
=3D256]
>>           Capabilities: [80] Power Management version 2
>>                   Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0=
+,D1+,D2+,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Capabilities: [88] Debug port: BAR=3D1 offset=3D00a0
>>           Kernel driver in use: ehci-pci
>>
>> 00:11.0 ISA bridge: VIA Technologies, Inc. VX855/VX875 Bus Control and =
Power Management
>>           Subsystem: QUANTA Computer Inc VX855/VX875 Bus Control and Po=
wer Management
>>           Device tree node: /sys/firmware/devicetree/base/pci/isa@11
>>           Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- P=
arErr+ Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Capabilities: [c0] Power Management version 2
>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,=
D1-,D2-,D3hot-,D3cold-)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>
>> 00:11.7 Host bridge: VIA Technologies, Inc. VX8xx South-North Module In=
terface Control
>>           Subsystem: VIA Technologies, Inc. VX8xx South-North Module In=
terface Control
>>           Device tree node: /sys/firmware/devicetree/base/pci/host@11,7
>>           Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
>>
>> 00:13.0 PCI bridge: VIA Technologies, Inc. VX855/VX875/VX900 PCI to PCI=
 Bridge (prog-if 00 [Normal decode])
>>           Device tree node: /sys/firmware/devicetree/base/pci/pci@13
>>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR+ FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort+ >SERR- <PERR- INTx-
>>           Latency: 0
>>           Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-late=
ncy=3D0
>>           I/O behind bridge: [disabled]
>>           Memory behind bridge: [disabled]
>>           Prefetchable memory behind bridge: [disabled]
>>           Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dmedium >TA=
bort- <TAbort- <MAbort- <SERR- <PERR-
>>           BridgeCtl: Parity- SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- F=
astB2B-
>>                   PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>           Capabilities: [70] Subsystem: VIA Technologies, Inc. VX855/VX=
875/VX900 PCI to PCI Bridge
>>
>> 00:14.0 Audio device: VIA Technologies, Inc. VT8237A/VT8251 HDA Control=
ler (rev 20)
>>           Subsystem: QUANTA Computer Inc VT8237A/VT8251 HDA Controller
>>           Device tree node: /sys/firmware/devicetree/base/pci/audio@14
>>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr- Stepping- SERR- FastB2B- DisINTx-
>>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>           Latency: 0, Cache Line Size: 32 bytes
>>           Interrupt: pin A routed to IRQ 17
>>           Region 0: Memory at 80004000 (64-bit, non-prefetchable) [size=
=3D16K]
>>           Capabilities: [50] Power Management version 2
>>                   Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+=
,D1-,D2-,D3hot+,D3cold+)
>>                   Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
>>           Capabilities: [60] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>>                   Address: 0000000000000000  Data: 0000
>>           Capabilities: [70] Express (v1) Root Complex Integrated Endpo=
int, MSI 00
>>                   DevCap: MaxPayload 128 bytes, PhantFunc 0
>>                           ExtTag- RBE- FLReset-
>>                   DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>                           RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>                           MaxPayload 128 bytes, MaxReadReq 128 bytes
>>                   DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- Aux=
Pwr+ TransPend-
>>           Kernel driver in use: snd_hda_intel
>>
>> =3D=3D=3D
>>
>> # lshw
>>
>> xo
>>       description: Laptop
>>       product: DA
>>       vendor: OLPC
>>       version: 1.5
>>       serial: SHC1470003A
>>       width: 32 bits
>>       capabilities: smbios-2.1 dmi-2.1
>>       configuration: chassis=3Dlaptop uuid=3D5a6dddd6-4fbe-32d5-50e9-78=
6f7411eb8e
>>     *-core
>>          description: Motherboard
>>          product: XO
>>          vendor: QUANTA
>>          physical id: 0
>>          version: 1.5
>>          serial: SHC1470003A
>>        *-firmware:0
>>             description: BIOS
>>             vendor: IE8y2D ScD%g4r2bAIFA.
>>             physical id: 0
>>             version: OLPC Ver 1.00.15
>>             date: 06/13/2014
>>             size: 64KiB
>>             capacity: 1MiB
>>             capabilities: pci upgrade shadowing cdboot bootselect edd a=
cpi
>>        *-cpu:0
>>             description: CPU
>>             product: VIA C7-M Processor 1000MHz
>>             vendor: CentaurHauls
>>             physical id: 400
>>             bus info: cpu@0
>>             version: 6.13.0
>>             size: 997MHz
>>             capacity: 997MHz
>>             width: 32 bits
>>             clock: 33MHz
>>             capabilities: fpu fpu_exception wp vme de pse tsc msr pae m=
ce cx8 apic sep mtrr pge cmov pat clflush acpi mmx fxsr sse sse2 tm nx cpu=
id pni est tm2 xtpr rng rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_=
en cpufreq
>>           *-cache:0
>>                description: L1 cache
>>                physical id: 701
>>                size: 128KiB
>>                capacity: 128KiB
>>                capabilities: internal write-back unified
>>                configuration: level=3D1
>>           *-cache:1
>>                description: L2 cache
>>                physical id: 703
>>                size: 128KiB
>>                capacity: 128KiB
>>                capabilities: internal write-back unified
>>                configuration: level=3D2
>>        *-memory
>>             description: System Memory
>>             physical id: 1001
>>             slot: System board or motherboard
>>             size: 1GiB
>>             capacity: 1GiB
>>           *-bank
>>                description: Row of chips DDR2 Synchronous
>>                physical id: 0
>>                slot: Soldered
>>                size: 1GiB
>>                width: 64 bits
>>        *-firmware:1
>>             product: CL1   Q3C17  Q3C
>>             physical id: 1
>>             logical name: /proc/device-tree
>>        *-cpu:1 DISABLED
>>             description: CPU
>>             product: cpu
>>             physical id: 2
>>             bus info: cpu@0
>>             size: 1GHz
>>        *-pci:0
>>             description: Host bridge
>>             product: VX855/VX875 Host Bridge: Host Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 100
>>             bus info: pci@0000:00:00.0
>>             version: 03
>>             width: 32 bits
>>             clock: 33MHz
>>             configuration: latency=3D32
>>           *-generic:0 UNCLAIMED
>>                description: PIC
>>                product: VX855/VX875 APIC and Central Traffic Control
>>                vendor: VIA Technologies, Inc.
>>                physical id: 0.5
>>                bus info: pci@0000:00:00.5
>>                version: 00
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: io_x_-apic bus_master
>>                configuration: latency=3D0
>>           *-display
>>                description: VGA compatible controller
>>                product: VX855/VX875 Chrome 9 HCM Integrated Graphics
>>                vendor: VIA Technologies, Inc.
>>                physical id: 1
>>                bus info: pci@0000:00:01.0
>>                logical name: /dev/fb0
>>                version: 00
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm msi vga_controller bus_master cap_list =
rom fb
>>                configuration: depth=3D32 driver=3Dviafb latency=3D32 re=
solution=3D1200,900
>>                resources: irq:16 memory:d0000000-d3ffffff memory:f00000=
00-f0ffffff memory:c0000-dffff
>>           *-generic:1
>>                description: MMC Host
>>                product: SDIO Host Controller
>>                vendor: VIA Technologies, Inc.
>>                physical id: c
>>                bus info: pci@0000:00:0c.0
>>                logical name: mmc0
>>                logical name: mmc1
>>                logical name: mmc2
>>                version: 10
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm bus_master cap_list
>>                configuration: driver=3Dsdhci-pci latency=3D0
>>                resources: irq:22 memory:80000000-800000ff memory:800010=
00-800010ff memory:80002000-800020ff
>>              *-device:0
>>                   description: SD Card
>>                   product: SD08G
>>                   vendor: SanDisk
>>                   physical id: aaaa
>>                   logical name: /dev/mmcblk0
>>                   version: 8.0
>>                   date: 09/2010
>>                   serial: 167437691
>>                   size: 7580MiB (7948MB)
>>                   capabilities: sd partitioned partitioned:dos
>>                   configuration: logicalsectorsize=3D512 sectorsize=3D5=
12 signature=3D304f4eb5
>>                 *-volume:0
>>                      description: Linux filesystem partition
>>                      vendor: Linux
>>                      physical id: 1
>>                      logical name: /dev/mmcblk0p1
>>                      logical name: /boot
>>                      version: 1.0
>>                      serial: 0e879075-94ae-487d-b65f-86c6f4814cc7
>>                      size: 7MiB
>>                      capacity: 7MiB
>>                      capabilities: primary extended_attributes ext2 ini=
tialized
>>                      configuration: filesystem=3Dext2 lastmountpoint=3D=
/mnt/sdb1 modified=3D2021-09-04 23:01:46 mount.fstype=3Dext2 mount.options=
=3Drw,noatime mounted=3D2021-09-04 23:01:46 state=3Dmounted
>>                 *-volume:1
>>                      description: Linux filesystem partition
>>                      physical id: 2
>>                      logical name: /dev/mmcblk0p2
>>                      capacity: 7572MiB
>>                      capabilities: primary
>>              *-device:1
>>                   description: SDIO Device
>>                   physical id: 1
>>                   bus info: mmc@1:0001:1
>>                   logical name: mmc1:0001:1
>>                   serial: 0
>>                   capabilities: sdio
>>              *-device:2
>>                   description: SD Card
>>                   product: SU04G
>>                   vendor: SanDisk
>>                   physical id: e624
>>                   logical name: /dev/mmcblk2
>>                   version: 8.0
>>                   date: 09/2011
>>                   serial: 290732065
>>                   size: 3781MiB (3965MB)
>>                   capabilities: sd partitioned partitioned:dos
>>                   configuration: logicalsectorsize=3D512 sectorsize=3D5=
12
>>                 *-volume:0
>>                      description: Linux filesystem partition
>>                      vendor: Linux
>>                      physical id: 1
>>                      logical name: /dev/mmcblk2p1
>>                      version: 1.0
>>                      serial: ad2652ce-fee6-48ba-be72-86fb96ae288b
>>                      size: 64MiB
>>                      capacity: 64MiB
>>                      capabilities: primary bootable extended_attributes=
 ext2 initialized
>>                      configuration: filesystem=3Dext2 label=3DBoot last=
mountpoint=3D/var/lib/random-seed modified=3D2021-09-03 01:06:44 mounted=
=3D2021-09-03 01:06:32 state=3Dunknown
>>                 *-volume:1
>>                      description: EXT4 volume
>>                      vendor: Linux
>>                      physical id: 2
>>                      logical name: /dev/mmcblk2p2
>>                      version: 1.0
>>                      serial: 8a90ac7c-4c44-4750-83c5-0857f41ade6a
>>                      size: 3713MiB
>>                      capacity: 3713MiB
>>                      capabilities: primary journaled extended_attribute=
s large_files dir_nlink recover extents ext4 ext2 initialized
>>                      configuration: created=3D2020-01-29 04:49:55 files=
ystem=3Dext4 label=3DOLPCRoot lastmountpoint=3D/ modified=3D2020-10-19 19:=
23:30 mounted=3D2021-09-03 01:06:32 state=3Dclean
>>           *-usb:0
>>                description: USB controller
>>                product: VT82xx/62xx UHCI USB 1.1 Controller
>>                vendor: VIA Technologies, Inc.
>>                physical id: 10
>>                bus info: pci@0000:00:10.0
>>                version: a0
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm uhci bus_master cap_list
>>                configuration: driver=3Duhci_hcd latency=3D32
>>                resources: irq:20 ioport:8000(size=3D32)
>>           *-usb:1
>>                description: USB controller
>>                product: VT82xx/62xx UHCI USB 1.1 Controller
>>                vendor: VIA Technologies, Inc.
>>                physical id: 10.1
>>                bus info: pci@0000:00:10.1
>>                version: a0
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm uhci bus_master cap_list
>>                configuration: driver=3Duhci_hcd latency=3D32
>>                resources: irq:22 ioport:8020(size=3D32)
>>           *-usb:2
>>                description: USB controller
>>                product: VT82xx/62xx UHCI USB 1.1 Controller
>>                vendor: VIA Technologies, Inc.
>>                physical id: 10.2
>>                bus info: pci@0000:00:10.2
>>                version: a0
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm uhci bus_master cap_list
>>                configuration: driver=3Duhci_hcd latency=3D32
>>                resources: irq:21 ioport:8040(size=3D32)
>>           *-usb:3
>>                description: USB controller
>>                product: USB 2.0
>>                vendor: VIA Technologies, Inc.
>>                physical id: 10.4
>>                bus info: pci@0000:00:10.4
>>                version: 90
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pm debug ehci bus_master cap_list
>>                configuration: driver=3Dehci-pci latency=3D32
>>                resources: irq:23 memory:80003000-800030ff
>>           *-isa
>>                description: ISA bridge
>>                product: VX855/VX875 Bus Control and Power Management
>>                vendor: VIA Technologies, Inc.
>>                physical id: 11
>>                bus info: pci@0000:00:11.0
>>                version: 00
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: isa pm cap_list
>>                configuration: latency=3D0
>>              *-pnp00:00
>>                   product: System Board
>>                   physical id: 0
>>                   capabilities: pnp
>>                   configuration: driver=3Dsystem
>>              *-pnp00:01
>>                   product: Motherboard registers
>>                   physical id: 1
>>                   capabilities: pnp
>>                   configuration: driver=3Dsystem
>>              *-pnp00:02
>>                   product: PS/2 Port for PS/2-style Mice
>>                   physical id: 2
>>                   capabilities: pnp
>>                   configuration: driver=3Di8042 aux
>>              *-pnp00:03
>>                   product: IBM Enhanced keyboard controller (101/2-key)
>>                   physical id: 3
>>                   capabilities: pnp
>>                   configuration: driver=3Di8042 kbd
>>              *-pnp00:04
>>                   product: AT Real-Time Clock
>>                   physical id: 4
>>                   capabilities: pnp
>>                   configuration: driver=3Drtc_cmos
>>              *-pnp00:05
>>                   product: Motherboard registers
>>                   physical id: 5
>>                   capabilities: pnp
>>                   configuration: driver=3Dsystem
>>              *-pnp00:06
>>                   product: System Board
>>                   physical id: 6
>>                   capabilities: pnp
>>                   configuration: driver=3Dsystem
>>           *-pci
>>                description: PCI bridge
>>                product: VX855/VX875/VX900 PCI to PCI Bridge
>>                vendor: VIA Technologies, Inc.
>>                physical id: 13
>>                bus info: pci@0000:00:13.0
>>                version: 00
>>                width: 32 bits
>>                clock: 33MHz
>>                capabilities: pci normal_decode bus_master cap_list
>>           *-multimedia
>>                description: Audio device
>>                product: VT8237A/VT8251 HDA Controller
>>                vendor: VIA Technologies, Inc.
>>                physical id: 14
>>                bus info: pci@0000:00:14.0
>>                logical name: card0
>>                logical name: /dev/snd/controlC0
>>                logical name: /dev/snd/pcmC0D0c
>>                logical name: /dev/snd/pcmC0D0p
>>                version: 20
>>                width: 64 bits
>>                clock: 33MHz
>>                capabilities: pm msi pciexpress bus_master cap_list
>>                configuration: driver=3Dsnd_hda_intel latency=3D0
>>                resources: irq:17 memory:80004000-80007fff
>>              *-input:0
>>                   product: HDA VIA VT82xx Mic
>>                   physical id: 0
>>                   logical name: input6
>>                   logical name: /dev/input/event4
>>              *-input:1
>>                   product: HDA VIA VT82xx Headphone
>>                   physical id: 1
>>                   logical name: input7
>>                   logical name: /dev/input/event5
>>        *-pci:1
>>             description: Host bridge
>>             product: VX855/VX875 Error Reporting
>>             vendor: VIA Technologies, Inc.
>>             physical id: 101
>>             bus info: pci@0000:00:00.1
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:2
>>             description: Host bridge
>>             product: VX855/VX875 Host Bus Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 102
>>             bus info: pci@0000:00:00.2
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:3
>>             description: Host bridge
>>             product: VX855/VX875 DRAM Bus Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 103
>>             bus info: pci@0000:00:00.3
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:4
>>             description: Host bridge
>>             product: VX855/VX875 Power Management Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 104
>>             bus info: pci@0000:00:00.4
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:5
>>             description: Host bridge
>>             product: VX855/VX875 Scratch Registers
>>             vendor: VIA Technologies, Inc.
>>             physical id: 105
>>             bus info: pci@0000:00:00.6
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:6
>>             description: Host bridge
>>             product: VX855/VX875 North-South Module Interface Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 106
>>             bus info: pci@0000:00:00.7
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>        *-pci:7
>>             description: Host bridge
>>             product: VX8xx South-North Module Interface Control
>>             vendor: VIA Technologies, Inc.
>>             physical id: 107
>>             bus info: pci@0000:00:11.7
>>             version: 00
>>             width: 32 bits
>>             clock: 33MHz
>>             configuration: latency=3D8
>>     *-input:0
>>          product: Lid Switch
>>          physical id: 1
>>          logical name: input0
>>          logical name: /dev/input/event0
>>          capabilities: platform
>>     *-input:1
>>          product: Power Button
>>          physical id: 2
>>          logical name: input1
>>          logical name: /dev/input/event1
>>          capabilities: platform
>>     *-input:2
>>          product: AT Translated Set 2 keyboard
>>          physical id: 3
>>          logical name: input2
>>          logical name: /dev/input/event2
>>          capabilities: i8042
>>     *-input:3
>>          product: FSPPS/2 Sentelic FingerSensingPad
>>          physical id: 4
>>          logical name: input4
>>          logical name: /dev/input/event6
>>          capabilities: i8042
>>     *-input:4
>>          product: EBook Switch
>>          physical id: 5
>>          logical name: input5
>>          logical name: /dev/input/event3
>>          capabilities: platform
>>     *-network
>>          description: Wireless interface
>>          physical id: 6
>>          logical name: wlan0
>>          serial: 68:a3:c4:cf:8d:fa
>>          capabilities: ethernet physical wireless
>>          configuration: broadcast=3Dyes driver=3Dlibertas driverversion=
=3DCOMM-USB8388-323.p0 firmware=3D9.70.20.p0 multicast=3Dyes wireless=3DIE=
EE 802.11

