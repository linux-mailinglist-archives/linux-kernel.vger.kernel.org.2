Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7194D3A3AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 06:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFKEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 00:05:54 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:45960 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhFKEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 00:05:50 -0400
Received: by mail-pj1-f41.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso5198375pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpuuyZX5Ieel/toEhqaynm1+cB0UGivDIT7WkJ9Wrbs=;
        b=UJOx/qDoUCJiQuVKW4HhgE64kdIaaBumhGmNb/IqxFb/8RJTE/PmuFechrbRkxYw4s
         FurmOw8/eGeyXX6TrsU/oXeEIN/6gZUKv2Ay63XGTzLlehG13PC7eHEzTBN5EkJhqrBt
         oSendpq5KOfCmQd6HXd/iwDdXcawHA3yfHC+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpuuyZX5Ieel/toEhqaynm1+cB0UGivDIT7WkJ9Wrbs=;
        b=ZxfYgbbU6mEFuz5kLYN5whmZvbg8S8GGyYxqn6LDW/2ug9DVhxqQ3CZsc+CfyPlnDi
         3ii6PMA5kjFYeGjhAhQqtru8J9WeoBAODbHUTeG2mUUJ13bjGYJl7KYzQJa8cigotXFf
         vAC8FsaZQ9poZ0wubvDN7E6eNcrwmlgEGoTFFjBlMUc68cWZ7cQfFIjjQ9nhiDlVHkXU
         2Gks8bDczUKnpBsdC7Y/JIuuw4+6yMx8IgVbah+nnzY7I0zhTGLpx6uIpBuyUFtOBmK2
         LPVwFhUqfwv7i5j+gkBfpjIaRZrxRoJ298uZKBqsh3s6DU2cQ9dUsU0FllaEX0dXeufr
         muYA==
X-Gm-Message-State: AOAM531jk8SGVadQh8g23oW01nbPBNgKM8B3F1bblUxf4er0PWe7cy/n
        +r2TfKB/jczXElVXEunJbEWUSch2KTdyHbc6
X-Google-Smtp-Source: ABdhPJz9UGkfR/m5Tcy+qUD1mlxKWaupak7n44yapumthpB/XHCSLVasmdM/x73NiTdzhzOkN6Q7OQ==
X-Received: by 2002:a17:902:b181:b029:fc:c069:865c with SMTP id s1-20020a170902b181b02900fcc069865cmr2061779plr.28.1623384161010;
        Thu, 10 Jun 2021 21:02:41 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:db52:e918:e5f9:9e14])
        by smtp.gmail.com with UTF8SMTPSA id v18sm3752881pff.90.2021.06.10.21.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 21:02:40 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     houlong.wei@mediatek.com, enric.balletbo@collabora.com,
        yong.wu@mediatek.com, chunkuang.hu@kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/8] media: mtk-mdp: search for vpu node instead of linking it to a property
Date:   Fri, 11 Jun 2021 14:01:42 +1000
Message-Id: <20210611140124.v2.5.I0cbd6691d3edfa2757bd6f5de7acfce94b101480@changeid>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611040145.2085329-1-eizan@chromium.org>
References: <20210611040145.2085329-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is only one vpu node, it suffices to search for it instead
of having a link coded into the primary mdp device node.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

(no changes since v1)

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c |  6 ----
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 28 +++++++++++++------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index fdbb46a5330a..3d9bb7265159 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -117,12 +117,6 @@ static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
 	if (vpu_node) {
 		int ret;
 
-		mdp->vpu_dev = of_find_device_by_node(vpu_node);
-		if (WARN_ON(!mdp->vpu_dev)) {
-			dev_err(dev, "vpu pdev failed\n");
-			of_node_put(vpu_node);
-		}
-
 		ret = v4l2_device_register(dev, &mdp->v4l2_dev);
 		if (ret) {
 			dev_err(dev, "Failed to register v4l2 device\n");
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 267e4cb4bf32..48e9a557c446 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -113,6 +113,7 @@ static void release_of(struct device *dev, void *data)
 static int mtk_mdp_master_bind(struct device *dev)
 {
 	int status;
+	struct device_node *vpu_node;
 	struct mtk_mdp_dev *mdp = dev_get_drvdata(dev);
 
 	status = component_bind_all(dev, mdp);
@@ -121,15 +122,24 @@ static int mtk_mdp_master_bind(struct device *dev)
 		goto err_component_bind_all;
 	}
 
-	if (mdp->vpu_dev) {
-		int ret = vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, mdp,
-					  VPU_RST_MDP);
-		if (ret) {
-			dev_err(dev, "Failed to register reset handler\n");
-			goto err_wdt_reg;
-		}
-	} else {
-		dev_err(dev, "no vpu_dev found\n");
+	vpu_node = of_find_node_by_name(NULL, "vpu");
+	if (!vpu_node) {
+		dev_err(dev, "unable to find vpu node");
+		status = -ENODEV;
+		goto err_wdt_reg;
+	}
+
+	mdp->vpu_dev = of_find_device_by_node(vpu_node);
+	if (!mdp->vpu_dev) {
+		dev_err(dev, "unable to find vpu device");
+		status = -ENODEV;
+		goto err_wdt_reg;
+	}
+
+	status = vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, mdp, VPU_RST_MDP);
+	if (status) {
+		dev_err(dev, "Failed to register reset handler\n");
+		goto err_wdt_reg;
 	}
 
 	status = mtk_mdp_register_m2m_device(mdp);
-- 
2.32.0.272.g935e593368-goog

