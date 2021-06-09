Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C23A16A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhFIOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:08:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3926 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbhFIOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:08:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0TNd4cbLz6wVG;
        Wed,  9 Jun 2021 22:03:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:06:49 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:06:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] irqchip/gic-v3-its: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 22:06:42 +0800
Message-ID: <20210609140643.14531-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2e6923c2c8a8cb3..ba39668c3e08516 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4895,10 +4895,8 @@ static int its_init_vpe_domain(void)
 	entries = roundup_pow_of_two(nr_cpu_ids);
 	vpe_proxy.vpes = kcalloc(entries, sizeof(*vpe_proxy.vpes),
 				 GFP_KERNEL);
-	if (!vpe_proxy.vpes) {
-		pr_err("ITS: Can't allocate GICv4 proxy device array\n");
+	if (!vpe_proxy.vpes)
 		return -ENOMEM;
-	}
 
 	/* Use the last possible DevID */
 	devid = GENMASK(device_ids(its) - 1, 0);
@@ -5314,10 +5312,8 @@ static void __init acpi_table_parse_srat_its(void)
 
 	its_srat_maps = kmalloc_array(count, sizeof(struct its_srat_map),
 				      GFP_KERNEL);
-	if (!its_srat_maps) {
-		pr_warn("SRAT: Failed to allocate memory for its_srat_maps!\n");
+	if (!its_srat_maps)
 		return;
-	}
 
 	acpi_table_parse_entries(ACPI_SIG_SRAT,
 			sizeof(struct acpi_table_srat),
-- 
2.26.0.106.g9fadedd


