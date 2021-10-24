Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E5438B34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhJXSH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJXSHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:07:25 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D105EC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:05:04 -0700 (PDT)
Received: from dslb-178-004-201-201.178.004.pools.vodafone-ip.de ([178.4.201.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mehrg-00049p-Fe; Sun, 24 Oct 2021 20:05:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/5] staging: r8188eu: silent_reset_inprogress is never read
Date:   Sun, 24 Oct 2021 20:04:44 +0200
Message-Id: <20211024180448.20624-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211024180448.20624-1-martin@kaiser.cx>
References: <20211024180448.20624-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

silent_reset_inprogress in struct sreset_priv is only written
but never read. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sreset.c    | 2 --
 drivers/staging/r8188eu/include/rtw_sreset.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index baa2a080a46e..60596a3a3aad 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -9,7 +9,6 @@ void sreset_init_value(struct adapter *padapter)
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
 	mutex_init(&psrtpriv->silentreset_mutex);
-	psrtpriv->silent_reset_inprogress = false;
 	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 	psrtpriv->last_tx_time = 0;
 	psrtpriv->last_tx_complete_time = 0;
@@ -19,7 +18,6 @@ void sreset_reset_value(struct adapter *padapter)
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
-	psrtpriv->silent_reset_inprogress = false;
 	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 	psrtpriv->last_tx_time = 0;
 	psrtpriv->last_tx_complete_time = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 45bc227d088a..2489f55d0594 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -9,7 +9,6 @@
 
 struct sreset_priv {
 	struct mutex	silentreset_mutex;
-	u8	silent_reset_inprogress;
 	u8	wifi_error_status;
 	unsigned long last_tx_time;
 	unsigned long last_tx_complete_time;
-- 
2.20.1

