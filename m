Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED73822AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhEQCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 22:23:13 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40966 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230147AbhEQCXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 22:23:08 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP+4k06FgP_cXAA--.20760S3;
        Mon, 17 May 2021 10:21:27 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v4 1/2] samples/kprobes: Fix typo in handler_fault()
Date:   Mon, 17 May 2021 10:21:22 +0800
Message-Id: <1621218083-23519-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxP+4k06FgP_cXAA--.20760S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWxCw18JFW7KFWfKw18AFb_yoWDJFcEya
        s7t34DWw45JFya9FyUKr4rJFnFqr1xWa1xGw4xXr1qyas3Xay7CF4vkrnrGw4fX398GFyU
        trsrXry7Zr4rWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbyAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JU5Ma5UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a defective format in handler_fault() ending with an 'n' that
should be '\n'.

Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/kprobes/kprobe_example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index c495664..d77a546 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -101,7 +101,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
  */
 static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
 {
-	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
+	pr_info("fault_handler: p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
 	/* Return 0 because we don't handle the fault. */
 	return 0;
 }
-- 
2.1.0

