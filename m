Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF73B815F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhF3Lng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhF3Lne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:43:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6BAC061756;
        Wed, 30 Jun 2021 04:41:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r20so1211306qtp.3;
        Wed, 30 Jun 2021 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WGajNiQMTDo26j5le/bSfKiJsofDJEV08hqKWpTcKY=;
        b=lqL4REt4yP/jbdel4Hui+qpoiB/2SsINyZkvA9J/Ady4JM6toFgo+6vATEPuGACsXw
         sn3FYCOC2yattpqp6HugxOrKxl/6PiiTw+iOrLT7QurtgW5AKr/qONX5l1LRFUZ97/fH
         B1bWejnE27PJDjkblhyxn/vKSlevmIWHRQjMD/MjjGVZNLXlkw4fO1jDKGvaoGIdqHBN
         1CVzVEdS53tDJokzPaWmiHDDa+nacX8LLIhN4kq9rX6rvLPGgXTsGvXigQR3KcWexB+3
         39yXN7+Bbn7EaAprfx4OTJcy/iYWOIVpLZnrZ0iQKUh3v7q8nISB2xzAqLGSFnGH9IM2
         efag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WGajNiQMTDo26j5le/bSfKiJsofDJEV08hqKWpTcKY=;
        b=Ad2kkipPjWZYNabHtALfdZsyiUvaDB3NrY6Ki/eRAaLWzM2e0erDL7NATqmjA9mtwA
         iQgpMxGnUNe4M3tdv5EDQ8MR1vKv5xNpL+ivFmu89E6kz17jUAHOPfyZ+AAAsrAQeB6U
         bdQ5QN+ynO/sm7uSPi0SRVqcr1efyCCFdZnCHeGp+2QxMjll3sWbnC+LsJwaT8b93Djp
         TOLN2QHbJz8WQcdllGGB73l21XXdAKSeQwmv4kOEbpWnl/z+TQ+IyQqrEwE4HsOjEjCi
         JzoQFgEwHo/EkfIprfDO9ZJDv24Z4pWsdaY3pS+HiDcxSbeaWiYswAgwKvnYrnOoF/AL
         Kskg==
X-Gm-Message-State: AOAM532QzqIlW7Y742wPr0bQrnZX17f/9+MYvW/wAKsWBNH3bcpc1jvK
        IB4pbApSHBDwp0NinHINGNs=
X-Google-Smtp-Source: ABdhPJylPLF/vX617JJjLPIS4fQxa8BNN509WCfyDbGHvjnIrQjA/OT5JFFzxoiC8qgmcOYgkl+0XA==
X-Received: by 2002:ac8:5d8d:: with SMTP id d13mr30583296qtx.49.1625053264589;
        Wed, 30 Jun 2021 04:41:04 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:6476:6b8e:397c:a7a0])
        by smtp.gmail.com with ESMTPSA id k8sm12001773qkj.46.2021.06.30.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 04:41:04 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: add thermal fan control to rockpro64
Date:   Wed, 30 Jun 2021 07:40:57 -0400
Message-Id: <20210630114057.472121-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockpro64 had a fan node since
commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
however it was never tied into the thermal driver for automatic control.

Add the links to the thermal node to permit the kernel to handle this
automatically.
Borrowed from the (rk3399-khadas-edge.dtsi).

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6bff8db7d33e..687a5afa5d2c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -69,6 +69,7 @@ diy_led: led-1 {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
+		cooling-levels = <0 150 200 255>;
 		#cooling-cells = <2>;
 		fan-supply = <&vcc12v_dcin>;
 		pwms = <&pwm1 0 50000 0>;
@@ -245,6 +246,34 @@ &cpu_b1 {
 	cpu-supply = <&vdd_cpu_b>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_warm: cpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_hot: cpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map2 {
+			trip = <&cpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map3 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -281,6 +310,34 @@ &gpu {
 	status = "okay";
 };
 
+&gpu_thermal {
+	trips {
+		gpu_warm: gpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		gpu_hot: gpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&gpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
+			trip = <&gpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
-- 
2.25.1

