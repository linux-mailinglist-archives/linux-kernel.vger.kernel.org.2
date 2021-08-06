Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61563E2806
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbhHFKFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbhHFKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:05:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06462C061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:05:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so12293588edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDSFc/YFGROeBwra2NE5wlZ1pD4ayBay+gG3STbLHu0=;
        b=qfLFEJkym59HwX9J/ELX95EwPqTjAQ4o0ywbuG8nRSkRfjL2XwVd5lyRrV0WGK6pWb
         xKMyBQw6IpzL5KsTzLwzRPUyoTNKKuxmpw6ui5/sl0UXWtYvvdy3V+Kc2f1RhNx6U/e8
         5ag4szrGir0IWddIJ6z/3LXdnHXFhIpjoUwYTm+U2QIANQsJyCauqEFAJYODCBW3rVTW
         ejNJdQZ22P5R/O3LinT1hHSUoNtvDZxM+cKnvWRvaWSLKo1dDbOZdRVzQjPlnrtyBoDS
         AQN3nnC2spsASjdY4SjRx0g5jeaJmJ00Vx0+J/Zy94Mo1U1V4v8y90F1lRQt7eDuI8LR
         l+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WDSFc/YFGROeBwra2NE5wlZ1pD4ayBay+gG3STbLHu0=;
        b=ItzeL3r9XzFZoKti9av6TkDqH+SMyi8WTpcongScM8LG7TrvL5RLFlFmIlysfH/j1Y
         zidAiSqBu2mMAqG68e96lfGjAAfArlxu7gCCQcW6rLE8XsYpsNC86ddu+zbV288X0DHD
         /wXSzaP6ULAnWLIucvGNF3CiAwvfnyKWtcmt4UIfDyMqv7wz8ibZQPY8aWWdAodo4Z2w
         eur1pUuKpIOI6SsyHYOrAQLi70T/L148gTse/rNvZLhEgdsOI+ieWKiXe2uk/r97XJmI
         Nt0DAzUj6maYfzUkPZHg+5yoz2HD4AO3RIYKdbLlcvM8EG3K/GoDZYpId4E1xlDfwFEl
         9x/Q==
X-Gm-Message-State: AOAM532tbeqPeUpkBtvA7Jw3OciznuaeIq8RZOBYHF9HmPmrgiEEz9J3
        T342+2FCvS6H8WKbkBef6h7olmns5EJ4CD0F
X-Google-Smtp-Source: ABdhPJxeU0gz5fAf7JuAKGWgvm+A1QMkSuRIokztt3lVZM5Vwkw8ea9rC+kh7PC5+JpGYxOxh2HmdQ==
X-Received: by 2002:a05:6402:27cf:: with SMTP id c15mr12053766ede.268.1628244304263;
        Fri, 06 Aug 2021 03:05:04 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v8sm2712463ejy.79.2021.08.06.03.05.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 03:05:03 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: zynqmp: Enable gpio and qspi for zc1275-revA
Date:   Fri,  6 Aug 2021 12:05:02 +0200
Message-Id: <839d833133318feeb2755c4431204b0ef4788cce.1628244299.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing gpio and qspio for zc1275-revA board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zc1275-revA.dts     | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
index 66a90483b004..e971ba8c1418 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZC1275
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
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
@@ -37,6 +38,21 @@ &dcc {
 	status = "okay";
 };
 
+&gpio {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.32.0

