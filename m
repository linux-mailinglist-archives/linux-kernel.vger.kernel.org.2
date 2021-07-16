Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201873CBA24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhGPP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:56:36 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50158 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbhGPP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:56:31 -0400
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3EA2F3C057C;
        Fri, 16 Jul 2021 17:45:53 +0200 (CEST)
Received: from lxhi-059.adit-jv.com (10.72.93.144) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 16 Jul
 2021 17:45:53 +0200
From:   Christoph Gellner <cgellner@de.adit-jv.com>
To:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     <jens.wiklander@linaro.org>,
        Christoph Gellner <cgellner@de.adit-jv.com>
Subject: [PATCH 2/3] tee: optee: Allow to freeze while waiting for call_queue
Date:   Fri, 16 Jul 2021 17:44:59 +0200
Message-ID: <20210716154500.10115-3-cgellner@de.adit-jv.com>
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

When the system is going to hibernate or suspend and the tasks of
the other entries in the call queue are frozen wait_for_completion
on the call_queue might get stuck.

Change wait to interruptible and add try_to_freeze in order to
allow that the waiting task is frozen as well.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/call.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..916cfa11cce2 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -12,6 +12,7 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #define CREATE_TRACE_POINTS
@@ -50,7 +51,12 @@ static void optee_cq_wait_init(struct optee_call_queue *cq,
 static void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 					 struct optee_call_waiter *w)
 {
-	wait_for_completion(&w->c);
+	/*
+	 * wait_for_completion but allow hibernation/suspend
+	 * to freeze the waiting task
+	 */
+	while (wait_for_completion_interruptible(&w->c))
+		try_to_freeze();
 
 	mutex_lock(&cq->mutex);
 
-- 
2.32.0.rc0

