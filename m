Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6823D3A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhGWMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:05:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhGWMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A89DD6E;
        Fri, 23 Jul 2021 05:46:20 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE4D03F694;
        Fri, 23 Jul 2021 05:46:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 00/10] coresight: TRBE and Self-Hosted trace fixes
Date:   Fri, 23 Jul 2021 13:46:01 +0100
Message-Id: <20210723124611.3828908-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the following issues with the TRBE and Self-Hosted
trace for CoreSight.

The Self-hosted trace filter control registers are now save-restored
across CPU PM event. And more importantly the Trace Filtering is now
used to control per ETM session (rather than allowing the trace
throughout the life time of the system). i.e, ETM configuration of
the given run is used to enforce trace filtering (TRFCR) along with the
Trace Exclusion controls in TRCVICTLR.

For the TRBE, we were using the TRUNCATED flag in the AUX buffer on
every IRQ to indicate that we may have lost a few bytes of trace. But
this causes the event to be disabled until the userspace re-enables
it back, even when there is space left in the ring buffer. To make
things worse, we were restarting the AUX handle, which would soon
be disabled, potentially creating 0 sized records (without truncation),
which the perf tool tends to ignore. This might cause the event to be
disabled permanently. Also, sometimes we leave the buffer TRUNCATED,
but delay the closing of the handle to event schedule out, which could
cause significant black out in the trace capture. This was reported
by Tamas Zsoldos.

This series removes the use of TRUNCATED flag for every IRQ. Instead,
it is only used if we really run out of space in the buffer. And also
we make sure the "handle" is closed immediately on TRUNCATED case,
which triggers the userspace to take action. The core perf layer has
been hardened to handle this case where a "handle" is closed out.
Finally, we make sure that the CPU trace is prohibited, when the TRBE
is left disabled. The ETE/ETM driver will program the Trace Filtering
appropriately since we do this dynamically now with the first half
of the series.


Changes since v1 [0]:
  - Moved TRFCR related accessors to a new header file
  - Following a discussion, dropped the TRUNCATED flag from
    the TRBE IRQ handler on WRAP. Instead mark COLLISION.
  - Added new patches to harden the ETM perf layer to handle
    an error in the sink driver.
  - Fix TRBE spurious IRQ handling
  - Cleanup TRBE driver to make the "TRUNCATE" cases managed
    at a central place.


[0] https://lkml.kernel.org/r/20210712113830.2803257-1-suzuki.poulose@arm.com

Suzuki K Poulose (10):
  coresight: etm4x: Save restore TRFCR_EL1
  coresight: etm4x: Use Trace Filtering controls dynamically
  coresight: etm-pmu: Ensure the AUX handle is valid
  coresight: trbe: Ensure the format flag is set on truncation
  coresight: trbe: Drop duplicate TRUNCATE flags
  coresight: trbe: Fix handling of spurious interrupts
  coresight: trbe: Do not truncate buffer on IRQ
  coresight: trbe: Unify the enabling sequence
  coresight: trbe: End the AUX handle on truncation
  coresight: trbe: Prohibit trace before disabling TRBE

 .../hwtracing/coresight/coresight-etm-perf.c  |  27 ++++-
 .../coresight/coresight-etm4x-core.c          |  98 ++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h |   7 +-
 .../coresight/coresight-self-hosted-trace.h   |  34 ++++++
 drivers/hwtracing/coresight/coresight-trbe.c  | 109 ++++++++++--------
 5 files changed, 197 insertions(+), 78 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-self-hosted-trace.h

-- 
2.24.1

