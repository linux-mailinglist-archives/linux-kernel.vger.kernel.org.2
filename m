Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE883E8E29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhHKKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:10:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:49822 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236580AbhHKKKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:10:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215084180"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="215084180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506890878"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:10:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] perf tools: Add dlfilter test
Date:   Wed, 11 Aug 2021 13:10:30 +0300
Message-Id: <20210811101036.17986-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is V2 of some minor fixes / improvements to dlfilters and a new perf
test for the dlfilter C API.


Changes in V2:

    perf script: Fix documented const'ness of perf_dlfilter_fns
	New patch

    perf tools: Add dlfilter test
	Do not make perf_dlfilter_fns const in test dlfilter


Adrian Hunter (6):
      perf script: Fix documented const'ness of perf_dlfilter_fns
      perf script: Fix unnecessary machine_resolve()
      perf script: Fix --list-dlfilters documentation
      perf tools: Amend dlfilter documentation wrt library dependencies
      perf tools: Move perf_dlfilters.h in the source tree
      perf tools: Add dlfilter test

 tools/perf/Documentation/perf-dlfilter.txt        |  12 +-
 tools/perf/Documentation/perf-script.txt          |   2 +-
 tools/perf/Makefile.perf                          |  17 +-
 tools/perf/builtin-script.c                       |   2 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c       | 336 ++++++++++++++++++
 tools/perf/{util => include/perf}/perf_dlfilter.h |   0
 tools/perf/tests/Build                            |   1 +
 tools/perf/tests/builtin-test.c                   |   4 +
 tools/perf/tests/dlfilter-test.c                  | 411 ++++++++++++++++++++++
 tools/perf/tests/tests.h                          |   1 +
 tools/perf/util/dlfilter.c                        |   6 +-
 tools/perf/util/dlfilter.h                        |   2 +
 12 files changed, 785 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-test-api-v0.c
 rename tools/perf/{util => include/perf}/perf_dlfilter.h (100%)
 create mode 100644 tools/perf/tests/dlfilter-test.c


Regards
Adrian
