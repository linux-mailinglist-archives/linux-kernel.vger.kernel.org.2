Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9E3A0CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhFIGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:44:10 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5297 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhFIGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:43:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0HTJ1HQnz1BKSk;
        Wed,  9 Jun 2021 14:37:08 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:59 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:41:58 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v4 1/7] perf: Add EVENT_ATTR_ID to simplify event attributes
Date:   Wed, 9 Jun 2021 14:40:57 +0800
Message-ID: <1623220863-58233-2-git-send-email-liuqi115@huawei.com>
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

Similar EVENT_ATTR macros are defined in many PMU drivers,
like Arm PMU driver, Arm SMMU PMU driver. So add a generic
macro to simplify code.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 include/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f..2d510ad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1576,6 +1576,12 @@ static struct perf_pmu_events_attr _var = {				    \
 	.event_str	= _str,						    \
 };
 
+#define PMU_EVENT_ATTR_ID(_name, _show, _id)				\
+	(&((struct perf_pmu_events_attr[]) {				\
+		{ .attr = __ATTR(_name, 0444, _show, NULL),		\
+		  .id = _id, }						\
+	})[0].attr.attr)
+
 #define PMU_FORMAT_ATTR(_name, _format)					\
 static ssize_t								\
 _name##_show(struct device *dev,					\
-- 
2.7.4

