Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3131E406619
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhIJD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 23:27:46 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:35878 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhIJD1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:27:43 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowACHaaJV0Dph4vkNAA--.29783S2;
        Fri, 10 Sep 2021 11:26:13 +0800 (CST)
From:   Jiang Jiasheng <jiasheng@iscas.ac.cn>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiang Jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 6/6] irq: Potentially 'offset out of size' bug
Date:   Fri, 10 Sep 2021 03:26:12 +0000
Message-Id: <1631244372-1817960-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowACHaaJV0Dph4vkNAA--.29783S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy3JFWkuFykGF13ArW5Jrb_yoW3GrX_Gr
        9YyF1DWr48JryrAw4rtw4xAF1jy348AF48uw1Syay5J390vFn3Aw43XFZ0krsxXrWxAw1x
        A34Y9FW3tr4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU2FALUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find_next_bit() use nr_irqs as size, and using it without
any check might cause its returned value out of the size

Signed-off-by: Jiang Jiasheng <jiasheng@iscas.ac.cn>
---
 kernel/irq/irqdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4a617d73..5bb310a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -820,7 +820,8 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_get_next_irq(unsigned int offset)
 {
-	return find_next_bit(allocated_irqs, nr_irqs, offset);
+	offset = find_next_bit(allocated_irqs, nr_irqs, offset);
+	return offset < nr_irqs ? offset : nr_irqs;
 }
 
 struct irq_desc *
-- 
2.7.4

