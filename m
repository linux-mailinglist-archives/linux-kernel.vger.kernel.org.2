Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B846C430380
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhJPPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhJPPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:48:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E41C061570;
        Sat, 16 Oct 2021 08:46:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w8so11577511qts.4;
        Sat, 16 Oct 2021 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxKkdzMBTPnwglERy6orEJxvMW5PnT3lhdonviWbxrA=;
        b=jxAQLXRtafzAK2KPr8cXtf7HWx+MOpOfHAqdaFpBrvpRbFa6gmcD1nO7Rde/qXkcuq
         6+7laDGEiCNZJ1N/tdjHoyMlF7Mv+V2P8LqUT4hHYgWUQO/Fpr/0sWlTIQBTc8b02fC0
         JY8tzTZjsBEGK6OUzb/01ra4NfypDVJAbBN3Fd+o18iYDvr7x3+xpEWB0brozXHlMq3k
         KKGL1LCxcuMel0u7mQz8zHgCtEttsXQzJG0u9ayT9VyxNQHyL7677oyewGRRxkw4OikX
         mZHzrX7vHKS75AW34mOM6mNbmjZs5O7eEh8b0gXbwU7nwf+q4vUYw7Q9oF05Gn+vQZnk
         AyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VxKkdzMBTPnwglERy6orEJxvMW5PnT3lhdonviWbxrA=;
        b=PKru58PBkukilv7vzhhi+7oaD1U2GrMpqa0ioa1yA5MEWM5XqkVP6NW1InoWUVrRv5
         exxHNxMlYV6trYBTZhE96z4N9kdK7LGD+yos74kDF908u0oYG27YqeQFmKslk7p3Qubl
         ikxnq3njCrAtkNgTvRbSYyXIddrCXhA+MuXE+ye1WzUAY0x5vLqXkcjVSYgyc54uIoJo
         jtVnlrjN4gbr+Hm1d1tBj7msFl2A8hguMQFneC/NYlbPUWeV5hqPzGjmxDYGLS8Asm0i
         gzdPqsc9JMGeGalpTrl43lJYqEGKqE4bVTlBd7MdlEQxBZfmbp1mYiiIZKf5BktCswQy
         zq9g==
X-Gm-Message-State: AOAM533MNDsSVAa6p5gA9ajZHxL5iv5Co1qeO3RqMygBT9fefP7btSPT
        bzj+oFkrB8G889mHoB2MFVXqzUKSNOs=
X-Google-Smtp-Source: ABdhPJwKvMVm20Ye1VKw6BXYU2GSQWOw8DtwpsyBUc49NqOoOizAZ5LoeP1JiQEFvAzhy2VJvCx1Sg==
X-Received: by 2002:a05:622a:20d:: with SMTP id b13mr10337813qtx.117.1634399163014;
        Sat, 16 Oct 2021 08:46:03 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id i13sm4047978qtp.87.2021.10.16.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:46:02 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        David Wu <david.wu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Cameron Nemo <cnemo@tutanota.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
Date:   Sat, 16 Oct 2021 11:45:44 -0400
Message-Id: <20211016154548.29555-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an operating-points table and cooling entry to the GPU on the
RK3328 SoC to improve its performance. According to its datasheet[1]
the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
is 500MHz.

On my rock64 device, under x11, glmark2-es2 performance increased from
around 60 to just over 100. Same device running glmark2-es2 under
wayland/weston improved from just over 100 to just over 200.

[1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 8c821acb21ff..5e1dcf71e414 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -532,7 +532,8 @@ map0 {
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
 			};
@@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
 		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU_A>;
+		operating-points-v2 = <&gpu_opp_table>;
+		#cooling-cells = <2>;
+	};
+
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1100000>;
+		};
 	};
 
 	h265e_mmu: iommu@ff330200 {
-- 
2.30.0.rc0

