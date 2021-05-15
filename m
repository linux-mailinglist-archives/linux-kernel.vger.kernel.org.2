Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9017E3815A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 06:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhEOEDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 00:03:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2663 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhEOEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 00:03:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fhs8K11wnzPxZt;
        Sat, 15 May 2021 11:58:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 12:02:15 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Naga Sureshkumar Relli" <naga.sureshkumar.relli@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] memory: pl353: Fix error return code in pl353_smc_probe()
Date:   Sat, 15 May 2021 12:00:04 +0800
Message-ID: <20210515040004.6983-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no child nodes are matched, an appropriate error code -ENODEV should
be returned. However, we currently do not explicitly assign this error
code to 'err'. As a result, 0 was incorrectly returned.

Fixes: fee10bd22678 ("memory: pl353: Add driver for arm pl353 static memory controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/memory/pl353-smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 9c0a2841677739f..b0b251bb207f3a6 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -407,6 +407,7 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 		break;
 	}
 	if (!match) {
+		err = -ENODEV;
 		dev_err(&adev->dev, "no matching children\n");
 		goto out_clk_disable;
 	}
-- 
2.26.0.106.g9fadedd


