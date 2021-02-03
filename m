Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3030D1F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhBCDEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:04:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49368 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232402AbhBCC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:59:57 -0500
X-UUID: 69302ffbb1394a218e4d7f009631bcae-20210203
X-UUID: 69302ffbb1394a218e4d7f009631bcae-20210203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 584073477; Wed, 03 Feb 2021 10:59:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 10:59:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 10:59:12 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH 1/2] arm64: perf: add support for Cortex-A78
Date:   Wed, 3 Feb 2021 10:58:01 +0800
Message-ID: <20210203025802.30201-2-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210203025802.30201-1-seiya.wang@mediatek.com>
References: <20210203025802.30201-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Cortex-A78 using generic PMUv3 for now.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 arch/arm64/kernel/perf_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 38bb07eff872..62ec2b4ea403 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1190,6 +1190,12 @@ static int armv8_a77_pmu_init(struct arm_pmu *cpu_pmu)
 				       armv8_pmuv3_map_event);
 }
 
+static int armv8_a78_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_cortex_a78",
+				       armv8_pmuv3_map_event);
+}
+
 static int armv8_e1_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	return armv8_pmu_init_nogroups(cpu_pmu, "armv8_neoverse_e1",
@@ -1227,6 +1233,7 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a75-pmu",	.data = armv8_a75_pmu_init},
 	{.compatible = "arm,cortex-a76-pmu",	.data = armv8_a76_pmu_init},
 	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_a77_pmu_init},
+	{.compatible = "arm,cortex-a78-pmu",	.data = armv8_a78_pmu_init},
 	{.compatible = "arm,neoverse-e1-pmu",	.data = armv8_e1_pmu_init},
 	{.compatible = "arm,neoverse-n1-pmu",	.data = armv8_n1_pmu_init},
 	{.compatible = "cavium,thunder-pmu",	.data = armv8_thunder_pmu_init},
-- 
2.14.1

