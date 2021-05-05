Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA7374966
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhEEU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhEEU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5CFC06174A;
        Wed,  5 May 2021 13:26:44 -0700 (PDT)
Received: from dslb-188-104-057-152.188.104.pools.vodafone-ip.de ([188.104.57.152] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1leO6R-0003aS-Lq; Wed, 05 May 2021 22:26:39 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/6] staging: rtl8188eu: rtw_init_cmd_priv never fails
Date:   Wed,  5 May 2021 22:26:18 +0200
Message-Id: <20210505202622.11087-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505202622.11087-1-martin@kaiser.cx>
References: <20210505202622.11087-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return type to void. Remove unnecessary error handling.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c    | 3 +--
 drivers/staging/rtl8188eu/include/rtw_cmd.h | 2 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 6 +-----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 6728391d39e3..61d0342c76fc 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -52,13 +52,12 @@ static struct _cmd_callback rtw_cmd_callback[] = {
  * No irqsave is necessary.
  */
 
-int rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
+void rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
 	_rtw_init_queue(&pcmdpriv->cmd_queue);
-	return _SUCCESS;
 }
 
 /*
diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/rtl8188eu/include/rtw_cmd.h
index 68b8ad1a412f..cb0eb4a1d2b7 100644
--- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
+++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
@@ -54,7 +54,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd);
 
 int rtw_cmd_thread(void *context);
 
-int rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
+void rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
 
 enum rtw_drvextra_cmd_id {
 	NONE_WK_CID,
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index a826228cbbe9..55ed721994a0 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -424,11 +424,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+%s\n", __func__));
 
-	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init cmd_priv\n"));
-		ret8 = _FAIL;
-		goto exit;
-	}
+	rtw_init_cmd_priv(&padapter->cmdpriv);
 
 	padapter->cmdpriv.padapter = padapter;
 
-- 
2.20.1

