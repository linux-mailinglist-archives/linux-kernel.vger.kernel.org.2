Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C7407852
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhIKNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E14C06139F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so6831638wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmLUCAEYxFwcmvdkedi2Q6MG01eb0FCj6BHmjyNoRDo=;
        b=gh5fmzaKtMLgTD+LNRL5uPZYNtP312p4MYOVdoDN/VCvW6hvhAmFbyOyPOP5U8ZgWm
         GmQhFg2SzFDtCjzc+1lY0Pnpl9kFFDOwNqVjnhV/XwV28F8+BhmbAO3Vd8YAaGocKkIr
         TvknVHpzHvE7KCoX1h75lNtijcfzSwEhYVinwm/p6UoP7qiZJ+P2QfvJAoOBNFFPGhT6
         vPtkxxMTqg7OYSvCJKhKL/UrpQ7k4EXPOvI7zT23XQPeUXZAUKr4481HwjtyiPitGZgA
         xpY8mJtG8//amnwDQCbPUGG//DaaQP4CTD1PnaZ4qGE5nVhRMCsI7ag71qr7jcDNitZ/
         SI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmLUCAEYxFwcmvdkedi2Q6MG01eb0FCj6BHmjyNoRDo=;
        b=sr59aD3iRQahg7O0xGYi2w8ZaA/q7HhApzqe1Sy+DXD3giXaLUvSJFZKcrgj+saTI5
         otXQ1B6sjr3vxYJCWA2FRjCc/zfGMsRtaBEBbQnfkwzhyuIhPN4mZ6XfsGkyOfyenzIy
         PJViz26rSnnOC0nDufssg5seoRLEDVqc+8fSt71d6pADGxfJ+YEHjJriJzILwAbdW0nY
         R6y5E4Np07Py65cHf1WfEej3mbVQhBY2tqXTML6Cp2L9X+q+KGf8nEMduJxHWig3IcHw
         bGWYEXlfvluyANA+XYlrAFvlv/l/FQStG1Ro+kwr61SlY/DRr5enuN7Sysi/se+6kPfn
         JXyA==
X-Gm-Message-State: AOAM530PycebEsHVxwogsCa5Vb4yst+ikhK1rgaw7C+aQTx7Zjpu/IL1
        Hdz7Ne70BCkF2mVLQfzUOM0=
X-Google-Smtp-Source: ABdhPJzmLtRALLCbQiIs7tIlzevcAi6M2JWuEQVzxfm0jn4DPuJ+1LBl+VRnvTopetmb2sKsLKjt1Q==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr3179404wrv.219.1631366836171;
        Sat, 11 Sep 2021 06:27:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/18] staging: r8188eu: remove unused ODM_Read2Byte()
Date:   Sat, 11 Sep 2021 15:26:30 +0200
Message-Id: <20210911132635.30369-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_Read2Byte() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 31888a6dd9a8..987fad541337 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -10,12 +10,6 @@ u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 	return rtw_read8(Adapter, RegAddr);
 }
 
-u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read16(Adapter, RegAddr);
-}
-
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index ce9e4d8b6830..e87ee60005c8 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -62,8 +62,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
 
-u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
-
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
 
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
-- 
2.33.0

