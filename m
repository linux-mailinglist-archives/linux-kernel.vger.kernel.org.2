Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983634150F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhIVUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbhIVUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:06:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so10315517wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=So4uie0HiP7WQjSXZrgcgIwmM4TdpiWLeMD3d0z1vw8=;
        b=PgqtkcHRGPRv7TXV6nD3EeMqESrSMfAQp8WOxvYLW5KnIuQQlgsxFsEmbBrAYV14Zm
         9vqFCQOB5dhFkGmlrhszfVlj7ZuXXk/uzKEeLdThIhdD+a8exiGLiJ8xc/SsBJGTBbar
         +opeuIJdh03prCdFELeVEQkzG5mviahmA3+AzlL4pilW/F5Uhc3LQQalZIdY51uj8zMb
         2TgRQFpDTcre7Jei52dt7IYKSzgsV5kxoxpB9tWmVZ+dmJbpX/cWR7lw96ClwBwafR00
         dfIc8Le/WBCrzjLHeAVTDVVnh2B6uHeDqqAfDQjEUDAw+Y3M4klaQg6d/NcZ29dIjRix
         RtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=So4uie0HiP7WQjSXZrgcgIwmM4TdpiWLeMD3d0z1vw8=;
        b=iV3n9FZEODhblyfAO4e8dDp6uVJRZ0KaACkR8dFPrfmHkI3TlxBxL4dWvgfn8IxE6v
         wnhKSrGjon9KVMztAa926xiI35V2Ol5ZeLfj267fvESxZCc/mMonBEDICsoM72rvYS8R
         2Tqd+YpIWh7G1DwDwmty2Haq9nv4FGiRFMW5+kCSWhTuA+dj8cbaT/Moj07qS039DLTQ
         0vwqt4C7tYCOMOXuX8pRT428EF7NJujNU7WoqQfOH6+MHtY4ny+6AlOw41MRniUQc7Hh
         KAGstrUEB/SjtPP+ASGEXxFiyL+IcoSsO3QAy1x4ZpJ0b6ns2SDeROmmYNonSNdkOyaG
         cUZw==
X-Gm-Message-State: AOAM531KbSv7LurPYF9MlAI7FT3cMnRQwK6dX4Ct1swCfD8x3HheVg+Z
        4tt2TOIxVMgOR2RDmmaw9gwWGm6n+/3z7g==
X-Google-Smtp-Source: ABdhPJyBPJJgtGVivVgt+3OJLWAAPQ4v+rdRy91ItAm+K62S+wBgXQfPM4bq0NaFHyn+/T4ueagVAQ==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr882801wru.127.1632341126592;
        Wed, 22 Sep 2021 13:05:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/47] staging: r8188eu: remove EFUSE_ShadowRead()
Date:   Wed, 22 Sep 2021 22:03:34 +0200
Message-Id: <20210922200420.9693-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function EFUSE_ShadowRead() is not used, remove it. It is the only
user of the functions efuse_ShadowRead{1,2,4}Byte, remove these as
well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 87 ---------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 2 files changed, 88 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 801887f497cf..958954473d9b 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -516,66 +516,6 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 	return ret;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	efuse_ShadowRead1Byte
- *			efuse_ShadowRead2Byte
- *			efuse_ShadowRead4Byte
- *
- * Overview:	Read from efuse init map by one/two/four bytes !!!!!
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/12/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-static void
-efuse_ShadowRead1Byte(
-		struct adapter *pAdapter,
-		u16 Offset,
-		u8 *Value)
-{
-	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
-
-	*Value = pEEPROM->efuse_eeprom_data[Offset];
-
-}	/*  EFUSE_ShadowRead1Byte */
-
-/* Read Two Bytes */
-static void
-efuse_ShadowRead2Byte(
-		struct adapter *pAdapter,
-		u16 Offset,
-		u16 *Value)
-{
-	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
-
-	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
-
-}	/*  EFUSE_ShadowRead2Byte */
-
-/* Read Four Bytes */
-static void
-efuse_ShadowRead4Byte(
-		struct adapter *pAdapter,
-		u16 Offset,
-		u32 *Value)
-{
-	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
-
-	*Value = pEEPROM->efuse_eeprom_data[Offset];
-	*Value |= pEEPROM->efuse_eeprom_data[Offset + 1] << 8;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset + 2] << 16;
-	*Value |= pEEPROM->efuse_eeprom_data[Offset + 3] << 24;
-
-}	/*  efuse_ShadowRead4Byte */
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
@@ -636,30 +576,3 @@ void EFUSE_ShadowMapUpdate(
 	else
 		Efuse_ReadAllMap(pAdapter, efuseType, pEEPROM->efuse_eeprom_data, pseudo);
 } /*  EFUSE_ShadowMapUpdate */
-
-/*-----------------------------------------------------------------------------
- * Function:	EFUSE_ShadowRead
- *
- * Overview:	Read from efuse init map !!!!!
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/12/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-void EFUSE_ShadowRead(struct adapter *pAdapter, u8 Type, u16 Offset, u32 *Value)
-{
-	if (Type == 1)
-		efuse_ShadowRead1Byte(pAdapter, Offset, (u8 *)Value);
-	else if (Type == 2)
-		efuse_ShadowRead2Byte(pAdapter, Offset, (u16 *)Value);
-	else if (Type == 4)
-		efuse_ShadowRead4Byte(pAdapter, Offset, (u32 *)Value);
-
-}	/*  EFUSE_ShadowRead */
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 53ac906f79fd..81407efbdc44 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -119,6 +119,5 @@ u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
 
 void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
-void EFUSE_ShadowRead(struct adapter *adapt, u8 type, u16 offset, u32 *val);
 
 #endif
-- 
2.33.0

