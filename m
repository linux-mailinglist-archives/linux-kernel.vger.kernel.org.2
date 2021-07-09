Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A413C1D77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhGIC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhGIC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:27:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E745C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 19:24:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x3so4227453pll.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yy3Oct9A9WErk0mmVC/ltaAK4Ui6hpVOSI3ft7mId8M=;
        b=MBJjndII9RSzdAmXPewLWBwxTR4Ubq3cHz+sZN63Su+9L3sTjeGBr9dYcIpGF9vmpv
         2ov47gob3vf2AmitKMc9GiGBKKmsIrLH3/BdHaMBSAFaGZ4QvSBeUKiaeQ813jwW6AhS
         m4TtUXyIO1/XsLVBOqXZBxQTxozAKNJswsf04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yy3Oct9A9WErk0mmVC/ltaAK4Ui6hpVOSI3ft7mId8M=;
        b=HdNrQHY6ngcQzhNdBYjB7M3MiZvkgv+Edigc9MasixD66w1NbN/IkbN+Fqk8M7Zfu1
         t54WEz6zyV0MwnFKTdgLe1xaSlW5fcZvjYK+u75QZ5lQn4cD7CWx99c9N0Jds+9dB9DA
         jCczbmLw/uJkQ9N0ifhYXZUBlzbd8LmHS8b3fI7uGdloC4OwgFp3mjevLOU8ebm5cet/
         +yhisWbuIZcr/S8WUdCrsQOZcHufQhJY+t6QFfA0Thncuc6YufSGegsoGtoOYE1kij/T
         j3JXWTRIQC9E60nJ9ZD30X5ZtyjdFODtSXepJm7q+gxw8lZg7LRxxclIUwj9UVCDfPPx
         cxDw==
X-Gm-Message-State: AOAM53064T/Vcoj01hJNc4Xpf1osuyJBofFvtxcQVbPswA3W6GSKthpl
        MZ+LDeAPtdhtzLkSO7asxwIjIfq1z7kXPw==
X-Google-Smtp-Source: ABdhPJwrPoeT1worVig+mEWOrxVrOttPMio1WiqwFIggheuAML3w9AWKKeZYM9c66qmbAY7ZGocPHQ==
X-Received: by 2002:a17:90a:5306:: with SMTP id x6mr34578229pjh.59.1625797468220;
        Thu, 08 Jul 2021 19:24:28 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:d956:2966:7910:2bd2])
        by smtp.gmail.com with UTF8SMTPSA id d19sm3742267pjx.57.2021.07.08.19.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 19:24:27 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wenst@chromium.org, chunkuang.hu@kernel.org, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, houlong.wei@mediatek.com,
        Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 7/8] media: mtk-mdp: use mdp-rdma0 alias to point to MDP master
Date:   Fri,  9 Jul 2021 12:23:23 +1000
Message-Id: <20210709122040.v5.7.I2049e180dca12e0d1b3178bfc7292dcf9e05ac28@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709022324.1607884-1-eizan@chromium.org>
References: <20210709022324.1607884-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... Instead of depending on the presence of a mediatek,vpu property in
the device node.

That property was originally added to link to the vpu node so that the
mtk_mdp_core driver could pass the right device to
vpu_wdt_reg_handler(). However in a previous patch in this series,
the driver has been modified to search the device tree for that node
instead.

That property was also used to indicate the primary MDP device, so that
it can be passed to the V4L2 subsystem as well as register it to be
used when setting up queues in the open() callback for the filesystem
device node that is created. In this case, assuming that the primary
MDP device is the one with a specific alias seems useable because the
alternative is to add a property to the device tree which doesn't
actually represent any facet of hardware (i.e., this being the primary
MDP device is a software decision). In other words, this solution is
equally as arbitrary, but at least it doesn't add a property to a
device node where said property is unrelated to the hardware present.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

(no changes since v1)

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 47 ++++++++++++++-----
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  6 +++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 87e3f72ff02b..de2d425efdd1 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -151,22 +151,48 @@ void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
 		mtk_smi_larb_put(comp->larb_dev);
 }
 
+/*
+ * The MDP master device node is identified by the device tree alias
+ * "mdp-rdma0".
+ */
+static int is_mdp_master(struct device *dev)
+{
+	struct device_node *aliases, *mdp_rdma0_node;
+	const char *mdp_rdma0_path;
+
+	if (!dev->of_node)
+		return 0;
+
+	aliases = of_find_node_by_path("/aliases");
+	if (!aliases) {
+		dev_err(dev, "no aliases found for mdp-rdma0");
+		return 0;
+	}
+
+	mdp_rdma0_path = of_get_property(aliases, "mdp-rdma0", NULL);
+	if (!mdp_rdma0_path) {
+		dev_err(dev, "get mdp-rdma0 property of /aliases failed");
+		return 0;
+	}
+
+	mdp_rdma0_node = of_find_node_by_path(mdp_rdma0_path);
+	if (!mdp_rdma0_node) {
+		dev_err(dev, "path resolution failed for %s", mdp_rdma0_path);
+		return 0;
+	}
+
+	return dev->of_node == mdp_rdma0_node;
+}
+
 static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
 			void *data)
 {
 	struct mtk_mdp_comp *comp = dev_get_drvdata(dev);
 	struct mtk_mdp_dev *mdp = data;
-	struct device_node *vpu_node;
 
 	mtk_mdp_register_component(mdp, comp);
 
-	/*
-	 * If this component has a "mediatek-vpu" property, it is responsible for
-	 * notifying the mdp master driver about it so it can be further initialized
-	 * later.
-	 */
-	vpu_node = of_parse_phandle(dev->of_node, "mediatek,vpu", 0);
-	if (vpu_node) {
+	if (is_mdp_master(dev)) {
 		int ret;
 
 		ret = v4l2_device_register(dev, &mdp->v4l2_dev);
@@ -182,9 +208,8 @@ static int mtk_mdp_comp_bind(struct device *dev, struct device *master,
 		}
 
 		/*
-		 * presence of the "mediatek,vpu" property in a device node
-		 * indicates that it is the primary MDP rdma device and MDP DMA
-		 * ops should be handled by its DMA callbacks.
+		 * MDP DMA ops will be handled by the DMA callbacks associated with this
+		 * device;
 		 */
 		mdp->rdma_dev = dev;
 	}
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index b45d588d2659..e1fb39231248 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -158,6 +158,12 @@ static int mtk_mdp_master_bind(struct device *dev)
 		goto err_component_bind_all;
 	}
 
+	if (mdp->rdma_dev == NULL) {
+		dev_err(dev, "Primary MDP device not found");
+		status = -ENODEV;
+		goto err_component_bind_all;
+	}
+
 	vpu_node = of_find_node_by_name(NULL, "vpu");
 	if (!vpu_node) {
 		dev_err(dev, "unable to find vpu node");
-- 
2.32.0.93.g670b81a890-goog

