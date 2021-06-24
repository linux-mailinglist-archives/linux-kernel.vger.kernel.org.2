Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8833C3B2490
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFXBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 21:39:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:8634 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhFXBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 21:39:07 -0400
IronPort-SDR: +O8z5k22JaVWk+uZ+OgHCr+VS5beFqd9L4VD1oyusiLSTamDONu4q9BKXmvha3eIYgYSd4i2sE
 j4wtvyjeAosQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="187756952"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="187756952"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 18:36:47 -0700
IronPort-SDR: HWd69Qvw2ujSQGcsdmMSGvD2kkMvR0IY6tROFyPN2lAL75d6N3mkQ7GpWT7piB8JiSCN4UTOuJ
 7Qm0TgxsgnOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="490928444"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 18:36:46 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/7] perf: Add Sapphire Rapids server uncore support
Date:   Wed, 23 Jun 2021 18:22:02 -0700
Message-Id: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
named by the real PMU name, e.g., uncore_cha_0. To make the name
backward-compatible, a symlink is created from the new to the old name.
So the user scripts which use the old name still work.

The uncore spec of Sapphire Rapids server can be found at
https://cdrdv2.intel.com/v1/dl/getContent/642245

Kan Liang (7):
  driver core: Add a way to get to bus devices kset
  perf: Create a symlink for a PMU
  perf/x86/intel/uncore: Create a symlink for an uncore PMU
  perf/x86/intel/uncore: Add Sapphire Rapids server support
  perf/x86/intel/uncore: Factor out snr_uncore_mmio_map()
  perf/x86/intel/uncore: Support free-running counters on Sapphire
    Rapids server
  perf/x86/intel/uncore: Fix invalid unit check

 arch/x86/events/intel/uncore.c           |  44 ++-
 arch/x86/events/intel/uncore.h           |   5 +
 arch/x86/events/intel/uncore_discovery.c |  42 +--
 arch/x86/events/intel/uncore_discovery.h |  23 +-
 arch/x86/events/intel/uncore_snbep.c     | 508 ++++++++++++++++++++++++++++++-
 drivers/base/bus.c                       |   6 +
 include/linux/device/bus.h               |   1 +
 include/linux/perf_event.h               |   1 +
 kernel/events/core.c                     |  19 ++
 9 files changed, 607 insertions(+), 42 deletions(-)

-- 
2.7.4

