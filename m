Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65136F612
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhD3HDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:03:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:9042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhD3HDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:35 -0400
IronPort-SDR: ue9qnbJL2KwfpZtBjGY6l/oHnWzv5u2qjzHw/aDgCxdzNYCu2PFCh2xlia4Ee6DLT7O2SsW5lT
 hx/f43avkNCA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="184689673"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="184689673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:02:47 -0700
IronPort-SDR: X2XKT3jQHMoD7v+G+pSDWd6Xo+ttfMpu5tuu4A7ztJDUufzvom1+9RMiJnzdmyRz4hWcA86fZR
 kVEshNPeC8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492217"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:02:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/12] perf intel-pt: Add more support for VMs
Date:   Fri, 30 Apr 2021 10:02:57 +0300
Message-Id: <20210430070309.17624-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is V2, see changes list below.

Previously, limited support was added for timeless decoding of VM traces.

Primarily, these patches add support for decoding traces of virtual
machines using timestamps, assuming the VMX TSC Offset is unchanging
during perf record, and VMX TSC Scaling is not used.

The first 3 patches add an itrace option to allow timeless decoding
even if timestamps have been recorded.

The next 2 patches add an option to perf inject to do "VM Time Correlation"
i.e. sort out the timestamps.

There are 5 preparation patches, then the main changes in patch
"perf intel-pt: Add VM Time Correlation to decoder".

The final patch adds documentation which provides an example.


Changes in V2:

    perf inject: Add facility to do in place update
	Error out instead of prompt to continue

    perf inject: Add --vm-time-correlation option
	Tighten up parsing of "dry-run"

    perf intel-pt: Add a tree for VMCS information
	Rename lookup_vmcs to findnew_vmcs

    perf intel-pt: Add VM Time Correlation to decoder
	Rename lookup_vmcs to findnew_vmcs

    perf intel-pt: Parse VM Time Correlation options and set up decoding
	Rename lookup_vmcs to findnew_vmcs
	Explain "dry-run" option
	Adjust example for 'perf inject' changes


Adrian Hunter (12):
      perf auxtrace: Add Z itrace option for timeless decoding
      perf intel-pt: Move synth_opts initialization earlier
      perf intel-pt: Support Z itrace option for timeless decoding
      perf inject: Add facility to do in place update
      perf inject: Add --vm-time-correlation option
      perf auxtrace: Allow buffers to be mapped read / write
      perf intel-pt: Let overlap detection handle VM timestamps
      perf intel-pt: Add a tree for VMCS information
      perf intel-pt: Pass the first timestamp to the decoder
      perf intel-pt: Better 7-byte timestamp wraparound logic
      perf intel-pt: Add VM Time Correlation to decoder
      perf intel-pt: Parse VM Time Correlation options and set up decoding

 tools/perf/Documentation/itrace.txt                |   1 +
 tools/perf/Documentation/perf-inject.txt           |  10 +
 tools/perf/Documentation/perf-intel-pt.txt         | 114 +++-
 tools/perf/builtin-inject.c                        |  73 ++-
 tools/perf/util/auxtrace.c                         |   8 +-
 tools/perf/util/auxtrace.h                         |  14 +-
 tools/perf/util/data.c                             |   3 +-
 tools/perf/util/data.h                             |   1 +
 tools/perf/util/header.c                           |   5 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 723 ++++++++++++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  20 +-
 tools/perf/util/intel-pt-decoder/intel-pt-log.h    |   5 +
 tools/perf/util/intel-pt.c                         | 224 ++++++-
 tools/perf/util/session.c                          |   6 +-
 14 files changed, 1169 insertions(+), 38 deletions(-)


Regards
Adrian
