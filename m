Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6204325E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBZHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:11:46 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:33328 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBZHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:11:43 -0500
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id D7ABFB8A0C;
        Fri, 26 Feb 2021 15:09:03 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.207.172.18])
        by smtp.263.net (postfix) whith ESMTP id P17142T139833422886656S1614323343116917_;
        Fri, 26 Feb 2021 15:09:03 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e0f81c66d06411a6bdd42be156fabfd1>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: paulmck@kernel.org
X-SENDER-IP: 111.207.172.18
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   wangjingyu <wangjingyu@uniontech.com>
To:     paulmck@kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, elver@google.com,
        peterz@infradead.org, rppt@kernel.org, samitolvanen@google.com,
        axboe@kernel.dk, a.darwish@linutronix.de,
        linux-kernel@vger.kernel.org, wangjingyu <wangjingyu@uniontech.com>
Subject: [PATCH] init/init_task.c spaces required around that '='
Date:   Fri, 26 Feb 2021 15:09:00 +0800
Message-Id: <20210226070900.17730-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure checkpatch compliance

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
---
 init/init_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/init_task.c b/init/init_task.c
index 15f6eb93a04f..0f995118c6c0 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -81,7 +81,7 @@ struct task_struct init_task
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
-	.nr_cpus_allowed= NR_CPUS,
+	.nr_cpus_allowed = NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
-- 
2.11.0



