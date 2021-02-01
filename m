Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488E30A58E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhBAKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbhBAKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385DC061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m12so847713pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1Znj6OivgMAdlpTmZtNwTUdHVfyjxsrVrIZX5cgCQQ=;
        b=IqbgFDU6SacFk6Q8JhPBEmJAFEhQ/ymT7/a8vm5CwjxqaAZiCdjM+NOcurbcxqQ5Em
         k6XTuW9LT9nueisEfNgpM6C5CLLJNjFSxsR/83UNv9pxyCjJO6Bo9FQHaFO7RQrV2XbU
         mt8sp5rv8iPsrJXjVhBU01g7iGOjHB7qlDEsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1Znj6OivgMAdlpTmZtNwTUdHVfyjxsrVrIZX5cgCQQ=;
        b=EzQE3SPjZPyw/Ilh2rXGUVYJYeI8sMblIeI1EP/RjNPNkKLvKhO4ey7BW09aSi8WHB
         RynGllpX1W3vZ+ZL3udJKUqAYgFF2+mhacMVQbXLidzznlByUpyIA8A4kWk86VX0pe4q
         RnY6LcYyaUxvyVuwunFjlns3oG65WzJwuUr+DIkz15/N0s5gJAeEUDgIp+GP/o4HVCXf
         8wn2dJzNdG58HQTodAr9b1t2aISaeXQ+8XRMCXU3/9rt7TlsVpAOamqRY4i2ZR/wLUcv
         nnDsHpQFV2apsPuc+n4f6clomUj4engLxPH8Pqsw3mHMxgNs8XN3FbSmYR/SFmPvHJ08
         LSJA==
X-Gm-Message-State: AOAM5320MFrTpYkCQIve0rrEicAIMbzXbFpjNPq5/ubUKyBBWVQaTSsf
        oDnlJh5DgJBJRVAn0AC8R8y66g==
X-Google-Smtp-Source: ABdhPJxGUkkAe7tJYEX6+fmpVDu6k+JrucNgsMp+k/qXCq7PXx13UGJgUbgz79Nopoo1YkUnJH/rfg==
X-Received: by 2002:a17:902:b206:b029:dc:1f41:962d with SMTP id t6-20020a170902b206b02900dc1f41962dmr17350708plr.28.1612175865282;
        Mon, 01 Feb 2021 02:37:45 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:44 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 5/8] drm/mediatek: Fix ccorr size config
Date:   Mon,  1 Feb 2021 18:37:24 +0800
Message-Id: <20210201103727.376721-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210201103727.376721-1-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Fix setting to follow hardware datasheet. The original error setting
affects mt8192 display.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 6ee2431e6b843..6c86673a835c3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -65,7 +65,7 @@ void mtk_ccorr_config(struct device *dev, unsigned int w,
 {
 	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
 
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &ccorr->cmdq_reg, ccorr->regs,
+	mtk_ddp_write(cmdq_pkt, w << 16 | h, &ccorr->cmdq_reg, ccorr->regs,
 		      DISP_CCORR_SIZE);
 	mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &ccorr->cmdq_reg, ccorr->regs,
 		      DISP_CCORR_CFG);
-- 
2.30.0.365.g02bc693789-goog

