Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B830D33A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhBCFzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:55:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33598 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229831AbhBCFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:55:05 -0500
X-UUID: 213451558d484a1aab60501b5450babb-20210203
X-UUID: 213451558d484a1aab60501b5450babb-20210203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1905587967; Wed, 03 Feb 2021 13:54:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Feb 2021 13:53:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 13:53:58 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>
Subject: [PATCH v2 1/2] arm64: perf: add support for Cortex-A78
Date:   Wed, 3 Feb 2021 13:53:47 +0800
Message-ID: <20210203055348.4935-2-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210203055348.4935-1-seiya.wang@mediatek.com>
References: <20210203055348.4935-1-seiya.wang@mediatek.com>
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

