Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB439339081
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhCLO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhCLO4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FAE864FE2;
        Fri, 12 Mar 2021 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560980;
        bh=OQyJ253o9zsK9O8OvMY/sl3QhOqiohfjqnnr+D3rpNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfLmSxeiEZMU7ogKtM7X7QoOJJPNY2xIPXleeIL6OWKH6Hg0vKNxEQEHOW/cnkHLJ
         OGa3g17ZlmKnrMGt3DxCcbimgo+u++GGZKejLtIn9Qy1HfJHGIFu36UZR/7B1V/v0/
         4J2CXAJTanZYN3a61ICHRvBLGz6GThjrllJcnl/rPwbo1k5N8xSylE7DHbKbvkcGeP
         4q5wndA8kxiJJ6DWW9yeGLmjUWnyubRDxdoeEQDgfHunGs3Ao8tjaRgV2+aUncE1wa
         qLAIPJw1oegnvR8kNP7ZpAuBxyuGUq/OQ4uNTyvbIrRRad1gqw8IgXaFIEZWEoD+eR
         wTh0iLBjPphQA==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 7/7] arm64: dts: mt8173: Drop compatible for mt6397
Date:   Fri, 12 Mar 2021 15:55:45 +0100
Message-Id: <20210312145545.26050-7-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The regulator framework does not need compatible, it's actually
superfluous. Drop it from the DT.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Series-to: lee.jones@linaro.org
Series-to: robh+dt@kernel.org
Series-to: matthias.bgg@gmail.com
Series-to: lgirdwood@gmail.com
Series-to: broonie@kernel.org
Series-cc: devicetree@vger.kernel.org
Series-cc: linux-arm-kernel@lists.infradead.org
Series-cc: linux-mediatek@lists.infradead.org
Series-cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a8..db06a986f763e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -916,9 +916,7 @@ pio6397: pinctrl {
 			#gpio-cells = <2>;
 		};
 
-		regulator: mt6397regulator {
-			compatible = "mediatek,mt6397-regulator";
-
+		mt6397regulator {
 			mt6397_vpca15_reg: buck_vpca15 {
 				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 6dffada2e66b4..c3f2a85d55fe7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -303,9 +303,7 @@ pmic: mt6397 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		mt6397regulator: mt6397regulator {
-			compatible = "mediatek,mt6397-regulator";
-
+		mt6397regulator {
 			mt6397_vpca15_reg: buck_vpca15 {
 				regulator-compatible = "buck_vpca15";
 				regulator-name = "vpca15";
-- 
2.30.1

