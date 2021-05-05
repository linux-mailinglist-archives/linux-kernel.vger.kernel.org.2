Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEED37496D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhEEU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhEEU17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A48C061347;
        Wed,  5 May 2021 13:26:59 -0700 (PDT)
Received: from dslb-188-104-057-152.188.104.pools.vodafone-ip.de ([188.104.57.152] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1leO6i-0003aS-6j; Wed, 05 May 2021 22:26:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] staging: rtl8188eu: remove padapter from struct cmd_priv
Date:   Wed,  5 May 2021 22:26:20 +0200
Message-Id: <20210505202622.11087-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505202622.11087-1-martin@kaiser.cx>
References: <20210505202622.11087-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cmd_priv is an element of struct adapter. Use container_of
to get a pointer to the enclosing struct.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c    | 9 +++++----
 drivers/staging/rtl8188eu/include/rtw_cmd.h | 1 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 955899f334e6..64e83684fb81 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -103,11 +103,12 @@ struct cmd_obj *rtw_dequeue_cmd(struct __queue *queue)
 
 static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
+	struct adapter *padapter = container_of(pcmdpriv, struct adapter, cmdpriv);
 	u8 bAllow = false; /* set to true to allow enqueuing cmd when hw_init_completed is false */
 
 	/* To decide allow or not */
-	if ((pcmdpriv->padapter->pwrctrlpriv.bHWPwrPindetect) &&
-	    (!pcmdpriv->padapter->registrypriv.usbss_enable)) {
+	if ((padapter->pwrctrlpriv.bHWPwrPindetect) &&
+	    (!padapter->registrypriv.usbss_enable)) {
 		if (cmd_obj->cmdcode == _Set_Drv_Extra_CMD_) {
 			struct drvextra_cmd_parm	*pdrvextra_cmd_parm = (struct drvextra_cmd_parm	*)cmd_obj->parmbuf;
 
@@ -119,7 +120,7 @@ static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	if (cmd_obj->cmdcode == _SetChannelPlan_CMD_)
 		bAllow = true;
 
-	if ((!pcmdpriv->padapter->hw_init_completed && !bAllow) ||
+	if ((!padapter->hw_init_completed && !bAllow) ||
 	    !pcmdpriv->cmdthd_running)	/* com_thread not running */
 		return _FAIL;
 	return _SUCCESS;
@@ -128,7 +129,7 @@ static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
 	int res = _FAIL;
-	struct adapter *padapter = pcmdpriv->padapter;
+	struct adapter *padapter = container_of(pcmdpriv, struct adapter, cmdpriv);
 
 	if (!cmd_obj)
 		goto exit;
diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/rtl8188eu/include/rtw_cmd.h
index cb0eb4a1d2b7..0261cd931c35 100644
--- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
+++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
@@ -35,7 +35,6 @@ struct cmd_priv {
 	struct completion terminate_cmdthread_comp;
 	struct __queue cmd_queue;
 	u8 cmdthd_running;
-	struct adapter *padapter;
 };
 
 #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 193895338cf0..5207cb0c60cd 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -423,8 +423,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	rtw_init_cmd_priv(&padapter->cmdpriv);
 
-	padapter->cmdpriv.padapter = padapter;
-
 	if (rtw_init_mlme_priv(padapter) == _FAIL) {
 		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_priv\n"));
 		ret8 = _FAIL;
-- 
2.20.1

