Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165AC368CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhDWF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbhDWF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:59:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:59:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h15so15701640pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClClMMPQd5llgvCW5e48aFgqR6QpKZqnffvVViwFOAk=;
        b=UXdaegl95comyYbgpDWdVughU2GDaTO9EqsItbp29Ru9gz/EtAs0NMPjdiGH6aqzA1
         el3PPqdR/B/lvCW9G3pPfFwxVflEAp6Uc43i0QbG4LS9vC1gBTijiTpfUE89ZOygsSaI
         n6x1dm3+HGmvlWYev3lzpv9KqnkpLqSCCFFjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClClMMPQd5llgvCW5e48aFgqR6QpKZqnffvVViwFOAk=;
        b=sBGLtMgzwkxg2qIoeUZ3NKGtms5hQhxRKsiEfonMUc40HAA0khzbbjVfez7+rpVQlP
         qyVMINKenVb5cY3yZQO+dsLC7dGimqLeYrDfGwhCff7kcZHyYYfxqSnfy2kUK+gRocqR
         NFYiakZafjANZi4HUppT7pgal6/Hjo2K5zlwuNvPhkC8VIiHfIkYAlHc+UKk8JsRTLdg
         2Zw7gsoOHlMojoNSwlcglWF5Y9c9SrcNmEuNSrHG1y2L6ljaLFFKx7F0dF6YkJXts2in
         Sz2U9uGP4VcxdMLobdyX7SL6LYN+33Orjs18L8GU+MrwDYtqIi0/yBEzFdYA4VIaUKqJ
         qOMw==
X-Gm-Message-State: AOAM533LpHWe4Do1TIAeu4ZZMdDZejqggkRSpFHIdEHQNhMZdjAAnpwX
        LmJ3ThmQf80A4omW9RS0GldzE7/BEHyyGwqn
X-Google-Smtp-Source: ABdhPJwxGEgFd/VAicrMilXCvY+Sxm9dITxRAirtC5a8Tz9kl7N6sb4CQtkqLXA/FQF2+h+ydDVw0Q==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr2227290pgl.245.1619157550902;
        Thu, 22 Apr 2021 22:59:10 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:308c:235d:f7a2:53a1])
        by smtp.gmail.com with UTF8SMTPSA id i22sm3924003pgj.90.2021.04.22.22.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 22:59:10 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     enric.balletbo@collabora.com, chunkuang.hu@kernel.org,
        yong.wu@mediatek.com, Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 3/4] media: mtk-mdp: don't pm_run_time_get/put for master comp in clock_on
Date:   Fri, 23 Apr 2021 15:58:40 +1000
Message-Id: <20210423155824.v1.3.Ifd87681955689a08cce4c65e72ee5e8c6d09af95@changeid>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423055842.2490679-1-eizan@chromium.org>
References: <20210423055842.2490679-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original intent of commit 86698b9505bbc ("media: mtk-mdp: convert
mtk_mdp_dev.comp array to list") was to create a list to track all the
MDP components that needed to have their clocks enabled/disabled when
calling mtk_mdp_comp_clock_on/off. However, there was a bug inside
mtk_mdp_register_component where the args to a call to list_add were
swapped. The result is that only one component was added to
mtk_mdp_dev.comp_list because comp_list was instead being
repeatedly added to the single element lists headed by each
mtk_mdp_comp.

The order of the args to list_add in mtk_mdp_register_component was
fixed in https://patchwork.kernel.org/patch/11742895/ (Fix Null pointer
dereference when calling list_add).

Then, as a result of https://patchwork.kernel.org/patch/11530769/
(mtk-mdp: use pm_runtime in MDP component driver) if all the components
are added to the component list, the mdp "master" / rdma0 component
ends up having pm_runtime_get_sync() called on it twice recursively:

    rpm_resume+0x694/0x8f8
    __pm_runtime_resume+0x7c/0xa0 ***NOTE***
    mtk_mdp_comp_clock_on+0x48/0x104 [mtk_mdp]
    mtk_mdp_pm_resume+0x2c/0x44 [mtk_mdp]
    pm_generic_runtime_resume+0x34/0x48
    __genpd_runtime_resume+0x6c/0x80
    genpd_runtime_resume+0x104/0x1ac
    __rpm_callback+0x120/0x238
    rpm_callback+0x34/0x8c
    rpm_resume+0x7a0/0x8f8
    __pm_runtime_resume+0x7c/0xa0 ***NOTE***
    mtk_mdp_m2m_start_streaming+0x2c/0x3c [mtk_mdp]

(The calls to pm_runtime_get_sync are inlined and correspond to the
calls to __pm_runtime_resume). It is not correct to have
pm_runtime_get_sync called recursively and the second call will block
indefinitely.

As a result of all that, this change factors mtk_mdp_comp_clock_on/off
into mtk_mdp_comp_power_on/off and moves the calls to
pm_runtime_get/put into the power_on/off functions.

This change then special-cases the master/rdma0 MDP component and does
these things:
- the master/rdma0 component is not added to mtk_mdp_dev.comp_list
- the master/rdma0 component has its clocks (*but not power*) toggled
  by mtk_mpd_comp_clock_on/off inside mtk_mdp_clock_on/off.
- the other components have their clocks *and* power toggled with
  mtk_mdp_comp_power_on/off.

This change introduces the assumption that mtk_mdp_pm_resume will
always be called though a callback from pm_runtime_get_sync made on the
master / rdma0 component.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 28 ++++++++++++++-----
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  3 ++
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 23 ++++++++++-----
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 84f9c529d74a..d447bfaadef4 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -53,15 +53,31 @@ static const struct of_device_id mtk_mdp_comp_driver_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_mdp_comp_driver_dt_match);
 
-void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp)
+void mtk_mdp_comp_power_on(struct mtk_mdp_comp *comp)
 {
-	int i, err;
+	int err;
 
 	err = pm_runtime_get_sync(comp->dev);
 	if (err < 0)
-		dev_err(comp->dev,
-			"failed to runtime get, err %d.\n",
-			err);
+		dev_err(comp->dev, "failed to runtime get, err %d.\n", err);
+
+	mtk_mdp_comp_clock_on(comp);
+}
+
+void mtk_mdp_comp_power_off(struct mtk_mdp_comp *comp)
+{
+	int err;
+
+	mtk_mdp_comp_clock_off(comp);
+
+	err = pm_runtime_put_sync(comp->dev);
+	if (err < 0)
+		dev_err(comp->dev, "failed to runtime put, err %d.\n", err);
+}
+
+void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp)
+{
+	int i, err;
 
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		if (IS_ERR(comp->clk[i]))
@@ -83,8 +99,6 @@ void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
 			continue;
 		clk_disable_unprepare(comp->clk[i]);
 	}
-
-	pm_runtime_put_sync(comp->dev);
 }
 
 static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index 355e226d74fe..7ad9b06bb11b 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -21,6 +21,9 @@ struct mtk_mdp_comp {
 
 int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev);
 
+void mtk_mdp_comp_power_on(struct mtk_mdp_comp *comp);
+void mtk_mdp_comp_power_off(struct mtk_mdp_comp *comp);
+
 void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp);
 void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp);
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index c55bcfe4cbb7..5e71496e2517 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -53,8 +53,15 @@ static void mtk_mdp_clock_on(struct mtk_mdp_dev *mdp)
 {
 	struct mtk_mdp_comp *comp_node;
 
+	/*
+	 * The master / rdma0 component will have pm_runtime_get_sync called
+	 * on it through mtk_mdp_m2m_start_streaming, making it unnecessary to
+	 * have mtk_mdp_comp_power_on called on it.
+	 */
+	mtk_mdp_comp_clock_on(&mdp->comp_self);
+
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_on(comp_node);
+		mtk_mdp_comp_power_on(comp_node);
 }
 
 static void mtk_mdp_clock_off(struct mtk_mdp_dev *mdp)
@@ -62,7 +69,14 @@ static void mtk_mdp_clock_off(struct mtk_mdp_dev *mdp)
 	struct mtk_mdp_comp *comp_node;
 
 	list_for_each_entry(comp_node, &mdp->comp_list, node)
-		mtk_mdp_comp_clock_off(comp_node);
+		mtk_mdp_comp_power_off(comp_node);
+
+	/*
+	 * The master / rdma0 component will have pm_runtime_put called
+	 * on it through mtk_mdp_m2m_stop_streaming, making it unnecessary to
+	 * have mtk_mdp_comp_power_off called on it.
+	 */
+	mtk_mdp_comp_clock_off(&mdp->comp_self);
 }
 
 static void mtk_mdp_wdt_worker(struct work_struct *work)
@@ -101,8 +115,6 @@ static int mtk_mdp_master_bind(struct device *dev)
 	int status;
 	struct mtk_mdp_dev *mdp = dev_get_drvdata(dev);
 
-	mtk_mdp_register_component(mdp, &mdp->comp_self);
-
 	status = component_bind_all(dev, mdp);
 	if (status) {
 		dev_err(dev, "Failed to bind all components: %d\n", status);
@@ -124,8 +136,6 @@ static int mtk_mdp_master_bind(struct device *dev)
 	component_unbind_all(dev, mdp);
 
 err_component_bind_all:
-	mtk_mdp_unregister_component(mdp, &mdp->comp_self);
-
 	return status;
 }
 
@@ -136,7 +146,6 @@ static void mtk_mdp_master_unbind(struct device *dev)
 	pm_runtime_disable(dev);
 	mtk_mdp_unregister_m2m_device(mdp);
 	component_unbind_all(dev, mdp);
-	mtk_mdp_unregister_component(mdp, &mdp->comp_self);
 }
 
 static const struct component_master_ops mtk_mdp_com_ops = {
-- 
2.31.1.498.g6c1eba8ee3d-goog

