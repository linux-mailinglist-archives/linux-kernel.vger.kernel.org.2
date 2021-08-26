Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC513F8B30
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbhHZPg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:36:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:41889 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243024AbhHZPg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:36:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303345517"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="303345517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="426824761"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2021 08:36:09 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/7] perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints
Date:   Thu, 26 Aug 2021 08:32:43 -0700
Message-Id: <1629991963-102621-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629991963-102621-1-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

SPR M3UPI have the exact same event constraints as ICX, so add the
constraints.

Fixes: 2a8e51eae7c8 ("perf/x86/intel/uncore: Add Sapphire Rapids server M3UPI support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 0a8f8a6..02b926d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5771,6 +5771,7 @@ static struct intel_uncore_type spr_uncore_upi = {
 static struct intel_uncore_type spr_uncore_m3upi = {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			= "m3upi",
+	.constraints		= icx_uncore_m3upi_constraints,
 };
 
 static struct intel_uncore_type spr_uncore_mdf = {
-- 
2.7.4

