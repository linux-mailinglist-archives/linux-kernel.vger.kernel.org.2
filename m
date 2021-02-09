Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEEA314C82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBIKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:05:48 -0500
Received: from foss.arm.com ([217.140.110.172]:48652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhBIKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:00:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF09101E;
        Tue,  9 Feb 2021 01:59:15 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3118B3F73B;
        Tue,  9 Feb 2021 01:59:11 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] Split Coresight decode by aux records
Date:   Tue,  9 Feb 2021 11:58:52 +0200
Message-Id: <20210209095857.28419-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches fix opening perf.data files that have timestamps
(ordered data), aren't recorded with --per-thread, and that have
discontinuous data in a single aux trace buffer.

I have some open questions:
 * Can cs_etm__update_queues() be removed from cs_etm__flush_events()?
 * Why does the second commit start making some files process correctly?
 * Is it ok to wait for the flush to start processing? Previously
   processing happened when the first aux record was delivered to
   cs_etm__process_event().
 * Do the aux records need to be saved into a new buffer or can they
   be pulled from elsewhere?

I also have some further changes to make to make per-thread mode work
where the cpu field of the sample is set to -1. And when there are
no timestamps cs_etm__process_timeless_queues() is used, which is a
completely different code path.

Thanks
James

James Clark (5):
  perf cs-etm: Split up etm queue setup function
  perf cs-etm: Only search timestamp in current sample's queue.
  perf cs-etm: Save aux records in each etm queue
  perf cs-etm: don't process queues until cs_etm__flush_events
  perf cs-etm: split decode by aux records.

 tools/perf/util/cs-etm.c | 200 +++++++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 79 deletions(-)

-- 
2.28.0

