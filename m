Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7531E938
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBRLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:42:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:58030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhBRJ6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:58:50 -0500
IronPort-SDR: +tAioSkEUKbW2pwEELF8GOBf8gy7ALL+j7OzgV26sewcbazxYoylrXwbTWoS5oW2eP6QVzwQTu
 co9fnlsvX2sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127889"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:05 -0800
IronPort-SDR: epXotc7MyHum9s4DzIsJ+IhiuQ0vq2J4jRJbxQyd8SEoKHEn7V6iig0UfsY4pAibsSErpT4cEV
 3F6I6etjX5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427585"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:03 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] perf intel-pt: Add limited support for tracing guest kernels
Date:   Thu, 18 Feb 2021 11:57:50 +0200
Message-Id: <20210218095801.19576-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Currently, only kernel tracing is supported and only with "timeless" decoding
i.e. no TSC timestamps

Other limitations and caveats

 VMX controls may suppress packets needed for decoding resulting in decoding errors
 VMX controls may block the perf NMI to the host potentially resulting in lost trace data
 Guest kernel self-modifying code (e.g. jump labels or JIT-compiled eBPF) will result in decoding errors
 Guest thread information is unknown
 Guest VCPU is unknown but may be able to be inferred from the host thread
 Callchains are not supported

There is an example in the documentation of patch
"perf intel-pt: Add documentation for tracing virtual machines"

The patches are on top of the "Add PSB events" series.


Adrian Hunter (11):
      perf script: Add branch types for VM-Entry and VM-Exit
      perf intel_pt: Add vmlaunch and vmresume as branches
      perf intel-pt: Retain the last PIP packet payload as is
      perf intel-pt: Amend decoder to track the NR flag
      perf machine: Factor out machines__find_guest()
      perf machine: Factor out machine__idle_thread()
      perf intel-pt: Support decoding of guest kernel
      perf intel-pt: Allow for a guest kernel address filter
      perf intel-pt: Adjust sample flags for VM-Exit
      perf intel-pt: Split VM-Entry and VM-Exit branches
      perf intel-pt: Add documentation for tracing virtual machines

 tools/perf/Documentation/perf-intel-pt.txt         |  82 ++++++++++++++
 tools/perf/arch/x86/tests/insn-x86.c               |   1 +
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |   4 +-
 tools/perf/builtin-script.c                        |   2 +
 tools/perf/util/db-export.c                        |   2 +
 tools/perf/util/event.h                            |   6 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  61 +++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   3 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  15 +++
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |   1 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  12 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   2 +
 tools/perf/util/intel-pt.c                         | 122 ++++++++++++++++++---
 tools/perf/util/machine.c                          |  27 +++++
 tools/perf/util/machine.h                          |   2 +
 tools/perf/util/session.c                          |  32 +-----
 16 files changed, 307 insertions(+), 67 deletions(-)


Regards
Adrian
