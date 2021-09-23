Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C464165B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbhIWTLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242869AbhIWTLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t28so6737357wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doDk7RUtFMDUp7hgyLWsA1aVYygB5CnnTWl9G24Whkk=;
        b=RhqiiZKtQ+IRDox4XlAjdw+RWey5oYfQ1+3ISFjYRCTg8tC4x0aicIGhs6GFHdWGQi
         WE0zPwOtP9KdwyrpkjIdDLRtwph9mEOtc1mXlj2Wc4VICVqnJaNy7u/iHqfk1YgabQRw
         9ZUkWcQsu4KcHN9UrW8MrUHV+FReruxUqdiouM9rjkI5nRnxBG6ucMMiKBat/8VJ5dbK
         PtfZzWaton6q/ExcosJW3E2AP97QtcQEneFbWG6uphXjohoD5tgMshTMXiifbdk/CY2B
         yl1DTN8qYffKl7kBvUOZThVbIZht/AQ562nrmGC6WvBUTXJrdoeOw3J/QZ1mNnFk5Ypg
         QYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doDk7RUtFMDUp7hgyLWsA1aVYygB5CnnTWl9G24Whkk=;
        b=OR/MB92r5n3j+/TPKuK3RfNQ+dLBZsUZ1yDAe+d14I+zQqLdF62n6QzLyXBac2oWcv
         C3sYmVnujyp29BCUVZppw8K1vFtug8Lkso3sp0vE2LwT4fdFcdgT/msh9AQ72/I56IXQ
         dA+d5XqqNTfj7gSG6E3u0WvcJjztFbnl/QfT3DjoqQVRLm2NgUrfaeIQDrSCRgkhL4ma
         z6AjDR5Oqz3QAsP75Wzt7gdpaoik0xP8oJ3NrChHeuh44K9kLea93DwXDC994JLRr1WR
         wtquxfL4WXXUOkArpm/pmMcXjbc8AH3UzKy1SQPoNq+asuz1b9JGTpS3a5v74scVIz0q
         yXdw==
X-Gm-Message-State: AOAM530LpkLKOtyVzay29fjSv+PAHiPtWCjAwpO9dLOzoNy3/PInWvL4
        36axdQI6eXsoaE7jrcj1mrV1Vf6jFoI5PQ==
X-Google-Smtp-Source: ABdhPJy5quB4fAo1r1ALhknN3vt5PekwbZOfvLGItiSUAibr/jOhUh1AUeKJZmL0opEjncySqnCSFQ==
X-Received: by 2002:a05:600c:2d45:: with SMTP id a5mr6193115wmg.39.1632424171879;
        Thu, 23 Sep 2021 12:09:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/17] staging: r8188eu: remove rtw_getbbreg_cmd()
Date:   Thu, 23 Sep 2021 21:09:06 +0200
Message-Id: <20210923190920.3580-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_getbbreg_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 34 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 972c47136b1c..3a3a56078138 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -574,40 +574,6 @@ u8 rtw_setbbreg_cmd(struct adapter *padapter, u8 offset, u8 val)
 	return res;
 }
 
-u8 rtw_getbbreg_cmd(struct adapter  *padapter, u8 offset, u8 *pval)
-{
-	struct cmd_obj *ph2c;
-	struct readBB_parm *prdbbparm;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-		}
-	prdbbparm = kzalloc(sizeof(struct readBB_parm), GFP_ATOMIC);
-
-	if (!prdbbparm) {
-		kfree(ph2c);
-		return _FAIL;
-	}
-
-	INIT_LIST_HEAD(&ph2c->list);
-	ph2c->cmdcode = GEN_CMD_CODE(_GetBBReg);
-	ph2c->parmbuf = (unsigned char *)prdbbparm;
-	ph2c->cmdsz =  sizeof(struct readBB_parm);
-	ph2c->rsp = pval;
-	ph2c->rspsz = sizeof(struct readBB_rsp);
-
-	prdbbparm->offset = offset;
-
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-
-	return res;
-}
-
 u8 rtw_setrfreg_cmd(struct adapter  *padapter, u8 offset, u32 val)
 {
 	struct cmd_obj *ph2c;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index ce47ad21c087..fca02454c8d1 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -760,7 +760,6 @@ u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
 u8 rtw_setbasicrate_cmd(struct adapter  *padapter, u8 *rateset);
 u8 rtw_setbbreg_cmd(struct adapter * padapter, u8 offset, u8 val);
 u8 rtw_setrfreg_cmd(struct adapter * padapter, u8 offset, u32 val);
-u8 rtw_getbbreg_cmd(struct adapter * padapter, u8 offset, u8 * pval);
 u8 rtw_getrfreg_cmd(struct adapter * padapter, u8 offset, u8 * pval);
 u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
 u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_table);
-- 
2.33.0

