Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90145E7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbhKZG32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352569AbhKZG10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:27:26 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB5C061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 22:24:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CA701D1B97;
        Fri, 26 Nov 2021 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1637907849; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=ksOo59b9zPzpZ/xtZN+pj91AfwpAwnF4ANOJtE5pGEc=;
        b=ghGJUQwM6wRg8zSTKAxvvcaivOFvayoBy6tPj44WSZZHRID9l5k0uA75isxt5YoFkffXEj
        jljmj1oBhjIYJ6SSpv6NA4PYz7PfjizXvFDF6J/3PhB2iB5RngvrgyCTAHPqUnIAItpdPw
        J21HnU2ZjttKWOQzngr8t1eGOskYE0vQWi9zt+Ab1cxcWSntbUC5Lni4ChTNJWhnENfgxB
        EGYdiHsZEsp7w43H1Mtmp7tXATXOREFO8J3kYvQCcAxT8bWFwbkh/n5X6AILyBQeoiVlHs
        Plq0Oo75OdCJr32j/3SIK5qnbW71GwYZo3CRag9lM55FmvbXlar2Y6dCN3y4Yw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org
Subject: [RESEND PATCH] arm64: meson: fix dts for JetHub D1
Date:   Fri, 26 Nov 2021 09:21:28 +0300
Message-Id: <20211126062127.3084029-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misplace of cpu_cooling_maps for JetHub D1, move it to right place.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 .../amlogic/meson-axg-jethome-jethub-j100.dts | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index 52ebe371df26..561eec21b4de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -134,23 +134,23 @@ cpu_critical: cpu-critical {
 					type = "critical";
 				};
 			};
-		};
 
-		cpu_cooling_maps: cooling-maps {
-			map0 {
-				trip = <&cpu_passive>;
-				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
+			cpu_cooling_maps: cooling-maps {
+				map0 {
+					trip = <&cpu_passive>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
 
-			map1 {
-				trip = <&cpu_hot>;
-				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				map1 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
 			};
 		};
 	};
-- 
2.30.2

