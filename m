Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE52634720F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhCXHIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCXHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:08:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41168C0613DA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:08:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v3so14030957pgq.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RRd13xSmzzPdeil2PYUhQm6+cyptrl5URL+s03EZsI=;
        b=QAlvvh5jK4gEHwYp56McvWt/j2reVUksBe/t038i9Nj2NpKhSptr9UYnHfJlpEG+0C
         UwhTCSKgC7iznOpXn6CbSdFmENIzBHhUQBG+azqFBg2RL2lZ7B8/1/2Bz5NU/Jcd0rQi
         1a9rgyMnNWcZd/Rxtf3SY8EtBjHSmHbaEYUSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RRd13xSmzzPdeil2PYUhQm6+cyptrl5URL+s03EZsI=;
        b=X13Xu8pcFXV2/KpZ1OhkIICtTGwZRDJOLypYn5r3XTHaTUV6dt0+DO6w1QoEsYc9VE
         1Uu+6ERpdi/amBLCgOet9WRo1nHxWi6EtJ6znKdJocDEPBmV+mVxEzq2hGlQbeT1I1eX
         bmDNPDpqOnGXFNSkqJbVZDq3PqlLHGLV0Mt7fziRBwf2OvUfL11rwIToTuAn6XOjXsPJ
         8x/6eW0zrq4M/9MTQBZ/6ZTdYEzv6HXOtiMOyOy+Rr1bRpSnnRL1/nB7G74Z6+f01mPd
         EK7O+h7+vhUFjh1I/Imlrz6MubuTEnio/exD/b41yV5inR+CseGZUcmzjAU/MNFhFlq3
         4gWg==
X-Gm-Message-State: AOAM530PZ9tAfTIO5rB4SpOmpViye7yXXRUI+YeLkad3WNctWwYT0g2p
        fSKYsRSRhSdaL0/l8GdVwOUw5Q==
X-Google-Smtp-Source: ABdhPJwI0x2w6Tp2BHTsGd/z+j1YMe41PeKg3PJTel2Z+1wKA5TzhFhhV2Req+NqwYyObpioIBwOtw==
X-Received: by 2002:a62:2a83:0:b029:21a:d3a4:80f2 with SMTP id q125-20020a622a830000b029021ad3a480f2mr1665580pfq.47.1616569727657;
        Wed, 24 Mar 2021 00:08:47 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c8d1:279a:cb3a:39cd])
        by smtp.gmail.com with ESMTPSA id t18sm1408077pgg.33.2021.03.24.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:08:47 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mt8183: Add gce client reg for display subcomponents
Date:   Wed, 24 Mar 2021 15:08:42 +0800
Message-Id: <20210324070842.1037233-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,gce-client-reg for mmsys, ccorr, aal, gamma, dither.

Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v1->v2:
Add for mmsys.
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 80519a145f13..16f4b1fc0fb9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -983,6 +983,9 @@ mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8183-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
 		};
 
 		ovl0: ovl@14008000 {
@@ -1058,6 +1061,7 @@ ccorr0: ccorr@1400f000 {
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
 		};
 
 		aal0: aal@14010000 {
@@ -1067,6 +1071,7 @@ aal0: aal@14010000 {
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_AAL0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
 		};
 
 		gamma0: gamma@14011000 {
@@ -1075,6 +1080,7 @@ gamma0: gamma@14011000 {
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
 		};
 
 		dither0: dither@14012000 {
@@ -1083,6 +1089,7 @@ dither0: dither@14012000 {
 			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
 		};
 
 		dsi0: dsi@14014000 {
-- 
2.31.0.291.g576ba9dcdaf-goog

