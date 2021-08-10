Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288553D7A52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhG0P7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237157AbhG0P65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627401536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9LvYes5FSz1dRTHrjLjQKvpBsLyCNKtikf2oQ8PRrg=;
        b=fDhNwr68EPREYIAyDhnqG57iyU79umDF2YDs9Q6E7F0oiRHBkqlbpLwB2m+Y/+u0nZKyXl
        lg1vuxOAdh1t92KX7bAjQF+x/uV2KSidkedtE2vU2AjODnA2R++f9MdCap56wPCrbrCCLB
        aQzvXjQbLyYP0DYNszStNW0wwwaPpNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-aafm7Nq8PHmlN6QcbxaSKw-1; Tue, 27 Jul 2021 11:58:53 -0400
X-MC-Unique: aafm7Nq8PHmlN6QcbxaSKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9E25A07F;
        Tue, 27 Jul 2021 15:58:51 +0000 (UTC)
Received: from T590 (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70B0E6A901;
        Tue, 27 Jul 2021 15:58:39 +0000 (UTC)
Date:   Tue, 27 Jul 2021 23:58:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YQAtL5i0pjlnBpHV@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <2356877.Yf5hrMSTGe@natalenko.name>
 <YPfUOKrxGs6FjaOZ@T590>
 <17691292.WCMSeNvH9h@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17691292.WCMSeNvH9h@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 05:12:03PM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> On středa 21. července 2021 10:00:56 CEST Ming Lei wrote:
> > > I'm still hammering v5.14-rc2 + your patch, and I cannot reproduce the
> > > issue. Given I do not have a reliable reproducer (I'm just firing up the
> > > kernel build, and the issue pops up eventually, sooner or later, but
> > > usually within a couple of first tries), for how long I should hammer it
> > > for your fix to be considered proven?
> > 
> > You mentioned that the issue is reproducible with v5.14-rc, that means
> > it can be always reproduced in limited time(suppose it is A). If the issue
> > can't be reproduced any more after applying the patch in long enough time
> > B(B >> A), we can think it is fixed by the patch.
> > 
> > For example, if A is one hour, we can set B as 5*A or bigger to simulate
> > the long enough time.
> 
> With your patch the issue is still not reproducible for me. Hence, from my 
> side the patch looks to be verified.

OK.

BTW, can you test the following patch? which is another approach on the same
issue with other benefits.

From c853e7ed05a75f631da5b7952b9a989983437819 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 7 Jun 2021 16:03:51 +0800
Subject: [PATCH 2/2] block: support bio merge for multi-range discard

So far multi-range discard treats each bio as one segment(range) of single
discard request. This way becomes not efficient if lots of small sized
discard bios are submitted, and one example is raid456.

Support bio merge for multi-range discard for improving lots of small
sized discard bios.

Turns out it is easy to support it:

1) always try to merge bio first

2) run into multi-range discard only if bio merge can't be done

3) add rq_for_each_discard_range() for retrieving each range(segment)
of discard request

Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c          | 12 ++++-----
 drivers/block/virtio_blk.c |  9 ++++---
 drivers/nvme/host/core.c   |  8 +++---
 include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcdff1879c34..65210e9a8efa 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct request *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
+	if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
+	else if (blk_discard_mergable(req))
+		return ELEVATOR_DISCARD_MERGE;
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -908,12 +908,12 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
 		return ELEVATOR_FRONT_MERGE;
+	else if (blk_discard_mergable(rq))
+		return ELEVATOR_DISCARD_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..970cb0d8acaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -116,7 +116,6 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	unsigned short segments = blk_rq_nr_discard_segments(req);
 	unsigned short n = 0;
 	struct virtio_blk_discard_write_zeroes *range;
-	struct bio *bio;
 	u32 flags = 0;
 
 	if (unmap)
@@ -138,9 +137,11 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 		range[0].sector = cpu_to_le64(blk_rq_pos(req));
 		n = 1;
 	} else {
-		__rq_for_each_bio(bio, req) {
-			u64 sector = bio->bi_iter.bi_sector;
-			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+		struct req_discard_range r;
+
+		rq_for_each_discard_range(r, req) {
+			u64 sector = r.sector;
+			u32 num_sectors = r.size >> SECTOR_SHIFT;
 
 			range[n].flags = cpu_to_le32(flags);
 			range[n].num_sectors = cpu_to_le32(num_sectors);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24bcae88587a..4b0a39360ce9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -813,7 +813,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
 	struct nvme_dsm_range *range;
-	struct bio *bio;
+	struct req_discard_range r;
 
 	/*
 	 * Some devices do not consider the DSM 'Number of Ranges' field when
@@ -835,9 +835,9 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		range = page_address(ns->ctrl->discard_page);
 	}
 
-	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+	rq_for_each_discard_range(r, req) {
+		u64 slba = nvme_sect_to_lba(ns, r.sector);
+		u32 nlb = r.size >> ns->lba_shift;
 
 		if (n < segments) {
 			range[n].cattr = cpu_to_le32(0);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d66d0da72529..bd9d22269a7b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1007,6 +1007,57 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
 	return rq->stats_sectors;
 }
 
+struct req_discard_range {
+	sector_t	sector;
+	unsigned int	size;
+
+	/*
+	 * internal field: driver don't use it, and it always points to
+	 * next bio to be processed
+	 */
+	struct bio *__bio;
+};
+
+static inline void req_init_discard_range_iter(const struct request *rq,
+		struct req_discard_range *range)
+{
+	range->__bio = rq->bio;
+}
+
+/* return true if @range stores one valid discard range */
+static inline bool req_get_discard_range(struct req_discard_range *range)
+{
+	struct bio *bio;
+
+	if (!range->__bio)
+		return false;
+
+	bio = range->__bio;
+	range->sector = bio->bi_iter.bi_sector;
+	range->size = bio->bi_iter.bi_size;
+	range->__bio = bio->bi_next;
+
+	while (range->__bio) {
+		struct bio *bio = range->__bio;
+
+		if (range->sector + (range->size >> SECTOR_SHIFT) !=
+				bio->bi_iter.bi_sector)
+			break;
+
+		/*
+		 * ->size won't overflow because req->__data_len is defined
+		 *  as 'unsigned int'
+		 */
+		range->size += bio->bi_iter.bi_size;
+		range->__bio = bio->bi_next;
+	}
+	return true;
+}
+
+#define rq_for_each_discard_range(range, rq) \
+	for (req_init_discard_range_iter((rq), &range); \
+			req_get_discard_range(&range);)
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
-- 
2.31.1



Thanks,
Ming

