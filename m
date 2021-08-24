Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12193F5C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhHXK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhHXK7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:59:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D451E61214;
        Tue, 24 Aug 2021 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629802744;
        bh=IDTwvuQgd0ZlplUnQ8rCLzRXVLaw4Fgh8/mLJlipugs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+Uhtt81bWRF/WSeP+tD7Z7xQPbSWNnOkbJPZTK55N6Dj9420vIJZkAA6U85jF+vb
         yNB1shNZ1NuuqmXvscziepgMiZGMmrpQJBiLoBoMKPupV0Qx8Glt0G0PPaTCYsJ8XC
         woRQnWECjeR2JWhqQkaNLRNpYduNqA0cpcSP5rzhr/Luy7E2Q7n1Q6rdqB5kWx48LW
         lHLemkWghG45yZFztdhPzsEYNBoUjH4mzSV1rhM6rkrAl0P/OCtidiD5eFBGui68bx
         rVBdXu3bLZ7mWXRYolSVHbEAumQx+kPItZA5Wr1oD33+q609sber9Ub8pK2RIlhYRD
         SlGysmBPHdboA==
From:   Roger Quadros <rogerq@kernel.org>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: keystone-k2*-evm: Fix mdio node status to "okay"
Date:   Tue, 24 Aug 2021 13:58:57 +0300
Message-Id: <20210824105858.19496-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105858.19496-1-rogerq@kernel.org>
References: <20210824105858.19496-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Device Tree Specification [1], the status parameter of nodes can
be "okay", "disabled", etc. "ok" is not a valid parameter.

U-boot Driver Model does not recognize status="ok" either and treats
the node as disabled.

[1] https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3

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

