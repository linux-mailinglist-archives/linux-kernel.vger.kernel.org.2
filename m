Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1311F400B31
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhIDLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 07:38:40 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:56261 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhIDLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 07:38:38 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d31 with ME
        id pndZ250093riaq203ndZ3n; Sat, 04 Sep 2021 13:37:35 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 Sep 2021 13:37:35 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, james.quinlan@broadcom.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] remoteproc: Fix a memory leak in an error handling path in 'rproc_handle_vdev()'
Date:   Sat,  4 Sep 2021 13:37:32 +0200
Message-Id: <e6d0dad6620da4fdf847faa903f79b735d35f262.1630755377.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'copy_dma_range_map() fails, the memory allocated for 'rvdev' will leak.
Move the 'copy_dma_range_map()' call after the device registration so
that 'rproc_rvdev_release()' can be called to free some resources.

Also, branch to the error handling path if 'copy_dma_range_map()' instead
of a direct return to avoid some other leaks.

Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
Review with care. I don't like to move code around because of possible
side-effect.
---
 drivers/remoteproc/remoteproc_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 502b6604b757..775df165eb45 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -556,9 +556,6 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
 	rvdev->dev.parent = &rproc->dev;
-	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
-	if (ret)
-		return ret;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
 	dev_set_drvdata(&rvdev->dev, rvdev);
@@ -568,6 +565,11 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
 		put_device(&rvdev->dev);
 		return ret;
 	}
+
+	ret = copy_dma_range_map(&rvdev->dev, rproc->dev.parent);
+	if (ret)
+		goto free_rvdev;
+
 	/* Make device dma capable by inheriting from parent's capabilities */
 	set_dma_ops(&rvdev->dev, get_dma_ops(rproc->dev.parent));
 
-- 
2.30.2

