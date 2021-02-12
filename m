Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EF331A0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBLOqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:46:24 -0500
Received: from foss.arm.com ([217.140.110.172]:38040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhBLOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:46:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A815B1063;
        Fri, 12 Feb 2021 06:45:33 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.46.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18F143F73D;
        Fri, 12 Feb 2021 06:45:29 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Split Coresight decode by aux records
Date:   Fri, 12 Feb 2021 16:45:06 +0200
Message-Id: <20210212144513.31765-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Since my previous RFC, I've fixed --per-thread mode and solved
most of the open questions. I've also changed --dump-raw-trace
to use the same code path so it's also working now.

I think the only open questions are:
  * General approach
  * If aux records need to be saved, or if they can be pulled
    from elsewhere.

I've also tested perf inject which is now working with troublesome
files.

Thanks
James

James Clark (7):
  perf cs-etm: Split up etm queue setup function
  perf cs-etm: Only search timestamp in current sample's queue.
  perf cs-etm: Save aux records in each etm queue
  perf cs-etm: don't process queues until cs_etm__flush_events
  perf cs-etm: split decode by aux records.
  perf cs-etm: Use existing decode code path for --dump-raw-trace
  perf cs-etm: Suppress printing when resetting decoder

 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  10 +-
 tools/perf/util/cs-etm.c                      | 300 ++++++++++--------
 2 files changed, 168 insertions(+), 142 deletions(-)

-- 
2.28.0

