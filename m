Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65B03822A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhEQCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 22:00:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3702 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhEQB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:59:58 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fk2KT6xQjz16R5W;
        Mon, 17 May 2021 09:55:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 09:58:41 +0800
Received: from huawei.com (10.175.112.208) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 09:58:41 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <sjakhade@cadence.com>,
        <p.zabel@pengutronix.de>, <wangwensheng4@huawei.com>,
        <rikard.falkeborn@gmail.com>, <sparmar@cadence.com>,
        <chunfeng.yun@mediatek.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] phy: cadence: Sierra: Fix error return code in cdns_sierra_phy_probe()
Date:   Mon, 17 May 2021 01:57:49 +0000
Message-ID: <20210517015749.127799-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: a43f72ae136a ("phy: cadence: Sierra: Change MAX_LANES of Sierra to 16")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 5c68e31..e93818e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -940,6 +940,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	sp->nsubnodes = node;
 
 	if (sp->num_lanes > SIERRA_MAX_LANES) {
+		ret = -EINVAL;
 		dev_err(dev, "Invalid lane configuration\n");
 		goto put_child2;
 	}
-- 
2.9.4

