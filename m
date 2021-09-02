Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D80E3FE9BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhIBHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:10:28 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:46898 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242504AbhIBHK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:10:27 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowACnlNKSeDBh4Ic9AQ--.4291S2;
        Thu, 02 Sep 2021 15:09:06 +0800 (CST)
From:   jiasheng <jiasheng@iscas.ac.cn>
To:     linux-kernel@vger.kernel.org
Cc:     jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 2/2] tracing: Add trace_trigger_soft_disabled() in front of trace_event_buffer_commit() in trace_inject_entry()
Date:   Thu,  2 Sep 2021 07:09:03 +0000
Message-Id: <1630566543-598084-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACnlNKSeDBh4Ic9AQ--.4291S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4DJry7tF1UJw4xuF18AFb_yoW8JrWUpw
        nxKr9xKrW8Ja12g3WxuF48GryUZ397tr9rJFW8G343J3s8CrnrXFZ2qFn8Z34Yyw48J3ya
        yw1jyrW7CrWUXFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIApnUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have found that in the complied files trace_event_buffer_commit()
appear more than 200 times, and under at least 90% circumstances
that trace_trigger_soft_disabled() and trace_event_buffer_commit()
appear in pairs.
For example, they appear together in the trace_event_raw_event_##call()
of the file complie from 'include/trace/trace_events.h'.
But we have found that in the trace_inject_entry(), there is only
trace_event_buffer_commit() instead of the pair.
Therefore, we consider that the trace_trigger_soft_disabled()
might be forgotten.

Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
---
 kernel/trace/trace_events_inject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index c188045..6dfd3cd 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -21,6 +21,8 @@ trace_inject_entry(struct trace_event_file *file, void *rec, int len)
 	void *entry;
 
 	rcu_read_lock_sched();
+	if (trace_trigger_soft_disabled(file))
+		return written;
 	entry = trace_event_buffer_reserve(&fbuffer, file, len);
 	if (entry) {
 		memcpy(entry, rec, len);
-- 
2.7.4

