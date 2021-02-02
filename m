Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095BE30BEF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhBBNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:00:24 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223]:24240 "EHLO
        esa9.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhBBNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:00:18 -0500
IronPort-SDR: ZxIuKzG20pUZ2FH9tSljD3C/EUZAKv0KduRGiWhfmopBn3ITfy8GATahkUNNixcJKSCIZgyL9Y
 Phk10jcjQGmPDDQcZPn/rbCAiIG499zgfYRU5L1jq7lZlUCImSyKe1X2RPgMg1K0wWvsPcf+sZ
 qMGF5d8uzfbTS3qOZyuDD5EgwHD1C38oWvG8sRBSBbNrlQU/ipq7/JAsxBD0BsjVlx56fHgc3f
 YaKRMI2mjwRWrOrgsuwcjrE+eExhfGqZByeIdDiSomFoi+/SMtfV3YeE139sy8Vz2b5mvjocs3
 KkY=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="5703227"
X-IronPort-AV: E=Sophos;i="5.79,395,1602514800"; 
   d="scan'208";a="5703227"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Feb 2021 21:57:58 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C2396EC7E6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:57 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 111ED1557A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 21:57:57 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 8AD391086; Tue,  2 Feb 2021 21:51:40 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Date:   Tue,  2 Feb 2021 21:51:36 +0900
Message-Id: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

This patch series supports A64FX PMU event v1.2.

The first patch adds a common and microarchitecture event, which can be
referenced from CPU JSONs.
This patch uses part of John's patch.[1]

The second patch add more common and microarchitecture events.

The third patch fixes the lexical definition of event name so that
perf can recognize event name that start with a number.

The fourth patch adds PMU events for A64FX.


Changes in v4:
 - Add arm64 to the subjects of the second and fourth patches.
 - Add reference URLs to the body of the second patch.

Changes in v3:
 - Add linux-arm-kernel mailing list to cc.

Changes in v2:
 - Added armv8-common-and-microarch based on John's patch.[1]
 - Fixed A64FX Json to refer to standard events in armv8-common-and-microarch.


[1] https://lore.kernel.org/lkml/1611835236-34696-3-git-send-email-john.garry@huawei.com/


John Garry (1):
  perf vendor events arm64: Add common and uarch event JSON

Shunsuke Nakamura (3):
  perf vendor events arm64: Add common and uarch event JSON
  perf vendor events arm64: Add more common and uarch events
  perf tools: Fix lexical definition of event name
  perf vendor events arm64: Add Fujitsu A64FX pmu event

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

