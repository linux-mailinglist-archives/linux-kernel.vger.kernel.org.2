Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3852343942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCVGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:14:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:15223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCVGON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:14:13 -0400
IronPort-SDR: SkkmbfP1yHW+AFjglXZM+fvjOZFj0nw6qpceYzo9xaE0xQxJAhoZ7YTVJ8NjDA/eKjHUCx+OGy
 zpsd4Dzz+g2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="186889246"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="186889246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 23:14:13 -0700
IronPort-SDR: ZxxNthmSMV11c1LDwRs46tGtYC6PuxYcTebC8S9qDM5RBi0ponAQo/fIhIHAqZJwi/Nuww+oFC
 EULSejX1B06g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441026231"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2021 23:14:09 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v4 RESEND 0/5] x86: The perf/x86 changes to support guest Arch LBR
Date:   Mon, 22 Mar 2021 14:06:30 +0800
Message-Id: <20210322060635.821531-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Please help review these minor perf/x86 changes in this patch set,
and we need some of them to support Guest Architectural LBR in KVM.

If you are interested in the KVM emulation, please check
https://lore.kernel.org/kvm/20210314155225.206661-1-like.xu@linux.intel.com/

Please check more details in each commit and feel free to comment.

Like Xu (5):
  perf/x86/intel: Fix the comment about guest LBR support on KVM
  perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers
  perf/x86/lbr: Move cpuc->lbr_xsave allocation out of sleeping region
  perf/x86/lbr: Skip checking for the existence of LBR_TOS for Arch LBR
  perf/x86: Move ARCH_LBR_CTL_MASK definition to include/asm/msr-index.h

 arch/x86/events/core.c           |  8 +++++---
 arch/x86/events/intel/bts.c      |  2 +-
 arch/x86/events/intel/core.c     |  6 +++---
 arch/x86/events/intel/lbr.c      | 28 +++++++++++++++++-----------
 arch/x86/events/perf_event.h     |  8 +++++++-
 arch/x86/include/asm/msr-index.h |  1 +
 6 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.29.2

