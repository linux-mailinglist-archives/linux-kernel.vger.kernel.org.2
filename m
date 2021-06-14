Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BE3A6A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhFNP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhFNP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64FC0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id og14so17363542ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7lBceymVXyPIWYk/tgF5zZZKiUc/wpcuGpIs/70M3U=;
        b=HG7bJ5j2mZEM1ey7XZwFLfS/q/hIXCiH6pBb/UXyNl7c25M+teLsL8oQyui/ggVUFI
         CedyOy0fp67JCBFWavj0izaSj3EwgiHOTF6rneqifcu2pCY/pzrM8aNTncdwCrP49kzC
         NUkgSwTKBQ2+f3Cswl+OlJjHWhq7W0+///Q9sp2sfNbGRLE5hiooaWhuUrT9S41Sk6v4
         gpvxgeq2DBfzlvY4AJ3MltvQRODnPMbiNmJf7SRVj3GT6HwuT7VhNJG4KQPyQkbMEDj5
         C+e3E5IWFwnxjbTEgrveR/d/Wh5ncLtr7npq5w4w4qNYIzvbMg2dCUQIo/z3Ug61AXDM
         pPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F7lBceymVXyPIWYk/tgF5zZZKiUc/wpcuGpIs/70M3U=;
        b=dqRDleiEGTbT4/54eq/KF8NxyivSwpJJy9vdrrHVuecMcNcO/OiYdkL1qy3nFP0opy
         UYnX8GG1cn7tdlmg/xHKW4FIE58hBJwyOTBFy0AV3sTKTs51J+pKT5CnHDqTA/tsDTE9
         uWpbjElTW9DHxF/pEqu+5fJFqSJhOGbiqyh9MB/md6H0q704vObqEERBhnboIrOrrkBb
         zbmmznj5flU1RGYLX5aN74Obz3icDbFokR5plnXKOjxUAms1DJ4flKEu8m6icf7fvqYf
         mVVPLhV7GDQt1WP/dAKQGtyGgqdK4jTd+I6mw9SZuGQbasgZ0eiXU0U4pVi/PdAXS7Qs
         t2Ng==
X-Gm-Message-State: AOAM53165RkWChM5k114F/Hlj0/7yK05bicXJiBnePicz/TcKrQ5ZVC6
        tiFljPhLbyvaQEpOdy+kdTvnlQOQcRmZXORa
X-Google-Smtp-Source: ABdhPJx2lNLaBs30rWZqqzjAaFYSMy69RB5MGoxgE+w3f6E0AwLl5dcG9/gJCbxlJVsgw7bgJF4Nsw==
X-Received: by 2002:a17:906:c141:: with SMTP id dp1mr16452603ejc.87.1623684375987;
        Mon, 14 Jun 2021 08:26:15 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id n5sm9123119edd.40.2021.06.14.08.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:15 -0700 (PDT)
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
Subject: [PATCH v2 22/33] arm64: zynqmp: Add note about UHS mode on some boards
Date:   Mon, 14 Jun 2021 17:25:30 +0200
Message-Id: <462b95844e7aedb00768035913265d7af90c3b2f.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add note about UHS mode and add no-1-8-v property to zc1751-dc1 board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 5 ++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 460aba6e7990..cd406947ec34 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -370,6 +370,10 @@ &sdhci0 {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5ddcfdf48626..3cbc51b4587d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -956,6 +956,10 @@ &sata {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * 1.0 revision has level shifter and this property should be
+	 * removed for supporting UHS mode
+	 */
 	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4a0f3370bf7f..2c1c4d96fb21 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -951,6 +951,9 @@ &sata {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
 	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 85e9d0e2f9bd..c9d41d16c3f0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -796,8 +796,11 @@ &sdhci1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
-	no-1-8-v;
 	disable-wp;
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
+	no-1-8-v;
 	xlnx,mio-bank = <1>;
 };
 
-- 
2.32.0

