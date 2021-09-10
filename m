Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51E640687E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhIJIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhIJIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:30:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4164C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:29:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 18so1228115pfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=X1Ka596D4T+qrQ3x64aHg+vCGr4l6bDdJYBtf2qGrO0=;
        b=HaNdN2FTqndKVudMjlQwIWFnOE/CqokRoRHKeHRkWRZJOkVkT8frSZro/BHaU/8/WX
         9okM67qatIZ2cejk9JOyFtzLL05Ig81xOYtjhXO02hQGOvoaA8fKBgfOr9QHSiRQmCkA
         HTz740YYD2GgUEMj9GE3bBi5k9qnH3PGDXa2pfRoB0twhbxs9+Ha6nCh9OdTizR6Izw/
         bQnZYOVVLAWGR8hvvseHVgrt+X/9Z+qLu1rpKLPai5BxkF/+7sIZLyBveNlOqZTWdU7e
         feaOg027OQiJRgIwMpHCaBewP0Jv9YD7FvvJrgSb+6WJuUMmEubQVp9mfD5aEeBHdCsu
         d+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=X1Ka596D4T+qrQ3x64aHg+vCGr4l6bDdJYBtf2qGrO0=;
        b=z3bfuzrFSsSMFt+EVytfayjPZtD3dMfDraHhpjyrWcqxRhflWBoaoJu2Xv4mZFeo4H
         0YID/TuskoUaZYGpr4HCy1o0sIZ5mLNUQA4NCUryByqma4yLMB4R8pNUYSu76ltVBhPO
         n6Eupu/GJI8T1n+Fnldm83xBnVpwx0oH/VN3r1uLPEVkFhV8t1JX/A1ZoEohB6ulyh54
         YHEjNbA0mUFFDvOjCt++Hw3+P8b/capic/ckMlFqAeJS5APWELmeBAhwDrg+iBm+i8ic
         KiLsUFmp5MWLYobgNlS/4YfE3FQJAxjNb0+iH1A8FaYoIG7ZFlGzo605UeQCMjof4bT4
         y77A==
X-Gm-Message-State: AOAM532OaXE3mVdK2P/rTH3rjmcx8duwkb1bkf5KCKAu1WcwAyq3XV98
        /8Zubqw6FWq8m3WDKbotlS0=
X-Google-Smtp-Source: ABdhPJx+y/VBPKdyWT1FN19oFSjXlOnff4HzZHsc8WE0QCRAD91fR8f/qNwy27Bha2ytjOPpbg/2Eg==
X-Received: by 2002:a63:b007:: with SMTP id h7mr6222926pgf.443.1631262565075;
        Fri, 10 Sep 2021 01:29:25 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id y8sm4628496pfe.162.2021.09.10.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 01:29:24 -0700 (PDT)
Date:   Fri, 10 Sep 2021 13:59:19 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: rtl8712: Move similar execution in to a function.
Message-ID: <YTsXXxtQn7QN6nIm@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtl8712_cmd.c function read_macreg_hdl,write_macreg_hdl,write_bbreg_hdl
and write_rfreg_hdl all are having same execution.

Move this common execution in to a new function common_read_write_hdl().
Call common_read_write_hdl() from read_macreg_hdl,write_macreg_hdl,
write_bbreg_hdlhis and write_rfreg_hdl.This will reduce duplicate code.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangeLog V2:
- Add more explanation about the patch

 drivers/staging/rtl8712/rtl8712_cmd.c | 41 +++++++--------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index e9294e1ed06e..9bc0588be04b 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -117,9 +117,9 @@ static void r871x_internal_cmd_hdl(struct _adapter *padapter, u8 *pbuf)
 	kfree(pdrvcmd->pbuf);
 }

-static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
+static u8 common_read_write_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj	*pcmd);
+	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
 	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;

 	/*  invoke cmd->callback function */
@@ -129,20 +129,17 @@ static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
 	else
 		pcmd_callback(padapter, pcmd);
 	return H2C_SUCCESS;
+
 }

-static u8 write_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
+static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj	*pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	return common_read_write_hdl(padapter, pbuf);
+}

-	/*  invoke cmd->callback function */
-	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
-	if (!pcmd_callback)
-		r8712_free_cmd_obj(pcmd);
-	else
-		pcmd_callback(padapter, pcmd);
-	return H2C_SUCCESS;
+static u8 write_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
+{
+	return common_read_write_hdl(padapter, pbuf);
 }

 static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
@@ -155,15 +152,7 @@ static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)

 static u8 write_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
-
-	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
-	if (!pcmd_callback)
-		r8712_free_cmd_obj(pcmd);
-	else
-		pcmd_callback(padapter, pcmd);
-	return H2C_SUCCESS;
+	return common_read_write_hdl(padapter, pbuf);
 }

 static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
@@ -184,15 +173,7 @@ static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)

 static u8 write_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
-
-	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
-	if (!pcmd_callback)
-		r8712_free_cmd_obj(pcmd);
-	else
-		pcmd_callback(padapter, pcmd);
-	return H2C_SUCCESS;
+	return common_read_write_hdl(padapter, pbuf);
 }

 static u8 sys_suspend_hdl(struct _adapter *padapter, u8 *pbuf)
--
2.32.0

