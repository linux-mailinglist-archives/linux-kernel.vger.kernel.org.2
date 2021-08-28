Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524B43FA4A0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhH1JDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:03:35 -0400
Received: from mx20.baidu.com ([111.202.115.85]:58942 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233446AbhH1JDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:03:34 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id ECCCDDC310992669262B;
        Sat, 28 Aug 2021 17:02:42 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 28 Aug 2021 17:02:42 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.18) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 28 Aug 2021 17:02:42 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] driver core: platform: Make use of the helper macro SET_RUNTIME_PM_OPS()
Date:   Sat, 28 Aug 2021 17:02:19 +0800
Message-ID: <20210828090219.1177-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.18]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
operators ".runtime_suspend/.runtime_resume", because the
SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
in to make code a little clearer, a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/base/platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135..598acf93a360 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1466,8 +1466,7 @@ int platform_dma_configure(struct device *dev)
 }
 
 static const struct dev_pm_ops platform_dev_pm_ops = {
-	.runtime_suspend = pm_generic_runtime_suspend,
-	.runtime_resume = pm_generic_runtime_resume,
+	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
 	USE_PLATFORM_PM_SLEEP_OPS
 };
 
-- 
2.25.1

