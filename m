Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2099413AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhIUTtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhIUTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA0C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so164866wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAxHuRHm7WfK6bNik1ywIBpJsescet2i7txnxF2Aqf0=;
        b=VaUSB+G5i7MxEC1NU5ctqQF4GfLXIHpHcsb47g290mR+P//Lrq61NxgxaWVSVCabaa
         2TCgKQkvVP5XORobC+0eaJ2g6tKHAGbSYxNSGDnwIZb3FdrxjNnhXbGKf5wFHrClCF+Y
         MlfWd/fXpqL9+dFTGHX5Yr6w7Ytus7zhxigdj27BTz3i4WUuPoZg5w6n9SPzgNLJjx1Z
         WHM5srEvoPfZt62TJEsfIh8qQhlZYQRmDMFg7bUjwFTMQYdqQgjBVdZhYHT1iB/UA/ap
         fR6wBfu4LdcpbR//W0LFXOCHVpYSG9mcKK9ABc24QKHID7c64AcwtP7w8Km92jz0jOIm
         cS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAxHuRHm7WfK6bNik1ywIBpJsescet2i7txnxF2Aqf0=;
        b=GkWRKh8xSvnlJvyH06pQGho+JAb6QqTCQuD6FEHoSUrwx5B1kkX8m1T2ifcaTeJy1W
         l0nw+niNSOogJRbWDuOIOLBULjEO4h2jw+XCxh9ljC/s4dJLaXH+lymiVJNA68piBl2/
         TwteD4GowZqNW0sUeAmgcngIjQD/98mqyuPqeTOXBgrvOUsnmyDuUX3Q71OwJnWkGiJb
         M+t0WVUBnK/DJ5Qpatm8U5XLjcFr6JNTczm9x1lg5sTtBLUoyFL5RHjGMRiZr23Hvb+8
         RSt/Oa2w7zAqngCr1zo4LFmXjS5aKD1479f085bDkwpggy982Lr29yUPXI+YpIerXMHU
         UHrA==
X-Gm-Message-State: AOAM5331BebLVNttdqouL0jvFeIZkg39O1iuvRfULSH/njmBq/F7xdZJ
        buHSRjzHf0PYn3aCsBImYzI=
X-Google-Smtp-Source: ABdhPJyElFp1acBjmLJYQr8aJci7+tL3R8CDUq0tU/ZKz1XYvXDEtbkcjFSX9gUM59/gIzN96r0fag==
X-Received: by 2002:a05:6000:1809:: with SMTP id m9mr38380557wrh.396.1632253645190;
        Tue, 21 Sep 2021 12:47:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: r8188eu: remove write-only fields from struct dm_priv
Date:   Tue, 21 Sep 2021 21:46:54 +0200
Message-Id: <20210921194658.10654-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields bDynamicTxPowerEnable and LastDTPLvl of struct dm_priv
are set but never used. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 2 --
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c691a6a90fa9..555060bdfdd9 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1183,8 +1183,6 @@ void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm)
 	struct adapter *Adapter = pDM_Odm->Adapter;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
-	pdmpriv->bDynamicTxPowerEnable = false;
-	pdmpriv->LastDTPLvl = TxHighPwrLevel_Normal;
 	pdmpriv->DynamicTxHighPowerLvl = TxHighPwrLevel_Normal;
 }
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 3ead20b321a9..2209975c0b2d 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -29,8 +29,6 @@ struct	dm_priv {
 	int	LastMinUndecoratedPWDBForDM;
 
 	/* for High Power */
-	u8 bDynamicTxPowerEnable;
-	u8 LastDTPLvl;
 	u8 DynamicTxHighPowerLvl;/* Tx Power Control for Near/Far Range */
 	u8	PowerIndex_backup[6];
 };
-- 
2.33.0

