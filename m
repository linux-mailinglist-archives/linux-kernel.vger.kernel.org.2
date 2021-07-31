Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3993DC1F0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhGaAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhGaAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CFC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so7426487wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Is39HpL/PKw5LqFK5S/i54PTBc1QGMOiWY+feaoJszs=;
        b=aGbymugbX5LmqAdYCoF2+x692NPkiLr2tyL7TvmXILh8y18pAhWHrDFYlfiHIY6G++
         0k3Un2igZw3rYZUXxJMPeMNev5xc3CxhHFfn3EYSwaji3e6Q5vaScWLKXUtXqMVOi1Wd
         7QRd3X7N21vqzzUmSPJseZe5QcMOlIcEeYNhIj9NGIPp7a7DQ/+He4oB9GBzTBmS+cRu
         ORFc2xTo7deDeyMkV9lJc+Cz+ZEJI8aeMInnZY10eiflCCemL8GtR+UdMVkc+BGuCR57
         q1HiQaFfFlyvhym4787+KFT6g4EwIitCFlsExobmzNLn3Hu0YFbAci2DW4DumJu1eHph
         vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Is39HpL/PKw5LqFK5S/i54PTBc1QGMOiWY+feaoJszs=;
        b=lJaj/8NTT19s8XiYdWbhFop3Ta2v4HLNyffyS4aakF+MR2fOBCpyuFqnv910btbjx/
         +KerBMX/EFdq4oDOuxhLdJl5oMclBk8bH1O96iAdML1PpSYXc/ey2bFE4jLzC8BUO0Di
         4FJPcK5cGwrX3/JQCeSYKHjXH4YCbNpNIk/PBeFpg06q9Ld6R5s8Gl8PDoDCa70sRKEj
         OMp+h5T50PuYCopkELEYhStG22iydqT8Z+I1L6vvUrwfXiuWBnYeQaW+1P683JWXXt3s
         VpS9BsYzrCa2Pg+Id/vskn++uINJ0QjeCXvKAOxfXvDry4ZV0s/dCG7izHfICOwne3EH
         NQzw==
X-Gm-Message-State: AOAM531XV/UElTw73okYr8dUqUYpLb+dRsCkfoHWEwtISOmwAuVzTiXF
        hibrNsVKEOowCBDRmgBGxvLFAvInm+FuXNvDbFY=
X-Google-Smtp-Source: ABdhPJyi5tWn37aXk152I+dVFxSvPgxt6uHj/ta0B2CCj2jrN57dpmdA2SMSDXVw5wJRJQhnFyci1w==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5658867wmj.144.1627691044277;
        Fri, 30 Jul 2021 17:24:04 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:24:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] staging: r8188eu: remove ODM_RT_TRACE macro definition
Date:   Sat, 31 Jul 2021 01:23:51 +0100
Message-Id: <20210731002353.68479-13-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE macro definition from include/odm_debug.h, as
it is called from nowhere and is therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index c70fe73e3339..38b07664b07c 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -68,24 +68,6 @@
 #define RT_PRINTK(fmt, args...)				\
 	DbgPrint( "%s(): " fmt, __func__, ## args);
 
-#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <= pDM_Odm->DebugLevel)) {				\
-		if (pDM_Odm->SupportICType == ODM_RTL8192C)		\
-			DbgPrint("[ODM-92C] ");				\
-		else if (pDM_Odm->SupportICType == ODM_RTL8192D)	\
-			DbgPrint("[ODM-92D] ");				\
-		else if (pDM_Odm->SupportICType == ODM_RTL8723A)	\
-			DbgPrint("[ODM-8723A] ");			\
-		else if (pDM_Odm->SupportICType == ODM_RTL8188E)	\
-			DbgPrint("[ODM-8188E] ");			\
-		else if (pDM_Odm->SupportICType == ODM_RTL8812)		\
-			DbgPrint("[ODM-8812] ");			\
-		else if (pDM_Odm->SupportICType == ODM_RTL8821)		\
-			DbgPrint("[ODM-8821] ");			\
-		RT_PRINTK fmt;						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.31.1

