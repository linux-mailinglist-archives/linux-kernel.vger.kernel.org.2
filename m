Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4730423422
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhJEXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:08:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:14170 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237007AbhJEXIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:08:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="205998550"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="205998550"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:06:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="438908098"
Received: from alyee-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.5.222])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:06:18 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] x86/split_lock: Fix the split lock #AC handling when running as guest
Date:   Tue,  5 Oct 2021 16:05:50 -0700
Message-Id: <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

If running as guest and hypervisor enables
MSR_TEST_CTRL.SPLIT_LOCK_DETECT during its running, it can get split
lock #AC even though sld_state is sld_off.

For kernel mode #AC, it always dies("split lock"), no more action
needed.

For user mode #AC, it should treat sld_off (default state when feature
is not available) as fatal as well.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 01d7935feaed..47f0bc95ce2a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1190,7 +1190,12 @@ static void bus_lock_init(void)
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+	/*
+	 * In virtualization environment, it can get split lock #AC even when
+	 * sld_off but hypervisor enables it.
+	 * Thus only handles when sld_warn explicitly.
+	 */
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state != sld_warn)
 		return false;
 	split_lock_warn(regs->ip);
 	return true;
-- 
2.25.1

