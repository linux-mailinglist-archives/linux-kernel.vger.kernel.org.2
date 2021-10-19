Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634D9433822
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhJSOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhJSOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:15:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34168C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y26so7748189lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJi+ZlCn+9t1HmHLAVFKllNO+of8NwzGF9ts4wWRjYI=;
        b=uuEyWPS/pV79truckMUZ1bI8r+5W4r04spqHtTD51i5L+be77tLsEh+C2U90tm7Dy7
         JBSolHXmUv4KVltKltkkmrBlawCoduIFFRhVtxkVP5LXJw/hAvLZUoPEoXovnLJiD3aR
         fgR5loldfgjbAW2NPC5J7E2Pty0BCMBHBMseE4StIwa+HIrtLr52muBY1fuB39F+4rFv
         fwxCJWFinMXUooXAIOB2qam3KjwXeArruF5fncaYVGRTwEpIcY9U18h4EyQDjEUXF9mC
         yqOdNA0EiFfSTY4J4Rt8xUXtRKTMbnDRWFa+F9k4Q+io7zWI9UClRyDGPW8W6g4rpRQv
         jTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJi+ZlCn+9t1HmHLAVFKllNO+of8NwzGF9ts4wWRjYI=;
        b=EbCEg7Sey/pIt/+gwRKynAFzFs2aFfjbDVD4KvpiZINx06RoE+0nf+TiZDsCR2ol4v
         DKRfU7TcGcTcxytdKUc+Qhf1iyczX4yo9T/nTPmyR4bHOErsQy8l+oKEvrM5dF/P9Di9
         0fm3ByvvcVGN1LnBVfQQ01agSlByst8FV5NyXIzYLfgAPBTUSAmsS1RZA+T4cu+fvHYK
         f3rDktYNAvvqXKk1JdnITA134wrnEun3560Qzyxdl/GQO7L0s7DOUePaq37HO+jYGk/y
         71Vg2mROBjOyyqkoSLi7+Z1QkEZd97+ua/u5mjZEGdk9IJ97CtQ14dJqArKOW+O05qoS
         GqGw==
X-Gm-Message-State: AOAM533ImAvgNCmY93xyElM5Zd3m+TfPMxxynR/MmsnlrXpRmKVkbTXz
        hfwMV21gSEWZy8UwuaDJ6AEN/A==
X-Google-Smtp-Source: ABdhPJxGaNSW+DRibwRVmL/Ce9KhEbw1nhmcpRfE50Q1Cd2e/1jKGjTJrcS4y3HuGEpxpWiaHrJQNA==
X-Received: by 2002:a05:6512:a86:: with SMTP id m6mr6082424lfu.149.1634652794616;
        Tue, 19 Oct 2021 07:13:14 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id d24sm1957805ljc.2.2021.10.19.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:13:14 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     dinguyen@kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@semihalf.com,
        mw@semihalf.com, jam@semihalf.com, ka@semihalf.com,
        tn@semihalf.com, amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Joanna Brozek <jbrozek@antmicro.com>,
        Mariusz Glebocki <mglebocki@antmicro.com>,
        Tomasz Gorochowik <tgorochowik@antmicro.com>,
        Maciej Mikunda <mmikunda@antmicro.com>
Subject: [PATCH v4 2/2] dts: socfpga: Add Mercury+ AA1 devicetree
Date:   Tue, 19 Oct 2021 16:12:28 +0200
Message-Id: <20211019141228.1271617-3-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019141228.1271617-1-pan@semihalf.com>
References: <20211019141228.1271617-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Mercury+ AA1 module for Arria 10 SoC FPGA.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
Signed-off-by: Joanna Brozek <jbrozek@antmicro.com>
Signed-off-by: Mariusz Glebocki <mglebocki@antmicro.com>
Signed-off-by: Tomasz Gorochowik <tgorochowik@antmicro.com>
Signed-off-by: Maciej Mikunda <mmikunda@antmicro.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 105 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..803702883122 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1075,6 +1075,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
+	socfpga_arria10_mercury_aa1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
new file mode 100644
index 000000000000..d77d0c3d71b9
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "socfpga_arria10.dtsi"
+
+/ {
+
+	model = "Enclustra Mercury AA1";
+	compatible = "altr,socfpga-arria10", "altr,socfpga";
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x80000000>; /* 2GB */
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+};
+
+&eccmgr {
+	sdmmca-ecc@ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+			     <47 IRQ_TYPE_LEVEL_HIGH>,
+			     <16 IRQ_TYPE_LEVEL_HIGH>,
+			     <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-addr = <0xffffffff>; /* probe for phy addr */
+
+	max-frame-size = <3800>;
+	status = "okay";
+
+	phy-handle = <&phy3>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy3: ethernet-phy@3 {
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			rxd0-skew-ps = <420>; /* 0ps */
+			rxd1-skew-ps = <420>; /* 0ps */
+			rxd2-skew-ps = <420>; /* 0ps */
+			rxd3-skew-ps = <420>; /* 0ps */
+			txen-skew-ps = <0>; /* -420ps */
+			txc-skew-ps = <1860>; /* 960ps */
+			rxdv-skew-ps = <420>; /* 0ps */
+			rxc-skew-ps = <1680>; /* 780ps */
+			reg = <3>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	isl12022: isl12022@6f {
+		status = "okay";
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+/* Following mappings are taken from arria10 socdk dts */
+&mmc {
+	status = "okay";
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+};
+
+&osc1 {
+	clock-frequency = <33330000>;
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.25.1

