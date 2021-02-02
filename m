Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE130B91E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhBBIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:01:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12062 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBBIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:01:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVHJ60VjMzMT4W;
        Tue,  2 Feb 2021 15:58:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 16:00:18 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH] drivers/perf: Prevent forced unbinding of ARM_DMC620_PMU drivers
Date:   Tue, 2 Feb 2021 15:58:06 +0800
Message-ID: <1612252686-50329-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "suppress_bind_attrs" to true, so that bind/unbind can be
disabled via sysfs and prevent unbinding ARM_DMC620_PMU drivers
during perf sampling.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/arm_dmc620_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 27f54c0..66ad5b3 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -717,6 +717,7 @@ static struct platform_driver dmc620_pmu_driver = {
 	.driver	= {
 		.name		= DMC620_DRVNAME,
 		.acpi_match_table = dmc620_acpi_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= dmc620_pmu_device_probe,
 	.remove	= dmc620_pmu_device_remove,
--
2.8.1

