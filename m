Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3328C366396
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhDUCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:19:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:44095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233950AbhDUCTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:19:14 -0400
IronPort-SDR: dFRlfaSKqsScH3AsAfWOL2AUz5QGp/kAOy8Y0qwVAe1JT++xz1J1kprLLSvZKzqTw53aaO084R
 4BjhVlrgNiaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175733826"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175733826"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 19:18:42 -0700
IronPort-SDR: b6JAxodUtWAtA4sxJpKAE1huCQwBxjwz9Xwa5O7eUNXGHlMZraaNw7i37Qu4vBf0ikARRp4ksy
 VpQuWDmz1Ujw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="384309780"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2021 19:18:39 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH RESEND 1/2] perf/x86: Skip checking MSR for MSR 0x0
Date:   Wed, 21 Apr 2021 10:18:24 +0800
Message-Id: <20210421021825.37872-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
When ARCH_LBR we don't set lbr_tos, the failure from the
check_msr() against MSR 0x000 will make x86_pmu.lbr_nr = 0,
thereby preventing the initialization of the guest LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5272f349dca2..5036496caa60 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4751,10 +4751,10 @@ static bool check_msr(unsigned long msr, u64 mask)
 	u64 val_old, val_new, val_tmp;
 
 	/*
-	 * Disable the check for real HW, so we don't
+	 * Disable the check for real HW or non-sense msr, so we don't
 	 * mess with potentionaly enabled registers:
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) || !msr)
 		return true;
 
 	/*
-- 
2.30.2

