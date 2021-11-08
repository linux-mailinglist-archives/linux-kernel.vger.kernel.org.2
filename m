Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D8447B09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhKHHaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbhKHHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:30:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1ECC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 23:27:23 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id j9so14406657pgh.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMyybJ8cedWreU7hFIqGdeFr06iYH5ttCqNwsXNo+Ug=;
        b=BlJ4p8MnCKRJrHov42Gw5KKXGTRYkmjY6+EH1ZkUsBlpQHSn1X3MArHfqqyICbpt8J
         ckBJBTOX1M7RNcLEX4+BBy5saGYqpvpVQDtiX6EgOU3R+pDDNCsYiY2H3XOSmlcBFFFS
         yPaiSqa+hYKrxoqtG0Csp1v1bWOsB8bznR7Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMyybJ8cedWreU7hFIqGdeFr06iYH5ttCqNwsXNo+Ug=;
        b=KdVtIMwy0FFZo3hPBaLe/iubjExTiU0XJNIY58tjvxxXa66e46FLxaf6SXnoAl1UaT
         ZmPBUo9eFQJascpLglpEqZdoXMwyRLWI894J5XMtq+SQif8SgfPUJ4nZwIlKfLVLCEgR
         rybL9IYjaUQQYvdLObbSyW0Z1KcF5H0rwLV0mW7A+ms25+pZz7qD8kKZv5CRI16teEDY
         nzxW4ADm+9KTjxIn5rHJI/NWeW3e1m42Mxy5psFs6JG+Q8DaaMdY63hnHo5i/VVzNpTt
         jFFdQqxSV/fh1+oY8VCxjbMN5fBB4Ew/LlLZ8AzngfWRPyMXIEvNAdlrz0G9kXynSOKM
         UUbw==
X-Gm-Message-State: AOAM532t7w3S0JSGFcp+gUu0LednXt/+kBHFgmc2QI8/f51q4aAikIgT
        bmCqVkONNoAEOH4DIDV2BRvbiw==
X-Google-Smtp-Source: ABdhPJzGTEjdH6LyTtUqnt1Zognyi8VuOYKKerfR1nK0zQN7I97rN5Rl+Pi5/x087s9KQfDWroMIMg==
X-Received: by 2002:a63:af06:: with SMTP id w6mr58727268pge.436.1636356443295;
        Sun, 07 Nov 2021 23:27:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f03:6a9b:24e8:3a2e])
        by smtp.gmail.com with ESMTPSA id e8sm11684972pgn.46.2021.11.07.23.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 23:27:23 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: mt8183: Add kakadu sku22
Date:   Mon,  8 Nov 2021 15:27:08 +0800
Message-Id: <20211108072711.1628566-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211108072711.1628566-1-hsinyi@chromium.org>
References: <20211108072711.1628566-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kakadu sku22 is using mediatek,mt8183_mt6358_ts3a227_rt1015p audio codec

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8183-kukui-kakadu-sku22.dts    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 9834bd659d1530..1613259b686576 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu-sku22.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku272.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku288.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts
new file mode 100644
index 00000000000000..3a724e6f915cd5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-kakadu.dtsi"
+#include "mt8183-kukui-audio-rt1015p.dtsi"
+
+/ {
+	model = "MediaTek kakadu board sku22";
+	compatible = "google,kakadu-rev3-sku22", "google,kakadu-rev2-sku22",
+		     "google,kakadu", "mediatek,mt8183";
+};
+
+&sound {
+	compatible = "mediatek,mt8183_mt6358_ts3a227_rt1015p";
+};
+
-- 
2.34.0.rc0.344.g81b53c2807-goog

