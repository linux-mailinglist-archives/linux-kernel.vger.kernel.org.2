Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA7358DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDHT51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbhDHT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:20 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531AC061762;
        Thu,  8 Apr 2021 12:57:09 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUam1-0005PV-0O; Thu, 08 Apr 2021 21:57:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/12] staging: rtl8188eu: simplify rtw_cmd_thread's main loop
Date:   Thu,  8 Apr 2021 21:56:01 +0200
Message-Id: <20210408195601.4762-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtw_cmd_thread's main loop, we wait until there's a command in the
queue. To skip this wait statement in subsequent iterations, the driver
uses a label and goto instead of the actual loop. We only get back to the
initial wait if the queue is empty when we read it.

Basically, all we want to do is check if there's a command in the queue.
If yes, we process it. If not, we wait until someone enqueues a command.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 9d358dce5296..6728391d39e3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -188,10 +188,6 @@ int rtw_cmd_thread(void *context)
 		 ("start r871x %s !!!!\n", __func__));
 
 	while (1) {
-		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp))
-			break;
-
-_next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
 			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
@@ -201,8 +197,13 @@ int rtw_cmd_thread(void *context)
 		}
 
 		pcmd = rtw_dequeue_cmd(&pcmdpriv->cmd_queue);
-		if (!pcmd)
+		if (!pcmd) {
+			/* The queue is empty. Wait until someone enqueues a command. */
+			if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp))
+				break;
+
 			continue;
+		}
 
 		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
 			pcmd->res = H2C_DROPPED;
@@ -239,8 +240,6 @@ int rtw_cmd_thread(void *context)
 
 		if (signal_pending(current))
 			flush_signals(current);
-
-		goto _next;
 	}
 	pcmdpriv->cmdthd_running = false;
 
-- 
2.20.1

