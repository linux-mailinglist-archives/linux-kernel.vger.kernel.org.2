Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19033B4F21
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFZPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 11:14:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:22924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhFZPOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 11:14:17 -0400
IronPort-SDR: /DyrA5M2d5FRmGsH2vFtj1Xbi1OdRGpIW57gPyaNFB+/578hIxokN4N48lwrx9CU86dm63nVZo
 OLPB4exilapw==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207613933"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207613933"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 08:11:54 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="642895555"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 08:11:53 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
Date:   Sat, 26 Jun 2021 08:11:43 -0700
Message-Id: <fd62548ceb8cefb961b98fdf6c2d4a587ad7621d.1624719668.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624719668.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624719668.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SetupEventNotifyInterrupt TDX hypercall is used by guest TD to specify
which interrupt vector to use as an event-notify vector to the VMM.
Such registered vector is also used by Host VMM to notify about
completion of GetQuote requests to the Guest TD.

Add tdx_hcall_set_notify_intr() helper function to implement the
SetupEventNotifyInterrupt hypercall.

This will be used by the TD quote driver.

Details about the SetupEventNotifyInterrupt TDVMCALL can be found in
TDX Guest-Host Communication Interface (GHCI) Specification, sec 3.5
"TDG.VP.VMCALL<SetupEventNotifyInterrupt>".

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index eb3a90051604..fcb0ed70ea19 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -29,6 +29,7 @@
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* TDX Module call error codes */
 #define TDX_PAGE_ALREADY_ACCEPTED       0x8000000000000001
@@ -202,6 +203,30 @@ int tdx_hcall_get_quote(u64 data)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/*
+ * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
+ *
+ * @vector        : Vector address to be used for notification.
+ *
+ * return 0 on success or failure error number.
+ */
+int tdx_hcall_set_notify_intr(u8 vector)
+{
+	u64 ret;
+
+	/* Minimum vector value allowed is 32 */
+	if (vector < 32)
+		return -EINVAL;
+
+	ret = _trace_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0,
+				   NULL);
+
+	if (ret == TDCALL_INVALID_OPERAND)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
-- 
2.25.1

