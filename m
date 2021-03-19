Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721D7341984
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCSKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:07:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhCSKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:07:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1zyZ3pKjzmZZY;
        Fri, 19 Mar 2021 18:04:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 18:06:57 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH v2 2/3] drivers/perf: convert sysfs scnprintf family to sysfs_emit_at() and sysfs_emit()
Date:   Fri, 19 Mar 2021 18:04:32 +0800
Message-ID: <1616148273-16374-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
References: <1616148273-16374-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic sysfs_emit_at() and sysfs_emit() function to take place
of scnprintf()

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm-ccn.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 3a2ddc0..96d47cb 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -326,43 +326,38 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
 	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
 	struct arm_ccn_pmu_event *event = container_of(attr,
 			struct arm_ccn_pmu_event, attr);
-	ssize_t res;
+	int res;
 
-	res = scnprintf(buf, PAGE_SIZE, "type=0x%x", event->type);
+	res = sysfs_emit(buf, "type=0x%x", event->type);
 	if (event->event)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",event=0x%x",
-				event->event);
+		res += sysfs_emit_at(buf, res, ",event=0x%x", event->event);
 	if (event->def)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",%s",
-				event->def);
+		res += sysfs_emit_at(buf, res, ",%s", event->def);
 	if (event->mask)
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",mask=0x%x",
-				event->mask);
+		res += sysfs_emit_at(buf, res, ",mask=0x%x", event->mask);
 
 	/* Arguments required by an event */
 	switch (event->type) {
 	case CCN_TYPE_CYCLES:
 		break;
 	case CCN_TYPE_XP:
-		res += scnprintf(buf + res, PAGE_SIZE - res,
-				",xp=?,vc=?");
+		res += sysfs_emit_at(buf, res, ",xp=?,vc=?");
 		if (event->event == CCN_EVENT_WATCHPOINT)
-			res += scnprintf(buf + res, PAGE_SIZE - res,
+			res += sysfs_emit_at(buf, res,
 					",port=?,dir=?,cmp_l=?,cmp_h=?,mask=?");
 		else
-			res += scnprintf(buf + res, PAGE_SIZE - res,
-					",bus=?");
+			res += sysfs_emit_at(buf, res, ",bus=?");
 
 		break;
 	case CCN_TYPE_MN:
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",node=%d", ccn->mn_id);
+		res += sysfs_emit_at(buf, res, ",node=%d", ccn->mn_id);
 		break;
 	default:
-		res += scnprintf(buf + res, PAGE_SIZE - res, ",node=?");
+		res += sysfs_emit_at(buf, res, ",node=?");
 		break;
 	}
 
-	res += scnprintf(buf + res, PAGE_SIZE - res, "\n");
+	res += sysfs_emit_at(buf, res, "\n");
 
 	return res;
 }
-- 
2.8.1

