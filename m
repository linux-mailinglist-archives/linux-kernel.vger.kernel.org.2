Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054CB349EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZB1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:27:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:51734 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhCZB1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:27:09 -0400
IronPort-SDR: fP3JCmSNiphD/t782ONQORG+bi0Ae+J1tWHrf09F+mNkltug58qm1fwEELbmOUWydmr3XgmQFA
 KDewcFW+zBaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="170421809"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="170421809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 18:27:09 -0700
IronPort-SDR: Jb70ug3TjJNnxK4Jw0QSrsr/dzP+zU9hJqi7StTpDe1YQNIQQ2xEgqeW+S2z1NvZNx4qnb7VvE
 MWwkedoX5/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="443088954"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2021 18:27:06 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     pbonzini@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, wei.w.wang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v5 0/5] perf/x86: Some minor changes to support guest Arch LBR
Date:   Fri, 26 Mar 2021 09:19:13 +0800
Message-Id: <20210326011918.183685-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Please help review these minor perf/x86 changes in this patch set,
and we need some of them to support Guest Architectural LBR in KVM.

This version keeps reserve_lbr_buffers() as is because the LBR xsave
buffer is a per-CPU buffer, not a per-event buffer. We only need to
allocate the buffer once when initializing the first event. 

If you are interested in the KVM emulation, please check
https://lore.kernel.org/kvm/20210314155225.206661-1-like.xu@linux.intel.com/

Please check more details in each commit and feel free to comment.

Previous:
https://lore.kernel.org/lkml/20210322060635.821531-1-like.xu@linux.intel.com/

v4->v5 Changelog:
- Add "Tested-by: Kan Liang"
- Make the commit message simpler
- Make check_msr() to ignore msr==0 
- Use kmem_cache_alloc_node() [Namhyung]

Like Xu (5):
  perf/x86/intel: Fix the comment about guest LBR support on KVM
  perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers
  perf/x86: Skip checking MSR for MSR 0x000
  perf/x86/lbr: Move cpuc->lbr_xsave allocation out of sleeping region
  perf/x86: Move ARCH_LBR_CTL_MASK definition to include/asm/msr-index.h

 arch/x86/events/core.c           |  8 +++++---
 arch/x86/events/intel/bts.c      |  2 +-
 arch/x86/events/intel/core.c     |  7 +++----
 arch/x86/events/intel/lbr.c      | 29 ++++++++++++++++++-----------
 arch/x86/events/perf_event.h     |  8 +++++++-
 arch/x86/include/asm/msr-index.h |  1 +
 6 files changed, 35 insertions(+), 20 deletions(-)

-- 
2.29.2

