Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF466354FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbhDFJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240602AbhDFJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:27:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:27:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l76so9908680pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJDxiGn0zb+AtBhh3GrH3c02J/dSNj0T0Os6e9JU2HI=;
        b=CkAK3AMNLVaTU0AJ+BKXafxyyc2oHDGM5ISRrZstIeYm0ynPQZLoUEbNCbeyNys0US
         wvN6aKbq1RQwZcbDiughkylaiLEy5dzBC5DOItvgLBPmNMJskYLL8TfUaI9vtKagynM/
         tJ+NdQww5Jl1iuVgbSIele56yUgv/6Zf1Fm14khEApXkHmRhy4xVSWdIpbjyQVhhapth
         XXlnJmkhM4cRnqZMS9oAg7MaIJE9REDQNDPj0PTC5azcN4V9DgsjVdCjhdEcZ0WiPAF7
         yln8aVHSakNPUsVmCLU7eAngNHG7lT3F63G6olwtImNY8A354i+NEIuidgqUB73U0eC2
         gpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJDxiGn0zb+AtBhh3GrH3c02J/dSNj0T0Os6e9JU2HI=;
        b=ffErsr8dmpeLCXJt7GPlSqpypEGItJMriVq7zzQMrL8DY9TXdurMxB7/tiMdOgQdlk
         nWOj3jDH/xInL5OvrpOyAB7R+jnLI6ychBzM6qrWYRm3iakT+QRo382ciOMImncS86Cc
         l8ulOC3l4oUqJGy/WRNIcf/OesGkVdPF0K5Be+lr+ucHmDFWiC2wce/tAvKPg2tX7tgN
         aOIKRZUFqZKBlxUYmGegRwN0ckcUCTP83ploE9uFozgmAalCYiLaiF5Y/0INzL64baVB
         iEw9Alc9oagmHfCQi9llxhFFgTUfbMUnA5OdbWmL69HaY4YJBk1lBv+gxLWxTQ1jzsZB
         HRIg==
X-Gm-Message-State: AOAM533Ky6bZDHHQoh0dpQja05Ou1Cu6YjAZedZ3+467tV4DpoI+u2wk
        jG8GZuvrw7s86Qz98nVSWavvqg==
X-Google-Smtp-Source: ABdhPJydGIUF/6dUeUWIt/R7Abd1V20Uua9AfyQ1Nildjd522JxEtojvsjGsv0bmaULXYZeNuwupGA==
X-Received: by 2002:a63:74c:: with SMTP id 73mr26216577pgh.200.1617701225074;
        Tue, 06 Apr 2021 02:27:05 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w7sm13685589pff.208.2021.04.06.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:27:04 -0700 (PDT)
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
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v5 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
Date:   Tue,  6 Apr 2021 17:26:34 +0800
Message-Id: <20210406092634.50465-7-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
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

