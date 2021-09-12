Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEFE407CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 11:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhILJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhILJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 05:52:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22954C061757;
        Sun, 12 Sep 2021 02:50:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so4452075wms.2;
        Sun, 12 Sep 2021 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfUDMjhaBW28irP63CnwhnXUauvV+ceBbmfpoRw/Bl8=;
        b=T1/hhsyBRS2DZ/592/U9LVU+905MkddkZ7e1nzYGxk3NrFdUaONbjuCPUU+gYQAHf6
         a1qCH3aWLd+2sKyN1+2zeYJQLYcEL/LZZwvW/b6O4juccBqfNW4nQncgbff+UwRkuXd4
         zKp96LxjFMOVlsVhsiJDad//D8305kdp21qeIu6Sd+AbbolgW+OSAkDc9EoWo9V8a48i
         nv9/oBTQwPlH4eCmKGCMoZTQ00ZQooVtNjRSwqL5zCep+fL3NLkM+nXrDeuo8xBKk/aH
         l0HebZCPiIoQrqZ6ZwIOfvpcBoeuQ861jdq4/sIkzWS9K030Sj/hYNhrbd5bZXL+ZUI5
         vzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfUDMjhaBW28irP63CnwhnXUauvV+ceBbmfpoRw/Bl8=;
        b=jrWIMzQW1bKktTR79m60KKEL92P+UWLjUXk56AXyoF8nVpz8cKPgQ+det5pA9gKxzL
         LKki+6WoYG8vO0ZRyKWkBvDvOfBGHJb1qOE+4D7SRJLfyJx9wqQsV3Cbw80O6FyS+65a
         vCMKt/C5Ng55eSoCNSfwrtdOgDTWqLjLXcJUQ96WnRHzZE8gn3p1kbbW1Siz2r3R1Hog
         +uOXBrNTH585dGCls2CdUdccTEBAbO6fcblhj5EOpoKdKTWKpyrnSmBvuH/nU4SariGw
         uOiRaUBuJ7sCjs8gwo+cCqcO+SCIKLpvuY3HOyyqctlGB4XOMF4SFo/uv98NpgnLO9KB
         mGOA==
X-Gm-Message-State: AOAM530gThdTGRw0fOBNRCK/Xd7C2b/X93u6YFbRAOddMqED8Sce/VIi
        ts4oAjQMjzKfveLkOn+UcIw=
X-Google-Smtp-Source: ABdhPJyzMQK6uGv0+edsUnseYhz0bylpHJqwuQWPA5iwYb8Cj0rz5723JiK4lVGjA+DXjoqok7/erg==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr1464839wmj.16.1631440245762;
        Sun, 12 Sep 2021 02:50:45 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id n13sm3471487wmq.3.2021.09.12.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 02:50:45 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: a64: Add GPU opp table
Date:   Sun, 12 Sep 2021 11:50:32 +0200
Message-Id: <20210912095032.2397824-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPU on A64 currently runs at default frequency, which is 297 MHz. This
is a bit low in some cases and noticeable lag can be observed in GPU
rendered UIs. GPU is capable to run at 432 MHz.

Add GPU OPP table.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6ddb717f2f98..5ba379078500 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -102,6 +102,22 @@ de: display-engine {
 		status = "disabled";
 	};
 
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+
+		opp-120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+		};
+
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+		};
+
+		opp-432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+		};
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -1103,6 +1119,7 @@ mali: gpu@1c40000 {
 			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
 			clock-names = "bus", "core";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 		};
 
 		gic: interrupt-controller@1c81000 {
-- 
2.33.0

