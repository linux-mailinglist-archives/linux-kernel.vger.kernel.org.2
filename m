Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2686D356CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352444AbhDGMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:50:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16062 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352426AbhDGMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:50:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkhx59Rnz16J2r;
        Wed,  7 Apr 2021 20:48:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:50:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] powerpc/smp: Make some symbols static
Date:   Wed, 7 Apr 2021 20:59:03 +0800
Message-ID: <20210407125903.4139663-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

arch/powerpc/kernel/smp.c:86:1: warning:
 symbol '__pcpu_scope_cpu_coregroup_map' was not declared. Should it be static?
arch/powerpc/kernel/smp.c:125:1: warning:
 symbol '__pcpu_scope_thread_group_l1_cache_map' was not declared. Should it be static?
arch/powerpc/kernel/smp.c:132:1: warning:
 symbol '__pcpu_scope_thread_group_l2_cache_map' was not declared. Should it be static?

These symbols are not used outside of smp.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 arch/powerpc/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5a4d59a1070d..63ccc70bdd0d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -83,7 +83,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
-DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
+static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
@@ -122,14 +122,14 @@ static struct thread_groups_list tgl[NR_CPUS] __initdata;
  * On big-cores system, thread_group_l1_cache_map for each CPU corresponds to
  * the set its siblings that share the L1-cache.
  */
-DEFINE_PER_CPU(cpumask_var_t, thread_group_l1_cache_map);
+static DEFINE_PER_CPU(cpumask_var_t, thread_group_l1_cache_map);
 
 /*
  * On some big-cores system, thread_group_l2_cache_map for each CPU
  * corresponds to the set its siblings within the core that share the
  * L2-cache.
  */
-DEFINE_PER_CPU(cpumask_var_t, thread_group_l2_cache_map);
+static DEFINE_PER_CPU(cpumask_var_t, thread_group_l2_cache_map);
 
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
-- 
2.25.4

