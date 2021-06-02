Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF6398E39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhFBPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:19:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhFBPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:19:51 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0248B21AB2;
        Wed,  2 Jun 2021 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=abiDawFaADWTZKPBaHNA1Cn487UEzBujiumXV31Y0hY=;
        b=FgGMWr2rx5+tyKHIGvzvQcdXnafUfufwEilebO4BNPEnTDcvJN9IIsSMtyj3keMFwvdTHW
        vYLpEBDPg4fOMUAnMgd4D0zeqAUlcPk3QYfmpVEaa4dMPgdbJIaR2Tx+20zUgn3yPzZB5Q
        2UJ+67kFfIEDv8cHsG/NL6AxVDPwb7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=abiDawFaADWTZKPBaHNA1Cn487UEzBujiumXV31Y0hY=;
        b=YqGPT4aMSZHc/Vk9k0tj5XBjN+v//Dxr3CdRdONjdWvPhnWHqPesQY8IZmDFGcejFPcNNN
        3o9r+Y3RafUrp4Cg==
Received: by relay2.suse.de (Postfix, from userid 51)
        id F33C0A3CB8; Wed,  2 Jun 2021 15:23:43 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D57FBA703B;
        Wed,  2 Jun 2021 13:00:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id C89DA516FB04; Wed,  2 Jun 2021 15:00:42 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme: reset disk to the mpath node also when requeuing
Date:   Wed,  2 Jun 2021 15:00:39 +0200
Message-Id: <20210602130039.122879-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ce86dad222e9 ("nvme-multipath: reset bdev to ns head when
failover") moved the reset code where the bio is added to the
requeue_list for the failover path. But it left the original
bio_set_dev() in nvme_requeue_work().

Let's move the bio_set_dev() where we add the bio to the requeue_list
and avoid the double setting in case of the failover path. And this
makes the code more consistent.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v2: loop over all bios and reset them

 drivers/nvme/host/multipath.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..3334c6f23476 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -302,6 +302,7 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
 	struct nvme_ns *ns;
+	struct bio *b;
 	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 
@@ -324,6 +325,8 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
 		spin_lock_irq(&head->requeue_lock);
+		for (b = bio; b; b = b->bi_next)
+			bio_set_dev(b, head->disk->part0);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
 	} else {
@@ -435,11 +438,6 @@ static void nvme_requeue_work(struct work_struct *work)
 		next = bio->bi_next;
 		bio->bi_next = NULL;
 
-		/*
-		 * Reset disk to the mpath node and resubmit to select a new
-		 * path.
-		 */
-		bio_set_dev(bio, head->disk->part0);
 		submit_bio_noacct(bio);
 	}
 }
-- 
2.29.2

