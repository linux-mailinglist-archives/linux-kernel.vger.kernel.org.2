Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAF398E69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFBPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhFBPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:28 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D3F9033D21;
        Wed,  2 Jun 2021 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DSGpUrJ/743MPuhxvT/nqi8w3p5GPMaeKeFBM44/gmo=;
        b=MdK4gYIAuzMyR2E4NvhFyziJMVS0Lz98HxeKXgkdNdpXwdetZdS/rJffcruMSrxpF6hChN
        ofeJSVSyGaDOGK2oA/vVezY1ktroIfUPP/WhxdIHRUGrm8yzyjpt+w6AyblAEkAPbjOV3B
        CI3cfLJ+HEswMRieUviEy4qA9pE6uC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DSGpUrJ/743MPuhxvT/nqi8w3p5GPMaeKeFBM44/gmo=;
        b=Pl3UpoZVohInFxwF79o5kXXnbcq7gN/B1oEeVjDou3PAyQk2wubz0Hc2j8d2pFEOYxkb/G
        FFVMuCPDjd6CSgCw==
Received: by relay2.suse.de (Postfix, from userid 51)
        id D01DCA3E3C; Wed,  2 Jun 2021 16:03:44 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 05B6AA548A;
        Wed,  2 Jun 2021 12:34:45 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id EB041516FAFD; Wed,  2 Jun 2021 14:34:44 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: reset disk to the mpath node also when requeuing
Date:   Wed,  2 Jun 2021 14:34:29 +0200
Message-Id: <20210602123429.103935-1-dwagner@suse.de>
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
 drivers/nvme/host/multipath.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..df07fc2ad7bc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -324,6 +324,7 @@ static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
 		spin_lock_irq(&head->requeue_lock);
+		bio_set_dev(bio, head->disk->part0);
 		bio_list_add(&head->requeue_list, bio);
 		spin_unlock_irq(&head->requeue_lock);
 	} else {
@@ -435,11 +436,6 @@ static void nvme_requeue_work(struct work_struct *work)
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

