Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BC33ED49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCQJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:44:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13181 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCQJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:44:21 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0lYH6rCXzmYfS;
        Wed, 17 Mar 2021 17:41:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:44:13 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH 2/3] drivers/perf: convert sysfs scnprintf family to sysfs_emit_at
Date:   Wed, 17 Mar 2021 17:41:50 +0800
Message-ID: <1615974111-45601-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
References: <1615974111-45601-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic sysfs_emit_at() function take place of scnprintf()

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm-ccn.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 3a2ddc0..0588f29 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -328,41 +328,37 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
 			struct arm_ccn_pmu_event, attr);
 	ssize_t res;
 
-	res = scnprintf(buf, PAGE_SIZE, "type=0x%x", event->type);
+	res = sysfs_emit(buf, "type=0x%x", event->type);
 	if (event->event)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",event=0x%x",
+		res += sysfs_emit_at(buf + res, res, ",event=0x%x",
 				event->event);
 	if (event->def)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",%s",
-				event->def);
+		res += sysfs_emit_at(buf + res, res, ",%s", event->def);
 	if (event->mask)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",mask=0x%x",
-				event->mask);
+		res += sysfs_emit_at(buf + res, res, ",mask=0x%x", event->mask);
 
 	/* Arguments required by an event */
 	switch (event->type) {
 	case CCN_TYPE_CYCLES:
 		break;
 	case CCN_TYPE_XP:
-		res += scnprintf(buf + res, PAGE_SIZE - res,
-				",xp=?,vc=?");
+		res += sysfs_emit(buf + res, res, ",xp=?,vc=?");
 		if (event->event == CCN_EVENT_WATCHPOINT)
-			res += scnprintf(buf + res, PAGE_SIZE - res,
+			res += sysfs_emit_at(buf + res, res,
 					",port=?,dir=?,cmp_l=?,cmp_h=?,mask=?");
 		else
-			res += scnprintf(buf + res, PAGE_SIZE - res,
-					",bus=?");
+			res += sysfs_emit_at(buf + res, res, ",bus=?");
 
 		break;
 	case CCN_TYPE_MN:
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",node=%d", ccn->mn_id);
+		res += sysfs_emit_at(buf + res, res, ",node=%d", ccn->mn_id);
 		break;
 	default:
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",node=?");
+		res += sysfs_emit_at(buf + res, res, ",node=?");
 		break;
 	}
 
-	res += scnprintf(buf + res, PAGE_SIZE - res, "\n");
+	res += sysfs_emit_at(buf + res, res, "\n");
 
 	return res;
 }
-- 
2.8.1

