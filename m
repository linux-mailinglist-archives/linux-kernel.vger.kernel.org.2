Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA333052A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhA0F6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:58:45 -0500
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:51822 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhA0DQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:16:47 -0500
Received: from localhost.localdomain (unknown [218.94.118.90])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 69032E026F4;
        Wed, 27 Jan 2021 11:15:52 +0800 (CST)
From:   Dongsheng Yang <dongsheng.yang@easystack.cn>
To:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchristi@redhat.com
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH V3] bcache: dont reset bio opf in bch_data_insert_start
Date:   Wed, 27 Jan 2021 11:15:50 +0800
Message-Id: <20210127031550.3605-1-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.25.1
Reply-To: 20210127031111.3493-1-dongsheng.yang@easystack.cn
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZHhkaTR1ISk4eSE5KVkpNSkpMSkxITklMQ0pVGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6Mxw6ED0xOggiMEoxE0sK
        PD0aCUpVSlVKTUpKTEpMSE5JQk5JVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
        V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSE1NQzcG
X-HM-Tid: 0a7741d71c7620bdkuqy69032e026f4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ad0d9e76(bcache: use bio op accessors) makes the bi_opf
modified by bio_set_op_attrs(). But there is a logical
problem in this commit:

                trace_bcache_cache_insert(k);
                bch_keylist_push(&op->insert_keys);

-               n->bi_rw |= REQ_WRITE;
+               bio_set_op_attrs(n, REQ_OP_WRITE, 0);
                bch_submit_bbio(n, op->c, k, 0);
        } while (n != bio);

The old code add REQ_WRITE into bio n and keep other flags; the
new code set REQ_OP_WRITE to bi_opf, but reset all other flags.

This problem is discoverd in our performance testing:
(1) start a fio with 1M x 128depth for read in /dev/nvme0n1p1
(2) start a fio with 1M x 128depth for write in /dev/escache0 (cache
device is /dev/nvme0n1p2)

We found the BW of reading is 2000+M/s, but the BW of writing is
0-100M/s. After some debugging, we found the problem is io submit in
writting is very slow.

bch_data_insert_start() insert a bio to /dev/nvme0n1p1, but as
cached_dev submit stack bio will be added into current->bio_list, and
return.Then __submit_bio_noacct() will submit the new bio in bio_list
into /dev/nvme0n1p1. This operation would be slow in
blk_mq_submit_bio() -> rq_qos_throttle(q, bio);

The rq_qos_throttle() will call wbt_should_throttle(),
static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
{
        switch (bio_op(bio)) {
        case REQ_OP_WRITE:
                /*
                 * Don't throttle WRITE_ODIRECT
                 */
                if ((bio->bi_opf & (REQ_SYNC | REQ_IDLE)) ==
                    (REQ_SYNC | REQ_IDLE))
                        return false;
... ...
}

As the bio_set_op_attrs() reset the (REQ_SYNC | REQ_IDLE), so this write
bio will be considered as non-direct write.

After this fix, bio to nvme will flaged as (REQ_SYNC | REQ_IDLE),
then fio for writing will get about 1000M/s bandwidth.

Fixes: ad0d9e76a412 ("bcache: use bio op accessors")
CC: Mike Christie <mchristi@redhat.com>
Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
V3-V2:
	remove an unused close-line in commit message.

 drivers/md/bcache/request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index c7cadaafa947..eb734f7ddaac 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -244,7 +244,7 @@ static void bch_data_insert_start(struct closure *cl)
 		trace_bcache_cache_insert(k);
 		bch_keylist_push(&op->insert_keys);
 
-		bio_set_op_attrs(n, REQ_OP_WRITE, 0);
+		n->bi_opf |= REQ_OP_WRITE;
 		bch_submit_bbio(n, op->c, k, 0);
 	} while (n != bio);
 
-- 
2.25.1

