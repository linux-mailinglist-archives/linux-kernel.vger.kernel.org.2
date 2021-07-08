Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF13BF39E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhGHBlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:41:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:38898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGHBlJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:41:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270538739"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270538739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 18:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="457708819"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2021 18:38:20 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 0/4] perf tool: Skip invalid hybrid PMU
Date:   Thu,  8 Jul 2021 09:36:57 +0800
Message-Id: <20210708013701.20347-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid platform, such as Alderlake, if atom CPUs are offlined,
the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
which indicates this is an invalid pmu. So we need to check and skip
the invalid hybrid pmu.

Also we need to update some perf test cases for core-only system.

Jin Yao (4):
  perf pmu: Skip invalid hybrid pmu
  perf tests: Fix 'Parse event definition strings' on core-only system
  perf tests: Fix 'Roundtrip evsel->name' on core-only system
  perf tests: Fix 'Convert perf time to TSC' on core-only system

 tools/perf/tests/evsel-roundtrip-name.c |  3 ++-
 tools/perf/tests/parse-events.c         | 16 ++++++++++------
 tools/perf/tests/perf-time-to-tsc.c     |  3 ++-
 tools/perf/util/pmu.c                   |  9 ++++++++-
 4 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.17.1

