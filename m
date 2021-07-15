Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856573C94C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhGOAFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 20:05:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:64465 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhGOAFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 20:05:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="207426911"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="207426911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 17:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="466263057"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2021 17:02:23 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3opa-000JA8-T4; Thu, 15 Jul 2021 00:02:22 +0000
Date:   Thu, 15 Jul 2021 08:02:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH] sched/fair: __pcpu_scope_nohz_balance_mask can be static
Message-ID: <20210715000201.GA122205@dea27cc16cf6>
References: <20210714113928.2795632-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714113928.2795632-1-valentin.schneider@arm.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched/fair.c:5697:1: warning: symbol '__pcpu_scope_nohz_balance_mask' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 497208a1afb88..c6a515d469dd8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5694,7 +5694,7 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
-DEFINE_PER_CPU(cpumask_var_t, nohz_balance_mask);
+static DEFINE_PER_CPU(cpumask_var_t, nohz_balance_mask);
 
 static struct {
 	cpumask_var_t idle_cpus_mask;    /* CPUs in NOHZ idle */
