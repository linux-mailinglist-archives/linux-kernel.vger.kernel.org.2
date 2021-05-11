Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86153379FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEKG1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:27:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2771 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhEKG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:26:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfSWm1VqGzmg6w;
        Tue, 11 May 2021 14:22:28 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:25:42 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drivers/perf: Remove redundant dev_err call in tx2_uncore_pmu_init_dev()
Date:   Tue, 11 May 2021 14:42:44 +0800
Message-ID: <1620715364-107460-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/perf/thunderx2_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 06a6d56..9e8f55a 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -818,7 +818,6 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 
 	base = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(base)) {
-		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
 		return NULL;
 	}
 
-- 
2.6.2

