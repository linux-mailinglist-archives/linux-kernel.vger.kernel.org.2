Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA07426C65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhJHOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhJHOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:10:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672EC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:08:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n8so37661850lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gttg+v6XbDIarAgQi1Ce3aR1kSoKgCW6Taf8X2Jr5ZQ=;
        b=OiYiJt/fIyBMC+P3XVgVgk8OtW58yDWtJSv++nyw1MeV8Zo+hmC4r4oUEsAcgEnch3
         FeuJuDRMIDhzRtCOi5h9yjht5K/Yy6xQLNwUnAv+1mNlc6x92Y7DmzbQ3HUpTVqZLAka
         GfzSLcKBhO02V5mlrdzJ7eruTtwGySzqMmtT1/k2cx2rReLZ2HAN8R+AmJlBPOt9j5vt
         Vo/p8kI70JT/jiP2qiy/NvT+6kbGCZ2uJ1qPmYdaY4j6ALxV1LxQFylPzS02n+vpLP5L
         p4CxcKEPJkWrs6HpuoCO0gvZWY2Dmti/PAPwuSt8BCMMBn6zOciVNZvyJFbj9aohl2/m
         IJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gttg+v6XbDIarAgQi1Ce3aR1kSoKgCW6Taf8X2Jr5ZQ=;
        b=FNxrKVPfZUUPG5EEURFMF7bdHBN6sr7CwIKhYuHldzPQ3WsPJuZKiT8WAq6mqagqwt
         Se5v2C8vna9/eLTy8mjhAMbzuv+FRLoLT0Vpt9CzSCoGMVi33d20JMvkXNmrGZ+ZvgwE
         +vGhg3UbGMB009kGQFZslkUGZkBQmvxiQIM1bBh70BDWw1N2aZchil3tOBkKFph0Ha3a
         t84AbWy0oK6j+WyIBNlz1kW7zbx7Qnf8E3O6lz0RXMCgIVrlXA6Te8moMR/Griu6DIGz
         QlL2d7Cfj1+fAO4BGrAj2HaJ367NB+c8wJ2/q9doW8lz4o7udQVruuzE/wA8B9OU/kIv
         +Hnw==
X-Gm-Message-State: AOAM533yYoF+xz8ThNr1NjSmrZLf2Xx8Rz0sGgD0ydbUmmXf3v3qHpNh
        BmailFUcnajHhr2Q4EQJYRszjA==
X-Google-Smtp-Source: ABdhPJx6Y0vAbnM8Fk95LZoJHxmArUZdZbwbvSH8XCOCNhaj/aRtIkpg+t5fPkZH5HwF8oaz0wq38Q==
X-Received: by 2002:a05:651c:997:: with SMTP id b23mr3885319ljq.325.1633702081587;
        Fri, 08 Oct 2021 07:08:01 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id j23sm252667lfm.139.2021.10.08.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:08:01 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@semihalf.com,
        mw@semihalf.com, ka@semihalf.com, tn@semihalf.com,
        jam@semihalf.com, amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>,
        Joanna Brozek <jbrozek@antmicro.com>,
        Mariusz Glebocki <mglebocki@antmicro.com>,
        Tomasz Gorochowik <tgorochowik@antmicro.com>,
        Maciej Mikunda <mmikunda@antmicro.com>
Subject: [PATCH v3 1/1] dts: socfpga: Add Mercury+ AA1 devicetree
Date:   Fri,  8 Oct 2021 16:07:35 +0200
Message-Id: <20211008140735.3290892-2-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008140735.3290892-1-pan@semihalf.com>
References: <20211008140735.3290892-1-pan@semihalf.com>
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
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
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
index 000000000000..2a3364b26361
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
@@ -0,0 +1,112 @@
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
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+	};
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

