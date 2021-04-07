Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F48356C93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352413AbhDGMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:50:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15158 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352394AbhDGMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:49:58 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFkgB672lzpVNC;
        Wed,  7 Apr 2021 20:47:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 20:49:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] macintosh/via-pmu: Make some symbols static
Date:   Wed, 7 Apr 2021 20:58:03 +0800
Message-ID: <20210407125803.4138837-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/macintosh/via-pmu.c:183:5: warning:
 symbol 'pmu_cur_battery' was not declared. Should it be static?
drivers/macintosh/via-pmu.c:190:5: warning:
 symbol '__fake_sleep' was not declared. Should it be static?

These symbols are not used outside of via-pmu.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/macintosh/via-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 73e6ae88fafd..478766434919 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -180,14 +180,14 @@ static struct proc_dir_entry *proc_pmu_options;
 static int option_server_mode;
 
 int pmu_battery_count;
-int pmu_cur_battery;
+static int pmu_cur_battery;
 unsigned int pmu_power_flags = PMU_PWR_AC_PRESENT;
 struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
 
-int __fake_sleep;
+static int __fake_sleep;
 int asleep;
 
 #ifdef CONFIG_ADB
-- 
2.25.4

