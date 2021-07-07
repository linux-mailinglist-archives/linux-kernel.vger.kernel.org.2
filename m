Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC33BE3A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGGHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhGGHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:37:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:34:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w15so1308755pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFOOJts7rrEL5kUzzl1L27qF8JAixgmRtoJGBoHNz+4=;
        b=KW4hOlquAvNKiDI5E3YLUGY4ojM8RmcRmXKtKMMO0zHIM+Jth15DrlQ1zEYh4VA5mM
         lRROJBxPpEueXgOhHUYog92xu4VijUWUDw11K5G0NQusvdKDPZhQD7kqvIJbtkLA0RoH
         A3uok+73m5VQ0exHCz458bn8WFOoN43e95+GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFOOJts7rrEL5kUzzl1L27qF8JAixgmRtoJGBoHNz+4=;
        b=YGLalqgEm8AmTBnYymbrZ3YN9S9DmqXKgk0W+RIdY0JlQyKP0U6aZcTpVyDqbN/y4e
         qX8+XyD3Aekk6WrpezKsamRbD2BZl5a/HJEPZIxKjafZi9h0d5FTVwaOFTifSNgS+wnX
         Jdc7iB5+sNycM29QFCoJ8AaYUF6NpdMG+h8smdfm2+fFZiGFEWSVo7Vvblwz2T/ZLrEi
         6XqrU4zNuezgJnIyViPJ6FWra2eA08kkjO0c2Vp2rpkCRvhtJvTxsZh2c9ktIwond8Fi
         lcMHG6RugihZiqA/qUmGR/4m+ml/LwHz1/OjQUXbWEIF/H+eZhbjLpKOHwY6+f8lE7q8
         vhRQ==
X-Gm-Message-State: AOAM533nu2UgNMGo6/DH2JGFLHt/tGpNiF413jq4AzX3hVJCM0t9YRoB
        oEHQJ9oEniL9/5u/k1uujtcFFUfaDZpKSw==
X-Google-Smtp-Source: ABdhPJzKNH0Z6jbCTZqE37jxP4jkU0W6j2YkBioqX2WNifrwe/WXbKls4DRS5Ev7Qup3EK2qzzfIkA==
X-Received: by 2002:a05:6a00:180d:b029:319:c3d8:16e1 with SMTP id y13-20020a056a00180db0290319c3d816e1mr21718004pfa.3.1625643286027;
        Wed, 07 Jul 2021 00:34:46 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:ccb9:d95f:4dac:dbc4])
        by smtp.gmail.com with UTF8SMTPSA id 75sm19843106pfb.159.2021.07.07.00.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:34:45 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     houlong.wei@mediatek.com, enric.balletbo@collabora.com,
        wenst@chromium.org, yong.wu@mediatek.com, chunkuang.hu@kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 2/8] mtk-mdp: use pm_runtime in MDP component driver
Date:   Wed,  7 Jul 2021 17:34:04 +1000
Message-Id: <20210707173108.v4.2.I909f5375d930f5d0cc877128e30e2a67078b674c@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707073410.999625-1-eizan@chromium.org>
References: <20210707073410.999625-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the MDP components are not fully integrated into
the runtime power management subsystem, and the MDP driver does not
work.

For each of the component device drivers to be able to call
pm_runtime_get/put_sync() a pointer to the component's device struct
had to be added to struct mtk_mdp_comp, set by mtk_mdp_comp_init().

Note that the dev argument to mtk_mdp_comp_clock_on/off() has been
removed. Those functions used to be called from the "master" mdp driver
in mtk_mdp_core.c, but the component's device pointer no longer
corresponds to the mdp master device pointer, which is not the right
device to pass to pm_runtime_put/get_sync() which we had to add to get
the driver to work properly.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

(no changes since v1)

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 21 ++++++++++++++-----
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  6 ++++--
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  6 ++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index aced0029b7cd..8cebc3565826 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -13,6 +13,8 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <soc/mediatek/smi.h>
+#include <linux/pm_runtime.h>
 
 #include "mtk_mdp_comp.h"
 #include "mtk_mdp_core.h"
@@ -51,22 +53,26 @@ static const struct of_device_id mtk_mdp_comp_driver_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_mdp_comp_driver_dt_match);
 
-void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
+void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp)
 {
 	int i, err;
 
+	err = pm_runtime_get_sync(comp->dev);
+	if (err < 0)
+		dev_err(comp->dev,
+			"failed to runtime get, err %d.\n",
+			err);
+
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		if (IS_ERR(comp->clk[i]))
 			continue;
 		err = clk_prepare_enable(comp->clk[i]);
 		if (err)
-			dev_err(dev,
-				"failed to enable clock, err %d. i:%d\n",
-				err, i);
+			dev_err(comp->dev, "failed to enable clock, err %d. i:%d\n", err, i);
 	}
 }
 
-void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
+void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
 {
 	int i;
 
@@ -75,6 +81,8 @@ void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
 			continue;
 		clk_disable_unprepare(comp->clk[i]);
 	}
+
+	pm_runtime_put_sync(comp->dev);
 }
 
 static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
@@ -84,6 +92,7 @@ static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
 	struct mtk_mdp_dev *mdp = data;
 
 	mtk_mdp_register_component(mdp, comp);
+	pm_runtime_enable(dev);
 
 	return 0;
 }
@@ -94,6 +103,7 @@ static void mtk_mdp_comp_unbind(struct device *dev, struct device *master,
 	struct mtk_mdp_dev *mdp = data;
 	struct mtk_mdp_comp *comp = dev_get_drvdata(dev);
 
+	pm_runtime_disable(dev);
 	mtk_mdp_unregister_component(mdp, comp);
 }
 
@@ -111,6 +121,7 @@ int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
 		 (enum mtk_mdp_comp_type)of_device_get_match_data(dev);
 
 	INIT_LIST_HEAD(&comp->node);
+	comp->dev = dev;
 
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		comp->clk[i] = of_clk_get(node, i);
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index 956d20c01e34..355e226d74fe 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -11,16 +11,18 @@
  * struct mtk_mdp_comp - the MDP's function component data
  * @node:	list node to track sibing MDP components
  * @clk:	clocks required for component
+ * @dev:	component's device
  */
 struct mtk_mdp_comp {
 	struct list_head	node;
 	struct clk		*clk[2];
+	struct device		*dev;
 };
 
 int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev);
 
-void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp);
-void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp);
+void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp);
+void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp);
 
 extern struct platform_driver mtk_mdp_component_driver;
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index d79bf7f0031a..c55bcfe4cbb7 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -51,20 +51,18 @@ MODULE_DEVICE_TABLE(of, mtk_mdp_of_ids);
 
 static void mtk_mdp_clock_on(struct mtk_mdp_dev *mdp)
 {
-	struct device *dev = &mdp->pdev->dev;
 	struct mtk_mdp_comp *comp_node;
 
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_on(dev, comp_node);
+		mtk_mdp_comp_clock_on(comp_node);
 }
 
 static void mtk_mdp_clock_off(struct mtk_mdp_dev *mdp)
 {
-	struct device *dev = &mdp->pdev->dev;
 	struct mtk_mdp_comp *comp_node;
 
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_off(dev, comp_node);
+		mtk_mdp_comp_clock_off(comp_node);
 }
 
 static void mtk_mdp_wdt_worker(struct work_struct *work)
-- 
2.32.0.93.g670b81a890-goog

