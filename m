Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D57358DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhDHT5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhDHT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87097C061760;
        Thu,  8 Apr 2021 12:57:05 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUalx-0005PV-Iq; Thu, 08 Apr 2021 21:57:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/12] staging: rtl8188eu: remove duplicate if statement
Date:   Thu,  8 Apr 2021 21:55:59 +0200
Message-Id: <20210408195601.4762-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's two identical checks if the device was stopped or unplugged.
Remove one of them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 4e4cac1ad6be..e1bf4ce9ab9d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -191,13 +191,6 @@ int rtw_cmd_thread(void *context)
 		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp))
 			break;
 
-		if (padapter->bDriverStopped ||
-		    padapter->bSurpriseRemoved) {
-			DBG_88E("%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
-				__func__, padapter->bDriverStopped,
-				padapter->bSurpriseRemoved, __LINE__);
-			break;
-		}
 _next:
 		if (padapter->bDriverStopped ||
 		    padapter->bSurpriseRemoved) {
-- 
2.20.1

