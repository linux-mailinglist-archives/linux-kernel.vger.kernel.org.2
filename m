Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927DD30DB75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBCNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:38:30 -0500
Received: from verein.lst.de ([213.95.11.211]:51287 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhBCNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:37:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6150367357; Wed,  3 Feb 2021 14:37:12 +0100 (CET)
Date:   Wed, 3 Feb 2021 14:37:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Erdem Aktas <erdemaktas@google.com>,
        Marc Orr <marcorr@google.com>, Christoph Hellwig <hch@lst.de>,
        m.szyprowski@samsung.com, Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <20210203133712.GA24674@lst.de>
References: <20210201183017.3339130-1-jxgao@google.com> <20210201183017.3339130-4-jxgao@google.com> <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com> <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com> <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try with this extra patch:

---
From 212764c3c15ce859e6f55d2146f450ea4ca6fdb9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 3 Feb 2021 14:27:13 +0100
Subject: nvme-pci: fix 2nd PRP setup in nvme_setup_prp_simple

Use the dma address instead of the bio_vec offset for the arithmetics
to find the address for the 2nd PRP.

Fixes: dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests")
Reported-by: Jianxiong Gao <jxgao@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 30e45f7e0f750c..4ae51735d72f4a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -808,8 +808,7 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 		struct bio_vec *bv)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
+	dma_addr_t next_prp;
 
 	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->first_dma))
@@ -817,8 +816,9 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	iod->dma_len = bv->bv_len;
 
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
-	if (bv->bv_len > first_prp_len)
-		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	next_prp = round_down(iod->first_dma + bv->bv_len, NVME_CTRL_PAGE_SIZE);
+	if (next_prp > iod->first_dma)
+		cmnd->dptr.prp2 = cpu_to_le64(next_prp);
 	return BLK_STS_OK;
 }
 
-- 
2.29.2

