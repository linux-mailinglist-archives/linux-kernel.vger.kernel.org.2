Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B43DD567
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhHBMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhHBMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:13:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D76FC0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:13:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so5485663pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2JtECa2IcVydNG9W9omBIT16d7EqW3TFLgJK31zJ7o=;
        b=eUvsQdPL/VkVnjaMbKYUtiGlRVNvPiAkh5fuwmShF9oNk/WZQ0kSW/XOFks1faLV9A
         RMDuDFpF3fcrm2RRfaR+8cXVmZPgqtFwsvxfahHuqk0gmcUfhKM/PHT1kHA5jEmJ+Zli
         YQG12rziTEbbsWhrj/rcEnlI8L7MboOCLrL9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2JtECa2IcVydNG9W9omBIT16d7EqW3TFLgJK31zJ7o=;
        b=BcI7APocCvx6UExIS8QVvq/Zqwoi8/8dgrLc4Z13M98Q7T7AZ/P3b69V7A4MY0q4YH
         vSkf8fYga/zAlDffSGlObOtUbpAnVC2YEnOTzwxEp8969SwtS34W5yEXdrV+oQyTeEMU
         VXLjgfm2KgZzS19KhlLisWk76VgYMDrWrMdw9726i9UcU9TPauTd1NwjILuieZQ/2Pue
         NH8kaztvlB1sidBhrI9RdBAljgda5Rt+FkO/8Nb1PqHVZQlKEiMBFLnyikjOZzcrDB5q
         MQD8eXrahfdIPWXbDFayL40qpdx75ko/Ze2CuaApVY4Gl8ZfpxiPaCwLb1igZw/QmmSk
         zqvA==
X-Gm-Message-State: AOAM532r4e60Zfy0JgImbrqPtiIVJCfnFQjOgGi3raR5lc02sudfjC8b
        t0Yi3+G9onFRx1YJXAL8tmW1xUb0JbZOOw==
X-Google-Smtp-Source: ABdhPJwDDACME/3b7TMkfgVYpZwoXd52Lpsw79m+gpQ1U876rXmkAZoCr6Z2s93D5COFlJv9y4ZIlA==
X-Received: by 2002:a62:ea1a:0:b029:329:a95a:fab with SMTP id t26-20020a62ea1a0000b0290329a95a0fabmr16889563pfh.31.1627906392167;
        Mon, 02 Aug 2021 05:13:12 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:cd34:e942:c094:baef])
        by smtp.gmail.com with UTF8SMTPSA id ns4sm691855pjb.51.2021.08.02.05.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 05:13:11 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wenst@chromium.org, houlong.wei@mediatek.com, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org, Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v6 6/9] soc: mediatek: mmsys: instantiate mdp virtual device from mmsys
Date:   Mon,  2 Aug 2021 22:12:12 +1000
Message-Id: <20210802220943.v6.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210802121215.703023-1-eizan@chromium.org>
References: <20210802121215.703023-1-eizan@chromium.org>
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
2.32.0.554.ge1b32706d8-goog

