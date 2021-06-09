Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC143A1F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFIVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:48:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:4884 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIVsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:19 -0400
IronPort-SDR: D3ApvNEQ4jDAtwkGyxvJiI8GtWYufgnp089TnPaY0+iMlMDh9sJsmpdD2Ws2bIfZDqjrMuwoVm
 sX6TBgxH2sSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266330417"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266330417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:23 -0700
IronPort-SDR: 7c4EWarOYSSF7oQs/dcpgBCA3dPy7MbbxjWsTh6i0oU8w3Ud5xXzOSmX+DsMx4bPD1vDPHAzTS
 ndjhqlUoeojA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448450485"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:22 -0700
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
Subject: [PATCH v1 02/10] x86/io: Allow to override inX() and outX() implementation
Date:   Wed,  9 Jun 2021 14:45:47 -0700
Message-Id: <20210609214555.1955404-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The patch allows to override the implementation of the port IO
helpers. TDX code will provide an implementation that redirect the
helpers to paravirt calls.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/io.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 841a5d104afa..be96bf1e667a 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -271,18 +271,26 @@ static inline bool sev_key_active(void) { return false; }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
+#ifndef __out
+#define __out(bwl, bw)							\
+	asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
+#endif
+
+#ifndef __in
+#define __in(bwl, bw)							\
+	asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
+#endif
+
 #define BUILDIO(bwl, bw, type)						\
 static inline void out##bwl(unsigned type value, int port)		\
 {									\
-	asm volatile("out" #bwl " %" #bw "0, %w1"			\
-		     : : "a"(value), "Nd"(port));			\
+	__out(bwl, bw);							\
 }									\
 									\
 static inline unsigned type in##bwl(int port)				\
 {									\
 	unsigned type value;						\
-	asm volatile("in" #bwl " %w1, %" #bw "0"			\
-		     : "=a"(value) : "Nd"(port));			\
+	__in(bwl, bw);							\
 	return value;							\
 }									\
 									\
-- 
2.25.1

