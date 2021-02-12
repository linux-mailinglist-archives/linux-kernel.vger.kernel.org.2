Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562F9319BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBLJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:12:21 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:19864 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhBLJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:12:18 -0500
IronPort-SDR: o5DST+B4r+oQ2MQkQAEBpAoqL+ZQnAxAU3tbLgBrb15mVuwUfA2LoMhrbwuQwzWNYPzR4wnC4T
 eHqMIqQJEv1hq2KZctReIDc7x4kyEyotPFg7dULBjjEh/swbsaf+eF+0jfroUYlN9HhCPMzxSs
 C+R/2Rs5aeWX3ei0KgW7EYWXUcrC5hpzGfIR6SAGAgIDBi4Q8WveKm1xhc8e8yLVKCZ4MhU5ug
 SlsBwyt7FRmq8zYUS9Y5U3Al8nCHI1tlPcDmGGFv3BYMH8hf4BcY5y1BQg9Zttq53ragF2DDDb
 xTM=
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="7088423"
X-IronPort-AV: E=Sophos;i="5.81,173,1610377200"; 
   d="scan'208";a="7088423"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 12 Feb 2021 18:10:00 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E24821EC60
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 18:09:59 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E2C9B595745
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 18:09:58 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id F270E5F6; Fri, 12 Feb 2021 18:03:18 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v6 0/3] perf vendor events: Support PMU events for A64FX
Date:   Fri, 12 Feb 2021 18:03:15 +0900
Message-Id: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series supports A64FX PMU event v1.2.

The first patch add more common and microarchitecture events.
This patch is based on john's patch [1].

The second patch fixes the lexical definition of event name so that
perf can recognize event name that start with a number.

The third patch adds PMU events for A64FX.


Changes in v5:
 - Removed john's patch [1] from this patch series.
 - Added the missing Reviewed-by tag to the patch.
 - Fixed the base of the patch series.[2]
 - Changed subject from fix to added.

Changes in v4:
 - Add arm64 to the subjects of the second and fourth patches.
 - Add reference URLs to the body of the second patch.

Changes in v3:
 - Add linux-arm-kernel mailing list to cc.

Changes in v2:
 - Added armv8-common-and-microarch based on John's patch.[1]
 - Fixed A64FX Json to refer to standard events in armv8-common-and-microarch.

[1] https://lore.kernel.org/lkml/1611835236-34696-3-git-send-email-john.garry@huawei.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core


Shunsuke Nakamura (3):
  perf vendor events arm64: Add more common and uarch events
  perf tools: Add lexical definition of event name
  perf vendor events arm64: Add Fujitsu A64FX pmu event

 .../arm64/armv8-common-and-microarch.json     | 228 ++++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/branch.json      |   8 +
 .../arch/arm64/fujitsu/a64fx/bus.json         |  62 +++++
 .../arch/arm64/fujitsu/a64fx/cache.json       | 128 ++++++++++
 .../arch/arm64/fujitsu/a64fx/cycle.json       |   5 +
 .../arch/arm64/fujitsu/a64fx/exception.json   |  29 +++
 .../arch/arm64/fujitsu/a64fx/instruction.json | 131 ++++++++++
 .../arch/arm64/fujitsu/a64fx/memory.json      |   8 +
 .../arch/arm64/fujitsu/a64fx/other.json       | 188 +++++++++++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json    | 194 +++++++++++++++
 .../arch/arm64/fujitsu/a64fx/sve.json         | 110 +++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 tools/perf/util/parse-events.l                |   2 +-
 13 files changed, 1093 insertions(+), 1 deletion(-)
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
2.25.1

