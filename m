Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3034330575F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhA0JvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:51:23 -0500
Received: from foss.arm.com ([217.140.110.172]:32968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhA0I7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379191529;
        Wed, 27 Jan 2021 00:56:10 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.91.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6E2C3F66B;
        Wed, 27 Jan 2021 00:56:04 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Ziljstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        will@kernel.org, mark.rutland@arm.com, acme@kernel.org,
        jolsa@redhat.com, Mathieu Poirier <mathieu.poirer@linaro.org>
Subject: [PATCH V3 13/14] perf: aux: Add flags for the buffer format
Date:   Wed, 27 Jan 2021 14:25:37 +0530
Message-Id: <1611737738-1493-14-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Allocate a byte for advertising the PMU specific format type
of the given AUX record. A PMU could end up providing hardware
trace data in multiple format in a single session.

e.g, The format of hardware buffer produced by CoreSight ETM
PMU depends on the type of the "sink" device used for collection
for an event (Traditional TMC-ETR/Bs with formatting or
TRBEs without any formatting).

 # Boring story of why this is needed. Goto The_End_of_Story for skipping.

CoreSight ETM trace allows instruction level tracing of Arm CPUs.
The ETM generates the CPU excecution trace and pumps it into CoreSight
AMBA Trace Bus and is collected by a different CoreSight component
(traditionally CoreSight TMC-ETR /ETB/ETF), called "sink".
Important to note that there is no guarantee that every CPU has
a dedicated sink.  Thus multiple ETMs could pump the trace data
into the same "sink" and thus they apply additional formatting
of the trace data for the user to decode it properly and attribute
the trace data to the corresponding ETM.

However, with the introduction of Arm Trace buffer Extensions (TRBE),
we now have a dedicated per-CPU architected sink for collecting the
trace. Since the TRBE is always per-CPU, it doesn't apply any formatting
of the trace. The support for this driver is under review [1].

Now a system could have a per-cpu TRBE and one or more shared
TMC-ETRs on the system. A user could choose a "specific" sink
for a perf session (e.g, a TMC-ETR) or the driver could automatically
select the nearest sink for a given ETM. It is possible that
some ETMs could end up using TMC-ETR (e.g, if the TRBE is not
usable on the CPU) while the others using TRBE in a single
perf session. Thus we now have "formatted" trace collected
from TMC-ETR and "unformatted" trace collected from TRBE.
However, we don't get into a situation where a single event
could end up using TMC-ETR & TRBE. i.e, any AUX buffer is
guaranteed to be either RAW or FORMATTED, but not a mix
of both.

As for perf decoding, we need to know the type of the data
in the individual AUX buffers, so that it can set up the
"OpenCSD" (library for decoding CoreSight trace) decoder
instance appropriately. Thus the perf.data file must conatin
the hints for the tool to decode the data correctly.

Since this is a runtime variable, and perf tool doesn't have
a control on what sink gets used (in case of automatic sink
selection), we need this information made available from
the PMU driver for each AUX record.

 # The_End_of_Story

Cc: Peter Ziljstra <peterz@infradead.org>
Cc: alexander.shishkin@linux.intel.com
Cc: mingo@redhat.com
Cc: will@kernel.org
Cc: mark.rutland@arm.com
Cc: mike.leach@linaro.org
Cc: acme@kernel.org
Cc: jolsa@redhat.com
Cc: Mathieu Poirier <mathieu.poirer@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/uapi/linux/perf_event.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e344..9a5ca45 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1105,10 +1105,11 @@ enum perf_callchain_context {
 /**
  * PERF_RECORD_AUX::flags bits
  */
-#define PERF_AUX_FLAG_TRUNCATED		0x01	/* record was truncated to fit */
-#define PERF_AUX_FLAG_OVERWRITE		0x02	/* snapshot from overwrite mode */
-#define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
-#define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
+#define PERF_AUX_FLAG_TRUNCATED			0x01	/* record was truncated to fit */
+#define PERF_AUX_FLAG_OVERWRITE			0x02	/* snapshot from overwrite mode */
+#define PERF_AUX_FLAG_PARTIAL			0x04	/* record contains gaps */
+#define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
+#define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
 
 #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
-- 
2.7.4

