Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D2355266
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbhDFLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhDFLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:36:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D754C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:36:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f6so7763697wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+nH21JCvam+dYUjtR0Eymm99HB3jx355hDeinSGyzQ=;
        b=dfACU2xivv5z+PLTgQvy1TvdJbRUFa6y2RdAyY8l3qghCSlCCf9TrOMUJaX2QbqufE
         UP3Y41nF6bQ23r+Cq2oW0ZRvRrapW8H3tsQ0cMetakyEbdmucJvOouQt2MwdxYVzJPSr
         YAvemBGnWNC9u2IjB73TVWYfwstldzZNfePTi6mFVy+JW4o2MmtjakxnMVNBe3q6x2VJ
         gmH7s56rbHIZYwfK72Nl11sRp3AF8VPkb3rEUIdb+Cx1h/jiaLcWSWy6NHDwuptNLP8X
         46C+7Kxf6HEtrUGWdQthU6XPYoAbG4YJoC0T7eJPx3jjB7oxvPu+bmAfT6PVzKkLlYrt
         Uyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+nH21JCvam+dYUjtR0Eymm99HB3jx355hDeinSGyzQ=;
        b=JTH8aJBPtQ4pDvH2sibC4NbFjZeuUep+H3JEYPOhVCY/P2h3FPOEVtVniWVHn434D/
         IclbXCPERP+Y1Qx62addm52yOWQE+ylNmOxBmd85DCqdRfAhC64R49lkZBzwem0PngZ3
         ha6Y/Ig7JA2nGSu8kpKbCKUQiZMRCg+FBR/Z4+HKZRNXTsQprEqOnnwez5T4xaP8UZ0K
         uzszSeoxHpE7fjstn0EDQOuZIIOK6PXz1Z0GRohR+R+iM7LBAyYkcFeQcSIYnzlV/UK5
         h+tWwhtm+K+PnSFK/imiD+bj+ONTRh6e9488iE1Y0FHSq3djWEamMIx5J01aPeftC++y
         gx2g==
X-Gm-Message-State: AOAM532qGXK/Mm+SiwqxX5XM1GKRMm1C6xWFSpO8FS8Mddz4A4oXEdfC
        a3Ambat+Ihbtt35hqQjxlYboKQ==
X-Google-Smtp-Source: ABdhPJxGxdN0DkHzApkTQUwPHD1Q4xSZfMoMeLq7WWOXS4qDqtTM09jiZ+TK5o3nnGduMSPPFgaAZw==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr34067108wri.403.1617708993266;
        Tue, 06 Apr 2021 04:36:33 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k3sm11880735wrc.67.2021.04.06.04.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:36:32 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: mediatek: mt8167: add larb nodes
Date:   Tue,  6 Apr 2021 13:36:28 +0200
Message-Id: <20210406113631.2675029-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add larb nodes for MT8167:
* larb0 is used for display (dsi and hdmi)
* larb1 is used for camera (csi)
* larb2 is used for the video hardware decoder

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2

V3:
	* Removed unicode character in commit summary
V2:
	* Removed unneeded mediatek,larb-id property

 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 4b951f81db9e..bbddd4b22d3e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -140,5 +140,35 @@ smi_common: smi@14017000 {
 			clock-names = "apb", "smi";
 			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
 		};
+
+		larb0: larb@14016000 {
+			compatible = "mediatek,mt8167-smi-larb";
+			reg = <0 0x14016000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+		};
+
+		larb1: larb@15001000 {
+			compatible = "mediatek,mt8167-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB1_SMI>,
+				 <&imgsys CLK_IMG_LARB1_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8167_POWER_DOMAIN_ISP>;
+		};
+
+		larb2: larb@16010000 {
+			compatible = "mediatek,mt8167-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_CKEN>,
+				 <&vdecsys CLK_VDEC_LARB1_CKEN>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8167_POWER_DOMAIN_VDEC>;
+		};
 	};
 };
-- 
2.31.0

