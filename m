Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323E30A5F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhBAK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:57:43 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:37213 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhBAK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:57:19 -0500
IronPort-SDR: jiropid0czbZZQufJSG54t8+vb2ohsWg3eA8ClcgJ5zTyynkmmqgGjdR9xlzC7lyqEo2WDOUjq
 qu5GwHKCbkNS1EB8wbU+BzH6rbxunq80X0l8zQnZV8BHNtAHivhZatLNwYT6hyh1UWsUv1FLZZ
 SQmjvpEtNlp/dgKxzpxXHpJ+PZFFvMF2BAYtS848vZ6Enn+MOxtUdKebz7rC2S96WVthgXlIqK
 Er9J1egIxkYAgf6zg7JLROed/yhFStsiiDL+VNu/jsSrjC+zdIlxpONap5TVx2VBeKhCVYs9zM
 Mwk=
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="17474092"
X-IronPort-AV: E=Sophos;i="5.79,392,1602514800"; 
   d="scan'208";a="17474092"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Feb 2021 19:54:55 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AC781EF958
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:54:53 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EEF1966
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:54:52 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 287F54357; Mon,  1 Feb 2021 19:48:39 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, nakamura.shun@fujitsu.com,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v3 0/4] perf vendor events: Support PMU events for A64FX
Date:   Mon,  1 Feb 2021 19:48:18 +0900
Message-Id: <20210201104822.3230543-1-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

