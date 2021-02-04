Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5130EB07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhBDDfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:35:40 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49614 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234145AbhBDDf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:35:26 -0500
Received: from loongson.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxidRHaxtgqDEDAA--.3945S2;
        Thu, 04 Feb 2021 11:34:32 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Remove unused ftrace_force_update()
Date:   Thu,  4 Feb 2021 11:34:31 +0800
Message-Id: <1612409671-8249-1-git-send-email-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxidRHaxtgqDEDAA--.3945S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13Aw1kWryxtF1DXFyrZwb_yoWkKFb_ZF
        n2yw18Cr47u3Z5Cw1rGr13ta4DWw10qr1qgF1vgrW7Zwn8Jr4ruay7W3srZF4jga1xZFya
        9F1xWas7Xr13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr4l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyG2MUUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_force_update() is committed by Commit e1c08bdd9fa7 ("ftrace: force
recording") and removed by Commit cb7be3b2fc2c ("ftrace: remove daemon").
Remove it in header file.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 include/linux/ftrace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9a8ce28..86e5028 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -485,7 +485,6 @@ struct dyn_ftrace {
 	struct dyn_arch_ftrace	arch;
 };
 
-int ftrace_force_update(void);
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset);
 int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
@@ -740,7 +739,6 @@ extern void ftrace_disable_daemon(void);
 extern void ftrace_enable_daemon(void);
 #else /* CONFIG_DYNAMIC_FTRACE */
 static inline int skip_trace(unsigned long ip) { return 0; }
-static inline int ftrace_force_update(void) { return 0; }
 static inline void ftrace_disable_daemon(void) { }
 static inline void ftrace_enable_daemon(void) { }
 static inline void ftrace_module_init(struct module *mod) { }
-- 
2.1.0

