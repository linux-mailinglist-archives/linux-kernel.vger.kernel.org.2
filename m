Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829D345DAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354938AbhKYNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354943AbhKYNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:13:52 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661BC06175D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 05:03:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98D771CE5AD;
        Thu, 25 Nov 2021 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1637845404; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=ksOo59b9zPzpZ/xtZN+pj91AfwpAwnF4ANOJtE5pGEc=;
        b=dwrUmbn1Ixk2Vut8EyDfPQt9tAmwsWCglOQUnFO9yuIRuJoRE9HtFw2UF/ayDTKvQo2hTS
        qel1lcuDRCZUlwrIJcV/2gsUue3hAcb2q+BQ4SiD8OOj6dnyJ7IXjEyYu13makJdDN7Qge
        VH41IviIJ5JyJa47h3Adjgr+KYo0822PHWV4TSibUZRsrUzrxoAQgaPjtK4xhH11Yf8q8r
        EuxHzEZ1ff7ar4kzZLc84P7z+mj8RSA9OoxsHXQz+ICTata0I7RxpKueqVGCB+vFVASLJE
        20h40vdpvjYqffE3X1AaFWUEw6MdehZVG/2tMd8egFqw0QR4h5I9e0Bh1Cseag==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: meson: fix dts for JetHub D1
Date:   Thu, 25 Nov 2021 16:02:47 +0300
Message-Id: <20211125130246.1086627-1-adeep@lexina.in>
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

