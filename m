Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB433DBBEA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhG3PRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhG3PRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:17:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43205C06175F;
        Fri, 30 Jul 2021 08:17:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t68so9730385qkf.8;
        Fri, 30 Jul 2021 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DbjCAjPm/ruEw8oD0MnskwEE22p0hpGp1LSK2YC18o=;
        b=iC2fs0BqUxYejyxpftiqF7R6h30qgI10RtbPw6Ve4dyYhTLcnBi0EAXzTTn9Qtq0xT
         W7blXVmlEuvt9DXqCaeGoqLYbO4qMwpWhpnhUHRaMXqVeoTJDNb/Gs1aPE/FgywUreW3
         QEuofjeP6k/pDOGyrOJTXSjoo4Zjfn2UbVxftj8xLvnmOJzz7UXp/CsXoEK79JsFeUoy
         cV/z0FcmKDo6dhorpUfugI3Co9J5aOpRj5Rv3otwAooqQpscd52Tg5wOA1l1uyBE1WyJ
         fvI2b4yXKxmJQMlTYkJFjy7M8Dgs5B7s9n7yJPAqYPDBEaAcOM2giPs2quma0FgzLdsi
         +OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7DbjCAjPm/ruEw8oD0MnskwEE22p0hpGp1LSK2YC18o=;
        b=AJb7fTYgB8yfolIqB5a5MOMXClHSE6IFmt1z58aSqq4oRJSv7tB6RDZBMOiqpFAnBe
         rtjz4KIZjs8oKXLz+KBHi1N0lpf0yNc16NJjBkEhbtsTIbBy2drlFow9dXDnfo8jCD/5
         gtdq5XIU6aBD5K+dXnpR3maY/ulW46vRIkKLAP5+5rCr6Fj+FNte2a3Hj+m03ICUR0l4
         6UJ/RoYviBwuABtHrdNdgRknDPUYBRESgG9ptwaAkvVD6pXi/jVsBCB0NpEvr7hzma9O
         oCTzs34NU3X1KG1pNGa45tPle/0qWOrs9+QfH/+BKz+tZnoGu7aYKjtYQ0eXAfKXa/du
         2CTA==
X-Gm-Message-State: AOAM533wU67jXys/ehazvc3z2Np4c8PW1niiEGldMZZhLZI3HvyJBuvx
        KWdG4snD7czPWAg5pzWG6S4=
X-Google-Smtp-Source: ABdhPJxbk9ZILaDpJAGSdJ1bJyZnaAqNjOo07NRxXgahjPKnC5DJw/XxvlIuwGUM/1wMNea31uxS9Q==
X-Received: by 2002:a05:620a:ece:: with SMTP id x14mr2734102qkm.482.1627658259336;
        Fri, 30 Jul 2021 08:17:39 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b33d:da64:8d94:ff34])
        by smtp.gmail.com with ESMTPSA id d25sm721854qtq.55.2021.07.30.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:17:39 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: rockchip: add thermal fan control to rockpro64
Date:   Fri, 30 Jul 2021 11:17:27 -0400
Message-Id: <20210730151727.729822-1-pgwipeout@gmail.com>
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

Changelog:
v3:
Removed the gpu nodes to prevent in-fighting (thanks Robin!)

v2:
Adjusted fan setpoints for less noise

 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6bff8db7d33e..83db4ca67334 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -69,6 +69,7 @@ diy_led: led-1 {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
+		cooling-levels = <0 100 150 200 255>;
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
-- 
2.25.1

