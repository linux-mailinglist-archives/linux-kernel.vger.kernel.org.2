Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F49E43C1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhJ0ElX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhJ0ElV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:41:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BF0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:38:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so1093618plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BahrkLo1cG01RdfeU2V63voiQNUDlACSWrU7M72tqUM=;
        b=XuVyzKpLU9Y1f7B2wa/lQrHHemNi2MGMKVkZ5gsl3UvdLuOhUQLIobFrJsugJraNE/
         8FjTtXtegOZo/fcLn/hRxp4yLeinmG1OwlgKdMJ2QMjihbe/4m3ryqOGSta4jSJCR221
         qBBZ3yuakPbL8vGbwqCjAeLuIecnMuOBB3S9PKOOQQsuwObJTULZT/GWsU8H7M/Kn71a
         vODuQ+bKI6EgvfS1Zmx+AVdeBB1X/K4Ie/SRlWFHxtLqA1oV7J6e3/R/UyKLSm0jDQte
         II1SczZAm1C5FW8TfaGLnn+cLrclzXWzig7jLFV/lVnEqji+kGhvF7AB+2jgF8M5izKC
         1+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BahrkLo1cG01RdfeU2V63voiQNUDlACSWrU7M72tqUM=;
        b=0ZbpKyMpCfS8i1/H5eQpsKyOBsQzcCaPTWRsUAEgL5jhaQACPCQzmrtdJPs8Mw24Zf
         KjApg+R/QD+5LVyU6caMBX/n24DU3HCszTNiObKDAJ8MuxTt8XSpOeB/RyGLBCJvXyyP
         CxcYQkT5xVCwvWliQt765drP2wIKdr40gAOPvg01jrNQL4Gzht53FiDgwswhUIW1IA3m
         aeuhGDiPhnTdfIvYgTzToBB+uxDBTDtGHUnx5VYEPOdTAOqrGIDK0mSpBwE7aYUirk56
         R7WZ5o2brlShzEKPZXjkVm4yYzPnHdEgMU3d/iFmjfyhH/jFsed9zvbxRdoUH023CPIM
         M8kw==
X-Gm-Message-State: AOAM532EShERxNqyXgtFhTaWtgiOcCIjih4v10yFjlaB5ShOdtG6gz56
        wb7voxP+VDGzP+5NRfwiFMo=
X-Google-Smtp-Source: ABdhPJxyxSWGbdnXnq9Vklcicy3xOXljcJl/Tqhk+55byjJgDZ/t0Qtwq+dP/X7Ik5Afkepa3Ay6eQ==
X-Received: by 2002:a17:902:bb01:b0:13e:a6e6:9a53 with SMTP id im1-20020a170902bb0100b0013ea6e69a53mr26176466plb.4.1635309535768;
        Tue, 26 Oct 2021 21:38:55 -0700 (PDT)
Received: from Sauravs-Air.domain.name ([2001:4490:4409:d5:1c27:7aae:179:bb91])
        by smtp.gmail.com with ESMTPSA id k6sm9249704pfu.161.2021.10.26.21.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:38:55 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:08:08 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: hal: remove goto statement and local
 variable
Message-ID: <YXjXsChOpaTThkxT@Sauravs-Air.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from FillH2CCmd_88E(). In this function goto
can be replace by return statement. As on goto label exit, function
only return it is not performing any cleanup. Avoiding goto will
improve the function readability. After replacing the goto statement
local variable ret is also not needed. So remove the ret local variable.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index c5f9353fe3e6..de88e9ee532d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -53,19 +53,14 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u8 cmd_idx, ext_cmd_len;
 	u32 h2c_cmd = 0;
 	u32 h2c_cmd_ex = 0;
-	s32 ret = _FAIL;

 	if (!adapt->bFWReady) {
 		DBG_88E("FillH2CCmd_88E(): return H2C cmd because fw is not ready\n");
-		return ret;
+		return _FAIL;
 	}

-	if (!pCmdBuffer)
-		goto exit;
-	if (CmdLen > RTL88E_MAX_CMD_LEN)
-		goto exit;
-	if (adapt->bSurpriseRemoved)
-		goto exit;
+	if (!pCmdBuffer || CmdLen > RTL88E_MAX_CMD_LEN || adapt->bSurpriseRemoved)
+		return _FAIL;

 	/* pay attention to if  race condition happened in  H2C cmd setting. */
 	do {
@@ -73,7 +68,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p

 		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
 			DBG_88E(" fw read cmd failed...\n");
-			goto exit;
+			return _FAIL;
 		}

 		*(u8 *)(&h2c_cmd) = ElementID;
@@ -102,11 +97,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p

 	} while ((!bcmd_down) && (retry_cnts--));

-	ret = _SUCCESS;
-
-exit:
-
-	return ret;
+	return _SUCCESS;
 }

 u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
--
2.33.0

