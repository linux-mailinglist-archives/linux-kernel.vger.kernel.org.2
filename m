Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A650B32CADE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhCDDgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:36:31 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:6785 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbhCDDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:36:07 -0500
IronPort-SDR: N0AZTvrW/jcOyuvrJaiSesNwGPmGH2ZBoF7MyqWtMae2P5TpEwzZNN3+FJ0B2eHpkLCBzgFqvU
 qVoR7CrLL/DTUv9i9b15WP6+dOWteUrmY5sSH0VZvLocaEgvXSf8EN8SLopjGJ1CSLhk11umdE
 O9wpm3m0m9WpWLLOFzjMMgnFv/YHof11jGatBFkP+i+RbPV4+nGqtd4dhljojiC+0llbGpJpA2
 X+/kK8OqHpWNYPZ54F5kGMgT+AYa+pnx+FobOpkan1jwrvCZo2Uc99+Q1i7fNtihx1TQhdtkN9
 GSI=
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="21614234"
X-IronPort-AV: E=Sophos;i="5.81,221,1610377200"; 
   d="scan'208";a="21614234"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2021 12:26:16 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B212C41AAA4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:14 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C767C6E00A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id A7AB24007EDAA;
        Thu,  4 Mar 2021 12:26:13 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] perf vendor events: Support PMU events for A64FX
Date:   Thu,  4 Mar 2021 12:26:06 +0900
Message-Id: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>

This patch series supports A64FX PMU event v1.2.

The first patch add more common and microarchitecture events.
This patch is based on john's patch [1].

The second patch fixes the lexical definition of event name so that 
perf can recognize event name that start with a number.

The third patch adds PMU events for A64FX.

The fourth patch adds test for event name starting with a number.

Changes in v6:
 - Add test to the second patch.
 - Add Acked-by tag to the third patch.
 - Add Reviewed-by tag to the third patch.

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

Shunsuke Nakamura (4):
  perf vendor events arm64: Add more common and uarch events
  perf tools: Add lexical definition of event name
  perf vendor events arm64: Add Fujitsu A64FX pmu event
  perf test: Add test for event name starting with a number

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
 tools/perf/tests/pmu-events.c                 |  16 +-
 tools/perf/util/parse-events.l                |   2 +-
 14 files changed, 1094 insertions(+), 16 deletions(-)
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

