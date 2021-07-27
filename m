Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5333D7436
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhG0LWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbhG0LWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:22:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D29C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:22:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4372426pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7I/jF2S0x4GNrJTMatkqZ5v2AExG75w8sw95n03TZZ0=;
        b=PqCGjDl0ZDJC6BzPx1oirKsbbPKW0TT0QoNZEJ5bgaUHxNW2pP0EjwwbnRgprztDqb
         BEn6zo6NOK4y1DgVh5S9XW+su4WkiyxAGq2tH16BQ26TyZZep208NdTgIfaVkUv+aGo6
         c359te2EWFAgsQ15StoybDeaVCYRnApyYGWh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7I/jF2S0x4GNrJTMatkqZ5v2AExG75w8sw95n03TZZ0=;
        b=ZjTjN8PyY/pn79zncMZKOIOY4QHgp1cI7j11rHWnmWeDlGVKvTvZkpguY5A7Zvsqdt
         b33xpMfglI1n0Nt8lace7d2mm6gqqUNXJujmz6b2IauUKdVo55ACXdSZXQgZZEs4ZoKH
         RM5El1f/623BkqeakaqVtOQ5RzO9KYlPytZS1iEpYlpC2AXQmCa5D8bCK8A6K1/Prg7B
         QXNlZFvUwOnNr84wViTq4mCSc2j8i/5RnunJJCEji77gkcgzVcX47B+ZT20gx3BwrmQF
         sidxtuEXF03CLssdmjq1wemqFhi/+0qeaub/Si3+n+Xkh7noWpT7uqs/um6guxJpxRDW
         kUMg==
X-Gm-Message-State: AOAM531CM2hK2xrXYu6oIt6KPdlOouwIYu9EMxZsyYElW6XXVvPOkMqx
        vJnCdHmfUrrUnNAPjAScvh07dQ==
X-Google-Smtp-Source: ABdhPJxO2igEEqSKLOzbj7utbR/KZmD++/50YFoHbGgBIVgwGez26YNeYy09LVDcdVm7+GbWPGivmA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr22984558pgh.343.1627384935268;
        Tue, 27 Jul 2021 04:22:15 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id 20sm3506467pfh.15.2021.07.27.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:22:14 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
Date:   Tue, 27 Jul 2021 19:22:08 +0800
Message-Id: <20210727112208.2508675-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727112208.2508675-1-hsinyi@chromium.org>
References: <20210727112208.2508675-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fa2d0aa96941 ("mmc: core: Allow setting slot index via device tree alias")
allows the use of aliases to number SD/MMC slots. This patch use aliases
to mmc nodes so the partition name for eMMC and SD card will be consistent
across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
v2->v3: add more commit message.
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a8..d5a2cad39c9c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -10,6 +10,12 @@
 #include "mt8173.dtsi"
 
 / {
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc3;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
2.32.0.432.gabb21c7263-goog

