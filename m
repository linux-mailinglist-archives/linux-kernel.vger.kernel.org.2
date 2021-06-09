Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D893A1331
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhFILsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhFILsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007AC061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:46:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d184so3852013wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTvDkENCPab09HgXDxlMsoxGhYemDjuw3++n5X0d3bU=;
        b=NeBmF6OH5rUUh2pAh9vy9F6ha1ygMw5OyFOoS6PiY9MBzaAE9Du3uuiXw95tFzaMWQ
         x9l1JMfesm1LKHCoSstV1WDrUjA2JvFhCP/wh8Iogr/GgrLBOXzpgg6JFpurxXG9QcGD
         spNALgrzBRRbWXWNhthMLv8lkZI5B9Uau/wT3TvooqzJnsR03Fxp8WwKWHVPoekULsfq
         H3XEtIEDfDOXmtuSnb8lUssSDOjUQpDJG7pQoKz3Z2Uw7TeOp2A/5gtEbb2AMJwu2ZCY
         UpxObckTraMizySTeZpOXkrGeD36+gDWxrR2sR5aepO6SjFPocvyhsmkGuw1nKxoiI7+
         re4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hTvDkENCPab09HgXDxlMsoxGhYemDjuw3++n5X0d3bU=;
        b=anQ7r/ke/OiWNHx584xStbhqb7YPuAJsnq0Hje/b/uDj+TVD3T4XjLhKFiPxJMeRiB
         IT+aE0U8n9MTo+O4roWbQLrOxl+ioIp0xDmGRRBkjG8b7wqBLNxcgAZM6vA9pLL+isnq
         1IAw9nO9XRqHAnytKo9gQniJp/0p2eeD8rn1TMEBssv6iT8N30NiJcS+Yza+z0BY2jsr
         NM3XxWpIZJ2jYXwNSn9O9XFHCsn5/EowMW46q8JccoBef1MCdDMP+0LWp4T0oLQ1HdF2
         DM5rjGuzhlgLOyWjoMvxTFbU+EqTAEt6jaweT61aBs7qPldwvLi+xDp/1WQu/FDyfyQr
         hOQg==
X-Gm-Message-State: AOAM531N6lw+mbF6TuX+hoVsvlmv0oMrkxpNCVpiEXv0vugKAfqeoT7D
        9bxDLSi7zLHKm5pWdSrBFy7XG4sMLHuPn5MI
X-Google-Smtp-Source: ABdhPJx5rULiDy17JCZyiDmUA+Yl0k7L9Wc4WOSx+8SO31YI9MwVMq6LLXIXfQj5/lBc4GXpprWtHQ==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr22222801wme.43.1623239164153;
        Wed, 09 Jun 2021 04:46:04 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id 62sm25881849wrm.1.2021.06.09.04.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:03 -0700 (PDT)
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
Subject: [PATCH 25/31] arm64: zynqmp: Wire qspi on multiple boards
Date:   Wed,  9 Jun 2021 13:45:01 +0200
Message-Id: <80671218c97ad2188df476cf1b49bcf6f64785df.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of boards have qspi on the board that's why enable controller and
describe them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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
2.31.1

