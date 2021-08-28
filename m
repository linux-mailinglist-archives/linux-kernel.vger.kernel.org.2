Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D803FA55B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhH1LNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhH1LNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:13:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF11C0613D9;
        Sat, 28 Aug 2021 04:12:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g21so13861715edw.4;
        Sat, 28 Aug 2021 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39v55ZA/hFZsNg0cEUPwV28i0EcogCJUViGDxeBmNP0=;
        b=Go5JKD/tmYkY3YuHZlTBp+5EYiY2mNFdn8wZVUGahl57SoxGHkpsPRKaZjr6LIErI1
         fE6E7ue5Qz9KRucuw5VkHF7iFweJhI2vAC6Yxs2f28Cr3WrxSu3XFPUqBfWDHv5Exkf9
         DQisnJ+aHT7P2NflCdf+Soc6evqXEI8o3Uz3vqyQtRIHo2agoj03zpnE8G16ceIMlB3P
         rPGZE2oNZNsVZDIwfpnycFbHjZdjovhLQVbOKOsaYHr4DBKcIq+vMxu8tyJjKJByrflX
         lIsDvGgTVx9Ynb8kOdzQ+ajKFFeKY+yDDJy4QT/0sYZ6KM4zSRV99JvJJ0A7eJ2Yk+/3
         8BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39v55ZA/hFZsNg0cEUPwV28i0EcogCJUViGDxeBmNP0=;
        b=gMiMUIYU69QwSLfRAfdo6zo9/GtTewjQHvVfaWNevFifOyY2A7xI/nGavvZe5afVIp
         hTRtaqjdlR4wnlwl6aj9chfplbchS9bOsm11zg8obRiddU+nsROc/iU9rVCx59mqGW1s
         nBlAzB63SskVl+Dw+TplkUDV1dZ64xy/JT36TCboTpALVPuo4RgfbU89XxhaUBIgv1GR
         UjqhwYnJbxP0nx2XxmSgAwPQa79dv19QSocMsbPScRhb7GlaCY+dVaR5ugRKgfKznzhg
         JOHpQ0cgjRU0PbPeV5sh5HjB08zNamQ/6t5k+FzZsurqq+Je5UP20D1pus2H/ggVQzzL
         1P2g==
X-Gm-Message-State: AOAM531XpvE7EarZ3TarYav/PUCg9eAKoYNGUoXhsK6ZerhmTCiI1uvx
        7oG8hzjqPL0U2lrN3DgExVA=
X-Google-Smtp-Source: ABdhPJyFVgO1IZ9+J0PUFNVZUQajZxjvIXNmcv8b82h16QoexlUvvJXIevofKX6SYchlQWKZuN4WPA==
X-Received: by 2002:a50:cb83:: with SMTP id k3mr15017614edi.102.1630149145908;
        Sat, 28 Aug 2021 04:12:25 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z15sm4716665edr.80.2021.08.28.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:12:25 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: remove usb-phy fallback string for rk3066a/rk3188
Date:   Sat, 28 Aug 2021 13:12:18 +0200
Message-Id: <20210828111218.10026-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210828111218.10026-1-jbx6244@gmail.com>
References: <20210828111218.10026-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of rockchip-usb-phy.yaml a long time used fallback
string for rk3066a/rk3188 was added. The linux driver doesn't do much with
the GRF phy address range, however the u-boot driver rockchip_usb2_phy.c
does. The bits in GRF_UOC0_CON2 for rk3066a/rk3188 and rk3288 for example
don't match. Remove the usb-phy fallback string for rk3066a/rk3188
to prevent possible strange side effects.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 3 +--
 arch/arm/boot/dts/rk3188.dtsi  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index cc701a4e0..10392e096 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -681,8 +681,7 @@
 	compatible = "rockchip,rk3066-grf", "syscon", "simple-mfd";
 
 	usbphy: usbphy {
-		compatible = "rockchip,rk3066a-usb-phy",
-			     "rockchip,rk3288-usb-phy";
+		compatible = "rockchip,rk3066a-usb-phy";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index d6a946a2a..922290892 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -647,8 +647,7 @@
 	};
 
 	usbphy: usbphy {
-		compatible = "rockchip,rk3188-usb-phy",
-			     "rockchip,rk3288-usb-phy";
+		compatible = "rockchip,rk3188-usb-phy";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
2.20.1

