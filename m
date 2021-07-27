Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8713D741D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhG0LPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhG0LPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:15:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913EAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:15:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n10so15491985plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kNbslq7vj9YiuOoktOVh6hBVXag9OQ/inx+NSoMTgg=;
        b=EKGqxJGnjY+bKuBecKb+9x9V4U/zyM+DfI9cY8TJhi7MREHhy+5CblfukvfTyY1GnK
         qLPMOn0NfI5IO1onW2adkZwW/WzOoH05UqDRSyeJKs5LkjOYVDEoomKGyJe01U66eDjT
         cDOB5epPM1W3XhF+rOhslBK60tOGTaMakKcCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kNbslq7vj9YiuOoktOVh6hBVXag9OQ/inx+NSoMTgg=;
        b=LKMcZn34QyUhLlUNFEtsLWKN/My2/zjtzLqD01TrBRJ7wd7PyosD4idOz20vrtXGDv
         fukmZd3XoF0DGufogBDKNfIOgA3mGmde4A2mEay/1m6tx2V7t3TJUBv+SxFuMsj0rWqa
         kpGw45kyZcnlY59ENA33BlDOZAtrr6vG5ElwB+rrDedOTMPuarGEF1onv18/xzAbsohM
         hRSeXiQsCf6dY+P8jsW6x8rCd8GC16BtArZzW6Za5FJUiUMP14ApmmDo6czeoxeU89Z0
         xQvtbBEVkPUQzciPTm7QZe7kJYn7FIrzfnczBce6lneYLgulfZpRiZKRStUoTK+69JUf
         wf1w==
X-Gm-Message-State: AOAM53098Uhjb+WSyeel+DMQ5MeRmL6hA/uL9jOMH5jW3H8pXJENzG9p
        r9gQ+4YiTQymOIv0h7uNsxHvvg==
X-Google-Smtp-Source: ABdhPJzkLIgghdfrbRoZrulmILkoZzo0xSTn37F9lFpSImUcxzYkhY/lOslEJ4rksKObpe9qSWZe7Q==
X-Received: by 2002:a63:5f55:: with SMTP id t82mr23038185pgb.226.1627384510116;
        Tue, 27 Jul 2021 04:15:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id t1sm3362305pgp.42.2021.07.27.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:15:09 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
Date:   Tue, 27 Jul 2021 19:15:02 +0800
Message-Id: <20210727111502.2506311-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727111502.2506311-1-hsinyi@chromium.org>
References: <20210727111502.2506311-1-hsinyi@chromium.org>
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

