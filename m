Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC13F2991
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhHTJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237305AbhHTJyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:54:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8A98610CB;
        Fri, 20 Aug 2021 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629453228;
        bh=1QdJBOoZoyIJQPmYOqhp2bG3Jvg+Tf3qJk1RsSPDcEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GT07E+axk3OezULnXso+VhxnGjRocWU2hCt353jKnSyQvW9iAHv5pG+9ADnIk8MXw
         oPB1vuWpaHbmeMRWTzi7nNj0A0xZLoK8jTtjZDyx2vFYyd1QboGNtiiQJROheg5ps3
         WZv9X05EGzVZ1dU4GRIvUUfF7yXHZaY6st2ZEFvyIheEgdPHrzPDqF84XIm+O8EE4d
         G5lQkTzhgvZ71AgaKje75vyj7Mugjk5cO43f4bvI0IZx2u7PcukGBpTDFOSZ8ZFUbh
         0NASL/PR/zl3tTwBEfHY72bGaQ+G8EuDDegZmOLkup4wg5FbBUFyaF5ZNC5/y3GYg/
         TPtz/0GyrjBdg==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
Date:   Fri, 20 Aug 2021 12:53:40 +0300
Message-Id: <20210820095341.5619-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820095341.5619-1-rogerq@kernel.org>
References: <20210820095341.5619-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree core schema [1], status parameter of nodes can be either
"okay" or "disabled".

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/dt-core.yaml#L36

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 66fec5f5d081..acac242ebdf7 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -159,7 +159,7 @@
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index ad4e22afe133..5e85f000acc3 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -183,7 +183,7 @@
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index e200533d26a4..a6cbff4cfe20 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -132,7 +132,7 @@
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-- 
2.17.1

