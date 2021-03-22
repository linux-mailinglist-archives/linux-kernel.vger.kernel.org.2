Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8241F34474A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCVOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhCVOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53284C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bf3so19635466edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNlBaswYmXMpAAiZg+aRMz4wD658eKTTonTGdQHvXsE=;
        b=Iu7wb/6nSqLYp0FXpE03/bHsMwOXXIeky8JncDE2nv7gkm+RHDDR7fHyBVzS2EMbFQ
         yzUr0yhI7g2gvnfvQjd9IkblYrgiztUD8fuF0Sjw2wussLT7orB6Yj7oZHLg6W64I+YP
         v6KaOG84uf9bigd/+c/sAwBrel83NPtq2pWNUF4OctPwR+GWyq2c4vh11yao6Q0QcpID
         VCq1vmn90LG7HeLNzGqi/sgJUd/U69CfQ8aVOiJUd4DhlwZQEgtzQPqJjgss34Psy7vV
         aF0VNW05l3xAcXd4JJRYScpyDyTOGjR3EwiR0q7ZuMpoFP8CYigg4lYZddFzD5aNTr4T
         T1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNlBaswYmXMpAAiZg+aRMz4wD658eKTTonTGdQHvXsE=;
        b=KfTxl1fPuCIKcXpT2Ng8dkyxzNC//vJxwTgQLRdp6xHYV9wgvmuc3Pe8PXF67Qmkl2
         jCJJpe2Y/nSFLZa4oogvQpdrNNrpOWyS0lAOdRGISECwtqP0JSarEDwMZhGUDtRhdPWc
         7A7HrXrdHvbDXcU8YRs0NtbyzGZSVMwUAA9RLYyCsHRcvRnyKh26gIEwhkrHHyRoXaVk
         2OQZDTVvnq6illLCtofSCgG1zrEuiWXBg4YFo6HGKCZWAlIV74m8bFrsphzTnGUqNcis
         Jb8bridz+sY4vAD7l7cCY0kQ9jpd5mUsvRjgol1cGZPOhRFHJ7gytfxnffv7TM8bzjBP
         5EJw==
X-Gm-Message-State: AOAM533mFB8PGbh2pAJYcG+DLl2FQQPkUr4FTBNL115yzYi9gnGKCw6R
        X7/p3MjdF3TXGG/kPVEkYKs=
X-Google-Smtp-Source: ABdhPJzDMtJxzOm9XpBGXYDs2Pzl5R0A+pTiDth4KOu/096lEjGSAlOL0ifaWdfnxlfa+h3SBKacQA==
X-Received: by 2002:a05:6402:1d19:: with SMTP id dg25mr26163918edb.218.1616423533158;
        Mon, 22 Mar 2021 07:32:13 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id u59sm11994141edc.73.2021.03.22.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/11] staging: rtl8723bs: moved function prototypes out of core/rtw_efuse.c
Date:   Mon, 22 Mar 2021 15:31:40 +0100
Message-Id: <c46e7d7a686988bb6aaea9bc24b15188136e0aed.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
+bool

moved two function prototypes in include/rtw_efuse.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 10 ----------
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  3 +++
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 32ca10f01413..0772397738d4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -32,11 +32,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-bool
-Efuse_Read1ByteFromFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 *Value);
 bool
 Efuse_Read1ByteFromFakeContent(
 	struct adapter *padapter,
@@ -53,11 +48,6 @@ Efuse_Read1ByteFromFakeContent(
 	return true;
 }
 
-bool
-Efuse_Write1ByteToFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 Value);
 bool
 Efuse_Write1ByteToFakeContent(
 	struct adapter *padapter,
diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
index 5bae46ecd9de..1f304df8c421 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -103,6 +103,9 @@ extern u8 fakeBTEfuseInitMap[];
 extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
+bool Efuse_Read1ByteFromFakeContent(struct adapter *padapter, u16 Offset, u8 *Value);
+bool Efuse_Write1ByteToFakeContent(struct adapter *padapter, u16 Offset, u8 Value);
+
 u16 Efuse_GetCurrentSize(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void EFUSE_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest);
-- 
2.20.1

