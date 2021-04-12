Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6262B35C81A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhDLOC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:02:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16449 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhDLOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:02:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJr2m2kfqzwRv8;
        Mon, 12 Apr 2021 21:59:44 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 22:01:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>
Subject: [PATCH -next] soc/tegra: fuse: don't return -ENOMEM when allocate lookups failed
Date:   Mon, 12 Apr 2021 22:05:27 +0800
Message-ID: <20210412140527.4142735-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fuse->base can not be unmapped if allocate lookups failed in
tegra_init_fuse(), because it is an early_initcall, the driver
will be loaded anyway and fuse->base will be accessed by other
functions later, so remove the return -ENOMEM after allocating
lookups failed to make less confusing.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 94b60a692b51..a0def1219501 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -490,9 +490,15 @@ static int __init tegra_init_fuse(void)
 
 		fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
 		if (!fuse->lookups)
-			return -ENOMEM;
-
-		nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
+			/*
+			 * fuse->base can not be unmapped if allocate lookups failed,
+			 * because it will be accessed by other functions later.
+			 * To make less confusing, remove the return -ENOMEM and
+			 * skip registering the nvmem cell lookups.
+			 */
+			pr_err("failed to allocate lookups");
+		else
+			nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
 	}
 
 	return 0;
-- 
2.25.1

