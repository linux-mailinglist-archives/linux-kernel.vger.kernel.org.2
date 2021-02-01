Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACF30A666
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhBALVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:21:49 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:55232 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233120AbhBALVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:21:45 -0500
IronPort-SDR: +qPHHYC7GH4frBzRnBBIvuA5TnMIRwOR2vl9x/ERqF9aEFJwFPysX7UB2rhknz9zVF3Cm2HFLW
 q/i6f2+nnnOIRS7Wehk3vI6gos86AdibDc97sBuYIyC5OJyc717yQu2ruudMLbRA7h3GGe+WYu
 33Eb1a6fWGKwCyaxuMQHsI3wWgBdDVxu7sIplQ7YYGHD76u4bHKQhtEDXv5FrKe7mBvKzsstZL
 U3BWLCui0OXqxaoqfwFL5pakP5PBF0EOzmYFBIXqsst5E2VF8brpmiqsoFNsJrSqJx1goJFV4U
 Q1Q=
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="17521679"
X-IronPort-AV: E=Sophos;i="5.79,392,1602514800"; 
   d="scan'208";a="17521679"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Feb 2021 20:19:29 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 27592EF959
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:27 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CB3CB4E48
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:19:26 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 7DDA04357; Mon,  1 Feb 2021 20:13:12 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nakamura.shun@fujitsu.com,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v4 0/4] perf vendor events: Support PMU events for A64FX
Date:   Mon,  1 Feb 2021 20:13:06 +0900
Message-Id: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I forgot to add the mailing list to cc. Will resend. Sorry about that.)

This patch series supports A64FX PMU event v1.2.

The first patch adds a common and microarchitecture event, which can be
referenced from CPU JSONs.
This patch uses part of John's patch.[1]

The second patch adds level 2 instruction TLB, SVE, SIMD, and FP events.

The third patch fixes the lexical definition of event name so that
perf can recognize event name that start with a number.

The fourth patch adds PMU events for A64FX.

Changes in v2:
 - Added armv8-common-and-microarch based on John's patch.[1]
 - Fixed A64FX Json to refer to standard events in armv8-common-and-microarch.


[1] https://lore.kernel.org/lkml/1611835236-34696-3-git-send-email-john.garry@huawei.com/


John Garry (1):
  perf vendor events arm64: Add common and uarch event JSON

Shunsuke Nakamura (3):
  perf vendor events: Add L2I_TLB, SVE, SIMD, and FP events
  perf tools: Fix lexical definition of event name
  perf vendor events: Add Fujitsu A64FX V1.2 pmu event

 .../arch/arm64/armv8-common-and-microarch.json     | 476 +++++++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/branch.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 +++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 128 ++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   5 +
 .../arch/arm64/fujitsu/a64fx/exception.json        |  29 ++
 .../arch/arm64/fujitsu/a64fx/instruction.json      | 131 ++++++
 .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 ++++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json         | 194 +++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 110 +++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/util/parse-events.l                     |   2 +-
 13 files changed, 1341 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json

-- 
1.8.3.1

