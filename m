Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98A316056
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhBJHuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:50:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12905 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhBJHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:49:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DbBgK4RsRzjK0D;
        Wed, 10 Feb 2021 15:47:25 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 15:48:23 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soc: mediatek: Make symbol 'mtk_mutex_driver' static
Date:   Wed, 10 Feb 2021 07:56:56 +0000
Message-ID: <20210210075656.1096251-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/soc/mediatek/mtk-mutex.c:464:24: warning:
 symbol 'mtk_mutex_driver' was not declared. Should it be static?

This symbol is not used outside of mtk-mutex.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index f531b119da7a..3a315a62e783 100644
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

