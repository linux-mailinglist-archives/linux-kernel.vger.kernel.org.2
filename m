Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE54030B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbhIGWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhIGWHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:07:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B1C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 15:06:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id c206so1431885ybb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zjy+Vuu7kRvsCLJFYFsUIukbFTA1vjLsQbaYagQaqto=;
        b=dRQKjKz3T6Jd3myE/bkeElY0sgJXFelAcnyZaYTVJdLMiYN1w8ekB5lCvEShzeHZ/H
         zpinHPXoy1SNVXeLOiarpNV5R7paRkB/CYMqOLWHbnTS3lrz//KY2JFqwabSS7lEeyej
         5wGHHXrhQavP4GglPdVbnMK8yGMvJ+cyPuQdiZ1YA5GEcmQ8mvvka+dfSrNyQ7P+6PLU
         U+0AL9zxZ7N4NILh47X4NojNECiwHUGryTi/D8c6GqTgU9W3cVkBYIsUm/FtkE912iUj
         F6YFGPwNlUQW7AdrGM/Hz5WaMP32tDpGGLfjAKwYb5q2SUfKbJS1mLNBHihRmaXm9ner
         ba1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zjy+Vuu7kRvsCLJFYFsUIukbFTA1vjLsQbaYagQaqto=;
        b=s7DSmX0CRgbTyQOedsKd/4ftPYb5IJTmFdLKlBsZzJ5ptAaLGdEf7DL/+ftRday3yS
         lUPf/IuDJKUWBIpEjPsVuKQtvtrdrFMEdVSwjeB9ve0+k++xOtCUBFQTYUX//Ir2SDaX
         jUbXRr2mC9yowV6345u7Ig5b3jAU5tUwC8CyTMMx8+MYQJ9w1cNAdanETFq2BplQ4TWo
         1t54Vfw12Fc7DKdKQ+xX2JNmHsDqG6Nt32Yp+yX+2lgEMHx4uvD1x8qvB8/lMUX81bPv
         SPwgcOARr3PM9hOlXiwUWQ4p7jKOaVk3JDzU7f+vG+oD0BTceXCfNlvmCjUfD5XIi7/p
         /PXg==
X-Gm-Message-State: AOAM531yYa+eh3l1AxV5RvZ08KOsEBoJiRIL4dcnOkmX0yEkBxaeZSR8
        tyB9r4LAYRuCKqTGe2a92w1uYNGKLY2u/JGMiw51610He4rxNA==
X-Google-Smtp-Source: ABdhPJyIrRtRr0LXkIX1e+PZNa1DAlHeduhCF2vevTY6S+b+5B1Sp6JJkZNTVWvs6IAmiFYb579Wt/HPCUUqVQvnR/w=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr727871ybh.23.1631052388047;
 Tue, 07 Sep 2021 15:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de>
In-Reply-To: <3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Sep 2021 15:05:51 -0700
Message-ID: <CAGETcx9eFg7jR=ibBLhU3q+VnpqJXQCVmQcEyMpozddRiCXFLQ@mail.gmail.com>
Subject: Re: [Bisected Regression] OLPC XO-1.5: Internal drive and SD card
 (mmcblk*) gone since commit ea718c699055
To:     Andre Muller <andre.muller@web.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 5, 2021 at 1:15 AM Andre Muller <andre.muller@web.de> wrote:
>
> With linux-5.13 and linux-5.14, the internal drive and SD card reader are=
 gone from the XO-1.5. I bisected the issue to come up with ea718c699055:
>
> # first bad commit: [ea718c699055c8566eb64432388a04974c43b2ea] Revert "Re=
vert "driver core: Set fw_devlink=3Don by default""
>
> The /dev/mmcblk* nodes are not generated since this patch.
>
> Please find the output of lspsi -vv and lshw below.
>
> I will be happy to provide more info and/or test patches.

Hi Andre,

Can you point me to the dts file in upstream that corresponds to this syste=
m?

Also, if you can give the output of:
cat /sys/kernel/debug/devices_deferred

Thanks,
Saravana

>
> Thank you,
> Andre M=C3=BCller
>
> =3D=3D=3D
>
> # lspci -vv
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VX855/VX875 Host Bridge: Host=
 Control (rev 03)
>          Subsystem: QUANTA Computer Inc VX855/VX875 Host Bridge: Host Con=
trol
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32, Cache Line Size: 32 bytes
>
> 00:00.1 Host bridge: VIA Technologies, Inc. VX855/VX875 Error Reporting
>          Subsystem: QUANTA Computer Inc VX855/VX875 Error Reporting
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:00.2 Host bridge: VIA Technologies, Inc. VX855/VX875 Host Bus Control
>          Subsystem: QUANTA Computer Inc VX855/VX875 Host Bus Control
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:00.3 Host bridge: VIA Technologies, Inc. VX855/VX875 DRAM Bus Control
>          Subsystem: QUANTA Computer Inc VX855/VX875 DRAM Bus Control
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0
>
> 00:00.4 Host bridge: VIA Technologies, Inc. VX855/VX875 Power Management =
Control
>          Subsystem: QUANTA Computer Inc VX855/VX875 Power Management Cont=
rol
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:00.5 PIC: VIA Technologies, Inc. VX855/VX875 APIC and Central Traffic =
Control (prog-if 20 [IO(X)-APIC])
>          Subsystem: QUANTA Computer Inc VX855/VX875 APIC and Central Traf=
fic Control
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:00.6 Host bridge: VIA Technologies, Inc. VX855/VX875 Scratch Registers
>          Subsystem: QUANTA Computer Inc VX855/VX875 Scratch Registers
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:00.7 Host bridge: VIA Technologies, Inc. VX855/VX875 North-South Modul=
e Interface Control
>          Subsystem: QUANTA Computer Inc VX855/VX875 North-South Module In=
terface Control
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>
> 00:01.0 VGA compatible controller: VIA Technologies, Inc. VX855/VX875 Chr=
ome 9 HCM Integrated Graphics (prog-if 00 [VGA controller])
>          Subsystem: QUANTA Computer Inc VX855/VX875 Chrome 9 HCM Integrat=
ed Graphics
>          Device tree node: /sys/firmware/devicetree/base/pci/display@1
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32
>          Interrupt: pin A routed to IRQ 16
>          Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D64M]
>          Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=3D=
16M]
>          Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
>          Capabilities: [60] Power Management version 2
>                  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-=
,D2-,D3hot-,D3cold-)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Capabilities: [90] MSI: Enable- Count=3D1/1 Maskable- 64bit-
>                  Address: 00000000  Data: 0000
>          Kernel driver in use: viafb
>
> 00:0c.0 SD Host controller: VIA Technologies, Inc. SDIO Host Controller (=
rev 10) (prog-if 01)
>          Subsystem: QUANTA Computer Inc SDIO Host Controller
>          Device tree node: /sys/firmware/devicetree/base/pci/sd@c
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0
>          Interrupt: pin A routed to IRQ 22
>          Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=3D=
256]
>          Region 1: Memory at 80001000 (32-bit, non-prefetchable) [size=3D=
256]
>          Region 2: Memory at 80002000 (32-bit, non-prefetchable) [size=3D=
256]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D=
1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Kernel driver in use: sdhci-pci
>
> 00:10.0 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 C=
ontroller (rev a0) (prog-if 00 [UHCI])
>          Subsystem: QUANTA Computer Inc VT82xx/62xx UHCI USB 1.1 Controll=
er
>          Device tree node: /sys/firmware/devicetree/base/pci/usb@10
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32, Cache Line Size: 32 bytes
>          Interrupt: pin A routed to IRQ 20
>          Region 4: I/O ports at 8000 [size=3D32]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D=
1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Kernel driver in use: uhci_hcd
>
> 00:10.1 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 C=
ontroller (rev a0) (prog-if 00 [UHCI])
>          Subsystem: QUANTA Computer Inc VT82xx/62xx UHCI USB 1.1 Controll=
er
>          Device tree node: /sys/firmware/devicetree/base/pci/usb@10,1
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32, Cache Line Size: 32 bytes
>          Interrupt: pin B routed to IRQ 22
>          Region 4: I/O ports at 8020 [size=3D32]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D=
1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Kernel driver in use: uhci_hcd
>
> 00:10.2 USB controller: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 C=
ontroller (rev a0) (prog-if 00 [UHCI])
>          Subsystem: VIA Technologies, Inc. VT82xx/62xx UHCI USB 1.1 Contr=
oller
>          Device tree node: /sys/firmware/devicetree/base/pci/usb@10,2
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32, Cache Line Size: 32 bytes
>          Interrupt: pin C routed to IRQ 21
>          Region 4: I/O ports at 8040 [size=3D32]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D=
1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Kernel driver in use: uhci_hcd
>
> 00:10.4 USB controller: VIA Technologies, Inc. USB 2.0 (rev 90) (prog-if =
20 [EHCI])
>          Subsystem: QUANTA Computer Inc USB 2.0
>          Device tree node: /sys/firmware/devicetree/base/pci/usb@10,4
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 32, Cache Line Size: 64 bytes
>          Interrupt: pin D routed to IRQ 23
>          Region 0: Memory at 80003000 (32-bit, non-prefetchable) [size=3D=
256]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D=
1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Capabilities: [88] Debug port: BAR=3D1 offset=3D00a0
>          Kernel driver in use: ehci-pci
>
> 00:11.0 ISA bridge: VIA Technologies, Inc. VX855/VX875 Bus Control and Po=
wer Management
>          Subsystem: QUANTA Computer Inc VX855/VX875 Bus Control and Power=
 Management
>          Device tree node: /sys/firmware/devicetree/base/pci/isa@11
>          Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParE=
rr+ Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Capabilities: [c0] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-=
,D2-,D3hot-,D3cold-)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>
> 00:11.7 Host bridge: VIA Technologies, Inc. VX8xx South-North Module Inte=
rface Control
>          Subsystem: VIA Technologies, Inc. VX8xx South-North Module Inter=
face Control
>          Device tree node: /sys/firmware/devicetree/base/pci/host@11,7
>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort+ >SERR- <PERR- INTx-
>
> 00:13.0 PCI bridge: VIA Technologies, Inc. VX855/VX875/VX900 PCI to PCI B=
ridge (prog-if 00 [Normal decode])
>          Device tree node: /sys/firmware/devicetree/base/pci/pci@13
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR+ FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort+ >SERR- <PERR- INTx-
>          Latency: 0
>          Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>          I/O behind bridge: [disabled]
>          Memory behind bridge: [disabled]
>          Prefetchable memory behind bridge: [disabled]
>          Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dmedium >TAbor=
t- <TAbort- <MAbort- <SERR- <PERR-
>          BridgeCtl: Parity- SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- Fast=
B2B-
>                  PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>          Capabilities: [70] Subsystem: VIA Technologies, Inc. VX855/VX875=
/VX900 PCI to PCI Bridge
>
> 00:14.0 Audio device: VIA Technologies, Inc. VT8237A/VT8251 HDA Controlle=
r (rev 20)
>          Subsystem: QUANTA Computer Inc VT8237A/VT8251 HDA Controller
>          Device tree node: /sys/firmware/devicetree/base/pci/audio@14
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx-
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 32 bytes
>          Interrupt: pin A routed to IRQ 17
>          Region 0: Memory at 80004000 (64-bit, non-prefetchable) [size=3D=
16K]
>          Capabilities: [50] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>          Capabilities: [60] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>                  Address: 0000000000000000  Data: 0000
>          Capabilities: [70] Express (v1) Root Complex Integrated Endpoint=
, MSI 00
>                  DevCap: MaxPayload 128 bytes, PhantFunc 0
>                          ExtTag- RBE- FLReset-
>                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                          RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                          MaxPayload 128 bytes, MaxReadReq 128 bytes
>                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr=
+ TransPend-
>          Kernel driver in use: snd_hda_intel
>
> =3D=3D=3D
>
> # lshw
>
> xo
>      description: Laptop
>      product: DA
>      vendor: OLPC
>      version: 1.5
>      serial: SHC1470003A
>      width: 32 bits
>      capabilities: smbios-2.1 dmi-2.1
>      configuration: chassis=3Dlaptop uuid=3D5a6dddd6-4fbe-32d5-50e9-786f7=
411eb8e
>    *-core
>         description: Motherboard
>         product: XO
>         vendor: QUANTA
>         physical id: 0
>         version: 1.5
>         serial: SHC1470003A
>       *-firmware:0
>            description: BIOS
>            vendor: IE8y2D ScD%g4r2bAIFA.
>            physical id: 0
>            version: OLPC Ver 1.00.15
>            date: 06/13/2014
>            size: 64KiB
>            capacity: 1MiB
>            capabilities: pci upgrade shadowing cdboot bootselect edd acpi
>       *-cpu:0
>            description: CPU
>            product: VIA C7-M Processor 1000MHz
>            vendor: CentaurHauls
>            physical id: 400
>            bus info: cpu@0
>            version: 6.13.0
>            size: 997MHz
>            capacity: 997MHz
>            width: 32 bits
>            clock: 33MHz
>            capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce =
cx8 apic sep mtrr pge cmov pat clflush acpi mmx fxsr sse sse2 tm nx cpuid p=
ni est tm2 xtpr rng rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_en cp=
ufreq
>          *-cache:0
>               description: L1 cache
>               physical id: 701
>               size: 128KiB
>               capacity: 128KiB
>               capabilities: internal write-back unified
>               configuration: level=3D1
>          *-cache:1
>               description: L2 cache
>               physical id: 703
>               size: 128KiB
>               capacity: 128KiB
>               capabilities: internal write-back unified
>               configuration: level=3D2
>       *-memory
>            description: System Memory
>            physical id: 1001
>            slot: System board or motherboard
>            size: 1GiB
>            capacity: 1GiB
>          *-bank
>               description: Row of chips DDR2 Synchronous
>               physical id: 0
>               slot: Soldered
>               size: 1GiB
>               width: 64 bits
>       *-firmware:1
>            product: CL1   Q3C17  Q3C
>            physical id: 1
>            logical name: /proc/device-tree
>       *-cpu:1 DISABLED
>            description: CPU
>            product: cpu
>            physical id: 2
>            bus info: cpu@0
>            size: 1GHz
>       *-pci:0
>            description: Host bridge
>            product: VX855/VX875 Host Bridge: Host Control
>            vendor: VIA Technologies, Inc.
>            physical id: 100
>            bus info: pci@0000:00:00.0
>            version: 03
>            width: 32 bits
>            clock: 33MHz
>            configuration: latency=3D32
>          *-generic:0 UNCLAIMED
>               description: PIC
>               product: VX855/VX875 APIC and Central Traffic Control
>               vendor: VIA Technologies, Inc.
>               physical id: 0.5
>               bus info: pci@0000:00:00.5
>               version: 00
>               width: 32 bits
>               clock: 33MHz
>               capabilities: io_x_-apic bus_master
>               configuration: latency=3D0
>          *-display
>               description: VGA compatible controller
>               product: VX855/VX875 Chrome 9 HCM Integrated Graphics
>               vendor: VIA Technologies, Inc.
>               physical id: 1
>               bus info: pci@0000:00:01.0
>               logical name: /dev/fb0
>               version: 00
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm msi vga_controller bus_master cap_list rom=
 fb
>               configuration: depth=3D32 driver=3Dviafb latency=3D32 resol=
ution=3D1200,900
>               resources: irq:16 memory:d0000000-d3ffffff memory:f0000000-=
f0ffffff memory:c0000-dffff
>          *-generic:1
>               description: MMC Host
>               product: SDIO Host Controller
>               vendor: VIA Technologies, Inc.
>               physical id: c
>               bus info: pci@0000:00:0c.0
>               logical name: mmc0
>               logical name: mmc1
>               logical name: mmc2
>               version: 10
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm bus_master cap_list
>               configuration: driver=3Dsdhci-pci latency=3D0
>               resources: irq:22 memory:80000000-800000ff memory:80001000-=
800010ff memory:80002000-800020ff
>             *-device:0
>                  description: SD Card
>                  product: SD08G
>                  vendor: SanDisk
>                  physical id: aaaa
>                  logical name: /dev/mmcblk0
>                  version: 8.0
>                  date: 09/2010
>                  serial: 167437691
>                  size: 7580MiB (7948MB)
>                  capabilities: sd partitioned partitioned:dos
>                  configuration: logicalsectorsize=3D512 sectorsize=3D512 =
signature=3D304f4eb5
>                *-volume:0
>                     description: Linux filesystem partition
>                     vendor: Linux
>                     physical id: 1
>                     logical name: /dev/mmcblk0p1
>                     logical name: /boot
>                     version: 1.0
>                     serial: 0e879075-94ae-487d-b65f-86c6f4814cc7
>                     size: 7MiB
>                     capacity: 7MiB
>                     capabilities: primary extended_attributes ext2 initia=
lized
>                     configuration: filesystem=3Dext2 lastmountpoint=3D/mn=
t/sdb1 modified=3D2021-09-04 23:01:46 mount.fstype=3Dext2 mount.options=3Dr=
w,noatime mounted=3D2021-09-04 23:01:46 state=3Dmounted
>                *-volume:1
>                     description: Linux filesystem partition
>                     physical id: 2
>                     logical name: /dev/mmcblk0p2
>                     capacity: 7572MiB
>                     capabilities: primary
>             *-device:1
>                  description: SDIO Device
>                  physical id: 1
>                  bus info: mmc@1:0001:1
>                  logical name: mmc1:0001:1
>                  serial: 0
>                  capabilities: sdio
>             *-device:2
>                  description: SD Card
>                  product: SU04G
>                  vendor: SanDisk
>                  physical id: e624
>                  logical name: /dev/mmcblk2
>                  version: 8.0
>                  date: 09/2011
>                  serial: 290732065
>                  size: 3781MiB (3965MB)
>                  capabilities: sd partitioned partitioned:dos
>                  configuration: logicalsectorsize=3D512 sectorsize=3D512
>                *-volume:0
>                     description: Linux filesystem partition
>                     vendor: Linux
>                     physical id: 1
>                     logical name: /dev/mmcblk2p1
>                     version: 1.0
>                     serial: ad2652ce-fee6-48ba-be72-86fb96ae288b
>                     size: 64MiB
>                     capacity: 64MiB
>                     capabilities: primary bootable extended_attributes ex=
t2 initialized
>                     configuration: filesystem=3Dext2 label=3DBoot lastmou=
ntpoint=3D/var/lib/random-seed modified=3D2021-09-03 01:06:44 mounted=3D202=
1-09-03 01:06:32 state=3Dunknown
>                *-volume:1
>                     description: EXT4 volume
>                     vendor: Linux
>                     physical id: 2
>                     logical name: /dev/mmcblk2p2
>                     version: 1.0
>                     serial: 8a90ac7c-4c44-4750-83c5-0857f41ade6a
>                     size: 3713MiB
>                     capacity: 3713MiB
>                     capabilities: primary journaled extended_attributes l=
arge_files dir_nlink recover extents ext4 ext2 initialized
>                     configuration: created=3D2020-01-29 04:49:55 filesyst=
em=3Dext4 label=3DOLPCRoot lastmountpoint=3D/ modified=3D2020-10-19 19:23:3=
0 mounted=3D2021-09-03 01:06:32 state=3Dclean
>          *-usb:0
>               description: USB controller
>               product: VT82xx/62xx UHCI USB 1.1 Controller
>               vendor: VIA Technologies, Inc.
>               physical id: 10
>               bus info: pci@0000:00:10.0
>               version: a0
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm uhci bus_master cap_list
>               configuration: driver=3Duhci_hcd latency=3D32
>               resources: irq:20 ioport:8000(size=3D32)
>          *-usb:1
>               description: USB controller
>               product: VT82xx/62xx UHCI USB 1.1 Controller
>               vendor: VIA Technologies, Inc.
>               physical id: 10.1
>               bus info: pci@0000:00:10.1
>               version: a0
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm uhci bus_master cap_list
>               configuration: driver=3Duhci_hcd latency=3D32
>               resources: irq:22 ioport:8020(size=3D32)
>          *-usb:2
>               description: USB controller
>               product: VT82xx/62xx UHCI USB 1.1 Controller
>               vendor: VIA Technologies, Inc.
>               physical id: 10.2
>               bus info: pci@0000:00:10.2
>               version: a0
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm uhci bus_master cap_list
>               configuration: driver=3Duhci_hcd latency=3D32
>               resources: irq:21 ioport:8040(size=3D32)
>          *-usb:3
>               description: USB controller
>               product: USB 2.0
>               vendor: VIA Technologies, Inc.
>               physical id: 10.4
>               bus info: pci@0000:00:10.4
>               version: 90
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pm debug ehci bus_master cap_list
>               configuration: driver=3Dehci-pci latency=3D32
>               resources: irq:23 memory:80003000-800030ff
>          *-isa
>               description: ISA bridge
>               product: VX855/VX875 Bus Control and Power Management
>               vendor: VIA Technologies, Inc.
>               physical id: 11
>               bus info: pci@0000:00:11.0
>               version: 00
>               width: 32 bits
>               clock: 33MHz
>               capabilities: isa pm cap_list
>               configuration: latency=3D0
>             *-pnp00:00
>                  product: System Board
>                  physical id: 0
>                  capabilities: pnp
>                  configuration: driver=3Dsystem
>             *-pnp00:01
>                  product: Motherboard registers
>                  physical id: 1
>                  capabilities: pnp
>                  configuration: driver=3Dsystem
>             *-pnp00:02
>                  product: PS/2 Port for PS/2-style Mice
>                  physical id: 2
>                  capabilities: pnp
>                  configuration: driver=3Di8042 aux
>             *-pnp00:03
>                  product: IBM Enhanced keyboard controller (101/2-key)
>                  physical id: 3
>                  capabilities: pnp
>                  configuration: driver=3Di8042 kbd
>             *-pnp00:04
>                  product: AT Real-Time Clock
>                  physical id: 4
>                  capabilities: pnp
>                  configuration: driver=3Drtc_cmos
>             *-pnp00:05
>                  product: Motherboard registers
>                  physical id: 5
>                  capabilities: pnp
>                  configuration: driver=3Dsystem
>             *-pnp00:06
>                  product: System Board
>                  physical id: 6
>                  capabilities: pnp
>                  configuration: driver=3Dsystem
>          *-pci
>               description: PCI bridge
>               product: VX855/VX875/VX900 PCI to PCI Bridge
>               vendor: VIA Technologies, Inc.
>               physical id: 13
>               bus info: pci@0000:00:13.0
>               version: 00
>               width: 32 bits
>               clock: 33MHz
>               capabilities: pci normal_decode bus_master cap_list
>          *-multimedia
>               description: Audio device
>               product: VT8237A/VT8251 HDA Controller
>               vendor: VIA Technologies, Inc.
>               physical id: 14
>               bus info: pci@0000:00:14.0
>               logical name: card0
>               logical name: /dev/snd/controlC0
>               logical name: /dev/snd/pcmC0D0c
>               logical name: /dev/snd/pcmC0D0p
>               version: 20
>               width: 64 bits
>               clock: 33MHz
>               capabilities: pm msi pciexpress bus_master cap_list
>               configuration: driver=3Dsnd_hda_intel latency=3D0
>               resources: irq:17 memory:80004000-80007fff
>             *-input:0
>                  product: HDA VIA VT82xx Mic
>                  physical id: 0
>                  logical name: input6
>                  logical name: /dev/input/event4
>             *-input:1
>                  product: HDA VIA VT82xx Headphone
>                  physical id: 1
>                  logical name: input7
>                  logical name: /dev/input/event5
>       *-pci:1
>            description: Host bridge
>            product: VX855/VX875 Error Reporting
>            vendor: VIA Technologies, Inc.
>            physical id: 101
>            bus info: pci@0000:00:00.1
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:2
>            description: Host bridge
>            product: VX855/VX875 Host Bus Control
>            vendor: VIA Technologies, Inc.
>            physical id: 102
>            bus info: pci@0000:00:00.2
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:3
>            description: Host bridge
>            product: VX855/VX875 DRAM Bus Control
>            vendor: VIA Technologies, Inc.
>            physical id: 103
>            bus info: pci@0000:00:00.3
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:4
>            description: Host bridge
>            product: VX855/VX875 Power Management Control
>            vendor: VIA Technologies, Inc.
>            physical id: 104
>            bus info: pci@0000:00:00.4
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:5
>            description: Host bridge
>            product: VX855/VX875 Scratch Registers
>            vendor: VIA Technologies, Inc.
>            physical id: 105
>            bus info: pci@0000:00:00.6
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:6
>            description: Host bridge
>            product: VX855/VX875 North-South Module Interface Control
>            vendor: VIA Technologies, Inc.
>            physical id: 106
>            bus info: pci@0000:00:00.7
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>       *-pci:7
>            description: Host bridge
>            product: VX8xx South-North Module Interface Control
>            vendor: VIA Technologies, Inc.
>            physical id: 107
>            bus info: pci@0000:00:11.7
>            version: 00
>            width: 32 bits
>            clock: 33MHz
>            configuration: latency=3D8
>    *-input:0
>         product: Lid Switch
>         physical id: 1
>         logical name: input0
>         logical name: /dev/input/event0
>         capabilities: platform
>    *-input:1
>         product: Power Button
>         physical id: 2
>         logical name: input1
>         logical name: /dev/input/event1
>         capabilities: platform
>    *-input:2
>         product: AT Translated Set 2 keyboard
>         physical id: 3
>         logical name: input2
>         logical name: /dev/input/event2
>         capabilities: i8042
>    *-input:3
>         product: FSPPS/2 Sentelic FingerSensingPad
>         physical id: 4
>         logical name: input4
>         logical name: /dev/input/event6
>         capabilities: i8042
>    *-input:4
>         product: EBook Switch
>         physical id: 5
>         logical name: input5
>         logical name: /dev/input/event3
>         capabilities: platform
>    *-network
>         description: Wireless interface
>         physical id: 6
>         logical name: wlan0
>         serial: 68:a3:c4:cf:8d:fa
>         capabilities: ethernet physical wireless
>         configuration: broadcast=3Dyes driver=3Dlibertas driverversion=3D=
COMM-USB8388-323.p0 firmware=3D9.70.20.p0 multicast=3Dyes wireless=3DIEEE 8=
02.11
