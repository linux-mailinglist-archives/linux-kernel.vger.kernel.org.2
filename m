Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776035C8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbhDLOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:29202 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242520AbhDLOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:39:09 -0400
IronPort-SDR: 30QvuMokkmX/YRSBBKI+mU90SNTaoYU5LzNXm211WXIGBV+DFzRhRFFA0XkhQDHeDxWKl9VQPf
 vCvSUcSQK5pw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194318035"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194318035"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:39 -0700
IronPort-SDR: Ni1l97AUkOVayfL1Akf57AVEbDpo7n6pdXdcKbM5vY6cFMqGY7ovcAZYA5ZhG85+VVs+24o3bG
 r4FcexGDZr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392905"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V6 25/25] perf/x86/rapl: Add support for Intel Alder Lake
Date:   Mon, 12 Apr 2021 07:31:05 -0700
Message-Id: <1618237865-33448-26-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
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

