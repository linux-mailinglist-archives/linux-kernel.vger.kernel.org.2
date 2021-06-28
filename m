Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8C3B587F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhF1FE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:04:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229578AbhF1FEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:04:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S4jPvT147889;
        Mon, 28 Jun 2021 01:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=HNOACgFDiUJg+I5VVNhuPXKpATRWk+P3y3rpSndAr+M=;
 b=l27YZYv/5+8tzKBk42G8uZJ3UiRwCNPo/Oc/e3BG9Nex3z/QfG3Xyt/BaiUxirUDyjmX
 MxmbeZQ2LMrDUF1/PJkNkjVJq5DQzYyR2rbYY3rWMFKMmf0iLaGbSbvZR5vXXqG8/cW4
 7UlFDqFIyGrnAFectjcoDwEYPGuir1DnMhS9LKJqXLwy1ZTkky7vC0WQJzxE70o2LFQv
 GfpyUCUNmsJniUrznj+GvVXcDwq5pvVXDfMEhip0zfku93R1X3nMRC5GgB55HRRPttEC
 G5M/CuyFJ20pxQM+891Py9ZhNtJBNl1Ax1V1nWP1ClCWei+4nC0wAKa48/jIL6b4+J6G 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39f4uebgeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 01:01:57 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15S4Z512115422;
        Mon, 28 Jun 2021 01:01:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39f4uebgdt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 01:01:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15S4X9iW023347;
        Mon, 28 Jun 2021 04:39:27 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 39ekx9d5nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 04:39:27 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15S4dRh340960470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 04:39:27 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E07112065;
        Mon, 28 Jun 2021 04:39:26 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80563112063;
        Mon, 28 Jun 2021 04:39:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.89])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 04:39:26 +0000 (GMT)
From:   wenxiong@linux.vnet.ibm.com
To:     ming.lei@redhat.com
Cc:     linux-kernel@vger.kernel.org, james.smart@broadcom.com,
        dwagner@suse.de, wenxiong@us.ibm.com,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing port
Date:   Sun, 27 Jun 2021 22:14:32 -0500
Message-Id: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.6.0.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xxzHLPShmb1IQc0eSZVSHD39h0mpBlro
X-Proofpoint-ORIG-GUID: N_GKISwL3-6fcmTho52Kf006AdfUXcqw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_03:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Error inject:

1. run hash ppc64_cpu  2>/dev/null && ppc64_cpu --smt=4
2. Disable one SVC port (at switch) down for 10 mins
3. Enable port back
4. Linux crash

System has two cores with 16 cpus like cpu0-cpu15. All cpus
are online when system boots up.
core0: cpu0-cpu7 online
core1: cpu8-cpu15 online

Issue the following cpu houplug command in ppc:
cpu0-cpu3 are online
cpu4-cpu7 are offline
cpu8-cpu11 are online
cpu12-cpu15 are offline

After this cpu hotplug operations, the state of hctx are changed:
- cpu0-cpu3(online): no change
- cpu4-cpu7(offline): mask off. The state for each hctx set to
INACTIVE, also realloc htcx for this cpu.
- cpu8-cpu11(oneline): cpus are still active but hctxs are disable
after calling realloc hctx
- cpu12-cpu15(offline):  mask off, The state for each hctx set to
INACTIVE, hctxs are disable.

From nvme/fc driver:
nvme_fc_create_association()
->nvme_fc_recreate_io_queues() if ctrl->ioq_live=ture
  ->nvme_fc_connect_io_queues()
    ->blk_mq_update_nr_hw_queues()
    ->nvme_fc_connect_io_queues()
      ->nvmf_connect_io_queue()

nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
{

        for (i = 1; i < ctrl->ctrl.queue_count; i++) {

                ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);

                set_bit(NVME_FC_Q_LIVE, &ctrl->queues[i].flags);
        }

}

After cpu hotplug, i loop from 1->8, let see what's happned if pass i:
i = 1, call blk_mq_alloc_request_hctx with id = 0 ok
i = 2, call blk_mq_alloc_request_hctx with id = 1 ok
i = 3, call blk_mq_alloc_request_hctx with id = 2 ok
i = 4, call blk_mq_alloc_request_hctx with id = 3 ok
i = 5, call blk_mq_alloc_request_hctx with id = 4 crash (cpu = 2048)
i = 6, call blk_mq_alloc_request_hctx with id = 5 crash (cpu = 2048)
i = 7, call blk_mq_alloc_request_hctx with id = 6 crash (cpu = 2048)
i = 8, call blk_mq_alloc_request_hctx with id = 7 crash (cpu = 2048)

cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);

The patch fixed the crash issue when doing bouncing port on storage side + cpu hotplug.
---
 block/blk-mq-tag.c | 3 ++-
 block/blk-mq.c     | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2a37731e8244..b927233bb6bb 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -171,7 +171,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	 * Give up this allocation if the hctx is inactive.  The caller will
 	 * retry on an active hctx.
 	 */
-	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))
+			&& data->hctx->queue_num > num_online_cpus()) {
 		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
 		return BLK_MQ_NO_TAG;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c86c01bfecdb..5e31bd9b06c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -436,7 +436,6 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		.cmd_flags	= op,
 	};
 	u64 alloc_time_ns = 0;
-	unsigned int cpu;
 	unsigned int tag;
 	int ret;
 
@@ -468,8 +467,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
-	data.ctx = __blk_mq_get_ctx(q, cpu);
+	data.ctx = __blk_mq_get_ctx(q, hctx_idx);
 
 	if (!q->elevator)
 		blk_mq_tag_busy(data.hctx);
-- 
2.27.0

