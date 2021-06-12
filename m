Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866273A5024
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhFLSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 14:50:55 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34811 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 14:50:54 -0400
Received: by mail-ed1-f52.google.com with SMTP id cb9so41081914edb.1;
        Sat, 12 Jun 2021 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AkaLNrdh2vimxp/He0IGozYNrPKG32CCBg/tput8n7s=;
        b=kY5mGH5jRDZHQ2g+wLpSi3Bjon3oyvrsWySSetNIWyyrpPxFJp8apUqyi/ZyJB9pLB
         WEnU/1QJ/1okEUnQ5i6Tr5h6GGBV/FWH4ux33OiJqY/4mAve14RFaVWe30oJpy0m1LyQ
         Sd7X9iBG5ODkIi9T9qOcE7GFtwuc2HP5ZbzyKB4ocT2rt1+GzQtWuqJbBV5WQDrDJcXr
         bPKhxWt+kfQANCno0rAT4n1blR6vccR/RP4heuWqtPCGSrXZeM6TOzt0tzykJPP+Kl+V
         bj5VZjF0DV4ltOgb2+A8MIKOYP3NLakiUVW8Zag44fKRtigQVVqCqtKFD8cmfIkdRTGe
         xJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AkaLNrdh2vimxp/He0IGozYNrPKG32CCBg/tput8n7s=;
        b=ZjQ+iANcj5B6vjFjR6VupgUp6qD9KR5GuKO2hH0LhSjMB1HH4uZHIfCf/oPLN8oAlv
         kh2idhtHDzDJEwTz/0nVqQ9+MJVlP0xMHVtRFyTtvaOoUhfU7FgbLdcnY+LrjQdN5CTB
         AqoihXq9hQg3leGV0pUS0yB9MMOzYYG8Xg5S3SYUSlak3jLoqKG6cMDcaBhwXIR9QXAX
         UauJuRyx+FmPhdYdATj2wtBrVsdPqCUMe/Il9lTK5SFjZbMABFMPAn3a/SqqXlYl09i9
         Upn+1D/C4F22mDYGdVTRHg/DqWIfDh9oo3WwsY6qwLYZMGe/VMBiHcP5foyTCXm53Ub5
         Dz8g==
X-Gm-Message-State: AOAM530/JT650l6FtveMqQF8BZu8oWt4Gh2PfvrBJMuXWYhOWyKIzEDy
        mjNq+d7RSi6MjP0Ir1TBoh0=
X-Google-Smtp-Source: ABdhPJw+XKHPcmiUY6C+yc3nz8FUZrfa/fchlm09RALpPMSJdRMusz+2Qe0jzAb25p9Ra/u111b1mw==
X-Received: by 2002:aa7:ce82:: with SMTP id y2mr9623571edv.264.1623523661655;
        Sat, 12 Jun 2021 11:47:41 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f21sm4309933edr.45.2021.06.12.11.47.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 11:47:41 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paweljarosz3691@gmail.com
Subject: [PATCH] ARM: dts: rockchip: add labels to the timer nodes on rk3066a
Date:   Sat, 12 Jun 2021 20:47:33 +0200
Message-Id: <20210612184733.2331-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the kernel doesn't care so much right now, boot loaders like
u-boot need to refine the node on their side, so to make life easier
for everyone add the labels to the timer nodes on rk3066a.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 511311d25..b15cbbe23 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -217,7 +217,7 @@
 				       <150000000>, <75000000>;
 	};
 
-	timer@2000e000 {
+	timer2: timer@2000e000 {
 		compatible = "snps,dw-apb-timer-osc";
 		reg = <0x2000e000 0x100>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
@@ -238,7 +238,7 @@
 		};
 	};
 
-	timer@20038000 {
+	timer0: timer@20038000 {
 		compatible = "snps,dw-apb-timer-osc";
 		reg = <0x20038000 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
@@ -246,7 +246,7 @@
 		clock-names = "timer", "pclk";
 	};
 
-	timer@2003a000 {
+	timer1: timer@2003a000 {
 		compatible = "snps,dw-apb-timer-osc";
 		reg = <0x2003a000 0x100>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0

