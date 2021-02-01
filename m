Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1E30AF70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBASdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhBASbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:31:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D20C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:30:27 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bg11so10084965plb.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=y7lafpwHwPK5mLUJYNpXf5D/a9FQS9JwhKfquZ6N6PI=;
        b=Lz9RegoyArGD7/Njm0yeOSa9hVKGX5dIR1sKuXMh7YX9fVDPXJYSrsAMuWEk0bii2V
         chvtIy+8dFO6PgQd1YJFNO2TWHWUvywrlNFEhcieuyVZXPKa3Ar53CEbzqDKIILsoX1E
         QMZddPHGcyPHa+g9lscMZg/ciF0UxBTewvkVpBRcEcRYtNcMJLoWOZlomdxonc7YqBqZ
         lYdUc9id12JfatpvDjALnBnLIIIyRGkiLoLPF/V8+eaOpeiGbP6HkMqDoxSbGzR1Xnly
         njCSd4DHvsx5U4XHn2T7vF7reiGURphVkVkf6xhrhut71ZGo1XKvLrhruGNRMT11Ggmy
         JWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=y7lafpwHwPK5mLUJYNpXf5D/a9FQS9JwhKfquZ6N6PI=;
        b=a69fLse3kLIzoVEJ1B6hyNryxXkr2KjgFeAwCK4WKC/udKFOwLcsefMu3yAVKqLXeu
         wcW3EWfS4334rLAP2qbe1Ai9qZ6DraO4iNIm5UHDeNk6ZJuMMC78ZY50j/rvyGQM9YQw
         hQEgeoA+uwmrRNGOkmVz80zmtco/1rFvoRZ/CEXSEzA/IBG4uQqY1Z0KQesuoJPEkN6t
         9G9nXcJMLY49GYSu8MZ0kfWb9pYD3H7Sze10awALG2gXA0Lgih9SUx+De4UdiTAQ4QwY
         HzkSVPkZ4amTn7gGj1g5+kj5O6MICClGHYEP0vr5xpSJzZxWK3RSMGvrV8uA2rqvTuIP
         VkSg==
X-Gm-Message-State: AOAM531scSZb+1wuMVMB0kAyaJaSbic728HE7wgumRzhDex1AXynGrrs
        eHgqiuAfceWVjK0V7nABSGQiFjtbVw==
X-Google-Smtp-Source: ABdhPJyxPr/mnKV6SfFRVsYQGdbwoOCXbpgSQ9gKmDR4teO9TwxE5BensFncv9xIqKkCY9ImrCPjV5hgMw==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:695f:7f9e:413c:e3c7])
 (user=jxgao job=sendgmr) by 2002:a17:902:d901:b029:e1:6a7f:564c with SMTP id
 c1-20020a170902d901b02900e16a7f564cmr4367057plz.11.1612204227054; Mon, 01 Feb
 2021 10:30:27 -0800 (PST)
Date:   Mon,  1 Feb 2021 10:30:17 -0800
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Message-Id: <20210201183017.3339130-4-jxgao@google.com>
Mime-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
From:   Jianxiong Gao <jxgao@google.com>
To:     jxgao@google.com, erdemaktas@google.com, marcorr@google.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe driver relies on the address offset to function properly.
This patch adds the offset preserve mask to NVMe driver when mapping
via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
depends on the page size defined by CC.MPS register of NVMe
controller.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 drivers/nvme/host/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..30e45f7e0f75 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
+	if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				    rq_dma_dir(req));
 	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (dma_set_min_align_mask(dev->dev, 0))
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
 }
 
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
@@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
-	int nr_mapped;
+	int nr_mapped, offset_ret;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
@@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out_free_sg;
 
+	offset_ret = dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
+		goto out_free_sg;
+	}
+
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+
+	offset_ret = dma_set_min_align_mask(dev->dev, 0);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
+		goto out_free_sg;
+	}
 	if (!nr_mapped)
 		goto out_free_sg;
 
-- 
2.27.0

