Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F13D8A54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhG1JLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhG1JLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:11:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927EAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:11:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x14so2178057edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHu9+6E3zn3Ify2B2lOQHD4xYOeH4mkuojnrDPfbLrs=;
        b=tJRTn0Aw/Lz17zLOr8JStE7vmiULzbTCrgxSRnWNqfUASOmkZmaLj5z3FFVeJbj8W6
         keHsK+fCOsoJIXgFQ06EVUIW0w7lNcrdg6qUG2f8MSrnNHIap9h1pge9AMWCZQJeea1D
         wnnr7+G5JRCZXhJtirmftEY7nnGBj5gUYFYr47XV7ym0W8JXhEgxkqy/yaxrZaqITyAZ
         XttsmbesVwsrApKaXMtzbGwZHwl0LBywoMutXyNYc30Gfp9tJCbA3/JjEtsRWsRhqPCY
         5NJOhP3MK6kkQnrBo8fovNHPHD1BRwZLbv7/XnJxK276wdqzZWTZs6b620gtZfOMYLbI
         286A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHu9+6E3zn3Ify2B2lOQHD4xYOeH4mkuojnrDPfbLrs=;
        b=BT/S/gt+N/nElosSVfRcX++7QKlSZAwT1ZuzHEY2MsfvuzK5o8i/tlmC+TdRPxSOQn
         nusqN4VuH+FYAtkS4mqCz9aRkkgSwVGGRQYwvEDNUcVcZ7JNOE30MZhzDnGpv4y+D47x
         IVWmh8cD4+RhFF5OgMFjN5VwwCcrdm6nWEr2WtbIn0eNicLXj58RUtbqd61l/TGklETu
         TxG5G8qwfmrTfamFqUNAn8pqxJ7YBdbB4nI53krbvANPFTc3JSbHL6aqiLo7mbVTzqeU
         UL3y2x5cwoSBEid8V5+wVstYKPyNXavAeYAcTmWqoepqAkYWC7+zvGe8znZFWj2oN0bq
         al6Q==
X-Gm-Message-State: AOAM532GGp/p/tX9Q5sC2QOfN7nKm051HhHCFlvtZFe8vsN+JMEZVrep
        S5lhEtxsMmGyOBiFkpasYwJLymsNLao=
X-Google-Smtp-Source: ABdhPJwrPbMTSNU5gFEP1jlzNu8I+TKcA5TYvt7qK1Ujs40LBiGwvrtIU/lVznzUnGeDXkBa9XMzJw==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr33022193eds.166.1627463481178;
        Wed, 28 Jul 2021 02:11:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id p18sm2322828edu.8.2021.07.28.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:11:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: core: Fix incorrect type in assignment
Date:   Wed, 28 Jul 2021 11:11:17 +0200
Message-Id: <20210728091117.6235-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings: incorrect type in assignment (different base types).

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 --> v2:
Fix incorrect indentation of the fields of a union. Problem detected by
Greg Kroah-Hartman.

 drivers/staging/rtl8723bs/core/rtw_security.c | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..8b507f6a447e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -35,8 +35,10 @@ const char *security_type_str(u8 value)
 */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
-
-	unsigned char crc[4];
+	union {
+		__le32 f0;
+		unsigned char f1[4];
+	} crc;
 
 	signed int	curfragnum, length;
 	u32 keylength;
@@ -69,18 +71,18 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
-				arc4_crypt(ctx, payload + length, crc, 4);
+				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
-				arc4_crypt(ctx, payload + length, crc, 4);
+				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -121,7 +123,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		arc4_crypt(ctx, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
-		*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 	}
 }
@@ -464,7 +466,10 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u32 pnh;
 	u8 rc4key[16];
 	u8   ttkey[16];
-	u8 crc[4];
+	union {
+		__le32 f0;
+		u8 f1[4];
+	} crc;
 	u8   hw_hdr_offset = 0;
 	signed int			curfragnum, length;
 
@@ -506,19 +511,19 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
-					arc4_crypt(ctx, payload + length, crc, 4);
+					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
-					arc4_crypt(ctx, payload + length, crc, 4);
+					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -618,7 +623,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			arc4_setkey(ctx, rc4key, 16);
 			arc4_crypt(ctx, payload, payload, length);
 
-			*((u32 *)crc) = le32_to_cpu(~crc32_le(~0, payload, length - 4));
+			*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
 			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
-- 
2.32.0

