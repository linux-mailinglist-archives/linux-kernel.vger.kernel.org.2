Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A103A0BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhFIEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFIEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:50:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E37C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:49:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k15so17469021pfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYok65sFwc6WEDcag9xh0Hf6j7gDgq0CQ1KsKHhgvjo=;
        b=IiKc5ndp1M+CHWA+wdg+354lmwNXghTKdybF8tq0RZvCL5COD05uofXz0TjPvIqrWD
         2Zd0UlSBCO8bso5l3lOkrxIqxpFUkoAtZW9Vodvtph2lfU6bzvov7tO/ZuOj6l+ULzzt
         HjWDkmXNfdxxOHBFRr+e80s0Z+H6fkvwtboE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYok65sFwc6WEDcag9xh0Hf6j7gDgq0CQ1KsKHhgvjo=;
        b=UIzTdD+2wKHWo7qjR47xmy3+2BRVWBoN/HEZHGhwOEXMlKU5mZCg4jKZ5NS0tTww15
         i3i9YutXPBRGkdaIvK8csn3VOg0nC1z0q4CvG17vmq+b/m/yThloPt/s6CjRr9G/nEhs
         UaYdWb3Ou0yV8qqtEl92LYiq0P6TLo0tdddYgD3CLah9iYxah5Hz0HuZBjWE4x+M4BSI
         V0aKK0FMy/k/9etKYfYRrwN0u732YGCX2d8Xw8LzGy3YajANRPqq6GOBwHHLepim7rWb
         ht6qyev/goeNiSoWsgf5cVO8ccq9fbhTdEZSLvwY4AF2v+e3tQPb5DH2Z5YHgs1gV7n/
         dEiw==
X-Gm-Message-State: AOAM532y6pBDMwUgEe3vVRT90mYFsS4fCkk32hqbrbR1aU7Ts4V1ctT8
        /46xI4nBhI6mZlFrE0opPytsEw==
X-Google-Smtp-Source: ABdhPJzu5e6c64mB7KD2PoLwdt2R2dL9vCR7lWw3zZp8Cn9JbjCwrAk24pXd1HLgFvQL4XbwwXG88A==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr3335696pff.49.1623214139561;
        Tue, 08 Jun 2021 21:48:59 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:83f0:56eb:3535:6bd5])
        by smtp.gmail.com with ESMTPSA id h18sm12865110pgl.87.2021.06.08.21.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:48:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com,
        tfiga@chromium.org
Subject: [PATCH v2] arm64: dts: mt8183: add jpeg enc node for mt8183
Date:   Wed,  9 Jun 2021 12:48:54 +0800
Message-Id: <20210609044854.393452-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maoguang Meng <maoguang.meng@mediatek.com>

Add jpeg encoder device tree node.

Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2: rebase to latest
v1: https://patchwork.kernel.org/project/linux-media/patch/20200914094012.5817-1-maoguang.meng@mediatek.com/
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c5e822b6b77a3..fffe0c52909ce 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1329,6 +1329,17 @@ larb4: larb@17010000 {
 			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
 		};
 
+		venc_jpg: venc_jpg@17030000 {
+			compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x17030000 0 0x1000>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_JPGENC_RDMA>,
+				 <&iommu M4U_PORT_JPGENC_BSDMA>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
+			clocks = <&vencsys CLK_VENC_JPGENC>;
+			clock-names = "jpgenc";
+		};
+
 		ipu_conn: syscon@19000000 {
 			compatible = "mediatek,mt8183-ipu_conn", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

