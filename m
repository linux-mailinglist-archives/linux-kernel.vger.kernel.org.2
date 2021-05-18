Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456DA3871DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhERG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhERG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:28:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83376C061573;
        Mon, 17 May 2021 23:27:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 27so4993216pgy.3;
        Mon, 17 May 2021 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQGuujMWoz7ctS+NiJQK1UQkIfCwzUf11oIcBdMR1xU=;
        b=bvFuriLODXVcIJVOWwh0ck6blpd5vo0EDlg23CefiWifKJTQlpy0mdIbHk6yhpgKwE
         31MqnHQLqtu+pWemOGZm0ERashP/LKp2ZqVdAP5NFQW4Jd2SVRU1YVbuxCCKFdiYZYGZ
         5tMlW0T+JI1iOq3hl/6ylGE6u/jdVe4JZ7UITaiSo/TuZOqQLayD9JXMonNdyEZrvHmS
         w/DTZV/vUqd2p09VddK5/0j8CrfW+oS0oV+cXgiN2y7M2HqriPIl2nFz1jq5QHeK3gtu
         eE/BeH7ycyTSdTF2E3moSdB/s6HTPCub9O43BjwyA5AmNGBGcLZivytEZu/bZuANxBbT
         a7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQGuujMWoz7ctS+NiJQK1UQkIfCwzUf11oIcBdMR1xU=;
        b=mCH5r2cTWLAA+tNaC5Uv6I+dCLKkKc8uZhCZyD2ddNTYmaAk3zAyk+S7j5JIMBrgDq
         HRe1wuEfmYMAjIbKkmEYwbCeOuNPY6BwIfe4qrSaj8nwuZHM9mYwDVQdO7GUa9dNhQmh
         O8z0JIaekqjcKiVJrxAoJCyPcnBiMLUvqeEaPArD0J68/EeGiShO01c2VI6+HPXEZKXy
         GpSuWkaIbSAv/hCCCNq86YGsQwoP3HD9e7LVjXEDHK7ZwTHVrFG/osjtBJ3i9z5NAilx
         XCkTYIZFX+ogjW3BUZfKahOEEgaJ+m8kJviw+yCsQ86AJmd7kMjOjXsLQ2wT6UOBcre2
         nwBw==
X-Gm-Message-State: AOAM533lwXZqtjDQDHs4kzWvUQi/qisTbK7l5CnoYfDs0sfmfM050cBz
        cmBYjFK38rEu3GFkTUWfuVg=
X-Google-Smtp-Source: ABdhPJz0txRUcgmBn2DhQ0GHOxAIJ8o4YBeACd2LRg54QFreNOFvy/GQeAAwQE5GS1p7OO/w8ciGfg==
X-Received: by 2002:a63:4a4b:: with SMTP id j11mr3421425pgl.451.1621319224979;
        Mon, 17 May 2021 23:27:04 -0700 (PDT)
Received: from varodek.localdomain ([223.179.151.249])
        by smtp.gmail.com with ESMTPSA id w125sm11105094pfw.214.2021.05.17.23.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 23:27:04 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc:     vaibhavgupta40@gmail.com, Kishon Vijay Abraham <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Gowtham Tammana <g-tammana@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ti: k3-am64-main: Enable crypto accelerator
Date:   Tue, 18 May 2021 11:56:30 +0530
Message-Id: <20210518062630.144154-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Gupta <v_gupta@ti.com>

Add the node for SA2UL including the random number generator.

[v_gupta@ti.com: Add address ranges entry in cbass_main]
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vaibhav Gupta <v_gupta@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  1 +
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 25b702303637..adbc3c0673f3 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -160,6 +160,31 @@ k3_reset: reset-controller {
 		};
 	};
 
+	main_crypto: crypto@40900000 {
+		compatible = "ti,am64-sa2ul";
+		reg = <0x0 0x40900000 0x0 0x1200>;
+		power-domains = <&k3_pds 133 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 133 0>, <&k3_clks 133 1>, <&k3_clks 133 2>;
+		clock-names = "pka_in_clk" , "x1_clk" , "x2_clk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x040900000 0x00 0x040900000 0x0 0x30000>;
+
+		status = "okay";
+
+		dmas = <&main_pktdma 0xc001 15>, <&main_pktdma 0x4002 15>,
+				<&main_pktdma 0x4003 15>;
+		dma-names = "tx", "rx1", "rx2";
+
+		eip76d_rng: rng@40910000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x0 0x40910000 0x0 0x80>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&k3_clks 133 2>;
+			clock-names = "x2_clk";
+		};
+	};
+
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
 		reg = <0x00 0xf4000 0x00 0x2d0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 0ae8c844c482..e2bea44a16c5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -85,6 +85,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00800000>, /* Main R5FSS */
 			 <0x06 0x00000000 0x06 0x00000000 0x01 0x00000000>, /* PCIe DAT1 */
 			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
+			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA2UL */
 
 			 /* MCU Domain Range */
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>;
-- 
2.31.1

