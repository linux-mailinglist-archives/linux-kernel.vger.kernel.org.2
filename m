Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05AF43AE77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhJZJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:04:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:37214 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhJZJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:04:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210639796"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="210639796"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 02:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="723991204"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2021 02:01:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] perf dlfilter: Add dlfilter-show-cycles
Date:   Tue, 26 Oct 2021 12:01:46 +0300
Message-Id: <20211026090152.357591-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The issue with V1 was that the IPC information used to accumulate cycle
counts has a lower granularity because it is output only when the cycle
count correlates to the IP of the event i.e. only when the IPC is exactly
correct.

To enable more frequent updates to the cycle count, itrace option 'A' is
added, which specifies that IPC information can be approximate.

In addition there are some new miscellaneous patches.


Changes in V2:

    perf dlfilter: Add dlfilter-show-cycles
      Separate counts for branches, instructions or other events.

    New patches:
      perf auxtrace: Add missing Z option to ITRACE_HELP
      perf auxtrace: Add itrace A option to approximate IPC
      perf intel-pt: Support itrace A option to approximate IPC
      perf auxtrace: Add itrace d+o option to direct debug log to stdout
      perf intel-pt: Support itrace d+o option to direct debug log to stdout


Adrian Hunter (6):
      perf auxtrace: Add missing Z option to ITRACE_HELP
      perf auxtrace: Add itrace A option to approximate IPC
      perf intel-pt: Support itrace A option to approximate IPC
      perf dlfilter: Add dlfilter-show-cycles
      perf auxtrace: Add itrace d+o option to direct debug log to stdout
      perf intel-pt: Support itrace d+o option to direct debug log to stdout

 tools/perf/Documentation/itrace.txt                |   2 +
 tools/perf/Documentation/perf-intel-pt.txt         |  23 ++++
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/dlfilters/dlfilter-show-cycles.c        | 144 +++++++++++++++++++++
 tools/perf/util/auxtrace.c                         |   3 +
 tools/perf/util/auxtrace.h                         |   6 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   1 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   8 +-
 tools/perf/util/intel-pt.c                         |  21 ++-
 10 files changed, 200 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c


Regards
Adrian
