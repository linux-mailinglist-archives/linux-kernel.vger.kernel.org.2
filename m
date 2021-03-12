Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A033907B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCLO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231983AbhCLO4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49D3364FD6;
        Fri, 12 Mar 2021 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560966;
        bh=dYV6M61tO7CKph2cwEeRsM8DUMu4Jp31AOjuDQyUfZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lr0i8NnqRRjht4xrRkUfmgtkN6fA8zTuv4k7uOpDhwIvioPQoNvQD+pJo4V4SnDr8
         29hFbI9yMzqK9So0vqDqYRy4A5fqEivoG6Rd1v0MW7xisNOB4Qym3z0wz+wixCdTpY
         oL6gZyl9Ki2huURi27QwpbpNdhpnJMVVHMFNnk0Pxy+/grf1GZiVOs4JJ9lg4KVxNO
         v9O7u5zb8YRXHPBswo1U6GwjRA/jTimHt8Z7IJuWfQoG065vT/2DSum3fre/zhFc3n
         ORUC9iUM/1GTjrSonSj3oZF/pSnVIIaj1RwSX+uc6JK0IaTbr3Tu8dKfMO2TC7i3mc
         A4BLJ1tOfVQjA==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 2/7] dt-bindigns: regulator: mtk: Drop unneeded compatible
Date:   Fri, 12 Mar 2021 15:55:40 +0100
Message-Id: <20210312145545.26050-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The regulator does not need to have a device tree compatible, if it's
part of an MFD. We leave the node name to the SoC specific name (e.g.
mt6323regulator) to allow older kernels to work with the new binding.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../bindings/regulator/mt6323-regulator.txt        |  2 +-
 .../bindings/regulator/mt6358-regulator.txt        |  4 +---
 .../bindings/regulator/mt6397-regulator.txt        | 14 +++++---------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
index a48749db4df36..69f32e1a6702e 100644
--- a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
@@ -19,7 +19,7 @@ LDO:
 Example:
 
 	pmic: mt6323 {
-		mt6323regulator: regulators {
+		mt6323regulator {
 			mt6323_vproc_reg: buck_vproc{
 				regulator-name = "vproc";
 				regulator-min-microvolt = < 700000>;
diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
index 9a90a92f2d7e1..ba1214da5bf7c 100644
--- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
@@ -23,9 +23,7 @@ Example:
 	pmic {
 		compatible = "mediatek,mt6358";
 
-		mt6358regulator: mt6358regulator {
-			compatible = "mediatek,mt6358-regulator";
-
+		mt6358regulator {
 			mt6358_vdram1_reg: buck_vdram1 {
 				regulator-compatible = "buck_vdram1";
 				regulator-name = "vdram1";
diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
index c080086d3e629..2b14362ac56e1 100644
--- a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
@@ -1,11 +1,9 @@
 Mediatek MT6397 Regulator
 
-Required properties:
-- compatible: "mediatek,mt6397-regulator"
-- mt6397regulator: List of regulators provided by this controller. It is named
-  according to its regulator type, buck_<name> and ldo_<name>.
-  The definition for each of these nodes is defined using the standard binding
-  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
+List of regulators provided by this controller. It is named
+according to its regulator type, buck_<name> and ldo_<name>.
+The definition for each of these nodes is defined using the standard binding
+for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
 
 The valid names for regulators are::
 BUCK:
@@ -23,9 +21,7 @@ Example:
 	pmic {
 		compatible = "mediatek,mt6397";
 
-		mt6397regulator: mt6397regulator {
-			compatible = "mediatek,mt6397-regulator";
-
+		mt6397regulator {
 			mt6397_vpca15_reg: buck_vpca15 {
 				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
-- 
2.30.1

