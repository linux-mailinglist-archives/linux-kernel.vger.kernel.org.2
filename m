Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAD3625E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhDPQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhDPQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:41:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d8so14272018plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9pozfVOg+w2yPK6oVL3TgBUt4Buw/Zfb6b1gwkYvZE=;
        b=Q7Bemqlhot8j7D1/Cm3Gs/uVOBYrRvQkQdCoWAhYCFQ9jaSu4BfzJQnUKNFTaRhPKk
         y5/PmgzDgKCTlqKIIHgs+r21Tf8T26UlLfV5y5635z+RNN3R4UzUqi2rCnR0BuMRxD3y
         Gr68s85lN1H1Z8ZERZzO9JXL6R5BoCzngoUyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9pozfVOg+w2yPK6oVL3TgBUt4Buw/Zfb6b1gwkYvZE=;
        b=kJA9PHeSQ1BpmqQ+TrwUK0JanpSKQ2W4LFmHkLoZO22loIbM0K5buz8eBmpK73iG1V
         igcSszZZs392XKQxT7BOTNdDuotltatdbohSSTC2QOwHEU+ZPfRlyjHlMePJ/UsNKU6s
         AmXWu3o+QsR7qeqNBMC0UCHHHma2TPdAhxkl2LoUcu3eOoFKmGFqC4wpHqqccuK0v9LA
         HicoOaev0aC0YWIroX9MK8uijD/3EsrjRJOsunPGi5GnYL/N0+Iyd+GKlZbAi8+z/fwq
         Wbcis6oZ+siYfVooWRB8SoivTFFGhP9HlqWYTY4/ggiQE0OAQZfyJuYO+fJXNPeKPTQG
         56Lw==
X-Gm-Message-State: AOAM5323EJ57KXhV8jZmhwRErCtg32TptPHkf8sYEH/nHWOIbf3S8oFm
        pQ0GmZngdw27koRuW4Jbr9ZP+A==
X-Google-Smtp-Source: ABdhPJy6g24ppchac1Gu6Rxw7HpwbDX6ILuD3CgG1e/lsWborJqP+sxh9RaxdhENz650nGxRBWHmFQ==
X-Received: by 2002:a17:902:ec84:b029:ea:b28d:e53e with SMTP id x4-20020a170902ec84b02900eab28de53emr10072302plg.77.1618591267200;
        Fri, 16 Apr 2021 09:41:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ccd5:218f:365:b90f])
        by smtp.gmail.com with ESMTPSA id g14sm6187186pjh.28.2021.04.16.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:41:06 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 5/8] arm64: dts: mt8183: Add kukui-jacuzzi-kappa board
Date:   Sat, 17 Apr 2021 00:40:52 +0800
Message-Id: <20210416164055.3223088-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kappa is known as HP Chromebook 11a

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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
2.31.1.368.gbe11c130af-goog

