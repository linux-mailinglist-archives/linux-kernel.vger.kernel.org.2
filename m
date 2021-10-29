Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22D043FB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJ2Lg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:36:29 -0400
Received: from ixit.cz ([94.230.151.217]:51026 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhJ2Lg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:36:28 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 9D31520064;
        Fri, 29 Oct 2021 13:33:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635507237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zOiZ5/PZ6rpeSK//w83AB0zdgKq32SgEHSychPRids=;
        b=is241A8cmQkmzKEYnMFzkGG+fdbR9rL3wCQlBRjrc2phDqx5oZjXpTylS5zy57qFw3NPav
        6D4MkMKGFt2d0tiuyn6px9vVWJC+MTdje374ePQL9RnutVbHiXnX+gjNFrDQnhPKLVoSVo
        Zr/XfQpW0ERoykS1CY6YwRI7zhMiXbw=
From:   David Heidelberg <david@ixit.cz>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hisilicon: update deprecated property name
Date:   Fri, 29 Oct 2021 12:42:12 +0200
Message-Id: <20211029104211.29079-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hisi,rst-syscon property name is deprecated, use hisilicon,rst-syscon

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8bd6d7e8a474..3fd80f1f7c1e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -345,7 +345,7 @@ crg_ctrl: crg_ctrl@fff35000 {
 		crg_rst: crg_rst_controller {
 			compatible = "hisilicon,hi3660-reset";
 			#reset-cells = <2>;
-			hisi,rst-syscon = <&crg_ctrl>;
+			hisilicon,rst-syscon = <&crg_ctrl>;
 		};
 
 
@@ -376,7 +376,7 @@ iomcu: iomcu@ffd7e000 {
 
 		iomcu_rst: reset {
 			compatible = "hisilicon,hi3660-reset";
-			hisi,rst-syscon = <&iomcu>;
+			hisilicon,rst-syscon = <&iomcu>;
 			#reset-cells = <2>;
 		};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 636c8817df7e..9eac9a339654 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -155,7 +155,7 @@ crg_rst: crg_rst_controller {
 			compatible = "hisilicon,hi3670-reset",
 				     "hisilicon,hi3660-reset";
 			#reset-cells = <2>;
-			hisi,rst-syscon = <&crg_ctrl>;
+			hisilicon,rst-syscon = <&crg_ctrl>;
 		};
 
 		pctrl: pctrl@e8a09000 {
@@ -196,7 +196,7 @@ media2_crg: media2_crgctrl@e8900000 {
 
 		iomcu_rst: reset {
 			compatible = "hisilicon,hi3660-reset";
-			hisi,rst-syscon = <&iomcu>;
+			hisilicon,rst-syscon = <&iomcu>;
 			#reset-cells = <2>;
 		};
 
-- 
2.33.0

