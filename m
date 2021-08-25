Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790273F6F98
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhHYGf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbhHYGfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:35:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D800C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:34:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x4so22085882pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzlvJ2pAHb+sQ8dhm6xnHR8froez4GvdycGHyMNLelc=;
        b=F5WiZhJXhxWF/mbzczkd9cNjwJ7S8d9ymOQjMsx98QRxA/cRwjk7CT7VlyyPZ8SMhW
         6da0jFGq6g5+LO8kceKVimbN5cE10MTXCRR9QGTyuWnBhktP6IxBUmeDLqAnLqM7WKDK
         BDkqDUPZIyf2oas8jRvXhgZerNuyKQV0G0uSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzlvJ2pAHb+sQ8dhm6xnHR8froez4GvdycGHyMNLelc=;
        b=f++rD5fLOBLnFRpgCNlDN8gkSzW+nmVEJWrkG3KuRY99rZOU+GR7vCvrCdmFwho8LI
         Gk+Yjz5Qc+Ll/K3qKs9Z9l9SixER/hWC3MP0pcYc4qSCMuxaE6PQLWIbVe6laVbDnhd1
         uUnbxSqlYXTtT41d71cSGsoqEnErDZZfY7Q4alZKD+8rZNTgpqThoNxH2Tx5cmKdG7Vz
         EmjOzgr1i+EEuL+87C71TPCP1Hx14SWS03MYAnvKlazpFzdyFeniLCxqHfOT/qH/w4lX
         fJU+l2eeaQe5LJEY36y0dtK4ttoYj/Fnyh0dzg8TeikU+upTmCD3jjn9YD3qlsqtjeOG
         a1SQ==
X-Gm-Message-State: AOAM533OhK9skwaHW+xzGkj1/3hEhovAAQ1zHff6dvaW2jmODJVOLCh0
        4opITYjfg6z4BCKdrQLQdeL2ZP+ZsWkksg==
X-Google-Smtp-Source: ABdhPJx2TfFNIn39qLNwd5ZRKN9W2+I5qUl2jnGzviCUVZz+vZQt1XYHenjGJ99AZJTmbQntBR4yZA==
X-Received: by 2002:a63:4206:: with SMTP id p6mr32630642pga.449.1629873272423;
        Tue, 24 Aug 2021 23:34:32 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:3f2f:9e23:8a5:952])
        by smtp.gmail.com with UTF8SMTPSA id b10sm21105718pfi.122.2021.08.24.23.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 23:34:32 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, yong.wu@mediatek.com, wenst@chromium.org,
        ck.hu@mediatek.com, houlong.wei@mediatek.com,
        enric.balletbo@collabora.com, yongqiang.niu@mediatek.com,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v7 6/7] soc: mediatek: mmsys: instantiate mdp virtual device from mmsys
Date:   Wed, 25 Aug 2021 16:33:22 +1000
Message-Id: <20210825163247.v7.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
In-Reply-To: <20210825063323.3607738-1-eizan@chromium.org>
References: <20210825063323.3607738-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A virtual device that is probed by the mtk_mdp_core driver is
instantiated by the mtk_mmsys driver.

This better reflects the logical organization of the hardware and
driver: there are a number of hardware blocks that are used by the MDP
that have no strict hierarchy, and the software driver is responsible
for driving them properly.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
---

(no changes since v1)

 drivers/soc/mediatek/mtk-mmsys.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 080660ef11bf..e681029fe804 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -97,6 +97,7 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 	struct platform_device *clks;
 	struct platform_device *drm;
 	struct mtk_mmsys *mmsys;
+	struct platform_device *mdp;
 	int ret;
 
 	mmsys = devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
@@ -122,10 +123,27 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 					    PLATFORM_DEVID_AUTO, NULL, 0);
 	if (IS_ERR(drm)) {
 		platform_device_unregister(clks);
-		return PTR_ERR(drm);
+		ret = PTR_ERR(drm);
+		goto err_drm;
+	}
+
+	mdp = platform_device_register_data(&pdev->dev, "mtk-mdp",
+					    PLATFORM_DEVID_AUTO, NULL, 0);
+	if (IS_ERR(mdp)) {
+		ret = PTR_ERR(mdp);
+		dev_err(dev, "Failed to register mdp: %d\n", ret);
+		goto err_mdp;
 	}
 
 	return 0;
+
+err_mdp:
+	platform_device_unregister(drm);
+
+err_drm:
+	platform_device_unregister(clks);
+
+	return ret;
 }
 
 static const struct of_device_id of_match_mtk_mmsys[] = {
-- 
2.33.0.rc2.250.ged5fa647cd-goog

