Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462C1382310
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhEQDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:25:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3560 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEQDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:25:46 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fk4DT2T4qzmVhs
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:21:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 11:24:29 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 11:24:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>
Subject: [PATCH -next] reset: lantiq: use devm_reset_controller_register()
Date:   Mon, 17 May 2021 11:26:48 +0800
Message-ID: <20210517032648.2969609-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_reset_controller_register() for the reset controller
registration.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/reset/reset-lantiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
index ac41d093de13..b936cfe85641 100644
--- a/drivers/reset/reset-lantiq.c
+++ b/drivers/reset/reset-lantiq.c
@@ -186,7 +186,7 @@ static int lantiq_rcu_reset_probe(struct platform_device *pdev)
 	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
 	priv->rcdev.of_reset_n_cells = 2;
 
-	return reset_controller_register(&priv->rcdev);
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
 }
 
 static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {
-- 
2.25.1

