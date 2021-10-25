Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B24390F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhJYIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:17:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14862 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJYIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:16:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hd75w5Nt3z90JS;
        Mon, 25 Oct 2021 16:14:28 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 16:14:30 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 16:14:29 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <akpm@linux-foundation.org>, <shakeelb@google.com>, <guro@fb.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <willy@infradead.org>,
        <songmuchun@bytedance.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH -next] mm/vmpressure: fix data-race with memcg->socket_pressure
Date:   Mon, 25 Oct 2021 08:28:43 +0000
Message-ID: <20211025082843.671690-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KCSAN: data-race in __sk_mem_reduce_allocated / vmpressure

write to 0xffff8881286f4938 of 8 bytes by task 24550 on cpu 3:
 vmpressure+0x218/0x230 mm/vmpressure.c:307
 shrink_node_memcgs+0x2b9/0x410 mm/vmscan.c:2658
 shrink_node+0x9d2/0x11d0 mm/vmscan.c:2769
 shrink_zones+0x29f/0x470 mm/vmscan.c:2972
 do_try_to_free_pages+0x193/0x6e0 mm/vmscan.c:3027
 try_to_free_mem_cgroup_pages+0x1c0/0x3f0 mm/vmscan.c:3345
 reclaim_high mm/memcontrol.c:2440 [inline]
 mem_cgroup_handle_over_high+0x18b/0x4d0 mm/memcontrol.c:2624
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
 exit_to_user_mode_prepare+0x110/0x170 kernel/entry/common.c:191
 syscall_exit_to_user_mode+0x16/0x30 kernel/entry/common.c:266
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:289

read to 0xffff8881286f4938 of 8 bytes by interrupt on cpu 1:
 mem_cgroup_under_socket_pressure include/linux/memcontrol.h:1483 [inline]
 sk_under_memory_pressure include/net/sock.h:1314 [inline]
 __sk_mem_reduce_allocated+0x1d2/0x270 net/core/sock.c:2696
 __sk_mem_reclaim+0x44/0x50 net/core/sock.c:2711
 sk_mem_reclaim include/net/sock.h:1490 [inline]
 ......
 net_rx_action+0x17a/0x480 net/core/dev.c:6864
 __do_softirq+0x12c/0x2af kernel/softirq.c:298
 run_ksoftirqd+0x13/0x20 kernel/softirq.c:653
 smpboot_thread_fn+0x33f/0x510 kernel/smpboot.c:165
 kthread+0x1fc/0x220 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

When reading memcg->socket_pressure in mem_cgroup_under_socket_pressure()
and writing memcg->socket_pressure in vmpressure() at the same time,
the data-race occurs.

So fix it by using READ_ONCE() and WRITE_ONCE() to read and write
memcg->socket_pressure.

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 include/linux/memcontrol.h | 2 +-
 mm/vmpressure.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e34bf0cbdf55..d06bbac14abc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1667,7 +1667,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
 		return true;
 	do {
-		if (time_before(jiffies, memcg->socket_pressure))
+		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
 	} while ((memcg = parent_mem_cgroup(memcg)));
 	return false;
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4166dc..b52644771cc4 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -308,7 +308,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 			 * asserted for a second in which subsequent
 			 * pressure events can occur.
 			 */
-			memcg->socket_pressure = jiffies + HZ;
+			WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
 		}
 	}
 }
-- 
2.25.1

