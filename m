Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2EF330BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhCHLBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:01:22 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100]:48439 "EHLO
        esa12.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229711AbhCHLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:00:55 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 06:00:54 EST
IronPort-SDR: Ly2bHpMIEcKUHTOhTQzCmDBtOIMjFxq+pJkKOvIrddxSSEQfYmBkmbS5lqk43tdnufhHKZdlyX
 l9MOEC1b20to/Hd8W0Pan+giVmjEwWycBxDLFuXzZyLX0UQOW+4yRjPclCnZtY66B+i0+0Mvne
 kPAJQyci8M1l1WbLob/7rJosPbx9lNyzch9R8VDYXJfTO92uoR6SAeqfpRmcVCA6F19941bcig
 Z7AghswVNrm7VB/Wdi0D2KJ8CdyMSi6ygFHEDGkDJXzg6jQ8SEmeIV/k3trdEHZvTzBTqub1Uo
 JBU=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="2099866"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200"; 
   d="scan'208";a="2099866"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Mar 2021 19:53:46 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 01D411F5142
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:46 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 50E09C9CE5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:45 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 3FB354005E9C0;
        Mon,  8 Mar 2021 19:53:45 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/2] perf vendor events: Support PMU events for A64FX
Date:   Mon,  8 Mar 2021 19:53:39 +0900
Message-Id: <20210308105342.746940-1-nakamura.shun@fujitsu.com>
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


Changes in v8:
 - Merge 'perf vendor events arm64: Add Fujitsu A64FX pmu event' and
   'perf vendor events arm64: Add "_" to the event name, which starts with a number'

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


Shunsuke Nakamura (2):
  perf vendor events arm64: Add more common and uarch events
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

