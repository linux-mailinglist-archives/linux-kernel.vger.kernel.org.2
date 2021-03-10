Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C958533436E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhCJQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhCJQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:16 -0500
IronPort-SDR: bCZOWeBveSkpt33wZNSETiq3J5RJPJ5KoOuSGbqGIBcW/9N+I51YrSrB0NgLy7V3oW7gU/Pqw1
 WjvMu6QS8+OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546549"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:16 -0800
IronPort-SDR: clxXMd45tcZpdR38SJOrO05l0EjS2KeS0a3c+b/0enTTKGcyhJP7F+5RrAjyUoBmO2HQ7QqCSU
 DYKU0duGntMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729389"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:15 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 25/25] perf/x86/rapl: Add support for Intel Alder Lake
Date:   Wed, 10 Mar 2021 08:38:01 -0800
Message-Id: <1615394281-68214-26-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Alder Lake RAPL support is the same as previous Sky Lake.
Add Alder Lake model for RAPL.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f42a704..84a1042 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -800,6 +800,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
-- 
2.7.4

