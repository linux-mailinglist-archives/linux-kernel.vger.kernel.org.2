Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1491944EC99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhKLSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:31:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:48480 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhKLSbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:31:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="233126795"
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="233126795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 10:28:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="493113785"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 10:28:47 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add Raptor Lake to Intel family
Date:   Fri, 12 Nov 2021 10:28:35 -0800
Message-Id: <20211112182835.924977-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add model ID for Raptor Lake.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 27158436f322..5a0bcf8b78d7 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -108,6 +108,8 @@
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
+#define INTEL_FAM6_RAPTOR_LAKE		0xB7
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.31.1

