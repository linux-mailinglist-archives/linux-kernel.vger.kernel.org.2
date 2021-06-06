Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC739D067
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFFSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFFSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:18:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6AC061766;
        Sun,  6 Jun 2021 11:16:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dj8so17396997edb.6;
        Sun, 06 Jun 2021 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=07UrgWTUrvd41OIpiSSSUai1/EscZkb/oDXQgnTVOVI=;
        b=RlJFng2oujbRP5GmKodhuSw5e/WwTGOcywGxdKk8ouL5YU4vWtadBbFGSXkUNyTsB/
         ToMJ+hdBs4gvdlUGY8lwhKW08UwYA8nxey0Bsddke4R/5GXqj1AI1GcCvbnZbOkPjhrT
         VFe6gSObR/KBdGEN4MVUf3/XIt1g0BDui0F2wZlXcej+YS/puUFdrSFXdeWH+WxPiQw7
         3X7Go0d+46aCDQ56uFFjrQz5HTonaeaaVKpRll05f07Y4TX6GLQf4mXs5KitNBnYeot8
         3FxukhV4yxRRJwCxy0bdyJStLB1klCzonsc8shFXPhsKUg5RLrqD9D2ubC4y3qaA9tlV
         8iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=07UrgWTUrvd41OIpiSSSUai1/EscZkb/oDXQgnTVOVI=;
        b=Z6XD0YWujaDbh3XibV8SZplsnpbrmsBTW9CSc+SnADu+6iOrzS68wjrEWTUib8bbPA
         /wSLY9l0KtkIBVo4WqD/XJbzYo44OhIA6xaG8vtfKggAHse/9ngZcPJwJODaQDv34yJJ
         L91AYoSy0aZ92ncZKeyqLGCOIkl5R9mjed8/ccxF02e+kQiTHcclBUqkBgrJgtg/tlup
         oZnX/QIAfUR0LOAyAxsGYvnxC5IF3hiLNdQz+XgNSnpppK37vtxCC85cn1ar6UKqaP5+
         KCOHXAC2kBi4vKC+ekawoPJpZYphePGaIHPh73ziuUDzzoJKHSpZR6tnqeWWE7UB8V/f
         m1kQ==
X-Gm-Message-State: AOAM5330YcG2/UFwtssHkVDrb9rjJUMJx6YqmLK9lzxOpuL4jtiDLgP5
        fcVWEbaCeMXQ4rMLOO2ZoABqsct5JhW+Qg==
X-Google-Smtp-Source: ABdhPJybhG2sFlGgCbW76SCPoPv85702fLqv89akUJ8LhblfPozxj/blYPKtMYJPABXwj3KRqfqXcg==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr16072806edt.106.1623003401891;
        Sun, 06 Jun 2021 11:16:41 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qq26sm4415932ejb.6.2021.06.06.11.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:16:41 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: fix supply properties in io-domains nodes
Date:   Sun,  6 Jun 2021 20:16:32 +0200
Message-Id: <20210606181632.13371-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with rockchip-io-domain.yaml gives notifications
for supply properties in io-domains nodes.
Fix them all into ".*-supply$" format.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index 44bb5e6f8..76363b8af 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -218,7 +218,7 @@
 	flash0-supply = <&vcc_flash>;
 	flash1-supply = <&vccio_pmu>;
 	gpio30-supply = <&vccio_pmu>;
-	gpio1830 = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
 	lcdc-supply = <&vcc_io>;
 	sdcard-supply = <&vccio_sd>;
 	wifi-supply = <&vcc_18>;
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index aa50f8ed4..b156a83eb 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -379,10 +379,10 @@
 	audio-supply = <&vcc_18>;
 	bb-supply = <&vcc_io>;
 	dvp-supply = <&vcc_io>;
-	flash0-suuply = <&vcc_18>;
+	flash0-supply = <&vcc_18>;
 	flash1-supply = <&vcc_lan>;
 	gpio30-supply = <&vcc_io>;
-	gpio1830 = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
 	lcdc-supply = <&vcc_io>;
 	sdcard-supply = <&vccio_sd>;
 	wifi-supply = <&vcc_18>;
-- 
2.11.0

