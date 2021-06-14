Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502843A6A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhFNP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhFNP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E5C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so6132706edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItdhOlLXx3JOi7zN07qCOdZ3c1nyE8y5l8oq9hutsv0=;
        b=yI4yALgEWTy3CBu4zybXmePaK0Irr8PujjGXw6TYJ8g2S6f7LTHcdofEQueilkHKKo
         G2/KsrYCKNKWopLG+QzRyF4NmzThB/YptOd2eDwc6Q/XIjK4wMQYsL4wmTigbW6701nA
         wOT4fnBux7WYf6i7R17e30/MBcUH35zVbzu7pW9XyxRRXrmyK8TsPQuue1tTnMPYPX1C
         QdevJ/7x/Yk1M3qYjUWSydJJzB19yGiueZ/FYBgzDJuQh7QRQ7vAU0vbgZMCo/U4hsm/
         R/xxuLtxDqusg3Rjc1+iYYz4yDxs6WHdpy3zAqoxDXVamx1PFZmQXRjb8wZl7q3Z1PHK
         obGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ItdhOlLXx3JOi7zN07qCOdZ3c1nyE8y5l8oq9hutsv0=;
        b=J6p2UALUABwLHJZ5rTACsCOZpOa/CC7Li8HTR4Wr+aa0I60D3ulRzzI1Pv2XHmw/wx
         rtM+r80KcVnjbqABB4cHNSZlkyNlZ0Wkpa5DdKWAha6YxPW/gsBo8r0C30ici8okMA0V
         NZxPTf6ukvDyyUeoPr9b7btIVladyD2mx1yqF+XIJpgiAPo4U1WrFDegTufcHmomkrlv
         0xvZemkijUTt5GKGFmNwkF2WC3ytXVF8bi3IyTl5SQ06VYDXXd2LnnNN9LkdAyuQL0rd
         gqW491tS+3ZaMggTTgItQFc6mWreUHOaa5uP2nbktx6igxnRKSKuLU3Cwi5OUMEdOueW
         Q7jg==
X-Gm-Message-State: AOAM531croRxPOPgKVFDJb1u6/HASvMqcKQX5kNCVyNS9K2PlGUdr/M5
        yotxOk+X55OLTxGPQpdID/SM07LtkE/G0fKL
X-Google-Smtp-Source: ABdhPJwXMgd0HOfGW1YAhy1r6mITXytvHcWYCMD1SmvgIJnDCxLtxHkY2RifdY3QXmf6SPrT9yHSdw==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr17985195edb.295.1623684385702;
        Mon, 14 Jun 2021 08:26:25 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id f10sm9238427edx.60.2021.06.14.08.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:25 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 29/33] arm64: zynqmp: Remove description for 8T49N287 and si5382 chips
Date:   Mon, 14 Jun 2021 17:25:37 +0200
Message-Id: <7557288230567fa136ba3edc004d5bfe4f4c6590.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit 73d677e9f379 ("arm64: dts: zynqmp: Remove si5328 device
nodes") also remove description for clock chips which don't have Linux
driver yet.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 4 +---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts | 4 +---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 048df043b45c..86fff3632c7d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -160,9 +160,7 @@ i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-			clock_8t49n287: clock-generator@6c { /* 8T49N287 - u182 */
-				reg = <0x6c>;
-			};
+			/* 8T49N287 - u182 */
 		};
 
 		i2c@2 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index c21d9612ce04..2a872d439804 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -184,9 +184,7 @@ i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-			clock_8t49n287: clock-generator@6c { /* 8T49N287 - u182 */
-				reg = <0x6c>;
-			};
+			/* 8T49N287 - u182 */
 		};
 
 		i2c@2 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 4dc315ee91b7..dac5ba67a160 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -475,9 +475,7 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			si5382: clock-generator@69 { /* SI5382 - u48 */
-				reg = <0x69>;
-			};
+			/* SI5382 - u48 */
 		};
 		i2c@5 {
 			#address-cells = <1>;
-- 
2.32.0

