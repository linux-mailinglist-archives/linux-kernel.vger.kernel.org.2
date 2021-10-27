Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609F943C495
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhJ0IGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:06:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:24462 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhJ0IGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:06:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="229960765"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="229960765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 01:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465644293"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 01:03:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/6] perf dlfilter: Add dlfilter-show-cycles
Date:   Wed, 27 Oct 2021 11:03:28 +0300
Message-Id: <20211027080334.365596-1-adrian.hunter@intel.com>
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


Changes in V3:

    perf intel-pt: Support itrace A option to approximate IPC
      Expanded explanation of the loss of accuracy of IPC with 'A' option.

    Added Reviewed-by: Andi Kleen <ak@linux.intel.com>


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
 tools/perf/Documentation/perf-intel-pt.txt         |  28 ++++
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/dlfilters/dlfilter-show-cycles.c        | 144 +++++++++++++++++++++
 tools/perf/util/auxtrace.c                         |   3 +
 tools/perf/util/auxtrace.h                         |   6 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   1 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt-decoder/intel-pt-log.c    |   8 +-
 tools/perf/util/intel-pt.c                         |  21 ++-
 10 files changed, 205 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c


Regards
Adrian
