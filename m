Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190E43FF872
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbhICAvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 20:51:06 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:46112 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231577AbhICAvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:51:05 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowABXeBAlcTFhFZEOAA--.40551S2;
        Fri, 03 Sep 2021 08:49:41 +0800 (CST)
From:   Jiang Jiasheng <jiasheng@iscas.ac.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 3/3] x86/microcode/amd: Add __list_del_entry_valid() in front of __list_del() in free_cache()
Date:   Fri,  3 Sep 2021 00:49:40 +0000
Message-Id: <1630630180-644591-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowABXeBAlcTFhFZEOAA--.40551S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryxtr4UtFWrCrWfJrWkWFg_yoWDtwb_Wa
        4rt348ur4fAFy2vwsFyw48GasxZwn5ta95Kryxta4rt343KFs8Aa12ga1YgFy3WrZYqFZ5
        Arn5CF4UGas3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWD
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU3DG5UUUUU=
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

Signed-off-by: Jiang Jiasheng <jiasheng@iscas.ac.cn>
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

