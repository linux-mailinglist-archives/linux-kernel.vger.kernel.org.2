Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB33FA4A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhH1JNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhH1JNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:13:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F04C061756;
        Sat, 28 Aug 2021 02:12:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z10so13558733edb.6;
        Sat, 28 Aug 2021 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvvbcesUWfj9LMRxBzI6Ev7Q0MX9bVpa2X1UHmZy5Ko=;
        b=WbrKJIDpVBW4LuxY9IEFZWqoCPt11yVJXydz5n+xiEdUt/Iiy9dTT5DzDciw9LRn1E
         y3KNoTpglKtkhTvAvbiMz2TZWWrvHO1XXLY04E0T/Mr1Ia3kFjwf0+WM6dY/RevB3M3n
         28SHgfjhu7ijS1MBgadoJSGB4Uinrt21n9fuxt+YtxaKnILOT7cBqB1hiAM/50y72T22
         5ZATPwdqltWGCXNOMFUWZ3y1Er5+O5+2BaEM1Wrd6wlJCTtCVC7MvjqaOBoWUYOikgUO
         rbgvRKsMnyI+8Ymy8YoqxQk4cQpp5cTyO2c6RvVQO8lwchIBxgm7VwctT8P+l/nU0pDx
         W7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvvbcesUWfj9LMRxBzI6Ev7Q0MX9bVpa2X1UHmZy5Ko=;
        b=Y6jH/mtd8EYy6/vC2jjWSapbtjDJnjAeJlyux9uCu74A+714EAfZ/aZmSaLeEGQAwY
         mmi1xutcEf4dd7XeKCEOflCrCEtumgy0ERreuWlY/vb8q/sHPvtmim8TnF+lri1Dytl2
         YU14uQVkizHsfUptCovvwC4HHiiUFlymPu2ZoYaQezr/sXelzwXUsZTeFOlNpYcgwwFv
         +ELch3aUZ6fpDdn3jXJG+Jcd2mZXu2qBsflUHi+zgb3NcpYV5DJoVGUUIbFB5ge5e+lW
         kbK54lbw2eb6OHDgv2G4ppxQlDH06sB6z0jw+jy5QnHNfeGN348pQp6krjS8xIQua61U
         n+jg==
X-Gm-Message-State: AOAM530p/dVlepkAOl9d30kNYkkoIPG1rSK5peUl9zp/LBlAV0uJM7wg
        tTd2RporGV9CUC6yPCY7sWY=
X-Google-Smtp-Source: ABdhPJwolTxMxxAfrpO8rnE0IdRrrykT1UKXuvGuqrPmonIccYMBpu5U39/TA+Ddd6hRpx80ronDeA==
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr10288906edx.62.1630141960105;
        Sat, 28 Aug 2021 02:12:40 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id gl2sm3965102ejb.110.2021.08.28.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:12:39 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3066a: add more angle brackets to operating-points property
Date:   Sat, 28 Aug 2021 11:12:33 +0200
Message-Id: <20210828091233.19992-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the conversion to YAML of the Operating Performance Points(OPP)
binding the operating-points property expects values in
a uint32-matrix with 2 items, so fix the notifications by adding
angle brackets.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v1.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index ae4055428..cc701a4e0 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -23,16 +23,15 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x0>;
-			operating-points = <
+			operating-points =
 				/* kHz    uV */
-				1416000 1300000
-				1200000 1175000
-				1008000 1125000
-				816000  1125000
-				600000  1100000
-				504000  1100000
-				312000  1075000
-			>;
+				<1416000 1300000>,
+				<1200000 1175000>,
+				<1008000 1125000>,
+				<816000  1125000>,
+				<600000  1100000>,
+				<504000  1100000>,
+				<312000  1075000>;
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
-- 
2.20.1

