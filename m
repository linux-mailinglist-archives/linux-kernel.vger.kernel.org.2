Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB253605EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhDOJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhDOJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:36:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974EC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u7so9926940plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJGA7CCltoi4LLPzz1QAsIABRN6U35XVYBq+koWY01c=;
        b=cENYPVud5PeRD1D7qHuukP+AksGsNcy/N6MKBCNIrvRMwZ7D4AmkT3YnJ0ZGxFvtre
         HfQb7ZL0JL4zUxRsbH0gJTkWBIUFkAU/683iyML2L1SHc+7BHBUNPK/qPt+lkccOfA0Y
         qURI0WOxyZyPQocKWPTdNCrGcwfXMuVE7EmPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJGA7CCltoi4LLPzz1QAsIABRN6U35XVYBq+koWY01c=;
        b=ojqnZ4MkmBs8Dol5FLJEX2NvlenTcH/q4XQonbRBiV83kEr+rxGwqTwBwAnNCnzh6Q
         WPRCgXAbedU/zBz6aOsu1DNme1C5feZe3AnjsW+rlIE1jYFG8XxlJM7Yoya2oM+LvR/u
         FGbVGKqVOKA7oaAYT7gd4oKlBPaT4f6la5ZnbrLVN08e9tO8eWQmV2qV2aOPeIwNddYy
         R48/gxsa7dQPtbc9Wi0f2wpNBZItJuGDd5w1KE6l+xdlG3J71VWr9cw+R+KzbgGssBKa
         s3Jw7Q6v6omIF1gBZPr4iBWFR+dTRkD9QLrc5FEBSjsT2SFRQZSyXgrk9FPQlKzvKmjV
         yoHA==
X-Gm-Message-State: AOAM532t7SfGYgE4U3PDNo8Pom/quJ+YCxw+z1lfazB6iA4RpmgqKShM
        RdfPSX0qIUvA6WNjx/gi0ZUo/SB6eg8NrQ==
X-Google-Smtp-Source: ABdhPJxgYrtlSJlROR24WiWfnuLX9r3uA+Pl2QHDNsh8eRJ+6V8MzWQzeTyRoA9+bjI23r0H4gMakw==
X-Received: by 2002:a17:903:1d2:b029:ea:e375:6a57 with SMTP id e18-20020a17090301d2b02900eae3756a57mr2926248plh.31.1618479337825;
        Thu, 15 Apr 2021 02:35:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6432:a6cb:91d2:5e32])
        by smtp.gmail.com with ESMTPSA id a13sm1849502pgm.43.2021.04.15.02.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:35:37 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 8/8] arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
Date:   Thu, 15 Apr 2021 17:35:19 +0800
Message-Id: <20210415093519.1920877-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenzo is known as Acer Chromebook 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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
2.31.1.295.g9ea45b61b8-goog

