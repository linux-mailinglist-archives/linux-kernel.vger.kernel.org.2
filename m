Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B73B69AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhF1Uet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:34:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:6224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233832AbhF1Uer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:34:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="188408761"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="188408761"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 13:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="557695593"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2021 13:32:21 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/6] perf: Add Sapphire Rapids server uncore support
Date:   Mon, 28 Jun 2021 13:17:37 -0700
Message-Id: <1624911463-192936-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Drop the symlink between two PMU names. Add a new attribute "alias"
  to indicate the old numeric name.
- Add document and perf tool support for the new attribute "alias".
(I once planned to use "caps/pmu_name" as the new attribute name in V1's
discussion.
https://lore.kernel.org/lkml/1edc6666-c4b3-ebf5-964a-e5ffc97d8563@linux.intel.com/
The name has a different meaning in the CPU PMU, which may causes
confusion. So the "alias" is used in V2.)
- The number of the free-running counter units should be the same as
  the max index of the relative units plus one. Correct the number in
  the patch 4.

Intel Sapphire Rapids supports a discovery mechanism, that allows an
uncore driver to discover the different components ("boxes") of the
chip.

All the generic information of the uncore boxes should be retrieved from
the discovery tables. This has been enabled with the commit edae1f06c2cd
("perf/x86/intel/uncore: Parse uncore discovery tables"). The uncore
driver doesn't need to hard code the generic information for each uncore
box. But we still need to enable various functionality that cannot be
directly discovered. This is done in the patchset.

Without this platform-specific enabling patch set, perf uses a type ID
plus a box ID, e.g., uncore_type_0_0 to name an uncore PMU. With the
patch set, perf has the mapping information from a type ID to a specific
uncore unit. Just like the previous platforms, the uncore PMU can be
named by the real PMU name, e.g., uncore_cha_0. Add a new attribute
"alias" to indicate the old numeric name. The userspace perf tool is
modified in the patch-set to handle both names.

The uncore spec of Sapphire Rapids server can be found at
https://cdrdv2.intel.com/v1/dl/getContent/642245

Kan Liang (6):
  perf/x86/intel/uncore: Add Sapphire Rapids server support
  perf/x86/intel/uncore: Add alias PMU name
  perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
  perf/x86/intel/uncore: Support free-running counters on Sapphire
    Rapids server
  perf/x86/intel/uncore: Fix invalid unit check
  perf pmu: Add PMU alias support

 .../testing/sysfs-bus-event_source-devices-uncore  |  11 +
 arch/x86/events/intel/uncore.c                     |  45 +-
 arch/x86/events/intel/uncore.h                     |   4 +
 arch/x86/events/intel/uncore_discovery.c           |  42 +-
 arch/x86/events/intel/uncore_discovery.h           |  23 +-
 arch/x86/events/intel/uncore_snbep.c               | 538 ++++++++++++++++++++-
 tools/perf/arch/x86/util/pmu.c                     | 129 ++++-
 tools/perf/util/parse-events.y                     |   4 +-
 tools/perf/util/pmu.c                              |  23 +-
 tools/perf/util/pmu.h                              |   5 +
 10 files changed, 776 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore

-- 
2.7.4

