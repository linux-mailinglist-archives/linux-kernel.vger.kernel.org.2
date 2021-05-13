Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBC37FBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhEMQky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:40:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:9615 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235163AbhEMQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:40:25 -0400
IronPort-SDR: St8AHh4rHIXGRkRaZpnMpIj3XSwRokcoBIyyrcSvBDKFjOIPF51vO7jpwr4RcSvt7gchr7x1Jd
 MPLqLC8nXObg==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="199673420"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199673420"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 09:39:10 -0700
IronPort-SDR: barfTuJ5HWwBGr0nO2u8qePWfBIoI849WrfYDCaYcgHdst3i7DbGIcqgJea9zsmgvXjxpGsR3t
 1vEREgnWNZrQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="538412130"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 09:39:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        peterz@infradead.org
Subject: [PATCH] x86/cpu: Fix comment for Sapphire Rapids
Date:   Thu, 13 May 2021 09:39:04 -0700
Message-Id: <20210513163904.3083274-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sapphire Rapids uses Golden Cove, not Willow Cove.

Cc: peterz@infradead.org
Fixes: 53375a5a218e ("x86/cpu: Resort and comment Intel models")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 955b06d6325a..27158436f322 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -102,7 +102,8 @@
 
 #define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
 #define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */
-#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Willow Cove */
+
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
-- 
2.25.4

