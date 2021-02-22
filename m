Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0153320F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 02:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhBVBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 20:44:59 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:42633
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230151AbhBVBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 20:44:57 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgDn7ztTDDNgB6kTAw--.49700S3;
        Mon, 22 Feb 2021 09:43:47 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] arm64/mm: Fixed some coding style issues
Date:   Mon, 22 Feb 2021 09:43:51 +0800
Message-Id: <1613958231-5474-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgDn7ztTDDNgB6kTAw--.49700S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13tw17tF48GrWrXry5Arb_yoW8JFy7pF
        naka1kKr4fKFykCrZrZry8Wry5uwn7Gas8JF4agFyqkF13J3W8Wry093sakF4UXFykZa13
        GayYy34UAay5XaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWk
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5AwIDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch move the pointer location to fix coding style issues,
improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 arch/arm64/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 25af183..9ce8641 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1155,7 +1155,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
-static inline pud_t * fixmap_pud(unsigned long addr)
+static inline pud_t *fixmap_pud(unsigned long addr)
 {
 	pgd_t *pgdp = pgd_offset_k(addr);
 	p4d_t *p4dp = p4d_offset(pgdp, addr);
@@ -1166,7 +1166,7 @@ static inline pud_t * fixmap_pud(unsigned long addr)
 	return pud_offset_kimg(p4dp, addr);
 }
 
-static inline pmd_t * fixmap_pmd(unsigned long addr)
+static inline pmd_t *fixmap_pmd(unsigned long addr)
 {
 	pud_t *pudp = fixmap_pud(addr);
 	pud_t pud = READ_ONCE(*pudp);
@@ -1176,7 +1176,7 @@ static inline pmd_t * fixmap_pmd(unsigned long addr)
 	return pmd_offset_kimg(pudp, addr);
 }
 
-static inline pte_t * fixmap_pte(unsigned long addr)
+static inline pte_t *fixmap_pte(unsigned long addr)
 {
 	return &bm_pte[pte_index(addr)];
 }
-- 
1.8.3.1

