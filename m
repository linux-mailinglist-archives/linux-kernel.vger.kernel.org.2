Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F414114BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhITMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhITMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:43:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B30C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so48877646lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgkRR7jceSG3sISw9EtlaxuO+Ca79VKVwo29bAvP5fI=;
        b=s4hLOdYrkJWqU9QfUxcZKehIh/nJu0e950CTAaaT16xIiWxBQdXpw1nrOo5VF4EClz
         08QmuTWf6QlU9WYteW5sm3nc6X49dKimoHADfogLU7n5dlP6BZmGrOZjEkrA4qj8PSZo
         W5zWuO7pqTNTXfj9RTc8jdEfSHWEVnEYRt97xnNUQuseq8Y/t+wh6CR8S5i+zSblV9WQ
         Lh+5isxoSGLrosnXmPBmUvRcn5LqIdcP8rVUJaUZmOWjwX3+BNFRwWwe/pskgO9HTjOw
         Ptc0HA7CY5lpRXeNu8FiiT0w5XI/d2I9kzst6o/DCD77Wx2gVRIek2zlzo4dYCbTxe+E
         1fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgkRR7jceSG3sISw9EtlaxuO+Ca79VKVwo29bAvP5fI=;
        b=r3b6+Z/lcEbzCOKEf+z4EyZEc2l4geTpctxBE2xV7+rqXXMXD4BPKuf8BUNNHs4UW1
         aBao/JY9425eraxNtfF4Q739WvSZEyW37vnmu8vn+zKl1HSulXB/MRxmGFA1ZmCzqL8h
         T0N5Yr2p3WoQqWNotmKW82dKD1BlZSd2I706B4BiNmn/yrHmMON3k/qhZCznKaHrDbEo
         J+LTJaRBlPR6QmWdLVksyWUSeT2Uk0AO2HDQ5XRMTpvL/lTI5p+8IxI1SbJMnu5qxoD+
         zwKKjT5RTTODTjNkxIOQv6DBQuACD1aa/q9/C9NgZ9SCqPCXa0ZCFc1C+81tIDXwR9RR
         OVnA==
X-Gm-Message-State: AOAM533hpokDYzED3zdx8KVVpBI2UCF5Y0B7pDZb5ICWrELfiTgr24/y
        89RAiYpIDmly+l91qXtvbuFemQ==
X-Google-Smtp-Source: ABdhPJwSJoLAEAHr8QbQNcp0H34mI/ghiqdYS6h5Nj2nmS8GtTJaaHhL0HdRSzUvFKGHyuLUNnM7fw==
X-Received: by 2002:ac2:4318:: with SMTP id l24mr18814386lfh.145.1632141729202;
        Mon, 20 Sep 2021 05:42:09 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v1sm630944lfo.308.2021.09.20.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:42:08 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        dinguyen@kernel.org, p.zabel@pengutronix.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tn@semihalf.com, ka@semihalf.com, jam@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Joanna Brozek <jbrozek@antmicro.com>,
        Mariusz Glebocki <mglebocki@antmicro.com>,
        Tomasz Gorochowik <tgorochowik@antmicro.com>,
        Maciej Mikunda <mmikunda@antmicro.com>
Subject: [PATCH 2/3] dts: socfpga: Add Mercury+ AA1 devicetree
Date:   Mon, 20 Sep 2021 14:41:40 +0200
Message-Id: <20210920124141.1166544-3-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920124141.1166544-1-pan@semihalf.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
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
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 127 ++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..0a7809eb3795 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1078,6 +1078,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
+	socfpga_arria10_mercury_aa1.dtb \
 	socfpga_cyclone5_chameleon96.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
new file mode 100644
index 000000000000..c13f16afa72f
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
@@ -0,0 +1,127 @@
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
+	aliases {
+		ethernet0 = &gmac0;
+		serial1 = &uart1;
+	};
+
+	memory {
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
+&osc1 {
+	clock-frequency = <33330000>;
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
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
+	mdio0 {
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
+&i2c1 {
+	status = "okay";
+	isl12022: isl12022@6f {
+		status = "okay";
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&qspi {
+	status = "disabled";
+
+	flash0: n25q00@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		m25p,fast-read;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <200>;
+		cdns,tsd2d-ns = <255>;
+		cdns,tchsh-ns = <20>;
+		cdns,tslch-ns = <20>;
+
+		part0: qspi-boot@0 {
+			label = "Flash 0 Raw Data";
+			reg = <0x0 0x01340000>;
+		};
+		part1: qspi-rootfs@1320000 {
+			label = "Flash 1 jffs2 Filesystem";
+			reg = <0x01340000 0x2cc0000>;
+		};
+	};
+};
-- 
2.25.1

