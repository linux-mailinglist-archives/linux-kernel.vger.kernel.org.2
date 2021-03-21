Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B7343583
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCUWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:52:13 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:45555 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCUWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:51:45 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 18:51:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:subject:message-id:mime-version:content-type; s=2018; bh=5hS
        d3hGGCIyg0B2WQAm0WqjGTwWPd0h197Oz9aFGe1c=; b=o0xKFnkc510cY0IG4UD
        jVvJJNaBSwE0TIjXXbcHiBMetYA8IUMmwQeVy8Hi/Jtu0CXylS5Va872SdsrQyMr
        7Ycs/hn4nrWM6H1fGYqWBS/CVuWpHPvyGWqlD7iqO+hQYbFx6rcHdHQU8+Cxgb7a
        9fqKkRvDuyg3VUUtt6o+dG/4=
Received: (qmail 19554 invoked from network); 21 Mar 2021 22:44:39 -0000
Received: by simscan 1.4.0 ppid: 19497, pid: 19520, t: 0.3653s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 21 Mar 2021 22:44:39 -0000
Date:   Sun, 21 Mar 2021 18:44:37 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: OT: How to report a HW bug
Message-ID: <20210321184437.56ae13a7@Zen-II-x12.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/iE4b0d3R3u.MaKMtlr248Qg"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/iE4b0d3R3u.MaKMtlr248Qg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm asking how to report a bug in the physical HW here because I can't
think of anywhere else to ask where there might be people who have done
this before.

The HW in question is an AMD 3900X and ASRock Taichi B550 MB. I have
turned both CPU and MB in for warranty and the defect remains.

What happens is this:
1: I get my ASM1166 6 port SATA PCIe 2.0 expansion card and plug it into
the second 16 lane wide PCIe port (my GPU is in the top one). It is
connected to the CPU's PCIe lanes.
2: I try to boot. I get several errors regarding memory and chipset
initialization errors. In particular. The last is error code 94. The
system fails to POST and reboots.
3: I place the AIC into the lowest PCIe port (also 16 lanes wide), and
the system boots without a problem. The AIC works correctly. The AIC is
then electrically connected to the chipset, not the CPU.

I'm attaching the output of lspci for the AIC. Here's the AIC I purchased:
https://www.ebay.com/itm/PCIE-SATA-3-0-PCI-E-SATA-Card-PCI-E-PCI-Express-SATA-Controller-6-Ports-SATA3-X4/114295190520

IMHO, the problem could be:
The Chipset, because it doesn't initialize.
The CPU, because it's PCIe lanes go as far as the second PCIe 16 lane
port).
The PCIe 4.0 re-drivers, because they might be malfunctioning.
The card, because it might abuse the PCIe 2.0 protocol.

So, who should I report this to? AMD or ASRock?
Is there anything I can do to further isolate this problem?
Is what I have written sufficient, or would you recommend that I add some
other info?
Is there any difficulty to trying to file a report with AMD and ASRock
which you would have any suggestions about working around?

Thanks,
David

--MP_/iE4b0d3R3u.MaKMtlr248Qg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci-aic-ASM1166.txt

03:00.0 SATA controller: ASMedia Technology Inc. Device 1166 (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: ZyDAS Technology Corp. Device 2116
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 49
	Region 0: Memory at fca82000 (32-bit, non-prefetchable) [size=8K]
	Region 5: Memory at fca80000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at fca00000 [disabled] [size=512K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee1b000  Data: 0023
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 26.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 512 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x2, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [130 v1] #19
	Kernel driver in use: ahci


--MP_/iE4b0d3R3u.MaKMtlr248Qg--
