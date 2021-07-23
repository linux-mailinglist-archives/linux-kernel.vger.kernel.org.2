Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047D43D3A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhGWMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:05:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234931AbhGWMFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55D9311D4;
        Fri, 23 Jul 2021 05:46:25 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE8C33F694;
        Fri, 23 Jul 2021 05:46:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 03/10] coresight: etm-pmu: Ensure the AUX handle is valid
Date:   Fri, 23 Jul 2021 13:46:04 +0100
Message-Id: <20210723124611.3828908-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ETM perf infrastructure closes out a handle during event_stop
or on an error in starting the event. In either case, it is possible
for a "sink" to update/close the handle, under certain circumstances.
(e.g no space in ring buffer.). So, ensure that we handle this
gracefully in the PMU driver by verifying the handle is still valid.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6f398377fec9..a6ab603afee4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -450,8 +450,15 @@ static void etm_event_start(struct perf_event *event, int flags)
 fail_disable_path:
 	coresight_disable_path(path);
 fail_end_stop:
-	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
-	perf_aux_output_end(handle, 0);
+	/*
+	 * Check if the handle is still associated with the event,
+	 * to handle cases where if the sink failed to start the
+	 * trace and TRUNCATED the handle already.
+	 */
+	if (READ_ONCE(handle->event)) {
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		perf_aux_output_end(handle, 0);
+	}
 fail:
 	event->hw.state = PERF_HES_STOPPED;
 	goto out;
@@ -519,7 +526,21 @@ static void etm_event_stop(struct perf_event *event, int mode)
 
 		size = sink_ops(sink)->update_buffer(sink, handle,
 					      event_data->snk_config);
-		perf_aux_output_end(handle, size);
+		/*
+		 * Make sure the handle is still valid as the
+		 * sink could have closed it from an IRQ.
+		 * The sink driver must handle the race with
+		 * update_buffer() and IRQ. Thus either we
+		 * should get a valid handle and valid size
+		 * (which may be 0).
+		 *
+		 * But we should never get a non-zero size with
+		 * an invalid handle.
+		 */
+		if (READ_ONCE(handle->event))
+			perf_aux_output_end(handle, size);
+		else
+			WARN_ON(size);
 	}
 
 	/* Disabling the path make its elements available to other sessions */
-- 
2.24.1

