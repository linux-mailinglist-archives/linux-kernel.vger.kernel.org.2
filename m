Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9F3FF91F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 05:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhICDcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 23:32:19 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:36814 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232339AbhICDcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 23:32:17 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowABHtyzbljFhGMsPAA--.18444S2;
        Fri, 03 Sep 2021 11:30:36 +0800 (CST)
From:   Jiang Jiasheng <jiasheng@iscas.ac.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 2/2] tracing: Add trace_trigger_soft_disabled() in front of trace_event_buffer_reserve() in trace_inject_entry()
Date:   Fri,  3 Sep 2021 03:30:34 +0000
Message-Id: <1630639834-767471-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowABHtyzbljFhGMsPAA--.18444S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1kWF4rWw45urWfKw4kWFg_yoWkXwb_tF
        ykXa4kWr4jkFn5AF4fCr4UXr1ag3WUXF18uw18tFyYq34xJw45Wan8Z34ayrZrGr1j9asr
        twnFgF1IgF1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU84SoDUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use trace_event_buffer_reserve() might be unsafe,
as we can see from the trace_trigger_soft_disabled() of
'include/linux/trace_events.h' that if the value of
file->flags is 256, the check in the trace_trigger_soft_disabled()
will be passed but actually shouldn't have.
Therefore, we suggest that trace_trigger_soft_disabled()
should be added in front of the trace_event_buffer_reserve()
in trace_inject_entry().

Signed-off-by: Jiang Jiasheng <jiasheng@iscas.ac.cn>
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

