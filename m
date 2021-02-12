Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78CA31A46D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhBLSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:18:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:58538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231348AbhBLSSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:18:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6759AAFEC;
        Fri, 12 Feb 2021 18:17:46 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: Check if request has started before processing it
Date:   Fri, 12 Feb 2021 19:17:38 +0100
Message-Id: <20210212181738.79274-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_tag_to_rq() will always return a request if the command_id is
in the valid range. Check if the request has been started. If we
blindly process the request we might double complete a request which
can be fatal.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This patch is against nvme-5.12.

There is one blk_mq_tag_to_rq() in nvme_tcp_recv_ddgst() which I
didn't update as I am not sure if it's also needed.

py-crash> bt
#0  0xffffffffa76a33de in arch_atomic_try_cmpxchg (new=<optimized out>, old=<optimized out>, v=<optimized out>)
    at ../arch/x86/include/asm/atomic.h:200
#1  atomic_try_cmpxchg (new=<optimized out>, old=<optimized out>, v=<optimized out>) at ../include/asm-generic/atomic-instrumented.h:695
#2  queued_spin_lock (lock=<optimized out>) at ../include/asm-generic/qspinlock.h:78
#3  do_raw_spin_lock_flags (flags=<optimized out>, lock=<optimized out>) at ../include/linux/spinlock.h:193
#4  __raw_spin_lock_irqsave (lock=<optimized out>) at ../include/linux/spinlock_api_smp.h:119
#5  _raw_spin_lock_irqsave (lock=0x8 <__UNIQUE_ID_license257+8>) at ../kernel/locking/spinlock.c:159
#6  0xffffffffa6eea418 in complete (x=0x0 <__UNIQUE_ID_license257>) at ../kernel/sched/completion.c:32
#7  0xffffffffa721f99c in blk_mq_force_complete_rq (rq=0x8 <__UNIQUE_ID_license257+8>) at ../block/blk-mq.c:634
#8  0xffffffffa721fa0a in blk_mq_complete_request (rq=<optimized out>) at ../block/blk-mq.c:672
#9  0xffffffffc0b092ef in nvme_end_request (result=..., status=<optimized out>, req=<optimized out>) at ../drivers/nvme/host/nvme.h:477
#10 nvme_tcp_process_nvme_cqe (cqe=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:485
        rq = 0xffff948b840d0000
        hdr = <optimized out>
        ret = 0
        queue = 0xffff949501dd8110
        result = 0
#11 nvme_tcp_handle_comp (pdu=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:542
#12 nvme_tcp_recv_pdu (len=<optimized out>, offset=<optimized out>, skb=<optimized out>, queue=<optimized out>) at ../drivers/nvme/host/tcp.c:660
#13 nvme_tcp_recv_skb (desc=<optimized out>, skb=<optimized out>, offset=24, len=0) at ../drivers/nvme/host/tcp.c:805
#14 0xffffffffa7598af5 in tcp_read_sock
    (sk=0x8 <__UNIQUE_ID_license257+8>, desc=0xa <__UNIQUE_ID_license257+10>, recv_actor=0x1 <__UNIQUE_ID_license257+1>) at ../net/ipv4/tcp.c:1645
#15 0xffffffffc0b075b8 in nvme_tcp_try_recv (queue=0xffff949501dd8110) at ../drivers/nvme/host/tcp.c:1102
#16 0xffffffffc0b08fc7 in nvme_tcp_io_work (w=0xffff949501dd8118) at ../drivers/nvme/host/tcp.c:1126
#17 0xffffffffa6eba4e4 in process_one_work (worker=0xffff948d1b633ec0, work=0xffff949501dd8118) at ../kernel/workqueue.c:2273
#18 0xffffffffa6eba6fd in worker_thread (__worker=0xffff948d1b633ec0) at ../kernel/workqueue.c:2419
#19 0xffffffffa6ec0a3d in kthread (_create=0xffff948d1b618ec0) at ../kernel/kthread.c:268
#20 0xffffffffa7800215 in ret_from_fork () at ../arch/x86/entry/entry_64.S:351

py-crash>  p /x ((struct request*)0xffff948b840d0000)->state
$2 = 0x2

 drivers/nvme/host/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..4bec705ce8e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -485,7 +485,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag 0x%x not found\n",
 			nvme_tcp_queue_id(queue), cqe->command_id);
@@ -506,7 +506,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
@@ -610,7 +610,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	int ret;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
@@ -696,7 +696,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
+	if (!rq || !blk_mq_request_started(rq)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x not found\n",
 			nvme_tcp_queue_id(queue), pdu->command_id);
-- 
2.29.2

