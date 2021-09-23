Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFA4165B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbhIWTLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhIWTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16678C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d21so19993435wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ypQ54O2UtSD63BBBZapGtWjBMnZ9QEQ/o8Kwb0GoN8=;
        b=SDWuZN1eSku6qKlgArFUIbu47NBygCYNFncDO9v09H8+LHJtHsVn6TUrMFN9FLkCrH
         dv8tK27an8CwhKlJjpoJdMoDyPYQeKELutRP98EXydi6xYLpskh1DjIKgNwFf7/WuCSv
         WHBhs5SqIpFlSRXyPuO6Ntz6/oPTnfPtU4p+4VqPiDJLQmwpjHTwfBQH7mJU59/hwwUc
         p2A+omjvPT5rzATo/Fs/iAlMeN4b2SdEHlqDQLaoZHyHbk+up0pmvwqyzA8b9ogRj/Xs
         KgEabfsD4vnJS/VWp+3Y0N+d0BJDUdUPD+xbiDsDLG2f62OnvnhFk+Q7CBkgf992nCp6
         mMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ypQ54O2UtSD63BBBZapGtWjBMnZ9QEQ/o8Kwb0GoN8=;
        b=15xUJghCF1qO+u1n0klO5vJTLgMtYgkO4uJLzuYHb8l5HYK+xOAGt8XaMqPZbP4K7t
         WfVR7WVroJ/8bkRC7WY54oz8KzEadqDgQP8S6SMmuE3Gw7LC89awj80sN4LpK5LDPjED
         M9KdtYNo9DvEWCQl4Orvj5ry+sOsP7meG9ZzzV2JYFq5sr1GY9BVSFWczMBMyRgab+Nn
         6tJVFL79KmoqBQXk2PHM0aT3wx2soQoiW0BeOBk0n1Rwgj1hBji2q17aOvpUIJ5hU78H
         YXYGc0G4zPx+m3k6zjFiiTCSNNvAA0eEg+NyB8ul/DjwTKyA/0lYpr5ax/P7UZmjojVe
         +pWg==
X-Gm-Message-State: AOAM532BQOprD6xrhpx8VuYBK6NwAr2K5w4DxhMtNGYR9MuVph6HXLl2
        sWlZDfvmPaNi54jZ5KsL5+A=
X-Google-Smtp-Source: ABdhPJxeMLCZpzfaIPlbkBOEJAjLej1lpyfxONNYBD49Zut6+/hyRcwtdvWw4rsUsLSymyv/7qGBjA==
X-Received: by 2002:a1c:210a:: with SMTP id h10mr6007528wmh.165.1632424174677;
        Thu, 23 Sep 2021 12:09:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/17] staging: r8188eu: remove rtw_led_blink_cmd()
Date:   Thu, 23 Sep 2021 21:09:09 +0200
Message-Id: <20210923190920.3580-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_led_blink_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 31 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index df835d0afc19..80257f5c55d1 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1193,37 +1193,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	return res;
 }
 
-u8 rtw_led_blink_cmd(struct adapter *padapter, struct LED_871x *pLed)
-{
-	struct	cmd_obj *pcmdobj;
-	struct	LedBlink_param *ledBlink_param;
-	struct	cmd_priv   *pcmdpriv = &padapter->cmdpriv;
-
-	u8	res = _SUCCESS;
-
-	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!pcmdobj) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	ledBlink_param = kzalloc(sizeof(struct LedBlink_param), GFP_ATOMIC);
-	if (!ledBlink_param) {
-		kfree(pcmdobj);
-		res = _FAIL;
-		goto exit;
-	}
-
-	ledBlink_param->pLed = pLed;
-
-	init_h2fwcmd_w_parm_no_rsp(pcmdobj, ledBlink_param, GEN_CMD_CODE(_LedBlink));
-	res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
-
-exit:
-
-	return res;
-}
-
 u8 rtw_set_csa_cmd(struct adapter *padapter, u8 new_ch_no)
 {
 	struct	cmd_obj *pcmdobj;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 3a12ca83af00..84c9592b08ae 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -781,7 +781,6 @@ u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
 
 u8 rtw_set_ch_cmd(struct adapter*padapter, u8 ch, u8 bw, u8 ch_offset, u8 enqueue);
 u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
-u8 rtw_led_blink_cmd(struct adapter*padapter, struct LED_871x * pLed);
 u8 rtw_set_csa_cmd(struct adapter*padapter, u8 new_ch_no);
 u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option);
 
-- 
2.33.0

