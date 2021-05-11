Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865E37A663
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEKMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhEKMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:16:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E09C061574;
        Tue, 11 May 2021 05:15:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j26so18916015edf.9;
        Tue, 11 May 2021 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQ0s5LoD5X94Z0GW2nwxwYQBIBsONNHPaMRImP4VMGc=;
        b=Zt2Nr3b8+CTR1VU/GW4NvgAtISihSur5Kdw7hsKoNWIkJmjs5j9PzgUisWq4vtAKlj
         2OIZTzLtAGwR9TtwHEoVCBAG680FdmEBNjplQ9BScMNYTzXrYTGLw/lWGIKSwhv3awVD
         2bxr5x1cZ8yb8PczbxyfSb5xblMAvmexHTOORs7tlAXizLK4YZ8iIwWwkVsq2jrFssMi
         NPzGl+CMsnMkeZmIi+t7Sm49BNKe3XcVFYxaP6o/lRTbAEUzOcAuLzvmdO+M/9l9Q1+I
         uidYcRViEeUoa3bnQmX/dw86RrL0LkGVkEyQhP/+ZDm03/oCJfuzaPJ9c+KrPDOE12UK
         1DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQ0s5LoD5X94Z0GW2nwxwYQBIBsONNHPaMRImP4VMGc=;
        b=Gcg/C7JRhcf+e0Obq2Z7fQSvLKy/Rg8GtQpT7HtlVvFOM4W+Kf1oPPuEM9HlwgWQc9
         1NS+Wi0eacKPDxrD/JpxbqdED6kVCtWGHtkdq6AaiKo1kSEgzdnrxwSg/D8aUv5I+8Ul
         06iJzbB+70QF+vsLz8pfmZ2I5eI6ev6rGHvUxbZMlvHy6CTHK0rh9MosxwZ4ROKWTSx2
         6usgcFmtFp6okAi96Em5iEkfeGQtO21W4wa64bQwNgr0NwgEX+Y8GdgQmEDXjHp8+cSx
         bFJJYmhsXnSHokyg9rdLPMr1DGCYei4oNSzIMsa6fxbCis38q5oUy9jDeHeOrhwOc3qW
         j3Vg==
X-Gm-Message-State: AOAM531NpOROVfzAmTlMOofpY/58Oh0+zcBabxnRzfSO2Hr/4Wb2/GJS
        MSeF9NdWG5K1orurUt7ovzo=
X-Google-Smtp-Source: ABdhPJzK67C1PK91gYz+osVlv4eObzxnudZJrAGlPoHalo1MGa+e13efSZEj1pFDdZCK6UFqWNr6wQ==
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr36201408edd.343.1620735324561;
        Tue, 11 May 2021 05:15:24 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.gmail.com with ESMTPSA id g17sm17282574edv.47.2021.05.11.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 05:15:24 -0700 (PDT)
Date:   Tue, 11 May 2021 14:15:21 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
Message-ID: <YJp1WYTXHsSAA0ES@Ansuel-xps.localdomain>
References: <20210511021656.17719-1-ansuelsmth@gmail.com>
 <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
 <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:26:28AM +0200, Ard Biesheuvel wrote:
> On Tue, 11 May 2021 at 04:32, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, May 11, 2021 at 03:24:29AM +0100, Matthew Wilcox wrote:
> > > On Tue, May 11, 2021 at 04:16:54AM +0200, Ansuel Smith wrote:
> > > > Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
> > >
> > > Do you really?  I mean, yes, theoretically, I understand it, the
> > > hardware supports 64kB of I/O port space per root port.  But I/O
> > > port space is rather deprecated these days.  My laptop has precisely
> > > two devices with I/O ports, one with 64 bytes and the other with 32
> > > bytes.  Would you really suffer by allocating 16kB of I/O port
> > > space to each root port?
> >
> > We were talking about this in the other wrong patch. I also think this
> > much space looks wrong. The current ipq806x dts have this space so it's
> > actually broken from a long time. The only reason pci worked before was
> > because the pci driver didn't actually check if the settings were right.
> > New kernel introduced more checks and this problem showed up. (to be
> > more precise, the pci port are commonly used by the ath10k wifi and the
> > second ath10k wifi fails to init because of this problem)
> > If you can give me any hint on how to check if the space can be reduced
> > I would be very happy to investigate it.
> > In the driver I notice that the max buffer is set to 2k, could be this a
> > hint?
> >
> 
> Could you share the output of lspci -vv from such a system?
> 
> I agree with Matthew that fiddling with the size of the I/O space
> range probably papers over another problem, and with the odd
> exception, no PCIe card used on ARM systems actually uses their I/O
> BARs, even when they have them. (I used to carry a PCIe serial port
> card to UEFI plugfests because that was the only thing that would stop
> working if a system configured its I/O resource window incorrectly)

Here is the output of lspci -vv

0000:00:00.0 PCI bridge: Qualcomm Device 0101 (prog-if 00 [Normal decode])
        Device tree node: /sys/firmware/devicetree/base/soc/pci@1b500000/bridge@0,0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 44
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: 08000000-081fffff [size=2M]
        Prefetchable memory behind bridge: [disabled]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 000000004361bc88  Data: 0000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP+ LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Kernel driver in use: pcieport
lspci: Unable to load libkmod resources: error -12

0000:01:00.0 Network controller: Qualcomm Atheros QCA9984 802.11ac Wave 2 Wireless Network Adapter
        Subsystem: Qualcomm Atheros Device cafe
        Device tree node: /sys/firmware/devicetree/base/soc/pci@1b500000/bridge@0,0/wifi@1,0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 53
        Region 0: Memory at 08000000 (64-bit, non-prefetchable) [size=2M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 000000004361bc88  Data: 0001
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM not supported
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [160 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- L1_PM_Substates-
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                L1SubCtl2:
        Kernel driver in use: ath10k_pci

0001:00:00.0 PCI bridge: Qualcomm Device 0101 (prog-if 00 [Normal decode])
        Device tree node: /sys/firmware/devicetree/base/soc/pci@1b700000/bridge@0,0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 46
        Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
        I/O behind bridge: [disabled]
        Memory behind bridge: 2e000000-2e1fffff [size=2M]
        Prefetchable memory behind bridge: [disabled]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000435e8688  Data: 0000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (downgraded)
                        TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP+ LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Kernel driver in use: pcieport

0001:01:00.0 Network controller: Qualcomm Atheros QCA9984 802.11ac Wave 2 Wireless Network Adapter
        Subsystem: Qualcomm Atheros Device cafe
        Device tree node: /sys/firmware/devicetree/base/soc/pci@1b700000/bridge@0,0/wifi@1,0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 54
        Region 0: Memory at 2e000000 (64-bit, non-prefetchable) [size=2M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 00000000435e8688  Data: 0001
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM not supported
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [160 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- L1_PM_Substates-
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                L1SubCtl2:
        Kernel driver in use: ath10k_pci
