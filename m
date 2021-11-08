Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80A5449F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbhKHXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:44:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:5566 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbhKHXor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:44:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232292397"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232292397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:42:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641642476"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2021 15:42:01 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, yang.zhong@intel.com,
        jing2.liu@intel.com, chang.seok.bae@intel.com
Subject: [PATCH 1/2] x86/arch_prctl: Fix ARCH_REQ_XCOMP_PERM
Date:   Mon,  8 Nov 2021 15:35:00 -0800
Message-Id: <20211108233501.11516-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108233501.11516-1-chang.seok.bae@intel.com>
References: <20211108233501.11516-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_REQ_XCOMP_PERM is supposed to add the requested feature to the
permission bitmap of thread_group_leader()->fpu. The master permission
field is assumed to be used only instead of each task's fpu->perm field.

But the code updates the current task's bitmap instead of the group
leader's. It also does overwrite the bitmap with the requested feature bit
only rather than adding it.

Fix the code to add the request feature bit to the correct bitmap.

Reported-by: Yang Zhong <yang.zhong@intel.com>
Fixes: db8268df0983 ("x86/arch_prctl: Add controls for dynamic XSTATE components")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d28829403ed0..f02c999049c8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1626,7 +1626,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 		return ret;
 
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-	WRITE_ONCE(fpu->perm.__state_perm, requested);
+	WRITE_ONCE(current->group_leader->thread.fpu.perm.__state_perm, mask);
 	/* Protected by sighand lock */
 	fpu->perm.__state_size = ksize;
 	fpu->perm.__user_state_size = usize;
-- 
2.17.1

