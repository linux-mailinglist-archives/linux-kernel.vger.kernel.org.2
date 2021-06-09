Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2503A0C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhFIGoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:44:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5298 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhFIGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:43:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0HTJ2Hpvz1BKSw;
        Wed,  9 Jun 2021 14:37:08 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:42:00 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:59 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/7] drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
Date:   Wed, 9 Jun 2021 14:41:00 +0800
Message-ID: <1623220863-58233-5-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
References: <1623220863-58233-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common macro PMU_EVENT_ATTR_ID to simplify L3CACHE_EVENT_ATTR

Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/qcom_l3_pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 0812735..e033d89 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -647,10 +647,7 @@ static ssize_t l3cache_pmu_event_show(struct device *dev,
 }
 
 #define L3CACHE_EVENT_ATTR(_name, _id)					     \
-	(&((struct perf_pmu_events_attr[]) {				     \
-		{ .attr = __ATTR(_name, 0444, l3cache_pmu_event_show, NULL), \
-		  .id = _id, }						     \
-	})[0].attr.attr)
+	PMU_EVENT_ATTR_ID(_name, l3cache_pmu_event_show, _id)
 
 static struct attribute *qcom_l3_cache_pmu_events[] = {
 	L3CACHE_EVENT_ATTR(cycles, L3_EVENT_CYCLES),
-- 
2.7.4

