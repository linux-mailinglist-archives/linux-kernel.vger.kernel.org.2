Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC53A6A39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhFNP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhFNP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F99C061283
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g20so17439933ejt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gSuMMTzPOnnvZGKURHsyvM4CxP9KcSAR0ZUn6v38d0=;
        b=Q65spS39D93TI4DKKgwhJVQEhcDNASELRQfSwQhYccTkXcodOMhRpdo23S8Se1ABoW
         7rqFH3/ArH7CXZ0j6VWzLMWi64dO9ynhmWyR6qDy3wkgxiY1NRNnwsZ6+0BROas9hrbc
         sj5sSlrVd6pVABPDe68TPwLczzdcv0MauXEyz+2fxEIlLCeukCc/k9jjL/Hg+IJIvJ3A
         FY6mR2wbr1cN4RpUP0Eap4KCQ9fT/tcXNb3LjNBBjuc6g8kjdATXkqSzY9+C0q5zQtwt
         TtrDMkj9uO05yaXvsvas39Od652/byvNPADQIKozR2I+DCDfIpSUmAkVKoe7pwHAzKK7
         k1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0gSuMMTzPOnnvZGKURHsyvM4CxP9KcSAR0ZUn6v38d0=;
        b=VCPvaaUwS1x0wV1lvaRO3W7/ySc2x05SkyaqGb9PckpPyYfjSIqP/82AzAgCKIkdfF
         NsO/4Jx+qgXy3VPeI5L3nQucpbgGpcZbzDBCZhrvv555o8sEsoMothiFHPqOWFdg1h6R
         s6aOzMpCSAiSRDZpWyPU/nkL92zTepq6VLPkz7tqPDh62wemLfThuXVAr5m0kC/jshBn
         sSYfPNR7anbgW/QhZZ1AV9dVrkEs/ClwWGp4tSpXcYReVLuz95PFs6FFsn8/MwmwCuJ6
         UomvV9m4P2y/eAF00xnDbgR/5ABVfq9yasE7PFy6aPmMpeYnHZbz2T1zhQ8X3AbNqYXg
         jlEw==
X-Gm-Message-State: AOAM5309VDpzuaIkE1NKK5cKrXf/pG4hEOP1X/MF9W7CMF/JwTLOBdwn
        ot9hW+pLByRM4NnEJBmcRU2747UTbdrwH0sc
X-Google-Smtp-Source: ABdhPJwvMiGaea4OuCUANCmNpeIOgn6X/zthCdRjs+/jsPtj9vMbPSB/qqPsJyjPHkGT6SkTBYRMQw==
X-Received: by 2002:a17:906:3006:: with SMTP id 6mr16179681ejz.73.1623684380154;
        Mon, 14 Jun 2021 08:26:20 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id p5sm7591163ejm.115.2021.06.14.08.26.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:19 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 25/33] arm64: zynqmp: Wire qspi on multiple boards
Date:   Mon, 14 Jun 2021 17:25:33 +0200
Message-Id: <01a69ee6590245b5bee70a2553f6faac0d31ca76.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of boards have qspi on the board that's why enable controller and
describe them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 16 +++++++++++++++-
 .../arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 16 +++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts  | 14 ++++++++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts  | 14 ++++++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 15 +++++++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 14 ++++++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts |  4 ++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 15 +++++++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 15 +++++++++++++++
 9 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index 2e05fa416955..f1598527e5ec 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZC1232
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -19,6 +19,7 @@ / {
 	aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -36,6 +37,19 @@ &dcc {
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 3d0aaa02f184..04efa1683eaa 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZC1254
  *
- * (C) Copyright 2015 - 2019, Xilinx, Inc.
+ * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
@@ -20,6 +20,7 @@ / {
 	aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -37,6 +38,19 @@ &dcc {
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index cd406947ec34..9f176307b62a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -26,6 +26,7 @@ aliases {
 		mmc1 = &sdhci1;
 		rtc0 = &rtc;
 		serial0 = &uart0;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -339,6 +340,19 @@ conf {
 	};
 };
 
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 8046f0df0f35..05a2b79738af 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -26,6 +26,7 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -161,6 +162,19 @@ &i2c1 {
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 3cbc51b4587d..becfc23a5610 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -30,6 +30,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -934,6 +935,20 @@ &psgtr {
 	clock-names = "ref0", "ref1", "ref2", "ref3";
 };
 
+&qspi {
+	status = "okay";
+	is-dual = <1>;
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 4c328569c3ac..84c4a9003e2e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -28,6 +28,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -427,6 +428,19 @@ &psgtr {
 	clock-names = "ref1", "ref2", "ref3";
 };
 
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 99d172867f6a..fb8d76b5c27f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -28,6 +28,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -435,6 +436,9 @@ flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 464a76a13c24..d2219373580a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -30,6 +30,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -928,6 +929,20 @@ &psgtr {
 	clock-names = "ref1", "ref2", "ref3";
 };
 
+&qspi {
+	status = "okay";
+	is-dual = <1>;
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index c9d41d16c3f0..4dc315ee91b7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -29,6 +29,7 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &dcc;
+		spi0 = &qspi;
 	};
 
 	chosen {
@@ -772,6 +773,20 @@ &psgtr {
 	clock-names = "ref1", "ref2", "ref3";
 };
 
+&qspi {
+	status = "okay";
+	is-dual = <1>;
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.32.0

