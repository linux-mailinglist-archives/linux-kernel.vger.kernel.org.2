Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB33B9F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGBKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhGBKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:25:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E630C061765
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 03:23:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so9106973pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp+Bhq4lKPiXlt4EaMla6Yc+MtggvqEHex3ImjFAmEU=;
        b=PWpyV8RSDVBda3F+KD+HwhmTw+MqtWuLLQXquKBpQIH5TTz0HMydEa6poyzI2T46Mz
         bKv4jJquVOihYOLEiuVq351KwNgctRsTxbZKAsXMJNP90FCyWbwCdXx+XiRORyGlHFKf
         nNBf1bIu4EkQxHIs3EEqgPGOl4UCgHvA3XDfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp+Bhq4lKPiXlt4EaMla6Yc+MtggvqEHex3ImjFAmEU=;
        b=JQfwNmO/zYijz+Oh8AHaQldDe5QIWF69mzG/vbkt06AvQQct0tQ6li/eJVc+aeaW4n
         JizEVTSiegQee0GDv8taAGx7YYqIBPp3lWEu2iFrdA1+d2ELTI7Oa1ccPf5oVb0r2KtL
         MmyPSSylqiKI3kzGOHKD76U/IMOr/X2kk196yT4E8UsbBQOxF/AnlL4uuVfPPw+Q0HWI
         JobOmoD+e6NNwnTSwUhSSZuXrRrHQ37cVG+DY+cAdzebKrq4KBdDN59t1ji5+oVa7R8F
         jAM0N2RFp3HUAxVfgL6I5v/NW4pUGICeTAPfxvHQ9vY5XHh1oznBAwV5jY80JzuwRgsS
         kK5Q==
X-Gm-Message-State: AOAM531oFU7EmJ5NgTsqsZKiyEzw+xv4o1q2hjDT2Oyubwq0gTf3TjX0
        cAdOkhWpQKQR0CEhG5s8pm7baQ==
X-Google-Smtp-Source: ABdhPJwoOPVoCSfUpMXiGFWZ9icm7QWpEkvqB7rr6mfeotvi+E2V0XfrHm9+YgiEdsFt0c9hFbdIcQ==
X-Received: by 2002:a05:6a00:15d3:b029:308:b2ed:6560 with SMTP id o19-20020a056a0015d3b0290308b2ed6560mr4603080pfu.32.1625221400502;
        Fri, 02 Jul 2021 03:23:20 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b63b:3ac0:4dda:fdd2])
        by smtp.gmail.com with ESMTPSA id d13sm2863484pfn.136.2021.07.02.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:23:20 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v5 RESEND 3/3] arm64: dts: mt8183: add jpeg enc node for mt8183
Date:   Fri,  2 Jul 2021 18:23:04 +0800
Message-Id: <20210702102304.3346429-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210702102304.3346429-1-hsinyi@chromium.org>
References: <20210702102304.3346429-1-hsinyi@chromium.org>
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
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index f90df6439c088..ca8ad953de914 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1435,6 +1435,18 @@ larb4: larb@17010000 {
 			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
 		};
 
+		venc_jpg: venc_jpg@17030000 {
+			compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x17030000 0 0x1000>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larb = <&larb4>;
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
2.32.0.93.g670b81a890-goog

