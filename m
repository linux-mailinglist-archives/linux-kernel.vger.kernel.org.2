Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE639C564
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFEDMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:12:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75020C061766;
        Fri,  4 Jun 2021 20:10:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q16so5607290pls.6;
        Fri, 04 Jun 2021 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuDgN5MJV883HSyDY5Ap+MjtVQArLbn97dqQsvTZD0Q=;
        b=oDPsgeb9JR4dUuytchkO8oJb/wgkUohBf7z3P29xrRqCPx0qyGcctYlFSx/jgPABaw
         c2agmaCXSYIpBDzBWMrWC1oXOcXaBUKELgHOvKocgwrVTkhsmSjyV7PRzPB6uGKYAdZp
         1V6jTWltatJ/p5+ENyeMIboAixnuDZNDRlSwdhUwYBv1naDGm1vlstwAdQnCINWaV5Bw
         qdicj+8d6Q1HHgLx2VJE1UDsjSVIRkbeF9zL3HYOuq8cCtOJHeeIOHtVN7fAtNylN7NE
         ypuMr6SUDoRaodujp9udMjM3cK7mU0xz1vTPGC07Qptnawl7ifj8auKxte6e9g8kq4rA
         erGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuDgN5MJV883HSyDY5Ap+MjtVQArLbn97dqQsvTZD0Q=;
        b=NI5ojyKAE/0WnW4aTLI2/o5IYhQwSPvyPkczqjLXma08QIzZWEIsGWXKYwrKU0/80e
         KzVne8ngt7niBSIk1DN3jRoIv2i39J/TDqWzNwcl1EIf1V23XAGW7/PKywaTuLcvv7c1
         46Z2uehR0vwEmxfgOzFiQWG1Nqc/fcDftyunRLtThqpBVrn+P1/DLo5LS9vuVpS9cRJW
         md75iWOxsTH6hfPVsiGlFRxTfZmqmpJHqxd11daUDC31XrRE4ier3rcFHIuwN9JqKL0f
         tMMl00mfvCez+VtemNrX2e4Mi7/aLtFAkT0uIbEhH6ZC2d3lntx6c0bH8qfAZxNNtq/w
         K95g==
X-Gm-Message-State: AOAM533v2DjPh3ARmGYSaLxB3zknIlJCTykw3smajz3/VpYuEaKXjEPV
        qmYzpE98WFdrQ5HC4Ow4OPY=
X-Google-Smtp-Source: ABdhPJzf5POh2wGEIBYT/5ja5F3EnhRWuIj4KWfkBknrDt0SUap8pKmqdObziCP6ewpF0wJTKN8gHQ==
X-Received: by 2002:a17:90b:318:: with SMTP id ay24mr19170987pjb.150.1622862615102;
        Fri, 04 Jun 2021 20:10:15 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id u21sm2846888pfh.163.2021.06.04.20.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 20:10:14 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim3: add NNA node
Date:   Sat,  5 Jun 2021 11:10:07 +0800
Message-Id: <20210605031007.411469-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add Neural Network Accelerator device tree node
for Khadas VIM3.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 124a80901084..4aa2b20bfbf2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -13,6 +13,41 @@
 
 / {
 	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
+
+	reserved-memory {
+		galcore_reserved:linux,galcore {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x1000000>;
+			alignment = <0x0 0x400000>;
+			linux,contiguous-region;
+		};
+	};
+
+	galcore {
+		compatible = "amlogic, galcore";
+		dev_name = "galcore";
+		status = "okay";
+		clocks = <&clkc CLKID_NNA_AXI_CLK>,
+			<&clkc CLKID_NNA_CORE_CLK>;
+		clock-names = "cts_vipnanoq_axi_clk_composite",
+			"cts_vipnanoq_core_clk_composite";
+		interrupts = <0 147 4>;
+		interrupt-names = "galcore";
+		reg = <0x0 0xff100000 0x0 0x800
+			0x0 0xff000000 0x0 0x400000
+			0x0 0xff63c10c 0x0 0x4
+			0x0 0xff63c110 0x0 0x4
+			0x0 0xffd01088 0x0 0x4
+			0X0 0xff63c1c8 0X0 0x4
+			>;
+		reg-names = "NN_REG","NN_SRAM","NN_MEM0",
+			"NN_MEM1","NN_RESET","NN_CLK";
+		nn_power_version = <2>;
+		nn_efuse = <0xff63003c 0x20>;
+
+		memory-region = <&galcore_reserved>;
+	};
 };
 
 /*
-- 
2.25.1

