Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB86437414
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhJVI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:58:24 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:33267 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S232467AbhJVI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:20 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 04:58:20 EDT
Received: from mail.didiglobal.com (unknown [172.20.36.204])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 3C168D81DBC6D;
        Fri, 22 Oct 2021 16:47:57 +0800 (CST)
Received: from localhost (172.22.203.49) by BJSGMBX002.didichuxing.com
 (172.20.15.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2242.4; Fri, 22 Oct
 2021 16:47:57 +0800
X-MD-Sfrom: houweitao@didiglobal.com
X-MD-SrcIP: 172.20.36.204
From:   Weitao Hou <houweitao@didiglobal.com>
To:     <akpm@linux-foundation.org>, <lukas.bulwahn@gmail.com>,
        <sfr@canb.auug.org.au>, <linux@rasmusvillemoes.dk>,
        <peterz@infradead.org>, <penguin-kernel@i-love.sakura.ne.jp>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Weitao Hou <houweitao@didiglobal.com>
Subject: [PATCH] kernel/hung_task.c: add error info when failed to start khungtaskd
Date:   Fri, 22 Oct 2021 16:47:55 +0800
Message-ID: <20211022084755.25215-1-houweitao@didiglobal.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.203.49]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGMBX002.didichuxing.com (172.20.15.14)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we need add necessary error info when core thread started failed

Signed-off-by: Weitao Hou <houweitao@didiglobal.com>
---
 kernel/hung_task.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8cc07e7f29aa..8a95997a693e 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -354,6 +354,10 @@ static int __init hung_task_init(void)
 	pm_notifier(hungtask_pm_notify, 0);
 
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
+	if (IS_ERR(watchdog_task)) {
+		pr_err("Failed to start khungtaskd\n");
+		watchdog_task = NULL;
+	}
 
 	return 0;
 }
-- 
2.17.1

