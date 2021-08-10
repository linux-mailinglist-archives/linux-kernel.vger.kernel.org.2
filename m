Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196433E50E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhHJCHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:07:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:25485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235167AbhHJCHF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214804814"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="214804814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 19:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="444807547"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 09 Aug 2021 19:06:41 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        irogers@google.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 0/6] perf events update for CascadeLake server and SkyLake server
Date:   Tue, 10 Aug 2021 10:05:02 +0800
Message-Id: <20210810020508.31261-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Update JSON core/uncore events and metrics for CascadeLake Server.
- Update JSON core/uncore events and metrics for SkyLake Server.

The patch series can be found at (in case broken by mailing system potentially):
https://github.com/yaoj/perf-clx-events.git
branch: perf/core

Jin Yao (6):
  perf vendor events intel: Update core event list for CascadeLake
    Server
  perf vendor events intel: Update uncore event list for CascadeLake
    Server
  perf vendor events: Update metrics for CascadeLake Server
  perf vendor events intel: Update core event list for SkyLake Server
  perf vendor events intel: Update uncore event list for SkyLake Server
  perf vendor events: Update metrics for SkyLake Server

 .../arch/x86/cascadelakex/cache.json          | 5468 ++++++++---------
 .../arch/x86/cascadelakex/clx-metrics.json    |  253 +-
 .../arch/x86/cascadelakex/floating-point.json |   48 +-
 .../arch/x86/cascadelakex/frontend.json       |  550 +-
 .../arch/x86/cascadelakex/memory.json         | 5444 ++++++++--------
 .../arch/x86/cascadelakex/other.json          | 4146 ++++++-------
 .../arch/x86/cascadelakex/pipeline.json       | 1046 ++--
 .../arch/x86/cascadelakex/uncore-memory.json  |   21 +-
 .../arch/x86/cascadelakex/uncore-other.json   |  161 +-
 .../arch/x86/cascadelakex/virtual-memory.json |  256 +-
 .../pmu-events/arch/x86/skylakex/cache.json   | 1724 +++---
 .../arch/x86/skylakex/floating-point.json     |   56 +-
 .../arch/x86/skylakex/frontend.json           |  580 +-
 .../pmu-events/arch/x86/skylakex/memory.json  | 1300 ++--
 .../pmu-events/arch/x86/skylakex/other.json   |  104 +-
 .../arch/x86/skylakex/pipeline.json           | 1068 ++--
 .../arch/x86/skylakex/skx-metrics.json        |  247 +-
 .../arch/x86/skylakex/uncore-memory.json      |    9 -
 .../arch/x86/skylakex/uncore-other.json       |  171 +-
 .../arch/x86/skylakex/virtual-memory.json     |  288 +-
 20 files changed, 11531 insertions(+), 11409 deletions(-)

-- 
2.17.1

