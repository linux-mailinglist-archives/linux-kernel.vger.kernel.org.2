Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA337B4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhELDpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:45:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2565 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELDpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:45:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg0w41TrSzwSQk;
        Wed, 12 May 2021 11:41:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:44:28 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <linux@armlinux.org.uk>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <gustavoars@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ARM: tegra: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 12:01:29 +0800
Message-ID: <1620792089-16319-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/amba/tegra-ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 0b2c20f..a0af8ed 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -272,6 +272,7 @@ static const struct of_device_id tegra_ahb_of_match[] = {
 	{ .compatible = "nvidia,tegra20-ahb", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tegra_ahb_of_match);
 
 static struct platform_driver tegra_ahb_driver = {
 	.probe = tegra_ahb_probe,
-- 
2.6.2

