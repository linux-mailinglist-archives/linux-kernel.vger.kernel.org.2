Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394039EFD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFHHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:42:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4509 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:42:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fzhsv5QzzzZdww;
        Tue,  8 Jun 2021 15:37:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:40:44 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:40:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] tracing: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:40:28 +0800
Message-ID: <20210608074029.12852-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

find kernel/trace/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/trace/ftrace.c      | 2 +-
 kernel/trace/ring_buffer.c | 2 +-
 kernel/trace/trace.c       | 2 +-
 kernel/trace/trace_seq.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2e8a3fde7104..1b013e29fa44 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4414,7 +4414,7 @@ int ftrace_func_mapper_add_ip(struct ftrace_func_mapper *mapper,
  * @ip: The instruction pointer address to remove the data from
  *
  * Returns the data if it is found, otherwise NULL.
- * Note, if the data pointer is used as the data itself, (see 
+ * Note, if the data pointer is used as the data itself, (see
  * ftrace_func_mapper_find_ip(), then the return value may be meaningless,
  * if the data pointer was set to zero.
  */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3cb9733719e5..833ade3d0b00 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3365,7 +3365,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d683a56a3e26..1446a3f80a06 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6205,7 +6205,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index ec63d0ae6a22..2eba0d1e9fd8 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -12,7 +12,7 @@
  * This will set up the counters within the descriptor. You can call
  * trace_seq_init() more than once to reset the trace_seq to start
  * from scratch.
- * 
+ *
  * The buffer size is currently PAGE_SIZE, although it may become dynamic
  * in the future.
  *
-- 
2.25.1


