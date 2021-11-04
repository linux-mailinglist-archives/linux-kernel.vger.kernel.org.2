Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79DA445C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhKDXCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:02:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:49613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhKDXCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:02:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="212554547"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="212554547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 15:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="490138591"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2021 15:59:55 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, mingo@redhat.com,
        chang.seok.bae@intel.com
Subject: [PATCH 3/4] x86/fpu: Prepare AMX state for CPU idle
Date:   Thu,  4 Nov 2021 15:52:25 -0700
Message-Id: <20211104225226.5031-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104225226.5031-1-chang.seok.bae@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before entering CPU idle, make sure large registers such as AMX TILE are
initialized. Otherwise, non-initialized register states may prevent a CPU
from entering a deeper low-power state.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index eb470be0e5ae..7044ba276064 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -707,6 +707,7 @@ static inline void play_dead(void)
 
 void arch_cpu_idle_enter(void)
 {
+	fpu_idle_fpregs();
 	tsc_verify_tsc_adjust(false);
 	local_touch_nmi();
 }
-- 
2.17.1

