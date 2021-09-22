Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78234150F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhIVUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhIVUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d6so10288506wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1P1gqXNu3vCPl5xPAOjYrMlPBx+j2k44ybuqnwvTH0=;
        b=YaN/VRWdUHm4KFO6EmBYmQV0ORRL1DdPlyz9ckP8LBptgmenmwPuLxBdLPPz2Kvqhw
         o0lMRD3LUO7gN1HK6SqOEasDNlVTFAVbqkwFtnmfVCaoRCZ6c/GbRG7oZvU6CQi8g+ID
         XpGo14Jh+IRMCRcJaEqP9HyXg45ZNWRZ0q3orGJHCCc/cVmGmmay9CO/P9MXajZpuNro
         iMuOejeJ59izumM0o1J8Y7iRXiVKKJzeaJ16006nkRifYmir9lPMnD89qoyki7n3NUMM
         Pe6a7ORJyN5ZAso61tXzaUVVS9gMki/Gs/9VA5iQc3gJfIBgot+DA70NmgYcS6pUkTUm
         ym7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1P1gqXNu3vCPl5xPAOjYrMlPBx+j2k44ybuqnwvTH0=;
        b=EhvcQM0I5e+9FxaYfWuBHBLmfXybX6GOMGAgB6U+gvywyF1EdZ68BHYe/QgFQBZYYN
         +s8pUbe8T2gj6aWi5tx/5Clhk273w/q9MnCVTV9gnX3vTUBbGsv+ojRNz0lYY7+MKyow
         UzuWB8WXjq3CPcPWttTJfJPFOLvE3EFUBH2P3slqh5//8fpdTRXbMpZpoz6oc3B4dmtI
         4UgQDYwKS9giAhO3IZlPgppWzG9UGJ23PVMowJEHNr18tee1Y+skE75RQIHYIsGdNPFC
         Lstf89Z5UkgM8EW2m0sQJvtwWPadA2oqNy7rRUEpbRX7tUSSp3xGrLdm4Js1WoxCXXY+
         kDeg==
X-Gm-Message-State: AOAM531kLlchy29/0ISpmBG7/UuONBr9GkwWBbsr/WTiudnMFoN4j61J
        xdkJZNr8KfQc/f/52cv+mBA=
X-Google-Smtp-Source: ABdhPJwZp2dd7bbQmrzXX6Cjnanyqd6boEs18l3H6SaTHBpDAV50i+2DkQL927Z583x8iyMqb48M/Q==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr921930wrr.246.1632341131455;
        Wed, 22 Sep 2021 13:05:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/47] staging: r8188eu: remove rtw_BT_efuse_map_read()
Date:   Wed, 22 Sep 2021 22:03:40 +0200
Message-Id: <20210922200420.9693-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_BT_efuse_map_read() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 18 ------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index a55e4861054c..4b97ce488b21 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -244,24 +244,6 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	return _SUCCESS;
 }
 
-u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
-{
-	u16 mapLen = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
-
-	if ((addr + cnts) > mapLen)
-		return _FAIL;
-
-	rtl8188e_EfusePowerSwitch(padapter, false, true);
-
-	rtl8188e_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
-
-	rtl8188e_EfusePowerSwitch(padapter, false, false);
-
-	return _SUCCESS;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index c7ce63985c7a..39b30ee1bae2 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -102,8 +102,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 rtw_efuse_map_read(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
-u8 rtw_BT_efuse_map_read(struct adapter *adapter, u16 addr,
-			 u16 cnts, u8 *data);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
-- 
2.33.0

