Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EBE445903
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKDRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:55:35 -0400
Received: from foss.arm.com ([217.140.110.172]:50404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhKDRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3274012FC;
        Thu,  4 Nov 2021 10:52:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.47.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0742C3F719;
        Thu,  4 Nov 2021 10:52:50 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, jing-ting.wu@mediatek.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()
Date:   Thu,  4 Nov 2021 17:51:20 +0000
Message-Id: <20211104175120.857087-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing protects the access to the per_cpu variable sd_llc_id. When testing
the same CPU (i.e. this_cpu == that_cpu), a race condition exists with
update_top_cache_domain(). One scenario being:

              CPU1                            CPU2
  ==================================================================

  per_cpu(sd_llc_id, CPUX) => 0
                                    partition_sched_domains_locked()
      				      detach_destroy_domains()
  cpus_share_cache(CPUX, CPUX)          update_top_cache_domain(CPUX)
    per_cpu(sd_llc_id, CPUX) => 0
                                          per_cpu(sd_llc_id, CPUX) = CPUX
    per_cpu(sd_llc_id, CPUX) => CPUX
    return false

ttwu_queue_cond() wouldn't catch smp_processor_id() == cpu and the result
is a warning triggered from ttwu_queue_wakelist().

Avoid a such race in cpus_share_cache() by always returning true when
this_cpu == that_cpu.

Fixes: 518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")
Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2611b9cf503..f5ca15cdcff4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3726,6 +3726,9 @@ void wake_up_if_idle(int cpu)
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
+	if (this_cpu == that_cpu)
+		return true;
+
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-- 
2.25.1

