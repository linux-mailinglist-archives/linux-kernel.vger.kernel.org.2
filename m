Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF83249C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhBYEfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:35:48 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:60451
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231284AbhBYEfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:35:45 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgC3v8PgKDdgePUfAw--.17619S3;
        Thu, 25 Feb 2021 12:34:40 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/vmscan: minor coding style tweaks
Date:   Thu, 25 Feb 2021 12:34:09 +0800
Message-Id: <1614227649-19853-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgC3v8PgKDdgePUfAw--.17619S3
X-Coremail-Antispam: 1UD129KBjvdXoWrGF1UWF15Ar45Xr1fWr1rZwb_yoWxWwbE9a
        yIgr4vgryDJF92kw1akF4IqFZ3Xw1q9r1DAr18ZF42qa4UGrWfZFykCryrZ34UXw13AF9I
        q3Z0vr9aq34xujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU22NtUUU
        UU=
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whitespace to fix coding style issues, improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1b574a..333c43b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3872,7 +3872,7 @@ static int kswapd(void *p)
 {
 	unsigned int alloc_order, reclaim_order;
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
-	pg_data_t *pgdat = (pg_data_t*)p;
+	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
 
-- 
1.8.3.1

