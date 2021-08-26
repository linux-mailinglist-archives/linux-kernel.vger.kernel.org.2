Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827213F811C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 05:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhHZDai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 23:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:30:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599AC061757;
        Wed, 25 Aug 2021 20:29:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e16so1094476pfc.6;
        Wed, 25 Aug 2021 20:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=XtPfIMAUlTL7iDQoQvHB8+nZAxqrvLZEj9yQzJVKyuI=;
        b=aMkAaEnCl/7RVWlXQgdSIUOVDeucvFNXh1W7GIwr6Wi77qHBV6jDkYsZdYmjj7LXjx
         HpoC6ClJubwRPvqM3UD+L/f9oRzdEXO6jDssMoggWKHrpmiUGbUmibOEFfeB9EYBUlat
         Xnz7FOlMNL1BBuAAqU17Iz9NucgWLCxJYMgBzFs4PQ/SL2TG2ziAjtjmtfaSRlfh3Svm
         Oezz/Y0HRkgv93yHHEH7cM8PJzz7Gc1J8jKWEcrtzZM38X6Ry+tDDa7goZ6wgElGWiMz
         OehUtmeu0D3D7SBvuulfmHUL9Ulw8J6+jXPj9k8c4xvol1VHX60r04w6SSeL6rTQhea9
         bKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=XtPfIMAUlTL7iDQoQvHB8+nZAxqrvLZEj9yQzJVKyuI=;
        b=TUOgdU0oD7xRw2yreo/9mK7EIdIpC99KvYv2MNH/WMkAQnaNPUS5HyRPN7FoTJ1tNA
         Q1kzk1mTKQCALv1yytAC50nZLIxF5A43JyGK/8eKUJObmlSByabCIIWx6wiUTM5hAxju
         kmQ+CqSs5P6F4dwa0MsJDHujb72+tTTqZYncNh+ZZFJ68QmpnxSYVPTjqMtt0ZzKSgpj
         d5Dux/yLuxlJ24KSLxAx3FRJZPAm0oQU4URbkkqswgb958aMIVaplCwDSe4zxgYcYwys
         mE5E48DtB7GVdQ0eiejCC2eyXUNIZ9rF4m20201xo405+jzAjXZkthi8gMXE0mKzEzLa
         S3eQ==
X-Gm-Message-State: AOAM531esWjRLOszV0vIOAmBZ60OAkGiX86yAMsQ50yJ/LrzwLjlN02J
        m5npgLCn2QT0M2A766Nd2GNxNzuKjjI=
X-Google-Smtp-Source: ABdhPJy7D7ZZZbObXJ/oELYx4GyEUqtSa5Gauz5XIuF7o64Gh6T5tJU3oIb9j0reAx70EYFXDo90KA==
X-Received: by 2002:a62:32c7:0:b029:3cd:fba0:3218 with SMTP id y190-20020a6232c70000b02903cdfba03218mr1668755pfy.52.1629948590503;
        Wed, 25 Aug 2021 20:29:50 -0700 (PDT)
Received: from anyang-linuxfactory-or-kr ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id p18sm1441194pgk.28.2021.08.25.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:29:49 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:28:32 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: sm1: add Ethernet PHY reset line for
 ODROID-C4/HC4
Message-ID: <YScKYFWlYymgGw3l@anyang-linuxfactory-or-kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix an issue that the ethernet link doesn't come up
when using ip link set down/up:
   [   11.428114] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
   [   14.428595] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
   [   14.428610] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
   [   14.428974] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
   [   14.711185] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed

This fix has been referred two commits applied for ODROID-N2 (G12B).
    commit 658e4129bb81 ("arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY reset line")
    commit 1c7412530d5d0 ("arm64: dts: meson: g12b: odroid-n2: fix PHY deassert timing requirements")

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index d14716b3d0f1..1230beba04aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -256,6 +256,10 @@ external_phy: ethernet-phy@0 {
 		reg = <0>;
 		max-speed = <1000>;
 
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_14 */
 		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
-- 
2.30.2

