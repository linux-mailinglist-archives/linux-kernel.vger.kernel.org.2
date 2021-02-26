Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC0326066
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBZJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:45:42 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:36480 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhBZJpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:45:33 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-05 (Coremail) with SMTP id zQCowAB3WRb8wjhgitu9AA--.22780S2;
        Fri, 26 Feb 2021 17:44:29 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Use WARN(1,...)
Date:   Fri, 26 Feb 2021 09:44:26 +0000
Message-Id: <20210226094426.49016-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAB3WRb8wjhgitu9AA--.22780S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wry5Wry5AF4UKr17KF15Jwb_yoWxZrc_CF
        4jg3W8Kw1UCFyqyr43Can7Xry0ka4qgF10kw1rtrW3A3Z8Gr1rWan8ArnrKr97XryqgF97
        ZrnrWrykKrsIvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bFBM_UUUUU=
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQoEA102Z9fu-AAAsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WARN(1,...) rather than printk followed by WARN_ON(1).

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 526fd5ac2ba8..a556b8c00a9f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1957,7 +1957,7 @@ static int run_tracer_selftest(struct tracer *type)
 	tr->current_trace = saved_tracer;
 	if (ret) {
 		/* Add the warning after printing 'FAILED' */
-		WARN(1, KERN_CONT "FAILED!\n");
+		WARN(1, "FAILED!\n");
 		return -1;
 	}
 	/* Only reset on passing, to avoid touching corrupted buffers */
-- 
2.17.1

