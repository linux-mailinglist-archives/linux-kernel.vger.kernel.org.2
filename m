Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69F45C6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349072AbhKXOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:14:47 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14979 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355407AbhKXONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:13:46 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HzjX20ndPzZd4N;
        Wed, 24 Nov 2021 22:08:02 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 22:10:34 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 22:10:34 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH] trace: Fix a kmemleak noise
Date:   Wed, 24 Nov 2021 14:08:01 +0000
Message-ID: <20211124140801.87121-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when run
echo 'hist:key=common_pid.execname,common_timestamp' >
/sys/kernel/debug/tracing/events/xxx/trigger

many kmemleak reported
unreferenced object 0xffff0000c7ea4980 (size 128):
  comm "bash", pid 338, jiffies 4294912626 (age 9339.324s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f3469921>] kmem_cache_alloc_trace+0x4c0/0x6f0
    [<0000000054ca40c3>] hist_trigger_elt_data_alloc+0x140/0x178
    [<00000000633bd154>] tracing_map_init+0x1f8/0x268
    [<000000007e814ab9>] event_hist_trigger_func+0xca0/0x1ad0
    [<00000000bf8520ed>] trigger_process_regex+0xd4/0x128
    [<00000000f549355a>] event_trigger_write+0x7c/0x120
    [<00000000b80f898d>] vfs_write+0xc4/0x380
    [<00000000823e1055>] ksys_write+0x74/0xf8
    [<000000008a9374aa>] __arm64_sys_write+0x24/0x30
    [<0000000087124017>] do_el0_svc+0x88/0x1c0
    [<00000000efd0dcd1>] el0_svc+0x1c/0x28
    [<00000000dbfba9b3>] el0_sync_handler+0x88/0xc0
    [<00000000e7399680>] el0_sync+0x148/0x180
unreferenced object 0xffff0000c7ea4980 (size 128):
  comm "bash", pid 338, jiffies 4294912626 (age 9339.324s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f3469921>] kmem_cache_alloc_trace+0x4c0/0x6f0
    [<0000000054ca40c3>] hist_trigger_elt_data_alloc+0x140/0x178
    [<00000000633bd154>] tracing_map_init+0x1f8/0x268
    [<000000007e814ab9>] event_hist_trigger_func+0xca0/0x1ad0
    [<00000000bf8520ed>] trigger_process_regex+0xd4/0x128
    [<00000000f549355a>] event_trigger_write+0x7c/0x120
    [<00000000b80f898d>] vfs_write+0xc4/0x380
    [<00000000823e1055>] ksys_write+0x74/0xf8
    [<000000008a9374aa>] __arm64_sys_write+0x24/0x30
    [<0000000087124017>] do_el0_svc+0x88/0x1c0
    [<00000000efd0dcd1>] el0_svc+0x1c/0x28
    [<00000000dbfba9b3>] el0_sync_handler+0x88/0xc0
    [<00000000e7399680>] el0_sync+0x148/0x180

The reason is elts->pages[i] is alloced by get_zeroed_page.
and kmemleak will not scan the area alloced by get_zeroed_page.
The address stored in elts->pages will be regarded as leaked.

To fix this, call kmemleak_alloc to tell kmemleak to scan elts->pages[i]

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 kernel/trace/tracing_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 4b50fc0cb12c..66307675d2a5 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -15,6 +15,7 @@
 #include <linux/jhash.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/kmemleak.h>
 
 #include "tracing_map.h"
 #include "trace.h"
@@ -307,6 +308,7 @@ static void tracing_map_array_free(struct tracing_map_array *a)
 	for (i = 0; i < a->n_pages; i++) {
 		if (!a->pages[i])
 			break;
+		kmemleak_free(a->pages[i]);
 		free_page((unsigned long)a->pages[i]);
 	}
 
@@ -342,6 +344,7 @@ static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!a->pages[i])
 			goto free;
+		kmemleak_alloc(a->pages[i], PAGE_SIZE, 1, GFP_KERNEL);
 	}
  out:
 	return a;
-- 
2.17.1

