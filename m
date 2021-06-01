Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0039786B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhFAQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhFAQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:49:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E00C061574;
        Tue,  1 Jun 2021 09:48:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b9so22687326ejc.13;
        Tue, 01 Jun 2021 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHH8YHAlTPU5T8bDwFoNt/piYkwaeBsEh0BIqwvr1v8=;
        b=UWfVn7196iEf7L184gwllFhn6rdJEIWyjJCbY5n2WJCVE3/0likbwUcU+ZHcNxJ5C9
         zzfZqKJJUvFzjm49sXA5z3F2EAoUJIBPIht6iz/Ws2OKkKoSMbHO17MUMNE3tYrz2bwg
         MfXqeEekBVhSH+SAlYqynKa5PbySth8XWvmy2n6gmb24HNn6Qs5zAqFfHRj+j+tYDGHt
         iroOJJcYKWLV/VwUm7q1W1qgKEFMeN2S0qF2WYtjHLUQFW373EIJSyh7Nj1EMERGt6vt
         THXONO63VvoMJsl9CpM/jm97wHpnWKsddcNZcCcAwInnzG8q2Vn8TFk735K30ALmBlsZ
         w8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHH8YHAlTPU5T8bDwFoNt/piYkwaeBsEh0BIqwvr1v8=;
        b=gri6e+rXmhMZypBmy0GZ1r3UyVrqqK+NQqvwVs2KipMm7925qh8UKQ9I6d5qtH2uy7
         P4pFKoS3EAt9f2kNywgUvyi8m59hhWPhux3qPw5Uq6r42FNPxJiFEoSVM4iEawi+Xgph
         ja6RaCJvFm5ps0JTGjV9PgQECVUe9jr/s/re+y6K80lnS8UCqB+ENQW6AYhRlx9PoN0m
         uVQoVM9WV3C/VK//8bXpWdnftC3LrjgzFL18HNEzQNuTuYe4MBgs+xvBE5WUcNnw1At1
         2BjeAjyVFudBj67FKt7s9lp3OXQuobk1VM0V/pzJrvaaox4sGftSO+PBNQg4kWZz1Ie0
         9mgg==
X-Gm-Message-State: AOAM532v+aLi4PUBdoorH2aHieN2yHlovHGXTFlCuUzKKxbwFrymIZJA
        VRdfokry4Mq183gtzHS4ItQ=
X-Google-Smtp-Source: ABdhPJxn8fLUrUgadCnTVAG5yqfmlbvyD3qqaRyr7KxYhhdmAgyN9kCwnpKervVuHajee3iAm0dALw==
X-Received: by 2002:a17:906:1dc2:: with SMTP id v2mr30584241ejh.8.1622566094887;
        Tue, 01 Jun 2021 09:48:14 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] arm64: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
Date:   Tue,  1 Jun 2021 18:47:59 +0200
Message-Id: <20210601164800.7670-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
in phy-provider.yaml has required "#phy-cells" for phy nodes.
The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
notifications.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4e243d72e..248ebb61a 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -822,7 +822,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,px30-usb2phy";
 			reg = <0x100 0x20>;
 			clocks = <&pmucru SCLK_USBPHY_REF>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index bc0bdc3d8..8c821acb2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -819,7 +819,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,rk3328-usb2phy";
 			reg = <0x100 0x10>;
 			clocks = <&xin24m>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a2eba5357..c1a253507 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1418,7 +1418,7 @@
 			status = "disabled";
 		};
 
-		u2phy0: usb2-phy@e450 {
+		u2phy0: usb2phy@e450 {
 			compatible = "rockchip,rk3399-usb2phy";
 			reg = <0xe450 0x10>;
 			clocks = <&cru SCLK_USB2PHY0_REF>;
@@ -1445,7 +1445,7 @@
 			};
 		};
 
-		u2phy1: usb2-phy@e460 {
+		u2phy1: usb2phy@e460 {
 			compatible = "rockchip,rk3399-usb2phy";
 			reg = <0xe460 0x10>;
 			clocks = <&cru SCLK_USB2PHY1_REF>;
-- 
2.11.0

