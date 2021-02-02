Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF44D30B95D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhBBIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhBBIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:14:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB3C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:12:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s24so1779045pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bXT4E5Sy6uZLs7wQdo5bJTu5WRYHheEqLaM47OwgPQ=;
        b=N9CZId4S7hNYbNn/EmNWWSAr8wF37aSzNhCtlBao3KDWLCsBnQnmZwcwgNMVJ+Qgwo
         aEvbUuzL0mg9ObRvaxRKPwBfDVNBc/IjdMlgNHMZ3Imd5TFB8ytiv7YYtsf12SVSmqA6
         D0RYUGNidfFwif5NovKfJrFGa4Yw/81TQFZvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bXT4E5Sy6uZLs7wQdo5bJTu5WRYHheEqLaM47OwgPQ=;
        b=ldpaOllsF4nP5/ntaTSgZnguomxKgXtNZk6qG0W1MSOv/f8T5sBG09UPD/Ea0cPa8y
         wjr+aGIN7F8ZDBlz3QU97byzfSCMs6xga7kVFbN0IR1wUYmhxecJpNZk1cUsWNhyzb4d
         Ip0Cwe+j2D4GIwj/xcCfqKw8pgCYy/AB0xurDAotwpU34hAlT1XXH81UveMvARAZSeEF
         gbpa+neMD5IwJyxvcS98ml+MFUef/j7oS5c0aK8AxMofh9vuTreJuQwpJqY9+ha8zqY9
         wvivC77D9KoyPcWEx1/xiy9ACNnYomR2yyYNFE40EsgbgsiUjHyIJX6ARK8VbwZbm0Xb
         4Qfw==
X-Gm-Message-State: AOAM530Y94NFzCBGYxXpcmb3S6nEJrcAhLo3QmLr3/yCFDtMyFJMbw5f
        2XIG1OMIWFshJEvb9gHw+8I7DQ==
X-Google-Smtp-Source: ABdhPJyLF2wHpV/D+HMLvMmxWe3iY+vP7l2QjMeBApFcWHo4WmvFIsbrCNchQ+/N5KYiGO8dwC/Qbg==
X-Received: by 2002:a17:90b:512:: with SMTP id r18mr3195381pjz.124.1612253575220;
        Tue, 02 Feb 2021 00:12:55 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id c8sm21343325pfo.148.2021.02.02.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:12:54 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6 5/8] drm/mediatek: Fix ccorr size config
Date:   Tue,  2 Feb 2021 16:12:34 +0800
Message-Id: <20210202081237.774442-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202081237.774442-1-hsinyi@chromium.org>
References: <20210202081237.774442-1-hsinyi@chromium.org>
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
Reviewed-by: CK Hu <ck.hu@mediatek.com>
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

