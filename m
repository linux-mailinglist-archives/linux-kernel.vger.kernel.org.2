Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B594150F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhIVUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhIVUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0297AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d21so10281304wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2kZHTtNsdaxdPMqGjhb0b1o6l7/J6zD702r/5mJMpo=;
        b=EVXUvaF1L9ojLya4VCTj2wjY9f/3s3Dl6kLTr/F9o4SfGKSi3eMaCQyH1UIouhYb9V
         V9YqmO8y11sdU3Z47M2hz/XP2WY1I2O3+s8vkwFXhraRYNcJrWCAi34WsY/u7ifh5jtC
         Px96AeXygcUzI72WqjAKdEDqwR6p2pOPBsias2FZTDoBHPZWNMgLQI28YsTHKCS18vYg
         fGUD/E4I75Y4L83+oKI6LNdAD8Okj6S8OiYEEUt245/TO+eTfebSewmhL3xVw1WGwYb7
         g0r0f8kGwxfPcOcF2p7h/G4cf0+RWpN3p2c21PJPTXP0g3ZHjRGbXOiZCO5ZXGMFFZfT
         fZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2kZHTtNsdaxdPMqGjhb0b1o6l7/J6zD702r/5mJMpo=;
        b=15rBQBstfN918ebVcBcBhwp/bhrTuD5dxQbofvCMfgNmkGPgbCE4KcV5OW6F67invt
         8z1k2quD7Zaad99NKaVTMt5dbkpsz4fI4K32HQmaphXbEcRCpWBvqyrS9hGdWs3WGkKm
         3w6cge/ltOHK8HghSAfSOKxCt59WRl2mXCyAVyo5PkpTEVfqdz7dpq1z8Jf/5hfZjQbQ
         s2Cnm8ErtcWp5i+Yyj3pJcgxeiqNJEm0HP9zB0wdkuX/T9tUiYswnCLvcnplOh8TQ2DK
         ApntIhmJZjpevfueKveE8bqH5oL8dVM9dDY9rMnMbOkhcKMHm0cZbQ5cSTBgNNwG/ySN
         uSsQ==
X-Gm-Message-State: AOAM532JAk2Pb2olZD2BcmsSbM7AYE+fJ9ag9+uTJuALW5dOhek78iiq
        bTI7rIDeY2Fx9FwGfrYimH4=
X-Google-Smtp-Source: ABdhPJznL3P6qNOvLn4oNq9E2MMmmgUlWbsh5MzUZkBW/byghu9gENJLuPQaISpa4+FNPNA4YcpgkA==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr800342wro.425.1632341130670;
        Wed, 22 Sep 2021 13:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/47] staging: r8188eu: remove rtw_efuse_map_write()
Date:   Wed, 22 Sep 2021 22:03:39 +0200
Message-Id: <20210922200420.9693-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_efuse_map_write() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 91 ---------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 2 files changed, 92 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 893287e50d9c..a55e4861054c 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -262,97 +262,6 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	return _SUCCESS;
 }
 
-u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
-{
-	u8 offset, word_en;
-	u8 *map;
-	u8 newdata[PGPKT_DATA_SIZE + 1];
-	s32	i, idx;
-	u8 ret = _SUCCESS;
-	u16 mapLen = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
-
-	if ((addr + cnts) > mapLen)
-		return _FAIL;
-
-	map = kzalloc(mapLen, GFP_KERNEL);
-	if (!map)
-		return _FAIL;
-
-	ret = rtw_efuse_map_read(padapter, 0, mapLen, map);
-	if (ret == _FAIL)
-		goto exit;
-
-	rtl8188e_EfusePowerSwitch(padapter, true, true);
-
-	offset = (addr >> 3);
-	word_en = 0xF;
-	memset(newdata, 0xFF, PGPKT_DATA_SIZE + 1);
-	i = addr & 0x7;	/*  index of one package */
-	idx = 0;	/*  data index */
-
-	if (i & 0x1) {
-		/*  odd start */
-		if (data[idx] != map[addr + idx]) {
-			word_en &= ~BIT(i >> 1);
-			newdata[i - 1] = map[addr + idx - 1];
-			newdata[i] = data[idx];
-		}
-		i++;
-		idx++;
-	}
-	do {
-		for (; i < PGPKT_DATA_SIZE; i += 2) {
-			if (cnts == idx)
-				break;
-			if ((cnts - idx) == 1) {
-				if (data[idx] != map[addr + idx]) {
-					word_en &= ~BIT(i >> 1);
-					newdata[i] = data[idx];
-					newdata[i + 1] = map[addr + idx + 1];
-				}
-				idx++;
-				break;
-			} else {
-				if ((data[idx] != map[addr + idx]) ||
-				    (data[idx + 1] != map[addr + idx + 1])) {
-					word_en &= ~BIT(i >> 1);
-					newdata[i] = data[idx];
-					newdata[i + 1] = data[idx + 1];
-				}
-				idx += 2;
-			}
-			if (idx == cnts)
-				break;
-		}
-
-		if (word_en != 0xF) {
-			ret = rtl8188e_Efuse_PgPacketWrite(padapter, offset, word_en, newdata, false);
-			DBG_88E("offset=%x\n", offset);
-			DBG_88E("word_en=%x\n", word_en);
-
-			for (i = 0; i < PGPKT_DATA_SIZE; i++)
-				DBG_88E("data=%x \t", newdata[i]);
-			if (ret == _FAIL)
-				break;
-		}
-
-		if (idx == cnts)
-			break;
-
-		offset++;
-		i = 0;
-		word_en = 0xF;
-		memset(newdata, 0xFF, PGPKT_DATA_SIZE);
-	} while (1);
-
-	rtl8188e_EfusePowerSwitch(padapter, true, false);
-exit:
-	kfree(map);
-	return ret;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index f0236a89d731..c7ce63985c7a 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -102,7 +102,6 @@ extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 rtw_efuse_map_read(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
-u8 rtw_efuse_map_write(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
 u8 rtw_BT_efuse_map_read(struct adapter *adapter, u16 addr,
 			 u16 cnts, u8 *data);
 u8 Efuse_CalculateWordCnts(u8 word_en);
-- 
2.33.0

