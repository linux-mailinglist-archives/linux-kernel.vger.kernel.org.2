Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAFB358DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhDHT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhDHT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13EBC061761;
        Thu,  8 Apr 2021 12:57:02 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUalu-0005PV-MC; Thu, 08 Apr 2021 21:56:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/12] staging: rtl8188eu: move another static array from .h to .c
Date:   Thu,  8 Apr 2021 21:55:57 +0200
Message-Id: <20210408195601.4762-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the declaration of the rtw_cmd_callback array from rtw_cmd.h to
rtw_cmd.c.

The _RTW_CMD_C_ symbol is now obsolete and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c    | 19 ++++++++++++++++++-
 drivers/staging/rtl8188eu/include/rtw_cmd.h | 20 --------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index bf1e49404e64..0bbe5ee918ce 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -4,7 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_CMD_C_
 
 #include <osdep_service.h>
 #include <drv_types.h>
@@ -30,6 +29,24 @@ static struct cmd_hdl wlancmds[] = {
 	{sizeof(struct SetChannelPlan_param), set_chplan_hdl}
 };
 
+static struct _cmd_callback rtw_cmd_callback[] = {
+	{_JoinBss_CMD_, &rtw_joinbss_cmd_callback},
+	{_DisConnect_CMD_, &rtw_disassoc_cmd_callback},
+	{_CreateBss_CMD_, &rtw_createbss_cmd_callback},
+	{_SetOpMode_CMD_, NULL},
+	{_SiteSurvey_CMD_, &rtw_survey_cmd_callback},
+	{_SetAuth_CMD_, NULL},
+	{_SetKey_CMD_, NULL},
+	{_SetStaKey_CMD_, &rtw_setstaKey_cmdrsp_callback},
+	{_SetAssocSta_CMD_, &rtw_setassocsta_cmdrsp_callback},
+	{_AddBAReq_CMD_, NULL},
+	{_SetChannel_CMD_, NULL},
+	{_TX_Beacon_CMD_, NULL},
+	{_Set_MLME_EVT_CMD_, NULL},
+	{_Set_Drv_Extra_CMD_, NULL},
+	{_SetChannelPlan_CMD_, NULL},
+};
+
 /*
  * Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
  * No irqsave is necessary.
diff --git a/drivers/staging/rtl8188eu/include/rtw_cmd.h b/drivers/staging/rtl8188eu/include/rtw_cmd.h
index 002a797c6d0a..68b8ad1a412f 100644
--- a/drivers/staging/rtl8188eu/include/rtw_cmd.h
+++ b/drivers/staging/rtl8188eu/include/rtw_cmd.h
@@ -361,24 +361,4 @@ enum rtw_h2c_cmd {
 	MAX_H2CCMD
 };
 
-#ifdef _RTW_CMD_C_
-static struct _cmd_callback	rtw_cmd_callback[] = {
-	{_JoinBss_CMD_, &rtw_joinbss_cmd_callback},
-	{_DisConnect_CMD_, &rtw_disassoc_cmd_callback},
-	{_CreateBss_CMD_, &rtw_createbss_cmd_callback},
-	{_SetOpMode_CMD_, NULL},
-	{_SiteSurvey_CMD_, &rtw_survey_cmd_callback},
-	{_SetAuth_CMD_, NULL},
-	{_SetKey_CMD_, NULL},
-	{_SetStaKey_CMD_, &rtw_setstaKey_cmdrsp_callback},
-	{_SetAssocSta_CMD_, &rtw_setassocsta_cmdrsp_callback},
-	{_AddBAReq_CMD_, NULL},
-	{_SetChannel_CMD_, NULL},
-	{_TX_Beacon_CMD_, NULL},
-	{_Set_MLME_EVT_CMD_, NULL},
-	{_Set_Drv_Extra_CMD_, NULL},
-	{_SetChannelPlan_CMD_, NULL},
-};
-#endif
-
 #endif /*  _CMD_H_ */
-- 
2.20.1

