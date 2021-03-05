Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34232E64E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCEK0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:26:41 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:18697 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhCEK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:26:15 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 05:26:15 EST
IronPort-SDR: krv/S+CFAURZZwWR4NKucmyBBjBYj9sr2GZaukzSln510273MOw8KznX5a0jDucHTnKE8tCrn7
 Kut1vOzngp3cGATtLVTnjbJ1fu67o7jho6SNVbmvxymsvZtBdAxIOxukDrGHMZ0a7ar0Jm/C0+
 ouGarW05dpRih2kK8eg23RD5GXIIC/4R0gIKDdNCsXyVephvrrvxZLxpzPuHj1ss2eg8ia35HF
 qkoHNrgI2AOujvGmsPxRo6m+Kt/p3QQdpZSej9c8w+9rradc21Donf/jdem7p07hiaPgaI9aAI
 eNU=
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="9801819"
X-IronPort-AV: E=Sophos;i="5.81,224,1610377200"; 
   d="scan'208";a="9801819"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Mar 2021 19:19:04 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 99D0BEBA5A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:19:03 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C214EB4E5A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:19:02 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 6768A40237059;
        Fri,  5 Mar 2021 19:19:02 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] perf vendor events arm64: Add "_" to the event name, which starts with a number
Date:   Fri,  5 Mar 2021 19:18:41 +0900
Message-Id: <20210305101841.3133721-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305101841.3133721-1-nakamura.shun@fujitsu.com>
References: <20210305101841.3133721-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf parser does not support event names that start with a number.
This patch adds "_" to the event name, which starts with a number.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
index 68b8e46d6140..10c823ac26cc 100644
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
@@ -98,31 +98,31 @@
   {
     "PublicDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only.",
     "EventCode": "0x190",
-    "EventName": "0INST_COMMIT",
+    "EventName": "_0INST_COMMIT",
     "BriefDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only."
   },
   {
     "PublicDescription": "This event counts every cycle that one instruction is committed.",
     "EventCode": "0x191",
-    "EventName": "1INST_COMMIT",
+    "EventName": "_1INST_COMMIT",
     "BriefDescription": "This event counts every cycle that one instruction is committed."
   },
   {
     "PublicDescription": "This event counts every cycle that two instructions are committed.",
     "EventCode": "0x192",
-    "EventName": "2INST_COMMIT",
+    "EventName": "_2INST_COMMIT",
     "BriefDescription": "This event counts every cycle that two instructions are committed."
   },
   {
     "PublicDescription": "This event counts every cycle that three instructions are committed.",
     "EventCode": "0x193",
-    "EventName": "3INST_COMMIT",
+    "EventName": "_3INST_COMMIT",
     "BriefDescription": "This event counts every cycle that three instructions are committed."
   },
   {
     "PublicDescription": "This event counts every cycle that four instructions are committed.",
     "EventCode": "0x194",
-    "EventName": "4INST_COMMIT",
+    "EventName": "_4INST_COMMIT",
     "BriefDescription": "This event counts every cycle that four instructions are committed."
   },
   {
-- 
2.25.1

