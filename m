Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46CF3A6A32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhFNP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhFNP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5DC0611C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g8so17366491ejx.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIIPf/rVDazF1Cu6Pp5jF9Ix3WsprKigp0yGfmEr25U=;
        b=iAz4f/xBbtkY3AYctaPRA8DB2vzul2OSrBZ90ROJrbwcyhd+AoP5wN0SfRlUJb1oTA
         BcG3BAxb1HAxrdBNQCI6e6QWMxBsH7K9+HZz/D2GHWphtACjWBcQljUK1kc4v4F6iY9N
         pK0mmaUChvFT3yKR+1lwHz3DXnhz34LG/OTKYBNZf/nVpR0mkXW/ZTwbV8v1sVN+aLK5
         TuaRkquusM/plvRTfoHYlXNcedNjLadSjmR4DSHTxqbWEfKwU1dC+RNb1RDEEpZXYUmz
         I5RlAeabNiQ+pp+9pXSQP/oWcSezfxiEXRiEi7n8AA9x4qGAPNzGI+zLMco4OVSSk3c5
         ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uIIPf/rVDazF1Cu6Pp5jF9Ix3WsprKigp0yGfmEr25U=;
        b=A/13jks1Sh7IDsnxyfKAwLZLAP20B5jN9pzQtbst+o8qRpOOWUCRlE1Az8w45Ys52v
         yftOqQrd3OtyxtDq5jrB6xDskDMoZGrJueJzIwUVOinS7hLZ6FfgNyGJ6TJ16+3R7s9Y
         M9nzLfGsjlMP2sFOTpEGdp/Hg3krLt0bIOYU+W2minHktW8GcG+hReWCYWkI047Wd75/
         iDDS8DkFyfGeO2AldxZYyDxlPchDOYu93fLCW8OcXKzwLLZAQh0VY4w628rCMJvHaLSE
         sAaFUOw5EzfY8z0IxjpxMFFs4nz0CbulbyAb0YbywIqboysH/FPZgKsTi3eqR05vbLNL
         UXPg==
X-Gm-Message-State: AOAM531SEWdrZiyBEiyX4793h73NWRnxznogWwRkHc7LSwnY2nbEtwG7
        97BIDNyekIB0N+vIJmz8G23x0+cbK6NDhXtf
X-Google-Smtp-Source: ABdhPJyxOgoYNEiSM6KdbKJLH1VaDNbu7OfZUgt6+tWaJUY/8p8L/YwWXA8RgxHoY5CRrOzWionDHw==
X-Received: by 2002:a17:906:86d2:: with SMTP id j18mr15425424ejy.180.1623684387146;
        Mon, 14 Jun 2021 08:26:27 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id kb20sm7631297ejc.58.2021.06.14.08.26.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:26 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 30/33] arm64: zynqmp: Add support for zcu102-rev1.1 board
Date:   Mon, 14 Jun 2021 17:25:38 +0200
Message-Id: <38bbbeb885f4d9ba466c43ab9b4d25190a3552fb.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zcu102 rev1.1 compare to rev1.0 is using by default different DDR memory
which requires different configuration. The reason for adding this file to
Linux kernel is that U-Boot fdtfile variable is composed based on board
revision (in eeprom) and dtb file should exist in standard distibutions for
passing it to Linux kernel.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/arm/xilinx.yaml |  1 +
 arch/arm64/boot/dts/xilinx/Makefile               |  1 +
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts      | 15 +++++++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index f52c7e8ce654..a0b1ae6e3e71 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -87,6 +87,7 @@ properties:
               - xlnx,zynqmp-zcu102-revA
               - xlnx,zynqmp-zcu102-revB
               - xlnx,zynqmp-zcu102-rev1.0
+              - xlnx,zynqmp-zcu102-rev1.1
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 11fb4fd3ebd4..083ed52337fd 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.1.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
new file mode 100644
index 000000000000..b6798394fcf4
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZCU102 Rev1.1
+ *
+ * (C) Copyright 2016 - 2020, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+#include "zynqmp-zcu102-rev1.0.dts"
+
+/ {
+	model = "ZynqMP ZCU102 Rev1.1";
+	compatible = "xlnx,zynqmp-zcu102-rev1.1", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
+};
-- 
2.32.0

