Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3693DF833
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhHCXF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhHCXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2DC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so362538wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oV5FutEJ9FRZE3dKq8Jy13n1PdVD5EOt/BBNRlH+OBw=;
        b=TWm9LR+Wd3aTB4hAh5jENudmGLHHj2yK1bJl+uMlwB9XPOqJ11/gO+9cOBL8dr4hjT
         hGcBM6VHeSoSUWIjvfaV+dK3Z+NlbQVgou42vWoXA9JH3HDmZsF+1XOTkYVSqBI2IPpg
         HbcmrFpTeMxRveEalOhraz0iRCWmETVXlcCdeEfv3y4iY9K3DJBnAiKw+pSuetphRi/u
         s2rwI/03H9Jvs9h++cAy7d2TzQIebASv0kxEZIa2Hdp9TpFwxFWhSALYfCc4dxjDKN/j
         s/O7bJOdJ4c/urzK/Y5E+rRtGmjXODsB7mNJu7h27o3OEMFhVr3LRjzCc7lZYLiGK5n9
         z9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oV5FutEJ9FRZE3dKq8Jy13n1PdVD5EOt/BBNRlH+OBw=;
        b=CITlXVubXGZQHJU2lMnteTfpWRMd19R/R73E5csz1RUQxsAk9v5kWXTT3QTOF4DYdd
         FZ9A5LQIVZEn52lSbaf685MdgzsqxQ+2nyh/1K8n5NrKDOWraP/KxKEO9d44plwHf0R1
         MewQ+3e8N9fBW8ApmQ/WnvFTFm84mbWKWNri/Zye1lq55qsZEZW1sB524ZCW5VfPBlQq
         MX6N8pgnDIMevXjHYVRoLbVtp02GbvJ3vuH0p9Dhv3+54PRuHlVGGjmBfyoX9cSgWdkz
         L2jCfm31whYkdkIPXmQmRDnx2k4RAfhft730JZmvqebIOWXfWBAqNjLC8Pbi2WBKwPxa
         hQiw==
X-Gm-Message-State: AOAM532N8Tkugydiq2WNJf9aoYEupGoRG3N8nsC6WQC3FIkIkZcZMHb1
        gFC+hxJ3QCAh34T61dCqSKY5Qg==
X-Google-Smtp-Source: ABdhPJznYvsOo5BIT3K+03mj1dq2h5KGv+U9LkG8Uxc6VFW1+3TbWFsyuwm2iKZdvOxtc5ja8cb+qg==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr25097411wme.31.1628031939693;
        Tue, 03 Aug 2021 16:05:39 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:39 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: r8188eu: remove RT_TRACE calls from hal/HalPwrSeqCmd.c
Date:   Wed,  4 Aug 2021 00:05:30 +0100
Message-Id: <20210803230535.74254-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/HalPwrSeqCmd.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index e1059c5dd711..e092563a3577 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -39,27 +39,12 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
-		RT_TRACE(_module_hal_init_c_, _drv_info_,
-			 ("HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
-			 GET_PWR_CFG_OFFSET(pwrcfgcmd),
-			 GET_PWR_CFG_CUT_MASK(pwrcfgcmd),
-			 GET_PWR_CFG_FAB_MASK(pwrcfgcmd),
-			 GET_PWR_CFG_INTF_MASK(pwrcfgcmd),
-			 GET_PWR_CFG_BASE(pwrcfgcmd),
-			 GET_PWR_CFG_CMD(pwrcfgcmd),
-			 GET_PWR_CFG_MASK(pwrcfgcmd),
-			 GET_PWR_CFG_VALUE(pwrcfgcmd)));
-
 		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
 		if ((GET_PWR_CFG_FAB_MASK(pwrcfgcmd) & fab_vers) &&
 		    (GET_PWR_CFG_CUT_MASK(pwrcfgcmd) & cut_vers) &&
 		    (GET_PWR_CFG_INTF_MASK(pwrcfgcmd) & ifacetype)) {
 			switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
-			case PWR_CMD_READ:
-				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_READ\n"));
-				break;
 			case PWR_CMD_WRITE:
-				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n"));
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
 				/*  Read the value from system register */
@@ -72,8 +57,6 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				rtw_write8(padapter, offset, value);
 				break;
 			case PWR_CMD_POLLING:
-				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n"));
-
 				poll_bit = false;
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 				do {
@@ -92,7 +75,6 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				} while (!poll_bit);
 				break;
 			case PWR_CMD_DELAY:
-				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n"));
 				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
 					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 				else
@@ -100,11 +82,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				break;
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
-				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_END\n"));
 				return true;
 				break;
 			default:
-				RT_TRACE(_module_hal_init_c_, _drv_err_, ("HalPwrSeqCmdParsing: Unknown CMD!!\n"));
 				break;
 			}
 		}
-- 
2.31.1

