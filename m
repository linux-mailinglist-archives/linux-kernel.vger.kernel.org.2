Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7CB3AA3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhFPTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:12:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:10721 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhFPTM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:12:29 -0400
IronPort-SDR: dotJIwHL/lxX+k821Lym1DlN8J9DJFETU1VfWhvU00A6b+W+ZZooo7BJekezf3dPI/f7UesZhx
 9Io1YoArTAZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291874230"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291874230"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:10:23 -0700
IronPort-SDR: nitqTHH+GJewpHhQ6zmGSMBh14N0xIgWaYmgz2H4f9eKDupi74KqIbghuXTtA0kLaNnyZp+BUI
 lE5Rkoilrc9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479208284"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:10:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/4] perf: Fix the ctx->pmu for a hybrid system
Date:   Wed, 16 Jun 2021 11:55:30 -0700
Message-Id: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patchset is to fix the below WARNING triggered on an ADL machine
when a user enables per-task monitoring with all available
perf_hw_context PMUs.

WARNING: CPU: 8 PID: 37107 at arch/x86/events/core.c:1505
x86_pmu_start+0x77/0x90
Call Trace:
x86_pmu_enable+0x111/0x2f0
event_sched_in+0x167/0x230
merge_sched_in+0x1a7/0x3d0
visit_groups_merge.constprop.0.isra.0+0x16f/0x450
? x86_pmu_del+0x42/0x190
ctx_sched_in+0xb8/0x170
perf_event_sched_in+0x61/0x90
__perf_event_task_sched_in+0x20b/0x2a0
finish_task_switch.isra.0+0x16a/0x290
__schedule+0x2fd/0x970
? free_inode_nonrcu+0x18/0x20
schedule+0x4f/0xc0
do_wait+0x176/0x2f0
kernel_wait4+0xaf/0x150

Here is the line of the WARNING.
        if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))

To fix the issue, the generic perf codes have to understand the
supported CPU mask of a specific hybrid PMU. So it can update the
ctx->pmu accordingly, when a task is scheduled on a CPU which has
a different type of PMU from the previous CPU. The supported_cpus
has to be moved to the struct pmu.

Besides, the moving can bring another improvement. All hybrid
architectures including x86 and arm check whether an event is
schedulable on the current CPU via the filter_match callback. Since the
supported_cpus is moved to struct pmu, the check can be done in the
generic code. The filter_match callback may be avoided. The patchset
only implements the improvement for x86. Arm may implement a similar
improvement later separately.

Kan Liang (4):
  perf: Update the ctx->pmu for a hybrid system
  perf/x86: Fix the x86_pmu_start WARNING on a hybrid system
  perf: Check the supported CPU of an event
  perf/x86: Remove filter_match callback

 arch/x86/events/core.c       | 22 ++++------------------
 arch/x86/events/intel/core.c | 19 ++++---------------
 arch/x86/events/perf_event.h |  2 --
 include/linux/perf_event.h   |  7 +++++++
 kernel/events/core.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.7.4

