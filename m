Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F883952A6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhE3TY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 15:24:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:21268 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhE3TY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 15:24:27 -0400
IronPort-SDR: E7Rg58Tu5uTHw9lEJjcfY8ZNyblceKSDq9BnfMAbOVrerWb7EabrkRfiPoHiUQoIPZnTUXB9PM
 GrYvld5V1ItA==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190362402"
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="190362402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 12:22:48 -0700
IronPort-SDR: 2WR5oB+WWWDGBWXyi5WUCCGVJYJhl5NpCS/Mk380LYYMQgn3IaUI93VaJG1FpK8rgL5gE5akty
 kdyOlKxNxZ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,234,1616482800"; 
   d="scan'208";a="415926255"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2021 12:22:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] perf scripting python: Add insn, srcline and srccode
Date:   Sun, 30 May 2021 22:22:55 +0300
Message-Id: <20210530192308.7382-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches to add insn, srcline and srccode to python scripting.
In addition, it is made possible for a script to set itrace options.

The first 2 patches are minor tidy-ups.  The next 3 are additions to
scripting_context. The next 5 add new methods that python scripts can call.

Then there is a patch to the perf scripting python documentation.

And finally 2 patches add to the intel-pt-events.py script as an example.


Adrian Hunter (13):
      perf scripting python: Remove unnecessary 'static'
      perf scripting python: Simplify perf-trace-context module functions
      perf scripting: Add scripting_context__update()
      perf scripting: Add perf_session to scripting_context
      perf scripting python: Assign perf_script_context
      perf script: Factor out script_fetch_insn()
      perf scripting python: Add perf_sample_insn()
      perf auxtrace: Factor out itrace_do_parse_synth_opts()
      perf scripting python: Add perf_set_itrace_options()
      perf scripting python: Add perf_sample_srcline() and perf_sample_srccode()
      perf scripting python: Update documentation for srcline etc
      perf scripting python: exported-sql-viewer.py: Factor out libxed.py
      perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace

 tools/perf/Documentation/perf-intel-pt.txt         |   6 +-
 tools/perf/Documentation/perf-script-python.txt    |  46 +++++-
 tools/perf/builtin-script.c                        |  12 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  | 168 +++++++++++++++++---
 tools/perf/scripts/python/exported-sql-viewer.py   |  89 +----------
 tools/perf/scripts/python/intel-pt-events.py       | 176 ++++++++++++++++++---
 tools/perf/scripts/python/libxed.py                | 107 +++++++++++++
 tools/perf/util/auxtrace.c                         |  10 +-
 tools/perf/util/auxtrace.h                         |  10 ++
 .../perf/util/scripting-engines/trace-event-perl.c |  11 +-
 .../util/scripting-engines/trace-event-python.c    |  37 ++++-
 tools/perf/util/trace-event-scripting.c            |  27 +++-
 tools/perf/util/trace-event.h                      |  20 ++-
 13 files changed, 568 insertions(+), 151 deletions(-)
 create mode 100644 tools/perf/scripts/python/libxed.py


Regards
Adrian
