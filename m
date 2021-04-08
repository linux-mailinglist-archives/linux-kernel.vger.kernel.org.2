Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E263358DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhDHT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhDHT5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F50EC061760;
        Thu,  8 Apr 2021 12:57:04 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUalw-0005PV-78; Thu, 08 Apr 2021 21:57:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/12] staging: rtl8188eu: always free cmd_obj in the cmd thread
Date:   Thu,  8 Apr 2021 21:55:58 +0200
Message-Id: <20210408195601.4762-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8188 driver starts a command thread that reads commands from a queue
and processes them. Each command consists of a struct cmd_obj. The command
thread may call a function to process the current command and optionally a
post-processing function. Eventually, the command's cmd_obj must be freed.

At the moment, if there's a post-processing function for the current
command, this function has to free the cmd_obj. If there's no
post-processing function, the command thread frees cmd_obj.

It's much simpler if we always leave it to the command thread to free
cmd_obj.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 0bbe5ee918ce..4e4cac1ad6be 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -235,17 +235,16 @@ int rtw_cmd_thread(void *context)
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
 					 ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n",
 					  pcmd_callback, pcmd->cmdcode));
-				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
-				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
+				pcmd_callback(pcmd->padapter, pcmd);
 			}
 		} else {
 			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
 				 ("%s: cmdcode = 0x%x callback not defined!\n",
 				  __func__, pcmd->cmdcode));
-			rtw_free_cmd_obj(pcmd);
 		}
+		rtw_free_cmd_obj(pcmd);
 
 		if (signal_pending(current))
 			flush_signals(current);
@@ -1186,9 +1185,6 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
 			 ("\n ********Error: MgntActrtw_set_802_11_bssid_LIST_SCAN Fail ************\n\n."));
 	}
-
-	/*  free cmd */
-	rtw_free_cmd_obj(pcmd);
 }
 
 void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
@@ -1202,11 +1198,7 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
 			 ("\n ***Error: disconnect_cmd_callback Fail ***\n."));
-		return;
 	}
-
-	/*  free cmd */
-	rtw_free_cmd_obj(pcmd);
 }
 
 void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
@@ -1224,8 +1216,6 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 		mod_timer(&pmlmepriv->assoc_timer,
 			  jiffies + msecs_to_jiffies(1));
 	}
-
-	rtw_free_cmd_obj(pcmd);
 }
 
 void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
@@ -1292,8 +1282,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 createbss_cmd_fail:
 
 	spin_unlock_bh(&pmlmepriv->lock);
-
-	rtw_free_cmd_obj(pcmd);
 }
 
 void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
@@ -1305,10 +1293,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	if (!psta) {
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
 			 ("\nERROR: %s => can't get sta_info\n\n", __func__));
-		goto exit;
 	}
-exit:
-	rtw_free_cmd_obj(pcmd);
 }
 
 void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
@@ -1322,7 +1307,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	if (!psta) {
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
 			 ("\nERROR: %s => can't get sta_info\n\n", __func__));
-		goto exit;
+		return;
 	}
 
 	psta->aid = passocsta_rsp->cam_id;
@@ -1332,7 +1317,4 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 
 	set_fwstate(pmlmepriv, _FW_LINKED);
 	spin_unlock_bh(&pmlmepriv->lock);
-
-exit:
-	rtw_free_cmd_obj(pcmd);
 }
-- 
2.20.1

