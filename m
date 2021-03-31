Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04734FCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhCaJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhCaJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:26:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FACC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:26:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d8so7596058plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yP7PEulAPK6UHzRxTLeSHifkookZOtRjzWBAZ0O/gdc=;
        b=LOw7EcVTffm/NjdpGaGKUcEGQ77gQ9JBGdonP44rzUgXmMgCpaNUUehuHZr1fxV1UH
         3BBm56IlXAYsVcHNKpUz4rfO9dQS24nWfBTjUsvikelk59OREv70zUWGBbH2weoPqb1v
         fe5f2NqgE0tBYaHEv53mPjfxC0q//a/k26g7ERe1p40gF7ZDAu55vDVITOsHtel4i7gk
         t193rAIOVpfvOXumSpeM5SWmZTcuFe8Ui9c0OnT1wU6EWF4zKZPgVgDWc6s3/YmvsIVs
         DSj7O3ADkHdwvuty7xC835x7GQzPyJUO+6tIJue0z3CAXUBR/aUoKr6JELz2lo+C+iNH
         gfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP7PEulAPK6UHzRxTLeSHifkookZOtRjzWBAZ0O/gdc=;
        b=seKVTk9rHNtaRz7fI+aLCptjMZvG0uoG8K/elOyprZvaUt249UAXGxBoo0bIxFv6Po
         yYEvxWcqsbSSssao77IkPlXmiUX05rZsukTXX8c3CNR5gLsjj0xqyUV0xqQogC9PHadO
         oELbnZUuCq8uyJNf+cRLAJzIeOoc2QYQJA9IYA4eE3ZMr9Js1yBCfTRF5fwRb+yNMUhn
         +mVigDaMlYSVn3aoPVnLUQywlF2+uzSpe2WCU/uIQpYvdKo8zi4v/zr4nYtt1c2PxDYV
         dMM9yTDRhs0rr1ztdx2/k1g2StmbkTWmVUZkpzjRqjtvtOQLJ5uNmNXYItHGnzINzzCL
         DpKA==
X-Gm-Message-State: AOAM530Z32FV+G8nnOKZkvQzUt31E9lLVndfNCjX+eqZoHAVff9Dn756
        nWy32oNBVbIjnIWsEaQEgK9mrA==
X-Google-Smtp-Source: ABdhPJyOcOzTnUY5eHiAJ1S0x1EGTnxPs4BI8SbPuOMDe+Jv2va6wUKiS7UneRWEWjd/DWnW7Vlmhw==
X-Received: by 2002:a17:90b:1987:: with SMTP id mv7mr2512728pjb.152.1617182799984;
        Wed, 31 Mar 2021 02:26:39 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 143sm1726505pfx.144.2021.03.31.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:26:39 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v3 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Wed, 31 Mar 2021 17:26:05 +0800
Message-Id: <20210331092605.105909-7-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331092605.105909-1-greentime.hu@sifive.com>
References: <20210331092605.105909-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index d1bb22b11920..b2317c8e3a80 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -158,6 +158,7 @@ prci: clock-controller@10000000 {
 			reg = <0x0 0x10000000 0x0 0x1000>;
 			clocks = <&hfclk>, <&rtcclk>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 		uart0: serial@10010000 {
 			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
@@ -288,5 +289,37 @@ gpio: gpio@10060000 {
 			clocks = <&prci PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
+		pcie@e00000000 {
+			compatible = "sifive,fu740-pcie";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			reg = <0xe 0x00000000 0x0 0x80000000>,
+			      <0xd 0xf0000000 0x0 0x10000000>,
+			      <0x0 0x100d0000 0x0 0x1000>;
+			reg-names = "dbi", "config", "mgmt";
+			device_type = "pci";
+			dma-coherent;
+			bus-range = <0x0 0xff>;
+			ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
+				 <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
+				 <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
+				 <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
+			num-lanes = <0x8>;
+			interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
+			interrupt-names = "msi", "inta", "intb", "intc", "intd";
+			interrupt-parent = <&plic0>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
+					<0x0 0x0 0x0 0x2 &plic0 58>,
+					<0x0 0x0 0x0 0x3 &plic0 59>,
+					<0x0 0x0 0x0 0x4 &plic0 60>;
+			clock-names = "pcie_aux";
+			clocks = <&prci PRCI_CLK_PCIE_AUX>;
+			pwren-gpios = <&gpio 5 0>;
+			reset-gpios = <&gpio 8 0>;
+			resets = <&prci 4>;
+			status = "okay";
+		};
 	};
 };
-- 
2.30.2

