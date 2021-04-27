Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDF36C16D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhD0JED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:04:03 -0400
Received: from mail.loongson.cn ([114.242.206.163]:39662 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229629AbhD0JD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:03:58 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP+9Q04dgSm8OAA--.7255S2;
        Tue, 27 Apr 2021 17:03:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] samples/kprobes: Fix typo in handler_post()
Date:   Tue, 27 Apr 2021 17:03:11 +0800
Message-Id: <1619514191-14551-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxP+9Q04dgSm8OAA--.7255S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryfuF1DAFyDGw4Duw1kGrg_yoWfArc_A3
        srtr92grW8Jr98uF12krsYqFsaqw1xWr4xG392qr9FvFnxJry7C3ykKr4DGa1fX3s8KFyU
        Jr4DX347ZF4xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EAp5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should use post_handler instead of pre_handler in handler_post().

Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/kprobes/kprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 331dcf1..c421fba 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -81,7 +81,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
 #endif
 #ifdef CONFIG_S390
-	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
+	pr_info("<%s> post_handler: p->addr, 0x%p, flags = 0x%lx\n",
 		p->symbol_name, p->addr, regs->flags);
 #endif
 }
-- 
2.1.0

