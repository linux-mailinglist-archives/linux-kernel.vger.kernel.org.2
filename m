Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDA44804F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbhKHNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:35:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:65375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234552AbhKHNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:35:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="230938616"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="230938616"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 05:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="581471753"
Received: from icx.bj.intel.com ([10.240.192.117])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2021 05:32:22 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@intel.com,
        chang.seok.bae@intel.com, yang.zhong@intel.com, jing2.liu@intel.com
Subject: [PATCH] x86/fpu: Set the corret permission value for perm.__state_perm
Date:   Mon,  8 Nov 2021 17:28:15 -0500
Message-Id: <20211108222815.4078-1-yang.zhong@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perm.__state_perm is default xsave set features, when we request
AMX permission from application, the requested value(bit18) should be
replaced with mask value(requested | permitted), which can keep default
features there.

Without this change, the below prctl syscall:
(1). ARCH_GET_XCOMP_PERM, the bitmask=0x202e7
(2). set ARCH_REQ_XCOMP_PERM with XFEATURE_XTILEDATA
(3). ARCH_GET_XCOMP_PERM, the bitmask=0x40000, the correct value
     should be 0x602e7 here.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
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
2.30.2

