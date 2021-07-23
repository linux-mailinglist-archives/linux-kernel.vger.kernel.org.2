Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B630D3D3A72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhGWMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:04 -0400
Received: from foss.arm.com ([217.140.110.172]:45518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234936AbhGWMF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10A9511D4;
        Fri, 23 Jul 2021 05:46:32 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E7EE3F694;
        Fri, 23 Jul 2021 05:46:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com, James Clark <james.clark@arm.com>
Subject: [PATCH v2 07/10] coresight: trbe: Do not truncate buffer on IRQ
Date:   Fri, 23 Jul 2021 13:46:08 +0100
Message-Id: <20210723124611.3828908-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
on FILL event. This has rather unwanted side-effect of the event
being disabled when there may be more space in the ring buffer.

So, instead of TRUNCATE we need a different flag to indicate
that the trace may have lost a few bytes (i.e from the point of
generating the FILL event until the IRQ is consumed). Anyways, the
userspace must use the size from RECORD_AUX headers to restrict
the "trace" decoding.

Using PARTIAL flag causes the perf tool to generate the
following warning:

  Warning:
  AUX data had gaps in it XX times out of YY!

  Are you running a KVM guest in the background?

which is pointlessly scary for a user. The other remaining options
are :
  - COLLISION - Use by SPE to indicate samples collided
  - Add a new flag - Specifically for CoreSight, doesn't sound
    so good, if we can re-use something.

Given that we don't already use the "COLLISION" flag, the above
behavior can be notified using this flag for CoreSight.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 503bea0137ae..d50f142e86d1 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -615,7 +615,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 		 * for correct size. Also, mark the buffer truncated.
 		 */
 		write = get_trbe_limit_pointer();
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
 	}
 
 	offset = write - base;
@@ -708,7 +708,7 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 	 * collection upon the WRAP event, without stopping the source.
 	 */
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
-				     PERF_AUX_FLAG_TRUNCATED);
+				     PERF_AUX_FLAG_COLLISION);
 	perf_aux_output_end(handle, size);
 	event_data = perf_aux_output_begin(handle, event);
 	if (!event_data) {
-- 
2.24.1

