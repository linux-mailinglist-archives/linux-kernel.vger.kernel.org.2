Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A993625E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhDPQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhDPQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:41:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91EC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u11so10649991pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjwezvR4WhTwoSsV7r7SDlHf748Qlz/vDJv9E/p5iNo=;
        b=L+Rv5bsduDVJHnNX/CmKwXQE/TqxVziHthO1cXuOBavA0ou4lQSZyTCFpQrLqaWMCG
         9at/Ryc6w6YpYncud1juy+qCJF/DfocHd1CoDkz7BYkJ1cYDyA3DkPJobSWaXjv8xOd2
         4VGDcpv3NKYDoj6VHrfdjl/2jXY1QJHgR6xFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjwezvR4WhTwoSsV7r7SDlHf748Qlz/vDJv9E/p5iNo=;
        b=IYT+9XICY4VlgWUWM4nVEgPlWA4CHWmZJtIshSZ8HWYLIxdb4VOfF2j7pxYGDtGC7U
         7AjeQMhuS4FJglgR/Z1EasVg2B0yFEMP7sDy/79ZrDMOm7alfg3oaNcZXMu6JKhshwyV
         GWGTFDFSDMV8oEmB0kYX0Inwix9rjQABzHaEepQDXGpPmuuANOLWoIc43d9113Cr2TRf
         vY8dRVor85PDIfIsP/dC4vZ2POurs5AAeInP9OfoIF4yj2PUUwDr+15Tft5mai/o2iUA
         CLel9j0evCnFF3NrILax3VM1gaYXK3y7y281fSFHnCsN+A0PL+xjPtSKwtPiq4wtujV7
         Z4vg==
X-Gm-Message-State: AOAM530kyw0wN9jQxPEOwZLn44MvHPfOz8b3wF063d5haRd7QCE706oh
        fhIXrH9mlRV8R7E13TBDAF2kEg==
X-Google-Smtp-Source: ABdhPJxW6qNNapuuJvgzEcFO5CklUOMaE9Q2P+8Lpslk/P4K8FSEukUC3p0c9YuKuFPtphNsQ0Ut7g==
X-Received: by 2002:a17:90a:ab09:: with SMTP id m9mr11215881pjq.122.1618591272951;
        Fri, 16 Apr 2021 09:41:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ccd5:218f:365:b90f])
        by smtp.gmail.com with ESMTPSA id g14sm6187186pjh.28.2021.04.16.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:41:12 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 8/8] arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
Date:   Sat, 17 Apr 2021 00:40:55 +0800
Message-Id: <20210416164055.3223088-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenzo is known as Acer Chromebook 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile                |  1 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index b33d0bc58021..25770d83059d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-burnet.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
new file mode 100644
index 000000000000..6f1aa692753a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-juniper.dtsi"
+
+/ {
+	model = "Google kenzo sku17 board";
+	compatible = "google,juniper-sku17", "google,juniper", "mediatek,mt8183";
+};
-- 
2.31.1.368.gbe11c130af-goog

