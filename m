Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA13F8B27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbhHZPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:36:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:41889 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhHZPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:36:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303345461"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="303345461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 08:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="426824654"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2021 08:35:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/7] perf/x86/intel/uncore: Various fix for ICX and SPR
Date:   Thu, 26 Aug 2021 08:32:36 -0700
Message-Id: <1629991963-102621-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The fixes in the series are to fix different issues of perf uncore.
They can be merged separately. I just want to make them more visible
on maintainers' radar. So I put them together.

Patch 1 is to add extra IMC channel for ICX.
Patch 2 is to fix the missing type 0 unit 0 uncore unit.
Patch 3-7 are to update the static event constraints table for IIO, CHA,
M2PCIE, M3UPI on ICX and SPR.

Kan Liang (7):
  perf/x86/intel/uncore: Support extra IMC channel on Ice Lake server
  perf/x86/intel/uncore: Fix invalid unit check
  perf/x86/intel/uncore: Fix Intel ICX IIO event constraints
  perf/x86/intel/uncore: Fix Intel SPR CHA event constraints
  perf/x86/intel/uncore: Fix Intel SPR IIO event constraints
  perf/x86/intel/uncore: Fix Intel SPR M2PCIE event constraints
  perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints

 arch/x86/events/intel/uncore_discovery.h |  2 +-
 arch/x86/events/intel/uncore_snbep.c     | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.7.4

