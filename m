Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51EA389E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhETHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:03:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:53040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETHDZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:03:25 -0400
IronPort-SDR: yBkLQXHCwlJ5+LqwejsdVLn+WnjmJQl3ZQq7oa/GhMZfrKaVh4gYTsA8oXOlWT9uy0SL6P6Qss
 30LuDsz+aEOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286691034"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286691034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:02:04 -0700
IronPort-SDR: DzMksfDfSeni6nZW1ZhQS8DNlDGGMDgqFa60CV8++BQqCy+UXKvzjCl19MBCTCpu8DkDE514xO
 Po0IcuhVYhng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543206754"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2021 00:02:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/5] perf: Support perf-mem/perf-c2c for AlderLake
Date:   Thu, 20 May 2021 15:00:35 +0800
Message-Id: <20210520070040.710-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AlderLake uses a hybrid architecture utilizing Golden Cove cores
(core CPU) and Gracemont cores (atom CPU). This patchset supports
perf-mem and perf-c2c for AlderLake. 

Jin Yao (5):
  perf util: Check mem-loads auxiliary event
  perf tools: Support pmu name in perf_mem_events__name
  perf tools: Check if mem_events is supported for hybrid
  perf mem: Support record for hybrid platform
  perf c2c: Support record for hybrid platform

 tools/perf/arch/arm64/util/mem-events.c   |   2 +-
 tools/perf/arch/powerpc/util/mem-events.c |   2 +-
 tools/perf/arch/x86/util/mem-events.c     |  37 ++++---
 tools/perf/builtin-c2c.c                  |  36 +++----
 tools/perf/builtin-mem.c                  |  39 ++++----
 tools/perf/util/mem-events.c              | 112 ++++++++++++++++++++--
 tools/perf/util/mem-events.h              |   4 +-
 7 files changed, 172 insertions(+), 60 deletions(-)

-- 
2.17.1

