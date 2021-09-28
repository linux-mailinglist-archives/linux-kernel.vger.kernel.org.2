Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833C941AB71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhI1JG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:06:58 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:54592 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239774AbhI1JGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:06:55 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAA3PQmu2lJhUhakAQ--.14119S2;
        Tue, 28 Sep 2021 17:04:46 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] x86/microcode/amd: Add __list_del_entry_valid() in front of __list_del() in free_cache()
Date:   Tue, 28 Sep 2021 09:04:44 +0000
Message-Id: <1632819884-800736-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAA3PQmu2lJhUhakAQ--.14119S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxtr4UtFWrCrWfJrWkWFg_yoWkArb_Za
        45t348ur4fAFy2vwsFyw48Gas3Zw1rtFs5Kryxta4rt345KFs8Aa12qa1YgFy3WrZYqFZ5
        Arn5CF4UG3s3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMmh5UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use __list_del() to remove 'p->plist' might be unsafe,
as we can see from the __list_del_entry_valid() of 'lib/list_debug.c'
that p->plist->prev or p->plist->next may be the LIST_POISON,
or p->list is not a valid double list.
In that case, __list_del() will be corruption.
Therefore, we suggest that __list_del_entry_valid()
should be added in front of the __list_del() in free_cache.

Fixes: bad5fa6 ("x86, microcode: Move to a proper location")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3d4a483..e589cff 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -626,6 +626,8 @@ static void free_cache(void)
 	struct ucode_patch *p, *tmp;
 
 	list_for_each_entry_safe(p, tmp, &microcode_cache, plist) {
+		if (!__list_del_entry_valid(&p->plist))
+			continue;
 		__list_del(p->plist.prev, p->plist.next);
 		kfree(p->data);
 		kfree(p);
-- 
2.7.4

