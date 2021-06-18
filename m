Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34B73AD1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhFRSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhFRSP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1BC061574;
        Fri, 18 Jun 2021 11:13:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6954231wmc.1;
        Fri, 18 Jun 2021 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rv4VKDRBcNrskkvEnd89Jswu3eRnd7ncejFN962fJIc=;
        b=MliDCA4h82Qv6GO6z0JtwJO5+8tXwdfODNzdyQKaMkLkFWiFf8n4HuqoMCeTeEW+YE
         B0UMnx53hRwiXJbZGkfdTK1zdrpS4b1m+rCz1hTKBPi2UW7itn2L8elTxo3sg5Du8k6C
         BQ8K/X6GuIwXrpaXqljV5OBiURiZpdgYo8f2ExCjzGAdKTvcsI5EWiNkecEmB7wBug71
         kmiMWKt4JzgM1FIODJd2Or8o0mhttgwr/vHyBc7s7eUnbwZjvYc+1s9p73wlzatQKK59
         5jQ82e/GTIVpSI0YolaPFIKxpIcofiQMUo3EqRrWCBpC3bdUv+GLti9jhHb0jNgZR+my
         O0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rv4VKDRBcNrskkvEnd89Jswu3eRnd7ncejFN962fJIc=;
        b=fbg+Am32Zm+VXDNz5OSftGpZlzBjACkwm7YZvaHjngQR9LBOOBp8bU8tkvdFGxE+P5
         M6fiW1Bgvt0Miv9E1cWVNSUBjPowypMpfKOvqCGMFdpM949WmyRFqXS6zC+HxZ7/dqAg
         yFFUEqINkngr7ahsQ+ZGZ1aZSCdMIC7Ki8sY9k2zpCUaH4KrlNy3oDauomMFlMUmDRAN
         cd0Gb6qYokulNBJZOEJcXMs/O74oiHYChZ00VbfCDceOXrlUCAxiOIY8lWEi+nxk0B/V
         nKVwhwCoLl11bOn40O9synkGaYBGnB6GtShqnalLf9mrS2DiLnCTbZdZg6pXtp6rg1oH
         /paA==
X-Gm-Message-State: AOAM531rY7FbFFFUPVxgJO8mYUPlkBrw/1EnOF3jSV0fLy/YcxIAan/h
        NorVbZAl1YckiUWUzjJSqw==
X-Google-Smtp-Source: ABdhPJw61tE1SgD3KZkdhjmX83akHP4VSX6zBLhC8lhARwMxkLIsxlU5wpu1/jpGew1IKacMRmYctA==
X-Received: by 2002:a05:600c:21d0:: with SMTP id x16mr2771318wmj.78.1624039995461;
        Fri, 18 Jun 2021 11:13:15 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:15 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5] arm64: dts: rockchip: Add RK3399 ROCK Pi 4A+ board
Date:   Fri, 18 Jun 2021 20:12:53 +0200
Message-Id: <20210618181256.27992-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCK Pi 4A+ board is the successor of ROCK Pi 4A board.

Differences to the original version are
- has RK3399 OP1 SoC revision
- has eMMC (16 or 32 GB) soldered on board (no changes required,
  since it is enabled in rk3399-rock-pi-4.dtsi)
- dev boards have SPI flash soldered, but as per manufacturer response,
  this won't be the case for mass production boards

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |  1 +
 .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index c3e00c0e2db7..dbd7d37950f1 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
new file mode 100644
index 000000000000..281a04b2f5e9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-op1-opp.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4A+";
+	compatible = "radxa,rockpi4a-plus", "radxa,rockpi4", "rockchip,rk3399";
+};
-- 
2.27.0

