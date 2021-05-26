Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22139114D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhEZHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:19:43 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:39655 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhEZHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:19:23 -0400
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 275433C04C1;
        Wed, 26 May 2021 09:11:01 +0200 (CEST)
Received: from lxhi-059.adit-jv.com (10.72.93.144) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 26 May
 2021 09:11:00 +0200
From:   Christoph Gellner <cgellner@de.adit-jv.com>
To:     <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
CC:     <jens.wiklander@linaro.org>,
        Christoph Gellner <cgellner@de.adit-jv.com>
Subject: [RFC PATCH 1/3] tee: optee: Allow to freeze the task waiting for tee-supplicant
Date:   Wed, 26 May 2021 09:09:09 +0200
Message-ID: <20210526070911.31681-2-cgellner@de.adit-jv.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210526070911.31681-1-cgellner@de.adit-jv.com>
References: <20210526070911.31681-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.144]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is going to hibernate or suspend it might happen
that the tee-supplicant task is frozen first.
wait_for_completion_interruptible might get stuck in this case.

Add try_to_freeze to allow the waiting task to be frozen while
waiting for the response of tee-supplicant.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/supp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..03c37bae6ac4 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
 
 struct optee_supp_req {
@@ -141,6 +142,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			req->ret = TEEC_ERROR_COMMUNICATION;
 			break;
 		}
+
+		try_to_freeze();
 	}
 
 	ret = req->ret;
-- 
2.32.0.rc0

