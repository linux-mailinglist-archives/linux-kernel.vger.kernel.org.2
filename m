Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946E23386F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhCLH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:56:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13882 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCLH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:56:01 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DxdP341wMz7kNl;
        Fri, 12 Mar 2021 15:53:59 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 15:55:37 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] perf/arm_dmc620_pmu: Fix error return code in dmc620_pmu_device_probe()
Date:   Fri, 12 Mar 2021 08:04:21 +0000
Message-ID: <20210312080421.277562-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 53c218da220c ("driver/perf: Add PMU driver for the ARM DMC-620 memory controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/perf/arm_dmc620_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 66ad5b3ece19..f2a85500258d 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -681,6 +681,7 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 	if (!name) {
 		dev_err(&pdev->dev,
 			  "Create name failed, PMU @%pa\n", &res->start);
+		ret = -ENOMEM;
 		goto out_teardown_dev;
 	}
 

