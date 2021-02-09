Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A139E314C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhBIKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:08:19 -0500
Received: from foss.arm.com ([217.140.110.172]:48730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhBIKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:00:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A552513A1;
        Tue,  9 Feb 2021 01:59:31 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A653F73B;
        Tue,  9 Feb 2021 01:59:27 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] perf cs-etm: don't process queues until cs_etm__flush_events
Date:   Tue,  9 Feb 2021 11:58:56 +0200
Message-Id: <20210209095857.28419-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210209095857.28419-1-james.clark@arm.com>
References: <20210209095857.28419-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure processing happens in the correct order, queue processing
shouldn't start until every aux queue has had its first timestamp found.

Now that we're only searching for timestamps within each aux record, we
need to wait until all aux records are delivered before starting the
processing.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index efe418a7c82e..0aaa1f6d2822 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2394,10 +2394,6 @@ static int cs_etm__process_event(struct perf_session *session,
 	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
-	if (!etm->timeless_decoding &&
-	    event->header.type == PERF_RECORD_AUX)
-		return cs_etm__process_queues(etm);
-
 	return 0;
 }
 
-- 
2.28.0

