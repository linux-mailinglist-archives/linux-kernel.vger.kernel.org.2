Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7C3C221D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhGIKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhGIKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:19:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B2C0613DD;
        Fri,  9 Jul 2021 03:16:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h2so13059541edt.3;
        Fri, 09 Jul 2021 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QXsQd7k3EtP7JbHV9P2Lkye4Fl7qOSwowTzhkaa8Fgo=;
        b=Fz9/2XKD/N1tODOGkH81ulbr327p/Kr65VN37IEO+Wt8Jo53Sg5/jdWW/iueTxutt+
         TssMGDUFo8ZN+13Zpwgy144wYOzkikYEvFrR7hLhHCwb4s8g3B/ZGJvEvzaqS0oeeJyV
         p4t9LI4CrYtiZdI2wUZxhDUA1Rcy+ra4SgRzCl15fJB5g4cmXtD/Aa9Ytq1PtbhrPjU+
         XY2/aCTo89v1/A457SH7knQ8He2L+zqq0VUEagcBmSJCyuTB8XjJSgraZThGVejeiBGn
         yWBonJUVCp8mzSPlulfbzq5c5jClQqpxE/3Ka7zS5MSLt4fubf5zoxAqTZX+2wndphMR
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QXsQd7k3EtP7JbHV9P2Lkye4Fl7qOSwowTzhkaa8Fgo=;
        b=rad+Q0ngp9UR0RZOgv51CQ+Bg6iUjbqZv6w3QCQC7PGqO8Pbfixm/7qfvivL+NRPTM
         wdi9ZRIgqypXe1ALF4UU0QpaeLwuOlHPNwxxSKXa+EfVncL4T1KGAuDdyUltZmf4BnNz
         Pwn+20+YZEh2dQrWcBtb/vJRwYInA/EUxUVIndWHtkdg9SLlOd345tqPGIQQybmgHG9D
         nGWbLNn1DfKVQNLsqKwqeQyi1e6n3GIbcYkMAwT8KycSO8pySaIvASqIHrMwQlWKap4A
         QZ6T/aO+J6w+o9F/2JV5u5Vs5Yj7vr9DEo8AbMcZwkbZ3j/VCUOzmTn6/DP5KqvCcrUG
         xxwg==
X-Gm-Message-State: AOAM532RI2w1LkXXeYjpXnqiqpX3ycNLTvDn9aTzTaHWBPBh+rMuoMtp
        AM/HvMDh1etSuMOZovlyPrQ=
X-Google-Smtp-Source: ABdhPJxh0VBIdnrLISWqRM+aoh8tzBoX/GhW7ibjDpNPypfVEICyqW9HX4pETTgubfwlv/DRX967Og==
X-Received: by 2002:a05:6402:22bb:: with SMTP id cx27mr7374800edb.96.1625825792381;
        Fri, 09 Jul 2021 03:16:32 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s10sm2118309ejc.39.2021.07.09.03.16.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 03:16:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: rockchip: rename timer compatible strings for rk3066a.dtsi
Date:   Fri,  9 Jul 2021 12:16:24 +0200
Message-Id: <20210709101624.1463-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string "snps,dw-apb-timer-osc" was deprecated in place
of "snps,dw-apb-timer". Rename the timer compatible strings in
rk3066a.dtsi, so boot loaders like U-boot can use the timer node
directly without conversion.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 9257ef6f8..b52ef9254 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -235,7 +235,7 @@
 	};
 
 	timer2: timer@2000e000 {
-		compatible = "snps,dw-apb-timer-osc";
+		compatible = "snps,dw-apb-timer";
 		reg = <0x2000e000 0x100>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TIMER2>, <&cru PCLK_TIMER2>;
@@ -256,7 +256,7 @@
 	};
 
 	timer0: timer@20038000 {
-		compatible = "snps,dw-apb-timer-osc";
+		compatible = "snps,dw-apb-timer";
 		reg = <0x20038000 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TIMER0>, <&cru PCLK_TIMER0>;
@@ -264,7 +264,7 @@
 	};
 
 	timer1: timer@2003a000 {
-		compatible = "snps,dw-apb-timer-osc";
+		compatible = "snps,dw-apb-timer";
 		reg = <0x2003a000 0x100>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TIMER1>, <&cru PCLK_TIMER1>;
-- 
2.11.0

