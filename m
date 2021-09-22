Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B94150F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhIVUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhIVUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w17so10315767wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSCnO5rvDNy/iD2c+QoexcZcz8k9dThBLzb6/O0fGr0=;
        b=VYmx1OeTObjdnEjr/+iGftwyxyiKPNRB4AFsn+RNes3rcpewJa4T0xNK56d34ZcOy4
         6g5EuLHe8QVIRt6g44B4kw4osBbB7zCzTC5QTYp5upgGAJCJhazXDZupRQMQ3cO9u7Fu
         40R6wTQnkxHoe72IBsVZmPxn2fjhLcLVZtWJ8hVBBClVa/7pHaSQB4tiZPXmCQPdskAs
         b36DOIGPdhpyt4M1doQFsmlPX6J9NX/fv4odVtyXV6RG/JyZXMqCYXUXwFxnAnnHr3Xa
         f7rtFurLBbzkKj9IoNMb2w1e//xn4H8MwKx5AeIBN5dBbtJ2hVEUxOBmRv19q49izSsn
         drpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSCnO5rvDNy/iD2c+QoexcZcz8k9dThBLzb6/O0fGr0=;
        b=eMRqXonWxQAiiE2PRADdUumyUCEgc4M9EDa+BcxCG+j09CMDOpiERY+qGBbK1hnkEL
         0mTO6ioB+5fNXvDGOaW2Mcd1OLz5SsviOAa2u7kbKz3D62TJ0YKyWZ44eG71vrCWzup1
         UYDJGxv3zSoRa471eliGB6sIXz+YYwjGW4OG8wJOjqR3MJCxbMmgvxokFjcSAATZxmIS
         R6dhLuPUrEm84B6K3vNqQzC6yNwF6TZjNdtHvWsYqGC5bFW2Jf2tmW0kBHr/s6AQ+1I0
         DHpoA0KjG4WYhSNGQ4oVwpsRisXTlkOFjXE6PQ71sxSQRxTCw8dnTvcOV8AVbiD0gCkS
         fa/w==
X-Gm-Message-State: AOAM5335qa0gjVr/55dq+eXTGJ8//r3/2rBQ402aOEt5mtVDQCjI/3YO
        PhFmDn4Lzzo7uHdNlmOg0a0bqcdlBu0Qyg==
X-Google-Smtp-Source: ABdhPJyu64QOxcI4VH2w07QK+7QIhs5fXkJs7Um+27YcZQ/GdSZlQb4Nxsl2g6PWGIB6GAqfsrO3vg==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr890167wrn.400.1632341128945;
        Wed, 22 Sep 2021 13:05:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/47] staging: r8188eu: remove rtw_BT_efuse_map_write()
Date:   Wed, 22 Sep 2021 22:03:37 +0200
Message-Id: <20210922200420.9693-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_BT_efuse_map_write() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 94 ---------------------
 drivers/staging/r8188eu/include/rtw_efuse.h |  2 -
 2 files changed, 96 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index ef7a50d31c01..010740d035ea 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -406,100 +406,6 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	return ret;
 }
 
-u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
-{
-	u8 offset, word_en;
-	u8 *map;
-	u8 newdata[PGPKT_DATA_SIZE + 1];
-	s32	i, idx;
-	u8 ret = _SUCCESS;
-	u16 mapLen = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
-
-	if ((addr + cnts) > mapLen)
-		return _FAIL;
-
-	map = kzalloc(mapLen, GFP_KERNEL);
-	if (!map)
-		return _FAIL;
-
-	ret = rtw_BT_efuse_map_read(padapter, 0, mapLen, map);
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
-			DBG_88E("%s: offset=%#X\n", __func__, offset);
-			DBG_88E("%s: word_en=%#X\n", __func__, word_en);
-			DBG_88E("%s: data=", __func__);
-			for (i = 0; i < PGPKT_DATA_SIZE; i++)
-				DBG_88E("0x%02X ", newdata[i]);
-			DBG_88E("\n");
-
-			break;
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
-
-exit:
-
-	kfree(map);
-
-	return ret;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	Efuse_ReadAllMap
  *
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index de98b732fce0..02cbadb2ec2b 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -107,8 +107,6 @@ u8 rtw_efuse_map_read(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
 u8 rtw_efuse_map_write(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
 u8 rtw_BT_efuse_map_read(struct adapter *adapter, u16 addr,
 			 u16 cnts, u8 *data);
-u8 rtw_BT_efuse_map_write(struct adapter *adapter, u16 addr,
-			  u16 cnts, u8 *data);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
-- 
2.33.0

