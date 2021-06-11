Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C83A412B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFKLWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFKLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:22:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC207C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:20:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7105592pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QwvH5bGqHeUyZVp5Ps3bAzGRgv84nKw9pL18XwdnBM=;
        b=kk3HFX3t7+pm4U/kjbmmasXspVI2T+d5ttTTpONnlHt9FJYS47YoPl6FI4PGXes9Wc
         6QS1tcKLLxH/Y0PD3TQ9KyiAySH3iNieFqIF9+2m7FSXNetsYOKvLEh6swUIljF9NFG0
         2eC5PsZkx/XLvDuBZG5ZICFggERngLC8Vp8Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QwvH5bGqHeUyZVp5Ps3bAzGRgv84nKw9pL18XwdnBM=;
        b=HgTO3DlnW2dHnFNDCF+VHrCNq07ocul14FuXwr4MfTFWtx+337keWhB60ZdEea9Yw1
         Q7+Z5tPpzNOenOlINHJyqHH1bCIBfb/7dUyGGbSRv6P3y91edkxobN4Hxegxr3EQDH3+
         8B69q8b/Q7WuZTL644uKD6KJGuAS+WhsfD54tFJHGWtH8PRqp2tpnVA0HaW3yDhuJ4zS
         MaGlUthEszUm20PMmIKB4OjxHAbdRXSmD32GEtyx0y8Ju3RlYhHBlJbk2b5XP3uoi2xl
         HUvfy3n9A6y94u3kP22Cd2qT/G2t+nm/VIRDKnNLX2xjsVQTYl/4AK+HN5wdDI9wY+/q
         qGMQ==
X-Gm-Message-State: AOAM532XQtwsbJ0gBYdewtKfQ5jnsFd7KiFM8c7f8FFsF5RBFLLNjjfg
        QipEuY8h9Dw0XRSxKzVMsP6mLQ==
X-Google-Smtp-Source: ABdhPJzduBIz6I4dCv6hcEL/NSQSitCklTwTnFZIr9rbFuPwFRYv2RhdaiZve2JcmaimUOSyRSHFlA==
X-Received: by 2002:a17:90b:3696:: with SMTP id mj22mr3994602pjb.42.1623410418179;
        Fri, 11 Jun 2021 04:20:18 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:73d3:4412:54cc:752d])
        by smtp.gmail.com with ESMTPSA id y5sm5177189pfo.25.2021.06.11.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:20:17 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v4 3/3] arm64: dts: mt8183: add jpeg enc node for mt8183
Date:   Fri, 11 Jun 2021 19:20:09 +0800
Message-Id: <20210611112009.2955944-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611112009.2955944-1-hsinyi@chromium.org>
References: <20210611112009.2955944-1-hsinyi@chromium.org>
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
index c5e822b6b77a3..d54b4532fc3f3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1329,6 +1329,18 @@ larb4: larb@17010000 {
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
2.32.0.272.g935e593368-goog

