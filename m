Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A286D3068C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhA1Alr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhA1Aj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:39:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E06C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so4105958ybz.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
        b=fz1zYJOGH62ztoJUartn4VEw2vyYszv5Q1bITcQeeg34HhxJNH56QOsyD61zYCGfxd
         O7A+iQPhET5O5Iva7LqnCizGtkPKW4pfNGMbubFOMH1RBYzMSGU6xD3q6/QrXA18Ff8/
         5G8BPmR7JcKzxA4ITYT/eKsnQTpPWpXcI/M9cTyZChpy28GxXqVXqWhRuu2H7is+0Nz1
         iIQrn6/kJilKpc9BmD7xkjcwDbgncjcB4rjOZKh56EcTNP8lVA/tlr0fWqnoMSCAJSqF
         yoceWAFFLD9BpXjDiLmsgFwfEl0Gu/npahweWe2ZfSjj7rurxZpp86jkHhmxZ3VXcOXU
         PX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
        b=k67Ig5/6LmjGL7IkS9ExA+LSwRkNhR0EPRVIIEa+H2yZoWquKBrkRZyfURizYu96cB
         nD9N6RRGQmyCLcUxBiP5qlZ2B9tjgalDp2gSuY6MkZFu6tG/l3z2aM+g+M6yYloL+67g
         VAiH37aYk4JvN9XaKsz46OWG+I/DejJexaJAXJ1f829X6A3ykNKGdQnBBHr4NY5N7QT0
         /lUS/ItFNuD+jEJnzY9rAWzuAhQ16MLwIvphhTZnK2kz93S0FCbpOVaYe+gFan2JtAWl
         7XrfcJblAwbIvnW/CLdOC+nwstEHrydw5P3KUfkURMwRYhe4ldo5WyGPAfqoT5z1nk0i
         bFlg==
X-Gm-Message-State: AOAM532smdqObMuRxTIoXPhAAJSoeow7vavbVid7TW4Zz0JpWkFAHxKV
        8MOay7EDJh25e7wAdjhqFY3ANxpOSA==
X-Google-Smtp-Source: ABdhPJxhW9bnAu6awThXrNNK9h8pR96zH9JI9NukbN8uc2eD0HCU4F2glSXLYN/SAof/oTTUS9ZxUoM4Wg==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a5b:30f:: with SMTP id j15mr19901700ybp.431.1611794326856;
 Wed, 27 Jan 2021 16:38:46 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:38:29 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-4-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
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
index 856aa31931c1..0b23f04068be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
+	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				    rq_dma_dir(req));
 	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (dma_set_page_offset_mask(dev->dev, 0))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
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
 
+	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
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
+	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
+		goto out_free_sg;
+	}
 	if (!nr_mapped)
 		goto out_free_sg;
 
-- 
2.27.0

