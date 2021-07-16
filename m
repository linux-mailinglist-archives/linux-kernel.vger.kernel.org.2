Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23F53CBA26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbhGPP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:56:41 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50159 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhGPP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:56:31 -0400
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 036923C057F;
        Fri, 16 Jul 2021 17:45:55 +0200 (CEST)
Received: from lxhi-059.adit-jv.com (10.72.93.144) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 16 Jul
 2021 17:45:54 +0200
From:   Christoph Gellner <cgellner@de.adit-jv.com>
To:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     <jens.wiklander@linaro.org>,
        Christoph Gellner <cgellner@de.adit-jv.com>
Subject: [PATCH 3/3] tee: optee: Allow to freeze while waiting in OPTEE_RPC_WAIT_QUEUE_SLEEP
Date:   Fri, 16 Jul 2021 17:45:00 +0200
Message-ID: <20210716154500.10115-4-cgellner@de.adit-jv.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210716154500.10115-1-cgellner@de.adit-jv.com>
References: <20210716154500.10115-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.144]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is going to hibernate or suspend and the task calling
the corresponding OPTEE_RPC_WAIT_QUEUE_WAKEUP gets frozen waiting
for completion in OPTEE_RPC_WAIT_QUEUE_SLEEP might get stuck.

Change wait to interruptible and add try_to_freeze in order to
allow that the waiting task is frozen as well.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/rpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..0851b19be529 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "optee_rpc_cmd.h"
@@ -169,7 +170,13 @@ static void wq_sleep(struct optee_wait_queue *wq, u32 key)
 	struct wq_entry *w = wq_entry_get(wq, key);
 
 	if (w) {
-		wait_for_completion(&w->c);
+		/*
+		 * wait_for_completion but allow hibernation/suspend
+		 * to freeze the waiting task
+		 */
+		while (wait_for_completion_interruptible(&w->c))
+			try_to_freeze();
+
 		mutex_lock(&wq->mu);
 		list_del(&w->link);
 		mutex_unlock(&wq->mu);
-- 
2.32.0.rc0

