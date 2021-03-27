Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0ED34B73A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhC0Mgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:36:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14937 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0Mge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:36:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6yw7430dzkg2b;
        Sat, 27 Mar 2021 20:34:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 20:36:20 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH 1/2] soc/tegra: fuse: Fix build with Tegra234 configuration
Date:   Sat, 27 Mar 2021 20:37:56 +0800
Message-ID: <20210327123757.4568-2-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210327123757.4568-1-xiexiuqi@huawei.com>
References: <20210327123757.4568-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only Tegra234 support is enabled, the tegra30_fuse_read() and
tegra30_fuse_init() function are not declared and cause a build failure.
Add Tegra234 to the preprocessor guard to make sure these functions are
available for Tegra234-only builds as well.

Fixes: 1f44febf71ba ("soc/tegra: fuse: Add Tegra234 support")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 9ea7f0168457..c1aa7815bd6e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -37,7 +37,8 @@
     defined(CONFIG_ARCH_TEGRA_132_SOC) || \
     defined(CONFIG_ARCH_TEGRA_210_SOC) || \
     defined(CONFIG_ARCH_TEGRA_186_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_194_SOC)
+    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
 static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)
 {
 	if (WARN_ON(!fuse->base))
-- 
2.25.1

