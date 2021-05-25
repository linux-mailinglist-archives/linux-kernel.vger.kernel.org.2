Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE138FE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhEYJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:40266 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232545AbhEYJwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:19 -0400
IronPort-SDR: IFYVa6RKukHptUv7ucAloI0EL/mNlsuAslhWuN9jpT44kLYLPz8oobo/eeVBIDrcHHPAgupsj4
 t0aXEepnWUHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181792999"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="181792999"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:50:50 -0700
IronPort-SDR: I5W+29c/vY0d5Pl9JgLLSpJ8pCu7jsYfvdoAfX79U7SjRC0h314NUCD5KViFqjf6fJPIrVZT7i
 3R5NP2eMacng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224473"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:50:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] perf scripting python: Improve general scripting for Intel PT
Date:   Tue, 25 May 2021 12:51:02 +0300
Message-Id: <20210525095112.1399-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

These patches make it easier to customize scripting for Intel PT traces.

The first patch is a dependent fix.

Subsequent patches add more information to python scripting.

The final patch adds a branch trace to the intel-pt-events.py script
which previously supported only power events and ptwrite.


Adrian Hunter (10):
      perf scripting python: Fix tuple_set_u64()
      perf scripting python: Factor out set_sym_in_dict()
      perf scripting python: Add 'addr_location' for 'addr'
      perf script: Factor out perf_sample__sprintf_flags()
      perf scripting python: Add sample flags
      perf scripting python: Add IPC
      perf scripting python: Add cpumode
      perf scripting python: Add context switch
      perf scripting python: Add auxtrace error
      perf scripts python: intel-pt-events.py: Add branches to script

 tools/perf/builtin-script.c                        |  56 +++-
 .../perf/scripts/python/bin/intel-pt-events-record |   4 +-
 .../perf/scripts/python/bin/intel-pt-events-report |   4 +-
 tools/perf/scripts/python/intel-pt-events.py       | 143 +++++++--
 tools/perf/util/db-export.c                        |  12 +-
 tools/perf/util/db-export.h                        |   2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   3 +-
 .../util/scripting-engines/trace-event-python.c    | 321 +++++++++++++++------
 tools/perf/util/trace-event-scripting.c            |   3 +-
 tools/perf/util/trace-event.h                      |   8 +-
 10 files changed, 415 insertions(+), 141 deletions(-)


Regards
Adrian
