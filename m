Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEC43A9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhJZBy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:54:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43206 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233005AbhJZByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:54:15 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2okX3dh6gIgAA--.33960S5;
        Tue, 26 Oct 2021 09:51:38 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, corbet@lwn.net
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] test_kprobes: Move it from kernel/ to lib/
Date:   Tue, 26 Oct 2021 09:51:30 +0800
Message-Id: <1635213091-24387-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
References: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj2okX3dh6gIgAA--.33960S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxKry8Cw4UXrWkuFWktFb_yoW8WFyUpw
        n5Aw48tw4kJ34rX3s7uFyvga48tw4v9342gF1DAr4rJr1kXw45XrsFgrW3trn2gr4ftFWf
        X3WxGFy3KFy5J3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
        3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
        WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU83xhPUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since config KPROBES_SANITY_TEST is in lib/Kconfig.debug, it is better to
let test_kprobes.c in lib/, just like other similar tests found in lib/.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/Makefile                | 1 -
 lib/Makefile                   | 1 +
 {kernel => lib}/test_kprobes.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {kernel => lib}/test_kprobes.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609b..9e4d33d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -85,7 +85,6 @@ obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKHEADERS) += kheaders.o
 obj-$(CONFIG_SMP) += stop_machine.o
-obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tree.o
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b4..864ff51 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
+obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/kernel/test_kprobes.c b/lib/test_kprobes.c
similarity index 100%
rename from kernel/test_kprobes.c
rename to lib/test_kprobes.c
-- 
2.1.0

