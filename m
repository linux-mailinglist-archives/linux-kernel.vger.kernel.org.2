Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6B36679A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhDUJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbhDUJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E65C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so19254483pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ntfb1UP9/jEh2M57HXjNuFQiWNlO95qklRJb1u95eE=;
        b=B64eaEDxaZ8wAzxiRmBMsUlnaCxBSwC9OQJVw2Tc/wEatJeU6+90BoXUBgjwAP+WQE
         xH/+gairrnvVOSMs4xzR3MYZAdUk8FTAg70zebpOTnmFdk//2GCDPfvkgnOzvPM23css
         S6aAUCyIgcg8U5goTupklYruTEpFuVUhisbn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ntfb1UP9/jEh2M57HXjNuFQiWNlO95qklRJb1u95eE=;
        b=PfvRlSoE2qoTOex1t0de+61gPx4qByKFhQFSJdyYCVwHakET0RUpjl2TJ5FYj0TSi4
         lMezCY9+QDTOYmYiV64c530jF0rwN0K3XHYkhKVswdgzMA0H9wTYEvO7CPfJHQ4A7m/1
         X7tmw2trAiB8xd7vjcleI/gi4GV6IJwzAmkFVubkGxzYdjdHCKlMG4JqSH/wqnshQMvM
         m3H6bqZRcQUyP6PfnbXbxorNhStZI65eBxpzgqaXuf/LXcL55Ejq5YNYX+C1/7VcNtp/
         qTIPDTBLFbJ/G/QpB9ADKLrqghQCX7HhbRJrRNv9t1mpYbuuXveOXFbUYTMWd58xh1jc
         F2Zg==
X-Gm-Message-State: AOAM532TbrqJ/K15wjPxs71a2l9xp/X9XRdFmYkSIR5DSaUC7GTMF55C
        74n3z6RpYa8VUV5l1FM3g4qzdA==
X-Google-Smtp-Source: ABdhPJyxXvsbYpW4WSQe7zYkJOz7ef/sy2AATBkOUL3dNhla1WWczXgf96/PLKhLpBGThF8hkvC3IQ==
X-Received: by 2002:a05:6a00:be2:b029:258:834c:cdc9 with SMTP id x34-20020a056a000be2b0290258834ccdc9mr27147115pfu.54.1618995982850;
        Wed, 21 Apr 2021 02:06:22 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:22 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 09/10] arm64: dts: mt8183: Add kukui-jacuzzi-kenzo board
Date:   Wed, 21 Apr 2021 17:06:00 +0800
Message-Id: <20210421090601.730744-10-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
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
2.31.1.498.g6c1eba8ee3d-goog

