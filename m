Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04679435D22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhJUIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:44:38 -0400
Received: from mx22.baidu.com ([220.181.50.185]:45948 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231509AbhJUIod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:44:33 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 5AC8D6F1DBA1CD40859A;
        Thu, 21 Oct 2021 16:42:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 21 Oct 2021 16:42:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 21 Oct 2021 16:42:15 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] parisc: Make use of the helper macro kthread_run()
Date:   Thu, 21 Oct 2021 16:42:13 +0800
Message-ID: <20211021084214.2289-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 arch/parisc/kernel/pdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index fcc761b0e11b..e391b175f5ec 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -352,12 +352,10 @@ static int __init pdt_initcall(void)
 	if (pdt_type == PDT_NONE)
 		return -ENODEV;
 
-	kpdtd_task = kthread_create(pdt_mainloop, NULL, "kpdtd");
+	kpdtd_task = kthread_run(pdt_mainloop, NULL, "kpdtd");
 	if (IS_ERR(kpdtd_task))
 		return PTR_ERR(kpdtd_task);
 
-	wake_up_process(kpdtd_task);
-
 	return 0;
 }
 
-- 
2.25.1

