Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE830A550
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhBAK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:29:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11963 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBAK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:29:03 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DTkdz5LSHzjGCV;
        Mon,  1 Feb 2021 18:27:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 18:28:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <jean-philippe@linaro.org>, <thunder.leizhen@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] driver/perf: Remove ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3
Date:   Mon, 1 Feb 2021 18:24:02 +0800
Message-ID: <1612175042-56866-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3_PMU was added with the idea
that a SMMUv3 PMCG would only exist on a system with an associated SMMUv3.

However it is not the job of Kconfig to make these sorts of decisions (even
if it were true), so remove the dependency.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 3075cf171f78..77522e5efe11 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -62,7 +62,7 @@ config ARM_PMU_ACPI
 
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
-	 depends on ARM64 && ACPI && ARM_SMMU_V3
+	 depends on ARM64 && ACPI
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter
 	   Groups (PMCG), which provide monitoring of transactions passing
-- 
2.26.2

