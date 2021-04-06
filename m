Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE10355269
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbhDFLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbhDFLgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:36:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:36:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u11so1424797wrp.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8P1R0vOoYt+iRLp92hKy4ER47sIrroX6pk17J519zYo=;
        b=0K2AIi2IQdb5pGIrrn10xuntiCkPk55XqsYL3mys4hDU3VKZhQpfOosx/g3+Klx4uV
         TFsbFZzrR8pxinBxmTvvH5PxCBheqHQjMHi9EsUm7ljXSQTzDBqOEl2K8B9VOMIoG6lj
         c4H43xx9TlG4zuUvpaB4K6rISFfpI63gYH71NBXpvFaXobCA4EXYbvM2JvWABLzGfV1D
         q8Yfk++i/VJaDIDgBMNlZSa/nJcNtV3e3uPG+l+iB5xEKHR6RvvNz3doJxq1j3PBfawo
         rWGyO1YcBurBAB2RQSR5xgXFuEKiKAlDaczu1vEK2v08g4NxatP2qCkCVmgvyQ5rjEpR
         c/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P1R0vOoYt+iRLp92hKy4ER47sIrroX6pk17J519zYo=;
        b=Irg1jHUW067RY11ZEH7NbDwRpjmoLs+JiZwfKbfQSBmcOFMWPjaX/I/dHqyJdijVx/
         UoRV9Smr3wxtyYpfK5tZAUo1yOQRuS0/9VY30w06SdQ94KL63gTqFPTyeI6tdrwTk2iq
         WtglGtOYJVmYqKwc+F471eFl7z0fSneB7wI0LOw0U1KfNODC/cj4aTZxRs51zD4aNXsl
         75W4zTbmcK6s6C5jF2219HSlwQTmddhF4lt4ePHL17je5wNuSGp7oGk9iQphcl+Oz5om
         1WNjyAli/OJqt05ZeCij5lumvqlXw2/HOqjmJ9Z/M5Tb4k0NFrEYaYxBMwpQ8Pe6fA+a
         AAsQ==
X-Gm-Message-State: AOAM533IPC4MKQ/xf7AxILrOv4psSITePVEcwqjsERwSWVYYJDgXNgow
        LQHY9wxayhZDT5FH+aSYLyiVoA==
X-Google-Smtp-Source: ABdhPJy5ttjZp/FzT2SOjuTcZRTy3ru48FPTj495+Gc5ocBZ/liZRPJ1hrEFxiPl5jG/QXOc+E+91g==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr34993104wrr.118.1617708994692;
        Tue, 06 Apr 2021 04:36:34 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k3sm11880735wrc.67.2021.04.06.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:36:34 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: mediatek: mt8167: add iommu node
Date:   Tue,  6 Apr 2021 13:36:29 +0200
Message-Id: <20210406113631.2675029-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210406113631.2675029-1-fparent@baylibre.com>
References: <20210406113631.2675029-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the MT8167's IOMMU.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2

V3:
	* Removed unicode character in commit summary
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

