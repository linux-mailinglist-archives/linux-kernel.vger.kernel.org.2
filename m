Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3403539ED20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFHDgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:36:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3464 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFHDgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:36:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzbPM16Mkz6wl3;
        Tue,  8 Jun 2021 11:31:19 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:42 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:33:42 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 8/9] drivers/perf: Simpilfy EVENT ATTR macro in arm_dsu_pmu.c
Date:   Tue, 8 Jun 2021 11:33:20 +0800
Message-ID: <1623123201-45634-9-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
References: <1623123201-45634-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common macro PMU_EVENT_ATTR_ID to simplify DSU_EVENT_ATTR.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_dsu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 196faea..bed8376 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -82,7 +82,7 @@
 	})[0].attr.attr)
 
 #define DSU_EVENT_ATTR(_name, _config)		\
-	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
+	PMU_EVENT_ATTR_ID(_name, dsu_pmu_sysfs_event_show, _config)
 
 #define DSU_FORMAT_ATTR(_name, _config)		\
 	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)
-- 
2.7.4

