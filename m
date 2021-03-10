Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE1333F75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhCJNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:41:18 -0500
Received: from verein.lst.de ([213.95.11.211]:36524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231867AbhCJNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:41:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68A8D68D15; Wed, 10 Mar 2021 14:41:11 +0100 (CET)
Date:   Wed, 10 Mar 2021 14:41:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310134110.GA13063@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru> <20210310132156.GA12145@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310132156.GA12145@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> Can you try this patch instead?
> 
> http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html

Actually, please try the patch below instead, it looks like our existing
logic messes up the units:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6ea..1867fdf2205bd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,30 +1963,18 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
+/*
+ * Even though NVMe spec explicitly states that MDTS is not applicable to the
+ * write-zeroes, we are cautious and limit the size to the controllers
+ * max_hw_sectors value, which is based on the MDTS field and possibly other
+ * limiting factors.
+ */
+static void nvme_config_write_zeroes(struct request_queue *q,
+		struct nvme_ctrl *ctrl)
 {
-	u64 max_blocks;
-
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
-	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
-		return;
-	/*
-	 * Even though NVMe spec explicitly states that MDTS is not
-	 * applicable to the write-zeroes:- "The restriction does not apply to
-	 * commands that do not transfer data between the host and the
-	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
-	 * In order to be more cautious use controller's max_hw_sectors value
-	 * to configure the maximum sectors for the write-zeroes which is
-	 * configured based on the controller's MDTS field in the
-	 * nvme_init_identify() if available.
-	 */
-	if (ns->ctrl->max_hw_sectors == UINT_MAX)
-		max_blocks = (u64)USHRT_MAX + 1;
-	else
-		max_blocks = ns->ctrl->max_hw_sectors + 1;
-
-	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   nvme_lba_to_sect(ns, max_blocks));
+	if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
+	    !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
+		blk_queue_max_write_zeroes_sectors(q, ctrl->max_hw_sectors);
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -2158,7 +2146,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(disk, ns);
+	nvme_config_write_zeroes(disk->queue, ns->ctrl);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
