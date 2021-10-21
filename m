Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DA436DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhJUXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:58072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232282AbhJUXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380060"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380060"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033380"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 13/23] x86/msr-index: Add MSRs for XFD
Date:   Thu, 21 Oct 2021 15:55:17 -0700
Message-Id: <20211021225527.10184-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFD introduces two MSRs:

    - IA32_XFD to enable/disable a feature controlled by XFD

    - IA32_XFD_ERR to expose the #NM trap handler which feature
      was tried to be used for the first time.

Both use the same xstate-component bitmap format, used by XCR0.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c413432b33..01e2650b9585 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -625,6 +625,8 @@
 
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 #define MSR_IA32_XSS			0x00000da0
 
 #define MSR_IA32_APICBASE		0x0000001b
-- 
2.17.1

