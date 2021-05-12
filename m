Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313C337B44D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELCwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:52:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2563 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:52:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FfzkR6181zwScW;
        Wed, 12 May 2021 10:48:31 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 10:51:05 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <krzysztof.kozlowski@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] memory: da8xx-ddrctl: add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 11:08:07 +0800
Message-ID: <1620788887-14812-1-git-send-email-zou_wei@huawei.com>
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
 drivers/memory/da8xx-ddrctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index 872addd..7a51932 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -153,6 +153,7 @@ static const struct of_device_id da8xx_ddrctl_of_match[] = {
 	{ .compatible = "ti,da850-ddr-controller", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, da8xx_ddrctl_of_match);
 
 static struct platform_driver da8xx_ddrctl_driver = {
 	.probe = da8xx_ddrctl_probe,
-- 
2.6.2

