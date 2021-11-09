Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9860D44A406
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbhKIBi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:38:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:9905 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243315AbhKIBi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:38:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="318555845"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="318555845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 17:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641693043"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2021 17:28:21 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, yang.zhong@intel.com,
        jing2.liu@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v2 1/2] x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation
Date:   Mon,  8 Nov 2021 17:21:21 -0800
Message-Id: <20211109012122.1142-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109012122.1142-1-chang.seok.bae@intel.com>
References: <20211109012122.1142-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_REQ_XCOMP_PERM is supposed to add the requested feature to the
permission bitmap of thread_group_leader()->fpu. But the code overwrites
the bitmap with the requested feature bit only rather than adding it.

Fix the code to add the request feature bit to the master bitmask.

Reported-by: Yang Zhong <yang.zhong@intel.com>
Fixes: db8268df0983 ("x86/arch_prctl: Add controls for dynamic XSTATE components")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Change the mask value only and trim the changelog.
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d28829403ed0..fc1ab0116f4e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1626,7 +1626,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 		return ret;
 
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-	WRITE_ONCE(fpu->perm.__state_perm, requested);
+	WRITE_ONCE(fpu->perm.__state_perm, mask);
 	/* Protected by sighand lock */
 	fpu->perm.__state_size = ksize;
 	fpu->perm.__user_state_size = usize;
-- 
2.17.1

