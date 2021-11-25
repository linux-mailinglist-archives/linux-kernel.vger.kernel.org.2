Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5057345DEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhKYQuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhKYQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:48:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2BC061759
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:25:31 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHYu-0006jj-8L; Thu, 25 Nov 2021 17:25:28 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: remove the _set_workitem wrapper
Date:   Thu, 25 Nov 2021 17:25:10 +0100
Message-Id: <20211125162513.25039-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125162513.25039-1-martin@kaiser.cx>
References: <20211125162513.25039-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the _set_workitem wrapper and call schedule_work directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c          | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 0e3453639a8b..d48ed98453f5 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -12,7 +12,7 @@ void BlinkTimerCallback(struct timer_list *t)
 	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
 		return;
 
-	_set_workitem(&pLed->BlinkWorkItem);
+	schedule_work(&pLed->BlinkWorkItem);
 }
 
 void BlinkWorkItemCallback(struct work_struct *work)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index f6f5e4581212..766440461a0c 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -79,11 +79,6 @@ static inline void _init_workitem(struct work_struct *pwork, void *pfunc, void *
 	INIT_WORK(pwork, pfunc);
 }
 
-static inline void _set_workitem(struct work_struct *pwork)
-{
-	schedule_work(pwork);
-}
-
 static inline void _cancel_workitem_sync(struct work_struct *pwork)
 {
 	cancel_work_sync(pwork);
-- 
2.20.1

