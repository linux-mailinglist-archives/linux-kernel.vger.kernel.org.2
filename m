Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878813FA49B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhH1JB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:01:28 -0400
Received: from mx20.baidu.com ([111.202.115.85]:57088 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233446AbhH1JB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:01:27 -0400
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id 3333A810093D2B3B40A7;
        Sat, 28 Aug 2021 17:00:36 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 28 Aug 2021 17:00:36 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.11) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 28 Aug 2021 17:00:35 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <linux@dominikbrodowski.net>
CC:     <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] pcmcia: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date:   Sat, 28 Aug 2021 17:00:11 +0800
Message-ID: <20210828090011.635-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.11]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() instead of
the verbose operators ".suspend_noirq /.resume_noirq/.freeze_noirq/
.thaw_noirq/.poweroff_noirq/.restore_noirq", because the
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() is a nice helper macro that could
be brought in to make code a little clearer, a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/pcmcia/yenta_socket.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 84bfc0e85d6b..e472da29d401 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1342,12 +1342,7 @@ static int yenta_dev_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops yenta_pm_ops = {
-	.suspend_noirq = yenta_dev_suspend_noirq,
-	.resume_noirq = yenta_dev_resume_noirq,
-	.freeze_noirq = yenta_dev_suspend_noirq,
-	.thaw_noirq = yenta_dev_resume_noirq,
-	.poweroff_noirq = yenta_dev_suspend_noirq,
-	.restore_noirq = yenta_dev_resume_noirq,
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(yenta_dev_suspend_noirq, yenta_dev_resume_noirq)
 };
 
 #define YENTA_PM_OPS	(&yenta_pm_ops)
-- 
2.25.1

