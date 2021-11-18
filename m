Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED11455FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhKRP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhKRP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:59:11 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4066C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 07:56:10 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:baf4:d6c5:5600:301] (unknown [IPv6:2a02:a03f:eafe:c901:baf4:d6c5:5600:301])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 920E52737E0;
        Thu, 18 Nov 2021 16:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1637250968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xFBgvNoKxIt+rGYYd66CKxyErQSt2mh7u9EnEzl9/Ww=;
        b=sGADkhOKzV4Bn3wVKoq8VGNAhPy3oeOal01P+gdvcQyeB6wuncBdC5N8WQWokDMsFyWPjB
        L+m3iDx/crHWEngH0LkJHPzOde6kV1f8MdmMHle33Vz3zCvXBZp9U/Drk8C1v2j2WG5TDP
        NQJTUDVnaPtIWZlVt717ZJwRD9yAMJgLf9RYEimQurwrQkaY5bfiYKmxQTD9lA65HFwq3i
        JwCg0nSm3ylG2PYHqihY/Tb7niBU9u3MZetxzTAitWz4WQqTwAlklp1OweN3C80JA1cssj
        +HbzOk2HjeUEXaw7bRZaqglRY5EiimSsG7o1glvB9mu09kbeWbFP8+igDYp47g==
Message-ID: <bbe5506a2458b2d6049bd22a5fda77ae6175ddec.camel@svanheule.net>
Subject: realtek,rtl-intc IRQ mapping broken on 5.16-rc1
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Date:   Thu, 18 Nov 2021 16:56:06 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On 5.16-rc1, the realtek,rtl-intc interrupt controller driver for Realtek RTL8380 SoCs
(and related) appears broken. When booting, I don't get a tty on the serial port, although
serial output works.

The watchdog (currently under review) also cannot acquire the required phase1 interrupt,
and produces the following output:
[    1.968228] realtek-otto-watchdog 18003150.watchdog: error -EINVAL: Failed to get IRQ 4
for phase1
[    1.978404] realtek-otto-watchdog: probe of 18003150.watchdog failed with error -22

A bisects points to commit 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"). Reverting this above commit and follow-up commit
10a20b34d735 ("of/irq: Don't ignore interrupt-controller when interrupt-map failed")
restores the functionality from v5.15.

Below you can find the DTS that I used to reproduce this on my Zyxel GS1900-8.


Best,
Sander

---
// SPDX-License-Identifier: GPL-2.0-or-later
/dts-v1/;

/ {
	#address-cells = <1>;
	#size-cells = <1>;

	compatible = "zyxel,gs1900-8", "realtek,rtl83xx-soc";
	model = "ZyXEL GS1900-8";

	aliases {
		serial0 = &serial0;
	};

	baseclk: baseclk {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <500000000>;
	};

	chosen {
		stdout-path = "serial0";
		bootargs = "earlycon console=ttyS0,115200";
	};

	cpuintc: cpuintc {
		compatible = "mti,cpu-interrupt-controller";
		#address-cells = <0>;
		#interrupt-cells = <1>;
		interrupt-controller;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			compatible = "mips,mips4KEc";
			reg = <0>;
			clocks = <&baseclk>;
			clock-names = "cpu";
		};
	};

	lx_clk: lx_clk {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <200000000>;
	};

	memory@0 {
		device_type = "memory";
		reg = <0x0 0x8000000>;
	};

	soc: soc@18000000 {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x18000000 0x10000>;

		serial0: serial@2000 {
			compatible = "ns16550a";
			reg = <0x2000 0x100>;

			clocks = <&lx_clk>;

			interrupt-parent = <&intc>;
			interrupts = <31>;

			reg-io-width = <1>;
			reg-shift = <2>;
			fifo-size = <1>;
			no-loopback-test;
		};

		intc: interrupt-controller@3000 {
			compatible = "realtek,rtl-intc";
			reg = <0x3000 0x20>;
			interrupt-controller;
			#interrupt-cells = <1>;

			#address-cells = <0>;
			interrupt-map =
				<31 &cpuintc 2>, /* UART0 */
				<20 &cpuintc 3>, /* SWCORE */
				<19 &cpuintc 4>, /* WDT IP1 */
				<18 &cpuintc 5>; /* WDT IP2 */
		};

		watchdog@3150 {
			compatible = "realtek,rtl8380-wdt";
			reg = <0x3150 0xc>;

			realtek,reset-mode = "soc";

			clocks = <&lx_clk>;
			timeout-sec = <20>;

			interrupt-parent = <&intc>;
			interrupt-names = "phase1", "phase2";
			interrupts = <19>, <18>;
		};
	};
};

