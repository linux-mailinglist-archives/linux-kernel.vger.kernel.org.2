Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B93358885
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhDHPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:32:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:26940 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhDHPcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:32:11 -0400
IronPort-SDR: BaqIoR/ze4NDkO0oqu+u2W9Vyu13VVixZib9AQvVOePT+/SGSYQrNnMkp09HviLAEmDJ+3f5Vw
 Lztp9vltQrjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="254903905"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="254903905"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:31:59 -0700
IronPort-SDR: AKACWkVzhno9+X+z5BSx5bfkogmHCe1ci4l6zIpm2DNQP2YjniI9xHBujFfrV24awkRo6RiA87
 OIEbcdBa9VaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="415820645"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2021 08:31:56 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        adrian.hunter@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf, pt: Improve data loss
Date:   Thu,  8 Apr 2021 18:31:57 +0300
Message-Id: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

There is a problem between the PT driver and the AUX allocator that results
in smaller buffers consisting of 2 high-order regions, which also means
only 2 possibilities of where PMI gets generated and where tracing stops.

This is not good enough for double buffering: when we get a PMI mid-buffer,
we update the ->aux_head etc and immediately start a new transaction while
observing ->aux_tail to still be zero, which makes the PT driver put a stop
bit at the end of the buffer. However quick userspace is to update the
->aux_tail, that second transaction/PERF_RECORD_AUX ends up truncated.

The proposed solution here is to set up attr.aux_watermark to a quarter of
the buffer. Unfortunately, at the moment, the PT driver is not equipped to
deal with aux_watermark that's smaller than the AUX allocation order. I
could fix this in the driver itself, but, seeing as it's the only PMU that
actually uses the 'order' from AUX allocations, I'd rather fix the
allocator instead, which is done in patch 1/2.

Patch 2/2 could be replaced by instead changing the in-kernel aux_watermark
default, but that may interfere with PMU drivers that don't ignore said
watermark / handle->wakeup (afaict, that's only arm_spe).

Alexander Shishkin (2):
  perf: Cap allocation order at aux_watermark
  perf intel-pt: Use aux_watermark

 kernel/events/ring_buffer.c         | 34 +++++++++++++++--------------
 tools/perf/arch/x86/util/intel-pt.c |  4 ++++
 2 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.30.2

