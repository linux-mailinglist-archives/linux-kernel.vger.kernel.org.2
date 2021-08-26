Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29933F8B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbhHZPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:36:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:41889 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243011AbhHZPgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:36:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303345507"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="303345507"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="426824755"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2021 08:36:07 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/7] perf/x86/intel/uncore: Fix Intel SPR M2PCIE event constraints
Date:   Thu, 26 Aug 2021 08:32:42 -0700
Message-Id: <1629991963-102621-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629991963-102621-1-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Similar to the ICX M2PCIE  events, some of the SPR M2PCIE events also
have constraints. Add the constraints for SPR M2PCIE.

Fixes: f85ef898f884 ("perf/x86/intel/uncore: Add Sapphire Rapids server M2PCIe support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a49a5a..0a8f8a6 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5685,9 +5685,16 @@ static struct intel_uncore_type spr_uncore_irp = {
 
 };
 
+static struct event_constraint spr_uncore_m2pcie_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type spr_uncore_m2pcie = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "m2pcie",
+	.constraints		= spr_uncore_m2pcie_constraints,
 };
 
 static struct intel_uncore_type spr_uncore_pcu = {
-- 
2.7.4

