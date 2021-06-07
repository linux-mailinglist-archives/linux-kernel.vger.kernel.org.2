Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7039D7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFGItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:49:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:48:58 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DD2D31FDCA;
        Mon,  7 Jun 2021 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623055626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bY05Mseh+Z7yupujGt16kI/m6VhGcN21TuE/soNSij0=;
        b=Xtd5QDsZ6Xo0ZNyuaWmUA6vNGTR9EHvEN3QvKa3D+8LJGOrHxn+iKm55b8vjJ5jPaAC25O
        FRhRQC2Ox+ijbB9uOLmTWMim4ZuLFohkhLQP+Bn6CROkNN6Zxb0bqhYuBiyPhU68GqCAY1
        NIePpYONax2W5/UEWg0chkaZxH96Cdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623055626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bY05Mseh+Z7yupujGt16kI/m6VhGcN21TuE/soNSij0=;
        b=cD1VWJJ7An9KsTkSW3/LLpn2ABFQMMaYVUQlKUTyJMfuxKX/fk1iCh2HOt5cmoq0wsb8Fb
        snwaLOOwGcdku5AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1BD1FA3B8D;
        Mon,  7 Jun 2021 08:47:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 0C3A9516FDEB; Mon,  7 Jun 2021 10:47:06 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3] nvme: remove superfluous bio_set_dev in nvme_requeue_work
Date:   Mon,  7 Jun 2021 10:46:51 +0200
Message-Id: <20210607084651.99122-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ce86dad222e9 ("nvme-multipath: reset bdev to ns head when
failover") moved the reset code where the bio is added to the
requeue_list for the failover path. But it left the original
bio_set_dev in nvme_requeue_work.

There is a second path to nvme_requee_work. It is via
nvme_ns_head_submit_bio. Though we don't have to set bio->bi_bdev for
this path either, as it points to the correct bdev already.

Let's remove the bio_set_dev. It's updating the bio->bi_bdev with the
same pointer and thus it's unnecessary.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v3: - dropped bio_set_dev from nvme_ns_head_submit_bio
    - renamed patch
v2: https://lore.kernel.org/linux-nvme/20210603072537.GA4718@lst.de/

 drivers/nvme/host/multipath.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..a501917d4c6e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -435,11 +435,6 @@ static void nvme_requeue_work(struct work_struct *work)
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

