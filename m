Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A19306FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhA1HhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhA1Hdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:33:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C7C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h15so2837972pli.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5JC3J9fiTLPDmuPJJpjxxF1Ga0nTHhfcPY/QtRnZ3w=;
        b=bKFUwTGyazHAINlNEy3tvekxCHGN20xbiU+MzmgJZ7r4ZJVV/IA51MJGx9CG0zzp/e
         WOg7TjLBWG8JaMfFhGBTHeFbRFBQ8eG5TY4G4VlVotheStiSLtGarvwpkxOC+xGF0qdT
         aHEkKWliZwTiqzGLhyutrShUsBuaJwlCTaPH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5JC3J9fiTLPDmuPJJpjxxF1Ga0nTHhfcPY/QtRnZ3w=;
        b=Tn5ivCMhe495WPW1qHyLPP0283h+/Nft3Erjj/asLmYaRVxT36vcbIMxyMgVCoEzft
         GXZFDYv13zETFsosCEACD+AUabzxeMeKAw9ueZy0vX9hFYnmndeYFUrijN5vR/Ad2WXb
         /aMAVLCylsUjl3+b8HaVB4MupYN8bo1gdPTM9Gwa4hfV7gX0bT4EY7XrReqQW2rUH9Ut
         V5itmrESdY9sBnpvE/OKRrC9BZUdmA2D2/G61XlowhepV7+Sv7Z6B3xB9Vr153bepS0n
         O1ZP8YyTRUskKfhPF/3DE8wnOBclMvQj+/8OOIpFJ1RE7/+O0R269J9CaicW3tpQAldo
         4esA==
X-Gm-Message-State: AOAM530jQX0ws80I6JPIidDsTAlJhmvEOtHhsRRyALVjXgh0Wwg6CVdr
        H45OLjXPQ1xODTxTuz0arrxfLw==
X-Google-Smtp-Source: ABdhPJzyocAU6LTq7WYj6JtsVxXfqP8goZhEPftbrsaGKzBZHQ0g/EnX2JCxYKHF5CFlM98QNs2s4Q==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr9845390pjo.234.1611818906090;
        Wed, 27 Jan 2021 23:28:26 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id h2sm4800304pfk.4.2021.01.27.23.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:28:25 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v11 6/9] drm/mediatek: add has_dither private data for gamma
Date:   Thu, 28 Jan 2021 15:27:59 +0800
Message-Id: <20210128072802.830971-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128072802.830971-1-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Not all SoC has dither function in gamma module.
Add private data to control this function setting.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index a7e2e326b2183..22199ef11f65d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -26,7 +26,7 @@
 #define LUT_10BIT_MASK				0x03ff
 
 struct mtk_disp_gamma_data {
-	u32 reserved;
+	bool has_dither;
 };
 
 /**
@@ -92,7 +92,8 @@ void mtk_gamma_config(struct device *dev, unsigned int w,
 
 	mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->regs,
 		      DISP_GAMMA_SIZE);
-	mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GAMMA_CFG, cmdq_pkt);
+	if (gamma->data && gamma->data->has_dither)
+		mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GAMMA_CFG, cmdq_pkt);
 }
 
 void mtk_gamma_start(struct device *dev)
@@ -172,8 +173,13 @@ static int mtk_disp_gamma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_gamma_data mt8173_gamma_driver_data = {
+	.has_dither = true,
+};
+
 static const struct of_device_id mtk_disp_gamma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-gamma"},
+	{ .compatible = "mediatek,mt8173-disp-gamma",
+	  .data = &mt8173_gamma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
-- 
2.30.0.280.ga3ce27912f-goog

