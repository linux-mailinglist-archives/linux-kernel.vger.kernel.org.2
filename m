Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927DB379F83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEKGGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:06:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2770 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhEKGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:06:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfS4T1w2mzmg2v;
        Tue, 11 May 2021 14:02:17 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:05:30 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <bgolaszewski@baylibre.com>, <nsekhar@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] bus: da8xx-mstpri: add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 14:22:30 +0800
Message-ID: <1620714150-106682-1-git-send-email-zou_wei@huawei.com>
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
 drivers/bus/da8xx-mstpri.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index ee4c023..ff158a1 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -249,6 +249,7 @@ static const struct of_device_id da8xx_mstpri_of_match[] = {
 	{ .compatible = "ti,da850-mstpri", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, da8xx_mstpri_of_match);
 
 static struct platform_driver da8xx_mstpri_driver = {
 	.probe = da8xx_mstpri_probe,
-- 
2.6.2

