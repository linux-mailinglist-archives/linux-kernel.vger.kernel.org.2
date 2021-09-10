Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D2406A88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhIJLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhIJLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:12:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A66C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:11:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1153842wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cV/z4HRiZSKdyLrb2H86Cg+HDx8EKzCLziyjHu/SfU=;
        b=Z6K4kgMMjs86niFPz7F+EbELD9nWwLPo9iS8BQL949u+X50Jh28R3l+qd+61mDJPRX
         xP/Di/3sCWblgqM1fcK+RByfk9HedWSnxj3vIPoXABXZeasET/S4R9nd4AKm6+bnoC9/
         aMgv9DsXapyy5RW4jGk30dNZACDDXqWmjVDlSSOe1ssm8nl9lAZyzt42oQXYlDTqSOs+
         wXFJbCs/DZ3VTRX4VxkiEx4xM/li3wK+ClB77onA08oeNYShUlwCf+BspiZZTwN1xIgP
         +Qo7nJWheq4whzyzSNDw5ym/C7Ir7bTL4fRnmNoz/3eSk4SIYjcAEt5TsftKAkJTb9V2
         s4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cV/z4HRiZSKdyLrb2H86Cg+HDx8EKzCLziyjHu/SfU=;
        b=Wa4VXFVSwg84FL4662po8+wnF0qSmXSN7RMmOvxY6eAkR9j5DPjR8FoGOnvxSsl7VX
         Fu15VG5pa/LzIwDH0mRhM06MUA+uTFCHOaq9vkyTYGb6FvpHOydMnISdQ2FB44nEyY7r
         9QyIEm0bECnzMGhb69E2Nue1pWbCqjPMssmfDLFq/68M/2jnCyINfw1K5vQVzUi09VD2
         uB6+ymNuN1wsHPTTOyx0+eI02dB66/Ewd8I8stdfa4CJVz9o30CdpAexWBwfJTfExqkO
         e7ZTt5KpKU7aEaoDPe94Ylduofq/DU1bvvusQuglCE21CxDC8YBxAPrfqipILARh0pUQ
         kIgg==
X-Gm-Message-State: AOAM530RvJSylK8n/7S0DaGWDvdCZyULDtYLxCk3227F07ZbKYOcMn35
        dCLSYhPOKSv7BLc0zx/5qxQ=
X-Google-Smtp-Source: ABdhPJwyAtmPqVkSYakdmDBewPobNVhuA5igo0RbNL0mjcabJm9ix2Q28i42Id7+fGIfSdpNkmNQAA==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr7829094wmr.35.1631272298400;
        Fri, 10 Sep 2021 04:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id o7sm3848828wmc.46.2021.09.10.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:11:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: remove wrapper rtw_IOL_exec_cmds_sync()
Date:   Fri, 10 Sep 2021 13:11:09 +0200
Message-Id: <20210910111110.4628-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910111110.4628-1-straube.linux@gmail.com>
References: <20210910111110.4628-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_IOL_exec_cmds_sync() is just a wrapper around
rtl8188e_IOL_exec_cmds_sync(). Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: added missing 'r8188eu:' to commit message

 drivers/staging/r8188eu/core/rtw_iol.c          |  5 -----
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c  |  4 ++--
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c |  2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c  |  2 +-
 drivers/staging/r8188eu/include/rtw_iol.h       |  3 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 10 +++++-----
 6 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 9c85e590fc9d..08677552e5d6 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -72,11 +72,6 @@ bool rtw_IOL_applied(struct adapter  *adapter)
 	return false;
 }
 
-int rtw_IOL_exec_cmds_sync(struct adapter  *adapter, struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt)
-{
-	return rtl8188e_IOL_exec_cmds_sync(adapter, xmit_frame, max_wating_ms, bndy_cnt);
-}
-
 int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary)
 {
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index 55aa20a30342..86e92552dfb0 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -246,7 +246,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 		}
 	}
 	if (biol) {
-		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+		if (!rtl8188e_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			printk("~~~ %s IOL_exec_cmds Failed !!!\n", __func__);
 			rst = HAL_STATUS_FAILURE;
 		}
@@ -557,7 +557,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 		}
 	}
 	if (biol) {
-		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+		if (!rtl8188e_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			rst = HAL_STATUS_FAILURE;
 			pr_info("~~~ IOL Config %s Failed !!!\n", __func__);
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 0ff2609c26bb..0aab0eb87682 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -204,7 +204,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 		}
 	}
 	if (biol) {
-		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+		if (!rtl8188e_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			pr_info("~~~ MAC IOL_exec_cmds Failed !!!\n");
 			rst = HAL_STATUS_FAILURE;
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 55e4b4a877a4..b4269ad56ede 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -241,7 +241,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 		}
 	}
 	if (biol) {
-		if (!rtw_IOL_exec_cmds_sync(pDM_Odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+		if (!rtl8188e_IOL_exec_cmds_sync(pDM_Odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
 			rst = HAL_STATUS_FAILURE;
 			pr_info("~~~ IOL Config %s Failed !!!\n", __func__);
 		}
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 471f9ca092a8..a07c3ae0bed7 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -34,9 +34,6 @@ struct xmit_frame *rtw_IOL_accquire_xmit_frame(struct adapter *adapter);
 int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds,
 			u32 cmd_len);
 int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary);
-int rtw_IOL_exec_cmds_sync(struct adapter  *adapter,
-			   struct xmit_frame *xmit_frame, u32 max_wating_ms,
-			   u32 bndy_cnt);
 bool rtw_IOL_applied(struct adapter  *adapter);
 int rtw_IOL_append_DELAY_US_cmd(struct xmit_frame *xmit_frame, u16 us);
 int rtw_IOL_append_DELAY_MS_cmd(struct xmit_frame *xmit_frame, u16 ms);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 08b891b9c708..b428d0b36171 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4032,7 +4032,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			rtw_IOL_append_LLT_cmd(xmit_frame, page_boundary);
 
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 500, 0))
+			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 500, 0) != _SUCCESS)
 				ret = -EPERM;
 		}
 			break;
@@ -4056,7 +4056,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				rtw_IOL_append_WB_cmd(xmit_frame, reg, 0x08, 0xff);
 				rtw_IOL_append_DELAY_MS_cmd(xmit_frame, blink_delay_ms);
 			}
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, (blink_delay_ms * blink_num * 2) + 200, 0))
+			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, (blink_delay_ms * blink_num * 2) + 200, 0) != _SUCCESS)
 				ret = -EPERM;
 		}
 			break;
@@ -4078,7 +4078,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			for (i = 0; i < write_num; i++)
 				rtw_IOL_append_WB_cmd(xmit_frame, reg, i + start_value, 0xFF);
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
+			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
 			final = rtw_read8(padapter, reg);
@@ -4107,7 +4107,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			for (i = 0; i < write_num; i++)
 				rtw_IOL_append_WW_cmd(xmit_frame, reg, i + start_value, 0xFFFF);
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
+			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
 			final = rtw_read16(padapter, reg);
@@ -4135,7 +4135,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			for (i = 0; i < write_num; i++)
 				rtw_IOL_append_WD_cmd(xmit_frame, reg, i + start_value, 0xFFFFFFFF);
-			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
+			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
 			final = rtw_read32(padapter, reg);
-- 
2.33.0

