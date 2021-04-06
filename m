Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF33355222
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhDFLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhDFLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:32:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:32:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a12so4066049wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B78AvIQPTuA3l0I3nLNmMUo3amV0ILeS2vy0UzeA6L4=;
        b=u7n2cx+mCvs3EGNR7IWh8V5vzcykWoEiaHrhDlO06ILrrjUaIARIpvQLLN3JdyT/e4
         ijVXmdy+hAXuVHS+L9sQpakwXA/PGvbj46pkt3v/e2MhUCf5+dYmfQOu3yg4WvPx6LfB
         nSXlJRH9X4SVt7SwWo6AWSyO9zl5w0HwdzNV/lhNpbxwZxkjLQXQA578nqIZ4bp6sddo
         JsK5qzsMQCqwo4FqsmcPWxXac+lwL4bh1gA3PTgfss9HleFf5pcdVkFyOeOBv2NibOp3
         kbs48/bh+PPICnHJAjd4ad6WuXUcyemElFGwhvdIAgnetJAM4V0IqPEgR7lyZXOzX6J2
         m6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B78AvIQPTuA3l0I3nLNmMUo3amV0ILeS2vy0UzeA6L4=;
        b=R/59lKF4vfksaaWqqZp5awtE4FpCaZVXvwwbAys13WmrXzjb3n76fdo0bCltAYBaIK
         mKhAIm/AD5qi+h5Z6p4cArSyMP02PoWuOdcIZ1VAKNGQwLyN87aSKqy7dTMIn1RV4KD1
         m97EdylbWI/Ry/EtiWT2/boL8nVz5bhf58KxQUuv07WQg+JJxaRlX9rwJmk7yjc5Yp9F
         OYjVOhH7CuWLccVA0d9D9bCL+/LpLGCHGU7Yeyk5RKfKSEpMGRxKuVOpFKblY/xnYocN
         YVsxoucY1P3PCQenzMSNO/Brj99TDQYvsPKJAw81vh92L7DaJoYBvAvj10T0OBisrhtB
         vbOQ==
X-Gm-Message-State: AOAM532TVL87OeHXS8PuGpfeojnYqySLVUT8Pa5XSmOa/5sD0xhCMvJz
        g9lMkyS+8kKZ97hgPS2gyMBi5A==
X-Google-Smtp-Source: ABdhPJxY199dcKmICZi49GxfShfRAikMdicOk2ggDqvXYLtcCRH1yvdjM9A1IJTgiSOGnHW+aOF4/A==
X-Received: by 2002:a05:6000:544:: with SMTP id b4mr5641500wrf.352.1617708768363;
        Tue, 06 Apr 2021 04:32:48 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id j6sm2424229wmq.16.2021.04.06.04.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:32:47 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] =?UTF-8?q?=F0=9F=93=A4=20arm64:=20dts:=20mediatek:?= =?UTF-8?q?=20mt8167:=20add=20iommu=20node?=
Date:   Tue,  6 Apr 2021 13:32:41 +0200
Message-Id: <20210406113243.2665847-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210406113243.2665847-1-fparent@baylibre.com>
References: <20210406113243.2665847-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the MT8167's IOMMU.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2

V2:
	* Remove unneeded cell-index property

 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index bbddd4b22d3e..9029051624a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -170,5 +170,13 @@ larb2: larb@16010000 {
 			clock-names = "apb", "smi";
 			power-domains = <&spm MT8167_POWER_DOMAIN_VDEC>;
 		};
+
+		iommu: m4u@10203000 {
+			compatible = "mediatek,mt8167-m4u";
+			reg = <0 0x10203000 0 0x1000>;
+			mediatek,larbs = <&larb0 &larb1 &larb2>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_LOW>;
+			#iommu-cells = <1>;
+		};
 	};
 };
-- 
2.31.0

