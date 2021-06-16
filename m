Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2583A8F27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFPDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:10:54 -0400
Received: from mail.synology.com ([211.23.38.101]:58246 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229943AbhFPDKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:10:52 -0400
Received: from localhost.localdomain (unknown [10.17.210.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 147CBFF5336;
        Wed, 16 Jun 2021 11:08:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1623812926; bh=wgRvEIZoATrAqq56uJ/cS1Urwp0XEH587ZCk+hB73Fo=;
        h=From:To:Cc:Subject:Date;
        b=YYlsKQtKEnKDiBamwUhhIrr0ofduAbx+IF5Lhr2W2zNCdZohfQBsn+BPeA3JWLRnR
         558hIHnb1cqAAYtO0E90KZLzL8KrSyl8rGIR/wwn1R9K+JnrNfhImSF4OapFjw6nvL
         ZPAhtAOtRYeo3mu7cHGh718OqOVXTnrOluHPT8jk=
From:   edwardh <edwardh@synology.com>
To:     axboe@kernel.dk, neilb@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com,
        Edward Hsieh <edwardh@synology.com>,
        Wade Liang <wadel@synology.com>
Subject: [PATCH v3] block: fix trace completion for chained bio
Date:   Wed, 16 Jun 2021 11:08:10 +0800
Message-Id: <20210616030810.4901-1-edwardh@synology.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Hsieh <edwardh@synology.com>

For chained bio, trace_block_bio_complete in bio_endio is currently called
only by the parent bio once upon all chained bio completed.
However, the sector and size for the parent bio are modified in bio_split.
Therefore, the size and sector of the complete events might not match the
queue events in blktrace.

The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
completion of all bios.") wants multiple complete events to correspond
to one queue event but missed this.

The issue can be reproduced by md/raid5 read with bio cross chunks.

To fix, move trace completion into the loop for every chained bio to call.

To make sense of the tail call optimization, the bio_chained_endio
handing should be at the end of bio_endio(), move blk_throtl_bio_endio()
and bio_uninit() to the else closure of bio_chain_endio condition.
blk_throtl_bio_endio updates latency for the throttle group, and
considering the throttle group tracks the latency of the current device,
we should record the latency after all chained bio finish. And since the
resources of the chained bio are released by bio_put() in
__bio_chain_endio(), calling bio_uninit() for chained bio is not necessary.

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Reviewed-by: Wade Liang <wadel@synology.com>
Reviewed-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Edward Hsieh <edwardh@synology.com>
---
 block/bio.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..dcb23e75f083 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1375,8 +1375,7 @@ static inline bool bio_remaining_done(struct bio *bio)
  *
  *   bio_endio() can be called several times on a bio that has been chained
  *   using bio_chain().  The ->bi_end_io() function will only be called the
- *   last time.  At this point the BLK_TA_COMPLETE tracing event will be
- *   generated if BIO_TRACE_COMPLETION is set.
+ *   last time.
  **/
 void bio_endio(struct bio *bio)
 {
@@ -1389,6 +1388,11 @@ void bio_endio(struct bio *bio)
 	if (bio->bi_bdev)
 		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
 
+	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
+		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
+		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
+	}
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
@@ -1400,18 +1404,13 @@ void bio_endio(struct bio *bio)
 	if (bio->bi_end_io == bio_chain_endio) {
 		bio = __bio_chain_endio(bio);
 		goto again;
+	} else {
+		blk_throtl_bio_endio(bio);
+		/* release cgroup info */
+		bio_uninit(bio);
+		if (bio->bi_end_io)
+			bio->bi_end_io(bio);
 	}
-
-	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
-		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
-	}
-
-	blk_throtl_bio_endio(bio);
-	/* release cgroup info */
-	bio_uninit(bio);
-	if (bio->bi_end_io)
-		bio->bi_end_io(bio);
 }
 EXPORT_SYMBOL(bio_endio);
 
-- 
2.31.1

