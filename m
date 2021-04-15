Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778843605EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhDOJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhDOJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:35:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u7so9926765plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMjBnZVcviRSoI/fJCL0g5fel6FhaOBmtY6DkO6xXxY=;
        b=h7u0EG2oQomUTpNXieEyKJqrlltD5arbBXhy5eiszP06AOd2iO8qgA0l8phkMady0h
         RXy9ualjzfyUH1mVHjK6sWlRVzvyQzyz7FMmZOYklSvBZxeYa553SWRx6gDBlrF9QclM
         yaWAoKzrqK9iHo82ft0OdCffwP+vbZ3wyjwEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMjBnZVcviRSoI/fJCL0g5fel6FhaOBmtY6DkO6xXxY=;
        b=dp9Mz1bXuobYV3b5TgUvRjOeYpZLoWEzjOlZDjix4ge+1qERUEBR3Nb6GhAqqZemnC
         468cwnCtef6BT1sF8W9z/DZOdSttsGgIZgYBghdIKRARfV8cavjh7lcwzitenXhmcrme
         MkcTwb0Fn5eWGMxt6b9npGYEKoqaSiw1xY8TVL5vDPia8y/3GmbqzgVJx4gLjvBuGcsv
         GB4HChobjr7s5+U4nT7npvr60p0JwiqbxJ61P7V8Qx2u8Hn37iGz6XecANMmYxwR78sH
         eSEQV4ajzVkIqz/1NfUOT8Qt0Hb8gAgXEb0lCgWClYeKJnvXg+awP0eaO09PZ+wezNbs
         x65Q==
X-Gm-Message-State: AOAM531ECUoDw5QulsxiKgJreksGzXBx1kuNbD+Fp4xiP8rh4s3YvwG6
        CfCcDA2LJBoudZRt2Rmmsgm2yQ==
X-Google-Smtp-Source: ABdhPJwKP4wSfoYB0NTaL8DCzzFiEbrj1tlgDGva13KPsgrDRbYyepCR8GYmJblM/4ysaLF0o+vdZQ==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr2815027pjb.43.1618479332053;
        Thu, 15 Apr 2021 02:35:32 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6432:a6cb:91d2:5e32])
        by smtp.gmail.com with ESMTPSA id a13sm1849502pgm.43.2021.04.15.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:35:31 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 5/8] arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
Date:   Thu, 15 Apr 2021 17:35:16 +0800
Message-Id: <20210415093519.1920877-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kappa is known as HP Chromebook 11a

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile            |  1 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a1c50adc98fa..df70674949ce 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-damu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
new file mode 100644
index 000000000000..b3f46c16e5d7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+/ {
+	model = "Google kappa board";
+	compatible = "google,kappa", "mediatek,mt8183";
+};
+
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
-- 
2.31.1.295.g9ea45b61b8-goog

