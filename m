Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A432107F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhBVFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:38:24 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:32847
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229487AbhBVFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:38:19 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgAHuDgEQzNgrzIUAw--.49872S3;
        Mon, 22 Feb 2021 13:37:08 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/mempolicy: minor coding style tweaks
Date:   Mon, 22 Feb 2021 13:37:08 +0800
Message-Id: <1613972228-25501-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgAHuDgEQzNgrzIUAw--.49872S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1xKr45Cw13urWUtF43KFg_yoWfKFc_ua
        1Iqa4xCFn8ZF1fGFs2vasaqFs0kwsFkFykZr18tay2v3yDArs8tr409ryxur4rZr43GF17
        C3yYvrsxX3Z7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe2NtDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whitespace to fix coding style issues, improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2c3a865..740633d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -330,7 +330,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	else if (pol->flags & MPOL_F_RELATIVE_NODES)
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 	else {
-		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
+		nodes_remap(tmp, pol->v.nodes, pol->w.cpuset_mems_allowed,
 								*nodes);
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
@@ -1151,7 +1151,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 
 	tmp = *from;
 	while (!nodes_empty(tmp)) {
-		int s,d;
+		int s, d;
 		int source = NUMA_NO_NODE;
 		int dest = 0;
 
-- 
1.8.3.1

