Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7232E60F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCEKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:19:02 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:24447 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhCEKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:18:55 -0500
IronPort-SDR: aw7dUhUnKHhPu7UajICRhwh5h4WDj0qFF+JtkDXw10agTElOvQRQsPRolse4WvQ3MloQjX/ErR
 mcNBzC5n0Z3NFoiLiXzEKaSytqq/yVmz1pIJigIANjNTUZWiB4vwrSvylQQKA/cKVjtLTSjhNI
 wK5QqiKGcOAjay3HPoIGdTJXT9E8aeiOmSG+GsLhq6DBTjKCcfHsjj3G5fh0aRePAyU3cuaBh/
 7a4GqLpMSonVAL8vbnQfI3P7wnBfx590YyZln4BAfIDVA/Qb+4L76CG7iCi0zGO1p86o9gghYW
 V54=
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="21791537"
X-IronPort-AV: E=Sophos;i="5.81,224,1610377200"; 
   d="scan'208";a="21791537"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Mar 2021 19:18:54 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A6FEA80C6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:18:52 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 87E77E165B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:18:51 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 238514023702A;
        Fri,  5 Mar 2021 19:18:51 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] perf vendor events: Support PMU events for A64FX
Date:   Fri,  5 Mar 2021 19:18:38 +0900
Message-Id: <20210305101841.3133721-1-nakamura.shun@fujitsu.com>
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

The second patch adds PMU events for A64FX.

The third patch adds "_" to the event name, which starts with a number.


Changes in v7:
 - Rename an event name that starts with a number.
 - Drop 'perf tools: Add lexical definition of event name'.
 - Drop 'perf test: Add test for event name starting with a number'.

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


Shunsuke Nakamura (3):
  perf vendor events arm64: Add more common and uarch events
  perf vendor events arm64: Add Fujitsu A64FX pmu event
  perf vendor events arm64: Add "_" to the event name, which starts with
    a number

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
 12 files changed, 1092 insertions(+)
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

