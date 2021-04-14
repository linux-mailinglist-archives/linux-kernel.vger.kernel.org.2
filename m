Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5420735F879
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbhDNPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:53:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:37682 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352431AbhDNPxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:53:01 -0400
IronPort-SDR: 3URdLCR5NzPX1AUP7ilfjkdglTZFUYSEhf+GGFeIsWgZ8QSJkRdaD8Zm9G8VvgK4D3c1ultVP+
 ue2PwDTZwlKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="279979725"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279979725"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 08:50:57 -0700
IronPort-SDR: XKU0UHpQ4n/W3Sn6e4mKdTm7sLk2rFJg2hw59FL9TFfpEBW+oA2VPnlhjyCAnRBmotHKrpTM5x
 3CJk76gs0LVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="399225962"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2021 08:50:52 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        adrian.hunter@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf, pt: Improve data loss
Date:   Wed, 14 Apr 2021 18:49:53 +0300
Message-Id: <20210414154955.49603-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

v1: fixed whitespace damage in 1/2 and applied Adrian's comment to 2/2.

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
 tools/perf/arch/x86/util/intel-pt.c |  6 +++++
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.30.2

