Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50A334168
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCJPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:24:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:38467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCJPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:23:59 -0500
IronPort-SDR: mN30GvvSgQzJSA3piu5p8bVklGGQyXi3d7x6GOOqqefia3Bnz5C1qvXbPTWrYrhVG5HewSjn7d
 7R7PC53VTaCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175591770"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="175591770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:23:58 -0800
IronPort-SDR: bRtDhYMHwW7QEbjiH14ChdldRcRD9gXCKABb3tIBs/ZeT/tUlV4taXTRkh4SKx2aJwNXe3dYo4
 s6KbyvjZI2ng==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="437963249"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:23:57 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        jmattson@google.com
Subject: [PATCH] perf/x86/kvm: Fix inverted pebs_no_isolation check
Date:   Wed, 10 Mar 2021 07:23:33 -0800
Message-Id: <20210310152333.1291338-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pebs_no_isolation optimization check is inverted. We want to disable
PEBS isolation when the microcode is at least the revision in the table,
not for older microcode. So remove the extra !.

It meant that the new microcodes did unnecessary work, and the old
microcodes could crash the PEBS. Presumably most people already
running with newer microcodes, so that functional impact is small.
But it should speed up the newer systems by the 2-4% claimed in
the original patch.

Cc: jmattson@google.com
Fixes: 9b545c04abd4 ("perf/x86/kvm: Avoid unnecessary work ...")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5bac48d5c18e..d74deadd3a6d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4532,7 +4532,7 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 
 static void intel_check_pebs_isolation(void)
 {
-	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+	x86_pmu.pebs_no_isolation = x86_cpu_has_min_microcode_rev(isolation_ucodes);
 }
 
 static __init void intel_pebs_isolation_quirk(void)
-- 
2.25.4

