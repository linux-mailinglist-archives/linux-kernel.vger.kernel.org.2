Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74C93CB54E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhGPJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232617AbhGPJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626428004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m08xqBA+uGZoSfDv0tyerS1nF0XIak+eyqoZwC+cyQU=;
        b=fs+uiCL+FgX9B4Y7CzNcyliC87vtZtwMV4adJC3RD6CV7gFLE38p+4ZAqBQhxtxmL3O6Oi
        E5OrOTQabtzve7ABKXGhJA6iTjDHtndUoQBwwmKWsvTjnQMIjeQNslBEsgi0PHRQrxLdSN
        kTVURCL7orejL2/YPVRswQQmp4YtVsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-RuIirQ95PvymlHJa_zgO6g-1; Fri, 16 Jul 2021 05:33:23 -0400
X-MC-Unique: RuIirQ95PvymlHJa_zgO6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362F5CC621;
        Fri, 16 Jul 2021 09:33:21 +0000 (UTC)
Received: from T590 (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5136604CD;
        Fri, 16 Jul 2021 09:33:10 +0000 (UTC)
Date:   Fri, 16 Jul 2021 17:33:05 +0800
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
Message-ID: <YPFSUfG+fMITAH01@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <YPDr8ucoDCE4NBSe@T590>
 <81322754.HEIg0oD171@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81322754.HEIg0oD171@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 07:53:28AM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> On pátek 16. července 2021 4:16:18 CEST Ming Lei wrote:
> > >  850     if (WARN_ON_ONCE(n != segments)) {
> > 
> > What is 'n' and 'segments'?
> 
> So, I used this change to check that:
> 
> ```
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 66973bb56305..0a64f2f77daf 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -847,7 +847,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, 
> struct request *req,
>  		n++;
>  	}
>  
> -	if (WARN_ON_ONCE(n != segments)) {
> +	if (unlikely(n != segments)) {
> +		pr_warn("nvme_setup_discard: n != segments (%u != %u)\n", n, 
> segments);
>  		if (virt_to_page(range) == ns->ctrl->discard_page)
>  			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
>  		else
> 
> ```
> 
> and the result is:
> 
> ```
> nvme_setup_discard: n != segments (3 != 2)
> nvme_setup_discard: n != segments (12 != 11)
> ```

Can you test the following patch?

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..673a634eadd9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2361,6 +2361,9 @@ static int bfq_request_merge(struct request_queue *q, struct request **req,
 	__rq = bfq_find_rq_fmerge(bfqd, bio, q);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
+
+		if (blk_discard_mergable(__rq))
+			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_FRONT_MERGE;
 	}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a11b3b53717e..f8707ff7e2fc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -705,22 +705,6 @@ static void blk_account_io_merge_request(struct request *req)
 	}
 }
 
-/*
- * Two cases of handling DISCARD merge:
- * If max_discard_segments > 1, the driver takes every bio
- * as a range and send them to controller together. The ranges
- * needn't to be contiguous.
- * Otherwise, the bios/requests will be handled as same as
- * others which should be contiguous.
- */
-static inline bool blk_discard_mergable(struct request *req)
-{
-	if (req_op(req) == REQ_OP_DISCARD &&
-	    queue_max_discard_segments(req->q) > 1)
-		return true;
-	return false;
-}
-
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..a5fe2615ec0f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -336,6 +336,9 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
 	__rq = elv_rqhash_find(q, bio->bi_iter.bi_sector);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
+
+		if (blk_discard_mergable(__rq))
+			return ELEVATOR_DISCARD_MERGE;
 		return ELEVATOR_BACK_MERGE;
 	}
 
diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 6f612e6dc82b..294be0c0db65 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -677,6 +677,8 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 
 		if (elv_bio_merge_ok(__rq, bio)) {
 			*rq = __rq;
+			if (blk_discard_mergable(__rq))
+				return ELEVATOR_DISCARD_MERGE;
 			return ELEVATOR_FRONT_MERGE;
 		}
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..87f00292fd7a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1521,6 +1521,22 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 	return offset << SECTOR_SHIFT;
 }
 
+/*
+ * Two cases of handling DISCARD merge:
+ * If max_discard_segments > 1, the driver takes every bio
+ * as a range and send them to controller together. The ranges
+ * needn't to be contiguous.
+ * Otherwise, the bios/requests will be handled as same as
+ * others which should be contiguous.
+ */
+static inline bool blk_discard_mergable(struct request *req)
+{
+	if (req_op(req) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(req->q) > 1)
+		return true;
+	return false;
+}
+
 static inline int bdev_discard_alignment(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);

Thanks,
Ming

