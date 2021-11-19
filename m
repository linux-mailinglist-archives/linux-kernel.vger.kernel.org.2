Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BB457509
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhKSRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:12:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:46708 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhKSRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:12:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="233170499"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="233170499"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 09:08:40 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="455848418"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 09:08:39 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Rui Zhang <rui.zhang@intel.com>
Subject: [PATCH] x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define
Date:   Fri, 19 Nov 2021 09:08:32 -0800
Message-Id: <20211119170832.1034220-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convention for all the other "lake" CPUs is all one word.

So s/RAPTOR_LAKE/RAPTORLAKE/

Reported-by: Rui Zhang <rui.zhang@intel.com>
Fixes: fbdb5e8f2926 ("x86/cpu: Add Raptor Lake to Intel family")
Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Dave Hansen had thanked me for sending a simple patch on his first full
day as x86 maintainer. I had foolishly said: "You can hand me a giant
brown paper bag if I broke the build with that patch." Well, I didn't
break the build. But the one-line change had an error in every line. My
usual collection of brown bags is at the office. So I'll have to make
a new one. Then explain to my family the tradition of brown paper bags.

Big thanks to Rui for catching this before I'd have the extra shame
of needing to backport to stable.
---
 arch/x86/include/asm/intel-family.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5a0bcf8b78d7..048b6d5aff50 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -108,7 +108,7 @@
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
-#define INTEL_FAM6_RAPTOR_LAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE		0xB7
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.31.1

