Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F783FE749
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhIBBwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:52:55 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:50934 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229910AbhIBBwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:52:54 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 21:52:53 EDT
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowACXeHHXLDBhbQY2AQ--.58084S2;
        Thu, 02 Sep 2021 09:46:02 +0800 (CST)
From:   jiasheng <jiasheng@iscas.ac.cn>
To:     linux-kernel@vger.kernel.org
Cc:     jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 9/9] x86/microcode/amd: Add __list_del_entry_valid() in front of __list_del() in free_cache()
Date:   Thu,  2 Sep 2021 01:45:56 +0000
Message-Id: <1630547156-3731187-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowACXeHHXLDBhbQY2AQ--.58084S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4DGFy3AF1fKF1UAr1rXrb_yoWkWFc_Xa
        4kJw18Wr4xJF9IqrsrAw48WFy3Aw15tFnYqryIq345t345KF15Aa17tayYgry3WrWktFZ8
        Zr98AF47GF1kWjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
        IxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqfOwUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have found that in the complied files __list_del()
appear more than 100 times, and under at least 90% circumstances
that __list_del_entry_valid() and __list_del() appear in pairs.
For example, they appear together in the __list_del_entry()
of the header file, 'include/linux/list.h'.
But we have found that in the free_cache(), there is only
__list_del() instead of the pair.
Therefore, we consider that the __list_del_entry_valid()
might be forgotten.

Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3d4a483..1987ee1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -626,6 +626,8 @@ static void free_cache(void)
 	struct ucode_patch *p, *tmp;
 
 	list_for_each_entry_safe(p, tmp, &microcode_cache, plist) {
+		if (!__list_del_entry_valid(p->plist))
+			continue;
 		__list_del(p->plist.prev, p->plist.next);
 		kfree(p->data);
 		kfree(p);
-- 
2.7.4

