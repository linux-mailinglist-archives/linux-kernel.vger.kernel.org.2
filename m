Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5792231E749
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBRIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:08:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12617 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhBRHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:13:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dh5TM56VGz168gn;
        Thu, 18 Feb 2021 15:10:47 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 15:12:09 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <matthias.bgg@gmail.com>
CC:     <ck.hu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] soc / drm: mediatek: Mark mtk_mutex_driver with static keyword
Date:   Thu, 18 Feb 2021 15:28:19 +0800
Message-ID: <1613633299-88332-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/soc/mediatek/mtk-mutex.c:464:24: warning: symbol 'mtk_mutex_driver' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index f531b11..3a315a6 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -461,7 +461,7 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
 
-struct platform_driver mtk_mutex_driver = {
+static struct platform_driver mtk_mutex_driver = {
 	.probe		= mtk_mutex_probe,
 	.remove		= mtk_mutex_remove,
 	.driver		= {
-- 
2.6.2

