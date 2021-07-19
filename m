Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81A3CD16C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhGSJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235976AbhGSJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626688716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nl05Atso+AuNvautQ00PbExeQ6q6lD+u2YEfbOwtiR0=;
        b=DNbPj5WsfgCLmUQ5DbW6OT+a3QXKsaFbj/xPKlfchQom+zll+m7KETya5irVCyTMzq+mlI
        hn3GGzmFXDeMSAU8wziWjl85wtW6PskGJ1Gzw+qQyJkxwuWS/mpWsivJK2c6YolYuHkSvC
        iJHbTlIeAwENZp+Rxhx6XqLpfpvay8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-5ZtCIki3P8W9ppD46R69Tg-1; Mon, 19 Jul 2021 05:58:32 -0400
X-MC-Unique: 5ZtCIki3P8W9ppD46R69Tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B151C804146;
        Mon, 19 Jul 2021 09:58:31 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1733969282;
        Mon, 19 Jul 2021 09:58:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 7/7] blk-mq: build default queue map via group_cpus_evenly()
Date:   Mon, 19 Jul 2021 17:57:29 +0800
Message-Id: <20210719095729.834332-8-ming.lei@redhat.com>
In-Reply-To: <20210719095729.834332-1-ming.lei@redhat.com>
References: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
topo into account, so the built mapping is pretty bad, since CPUs
belonging to different NUMA node are assigned to same queue. It is
observed that IOPS drops by ~30% when running two jobs on same hctx
of null_blk from two CPUs belonging to two NUMA nodes compared with
from same NUMA node.

Address the issue by reusing group_cpus_evenly() for addressing the
issue since group_cpus_evenly() does group cpus according to CPU/NUMA
locality.

Lots of drivers may benefit from the change, such as nvme pci poll,
nvme tcp, ...

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 64 +++++++++----------------------------------
 1 file changed, 13 insertions(+), 51 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d3197f1..5f183f52626c 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -10,67 +10,29 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/group_cpus.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 
-static int queue_index(struct blk_mq_queue_map *qmap,
-		       unsigned int nr_queues, const int q)
-{
-	return qmap->queue_offset + (q % nr_queues);
-}
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	return cpu;
-}
-
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
-	unsigned int *map = qmap->mq_map;
-	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling, q = 0;
-
-	for_each_possible_cpu(cpu)
-		map[cpu] = -1;
+	const struct cpumask *masks;
+	unsigned int queue, cpu;
 
-	/*
-	 * Spread queues among present CPUs first for minimizing
-	 * count of dead queues which are mapped by all un-present CPUs
-	 */
-	for_each_present_cpu(cpu) {
-		if (q >= nr_queues)
-			break;
-		map[cpu] = queue_index(qmap, nr_queues, q++);
-	}
+	masks = group_cpus_evenly(qmap->nr_queues);
+	if (!masks)
+		goto fallback;
 
-	for_each_possible_cpu(cpu) {
-		if (map[cpu] != -1)
-			continue;
-		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue
-		 * for performance optimizations.
-		 */
-		if (q < nr_queues) {
-			map[cpu] = queue_index(qmap, nr_queues, q++);
-		} else {
-			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = queue_index(qmap, nr_queues, q++);
-			else
-				map[cpu] = map[first_sibling];
-		}
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, &masks[queue])
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
-
+	return 0;
+ fallback:
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = qmap->queue_offset;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
-- 
2.31.1

