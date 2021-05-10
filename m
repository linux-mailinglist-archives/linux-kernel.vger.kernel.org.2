Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7A378E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhEJNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349679AbhEJMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:49:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE4C06125E
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s8so16499253wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6ORWNDRWgJRlfhAvZzg8AauiJB0VBHlunLMV8gEMLg=;
        b=GPptq1eQCHiI0AlF6t2sxmbll7W1HaiupRpJ9C3GlPVGxwbnlTT2PQlK9UlNim+YqF
         qfSA7SChfFQExNkFc6HCiL+qnq/uxJHZ90Wm+9wC7X5VDQdQklnODWP3g0akKHrKWY7D
         WZjvr2lYtFMMCJ92Qi3y8s2iXVlT6UqOIjfSP+WIdejrDUJBAS0gNdeu17wVpn1wwvhs
         BEqgcFL0KHetIcYegW9KEHVdZMdm84Bwp6yP6hv9UDaHr6Jxwr5flIdQiFeAvNJ3ieQr
         oQDXp0sjRbzHs5m2hNxMt6iQBsOYNiAHBk/YSQibXlBldnkgPznPaF431WoSJ/nsiFfS
         Ix7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6ORWNDRWgJRlfhAvZzg8AauiJB0VBHlunLMV8gEMLg=;
        b=uRcKJTzbmFBxqL5XrH65nek/9y1cqGSLXOiBDIr3PTRec4rcIBQPKc/VxbflCQGycp
         3Zyyv9ebTk9OOtbtN6yJ4y/9EZv2PRzX8o8eWk+EEM+ytZziUgTm+urhVBhFsIzCHEYt
         h3jshLcP6Myv8i0J+6FC5DSbPNoKQbIY4JHcElMkCdaGh1klrvpN28OdecLmPx7YjZCR
         SOUOq3x0dECas5o3qNUxdgwIIVWQ/DxjMfQI3JXbhWgBneTCGgqMXOfCNWDNZzjIx/mZ
         wF4i2+EFtmibzUGsQoyT1zSAl/PMpaiYcm7Tggf9j7qwAIxT0jFyav2HdfCNTCHgX+xb
         FH6w==
X-Gm-Message-State: AOAM532EuSxd37yObr1vSLEPDHwgu/EhQVZ4Pd342gNJxXAvGRXpwZlg
        XIpEGRSwDf2NGC0NYx0WFYL51PobZTk5rw==
X-Google-Smtp-Source: ABdhPJzycJrMbWbQ7b+6d08uVhDNA5epOuwDVSE7rf06QYG36SBoZerrs/bYNXBBEjvmQETS0KrA4w==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr29646246wrt.179.1620650782661;
        Mon, 10 May 2021 05:46:22 -0700 (PDT)
Received: from agape ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id q4sm22035162wrs.21.2021.05.10.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:46:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: replace private CRC-32 routines with in-kernel ones
Date:   Mon, 10 May 2021 14:46:18 +0200
Message-Id: <0ef23c56edb17e459b1ad9266f602da56b6e6716.1620650484.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620650484.git.fabioaiuto83@gmail.com>
References: <cover.1620650484.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private CRC-32 routines with in-kernel ones.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 66 ++-----------------
 1 file changed, 7 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 19f96025aea6..bee1b2e2504e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -4,7 +4,7 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#include <linux/crc32poly.h>
+#include <linux/crc32.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <crypto/aes.h>
@@ -31,58 +31,6 @@ const char *security_type_str(u8 value)
 
 /* WEP related ===== */
 
-static signed int bcrc32initialized;
-static u32 crc32_table[256];
-
-
-static u8 crc32_reverseBit(u8 data)
-{
-	return((u8)((data<<7)&0x80) | ((data<<5)&0x40) | ((data<<3)&0x20) | ((data<<1)&0x10) | ((data>>1)&0x08) | ((data>>3)&0x04) | ((data>>5)&0x02) | ((data>>7)&0x01));
-}
-
-static void crc32_init(void)
-{
-	if (bcrc32initialized == 1)
-		return;
-	else {
-		signed int i, j;
-		u32 c;
-		u8 *p = (u8 *)&c, *p1;
-		u8 k;
-
-		c = 0x12340000;
-
-		for (i = 0; i < 256; ++i) {
-			k = crc32_reverseBit((u8)i);
-			for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
-			p1 = (u8 *)&crc32_table[i];
-
-			p1[0] = crc32_reverseBit(p[3]);
-			p1[1] = crc32_reverseBit(p[2]);
-			p1[2] = crc32_reverseBit(p[1]);
-			p1[3] = crc32_reverseBit(p[0]);
-		}
-		bcrc32initialized = 1;
-	}
-}
-
-static __le32 getcrc32(u8 *buf, signed int len)
-{
-	u8 *p;
-	u32  crc;
-
-	if (bcrc32initialized == 0)
-		crc32_init();
-
-	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
-
-	for (p = buf; len > 0; ++p, --len)
-		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
-}
-
-
 /*
 	Need to consider the fragment  situation
 */
@@ -122,7 +70,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
-				*((__le32 *)crc) = getcrc32(payload, length);
+				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
 				arc4_setkey(&mycontext, wepkey, 3 + keylength);
 				arc4_crypt(&mycontext, payload, payload, length);
@@ -130,7 +78,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = getcrc32(payload, length);
+				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 				arc4_setkey(&mycontext, wepkey, 3 + keylength);
 				arc4_crypt(&mycontext, payload, payload, length);
 				arc4_crypt(&mycontext, payload + length, crc, 4);
@@ -174,7 +122,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(&mycontext, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
+		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
 
 	}
 }
@@ -559,7 +507,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
 
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
@@ -567,7 +515,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
 					arc4_crypt(&mycontext, payload + length, crc, 4);
@@ -670,7 +618,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(&mycontext, rc4key, 16);
 			arc4_crypt(&mycontext, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
+			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.20.1

