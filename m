Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B818639A09A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFCMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:13:03 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:37478 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFCMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:13:02 -0400
Received: by mail-ej1-f54.google.com with SMTP id ce15so8882331ejb.4;
        Thu, 03 Jun 2021 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7PO0CGCpV8AsN/73yaXhgONOIEZI3c1iQNVrhqwDq1U=;
        b=jYyg4ljpEQ8GjezGk/Hce31rsXKv50yJSkfMDdt3+G11mbrDn4vOGQPVRk/9ir6dEf
         RbPlS88AC1XR8VNs/4/C4LnCGWJYW/DnUHK0ZaVEs85LLqwI7t2pqbsao6f6SFsNedHk
         6aShLMCWTUFs5F+tq7vaA4WuZw/piIsEAHKD4PSkQ1VZVykkzjaHppuSFmhjPlBjMqEZ
         QVjhu/9Hx1VJKsh0uEWWrRyDEB3uIKu7WoKFKuSdd9UEnT98/AErRAjDZyKIpvmyT2ti
         qGaMx9GgohDoJL0Ld0Q9gyeLhWaRSFPpky17YdolXjOQp7Shvlk3ri78oynVUg7CkMmT
         JOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7PO0CGCpV8AsN/73yaXhgONOIEZI3c1iQNVrhqwDq1U=;
        b=Za3mbqzdpx5vPt+BFBFgvXiD+OFwLC5arxSikV3Seu1BQp5e9cfcWnhL6HzZUuDDDM
         JcvkRZV6reRT51pHaBNvWe8qoyT1Tu3IxGYeu1YvTbHt8LcRPGT3L8a+GnAwCXZGfIL1
         TJtcGuE/amzhMQjiySftZvBVBiRR00bpVHAcktgba06Y0COY7kZmONzGWJclWWS5ALzW
         p7H2UlQ1BCG/NWPMqkV83sDd5bizsvyIbMm2C/X3MdX8vJtBYI6m5faXODdLe1heduH0
         xBHKo7yww19YfkXXHJz0CTeQmakUfiPkoW4AV5QuSFBT7vfnJGbd8rpZtyG+j9HrIyJU
         BCGw==
X-Gm-Message-State: AOAM532WZYQd2zYT/L9PVQsUS6o0QKdhaUN8KQ45L/0B4EXknpB5HLR6
        U8Xb1Uxon1oJtPSSWCVhuLY43whHWVrUXw==
X-Google-Smtp-Source: ABdhPJzyWrNlOg4d+ANkP/HpgRnB5moybwkyin/NQLNomD+w8DUwGh8hRS1MCB1gQxVYTJqbwTJXMQ==
X-Received: by 2002:a17:906:4747:: with SMTP id j7mr30290606ejs.419.1622722217530;
        Thu, 03 Jun 2021 05:10:17 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id de19sm1703813edb.70.2021.06.03.05.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 05:10:17 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: remove #phy-cells from usbphy node rk3066/rk3188
Date:   Thu,  3 Jun 2021 14:10:10 +0200
Message-Id: <20210603121010.4315-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The review process of rockchip-usb-phy.yaml was not finished
when the patch in the link below was already applied.
Remove the unneeded #phy-cells property.

https://lore.kernel.org/r/20210512122346.9463-4-jbx6244@gmail.com

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 -
 arch/arm/boot/dts/rk3188.dtsi  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 30dcf557e..511311d25 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -684,7 +684,6 @@
 	usbphy: usbphy {
 		compatible = "rockchip,rk3066a-usb-phy",
 			     "rockchip,rk3288-usb-phy";
-		#phy-cells = <0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 3a0c50026..b36fcdd9a 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -644,7 +644,6 @@
 	usbphy: usbphy {
 		compatible = "rockchip,rk3188-usb-phy",
 			     "rockchip,rk3288-usb-phy";
-		#phy-cells = <0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
2.11.0

