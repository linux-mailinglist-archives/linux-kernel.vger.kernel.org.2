Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0537613E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhEGHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhEGHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:37:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C7C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:36:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so8119985wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHOjqEF6UVlzjeZHb+7Vr9m86VChb9YZwhcDczJQmlc=;
        b=sWv4uexfwDvY6fm7ndIjaaIlTcmNxN/OSciwOvOLqs+UT+9fk3wMVxXpYZHBtDORC8
         VNB06FVeMeaNoJP44/Z/B2I4Fb/I+FJf5JoW4KnGdVEpYXXfTw9BAUN8dD2azXO/a/ad
         usLq7R2wFRklKaxcZwmwrlay3ZnN4PxYkD52wOpySCpVzpd+l40JwW3JyvlXYNWH3X8T
         IjXUmAlxYTV4bYDZwxHbJ9Mn5fGWgVGLZIiNmtPwIwDkiNxYg/Eb7zVh/upsayYxhYG6
         701PqkDdx3dJc/8aMO92F7RCiMyRbXl//Ahgw60GoL/1RPWeR4USGiMUdtOWXDvc9Trt
         8jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHOjqEF6UVlzjeZHb+7Vr9m86VChb9YZwhcDczJQmlc=;
        b=VB0YSxkg3ea+uQKvg1teecGGuP8CSkfoDLq136QS6+kP0XKdeeedwg+fL6djnF9rgv
         HyYgaQOicsSuIFvwg4GfS/+rGuNo3iW7YS9zlR1Aeecpyl2NRtO3E5HOLsks7XD92q1O
         8eM68jodMOKtUZ3iwQCLH66irXcx1Sf7QDUoYsxNubCsbh28ofnots50QkpM2XKR5eG7
         PT25bCuKrwoPtsgn1lzi7xgDJ0Q4iu9WFmd+PbQl92L3MD1Q6/o9vfQysxDQDbTEJipm
         1x+T80tfue3wb5uyN+8IIuzHnoM6Ao8i7lmc5AnXeysHZbI4x6VOBtZ0RMr6JxI5m/hB
         nJGQ==
X-Gm-Message-State: AOAM533tda2Dl56U0jbJbE+T1/WjWrjT639xADA+vYb261RwtzSyvw9q
        U2JeYwc6QL3ThLdNaqXsJbuPEyeYkqaDuQ==
X-Google-Smtp-Source: ABdhPJzNDGyER8rNz2g2QXh7wNbazrsEwgzVtoSp6niDJmysDoLcjEcf19nlCemPn3bYtjesaRxbDg==
X-Received: by 2002:adf:d0cd:: with SMTP id z13mr10479375wrh.373.1620372967794;
        Fri, 07 May 2021 00:36:07 -0700 (PDT)
Received: from agape ([5.171.80.53])
        by smtp.gmail.com with ESMTPSA id u5sm7618459wrt.38.2021.05.07.00.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:36:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8723bs: replace private arc4 encryption with in-kernel one
Date:   Fri,  7 May 2021 09:36:00 +0200
Message-Id: <af960dc728f039d64f4fb28fcece3ca92d24fbe4.1620372584.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620372584.git.fabioaiuto83@gmail.com>
References: <cover.1620372584.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private arc4 encryption with in-kernel one.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 101 ++++--------------
 1 file changed, 21 insertions(+), 80 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bd723c80192a..19f96025aea6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -8,6 +8,7 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <crypto/aes.h>
+#include <crypto/arc4.h>
 
 static const char * const _security_type_str[] = {
 	"N/A",
@@ -30,66 +31,6 @@ const char *security_type_str(u8 value)
 
 /* WEP related ===== */
 
-struct arc4context {
-	u32 x;
-	u32 y;
-	u8 state[256];
-};
-
-
-static void arcfour_init(struct arc4context	*parc4ctx, u8 *key, u32 key_len)
-{
-	u32 t, u;
-	u32 keyindex;
-	u32 stateindex;
-	u8 *state;
-	u32 counter;
-
-	state = parc4ctx->state;
-	parc4ctx->x = 0;
-	parc4ctx->y = 0;
-	for (counter = 0; counter < 256; counter++)
-		state[counter] = (u8)counter;
-	keyindex = 0;
-	stateindex = 0;
-	for (counter = 0; counter < 256; counter++) {
-		t = state[counter];
-		stateindex = (stateindex + key[keyindex] + t) & 0xff;
-		u = state[stateindex];
-		state[stateindex] = (u8)t;
-		state[counter] = (u8)u;
-		if (++keyindex >= key_len)
-			keyindex = 0;
-	}
-}
-
-static u32 arcfour_byte(struct arc4context	*parc4ctx)
-{
-	u32 x;
-	u32 y;
-	u32 sx, sy;
-	u8 *state;
-
-	state = parc4ctx->state;
-	x = (parc4ctx->x + 1) & 0xff;
-	sx = state[x];
-	y = (sx + parc4ctx->y) & 0xff;
-	sy = state[y];
-	parc4ctx->x = x;
-	parc4ctx->y = y;
-	state[y] = (u8)sx;
-	state[x] = (u8)sy;
-	return state[(sx + sy) & 0xff];
-}
-
-static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32 len)
-{
-	u32 i;
-
-	for (i = 0; i < len; i++)
-		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
-}
-
 static signed int bcrc32initialized;
 static u32 crc32_table[256];
 
@@ -149,7 +90,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
 
 	unsigned char crc[4];
-	struct arc4context	 mycontext;
+	struct arc4_ctx	mycontext;
 
 	signed int	curfragnum, length;
 	u32 keylength;
@@ -183,16 +124,16 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				*((__le32 *)crc) = getcrc32(payload, length);
 
-				arcfour_init(&mycontext, wepkey, 3+keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
+				arc4_setkey(&mycontext, wepkey, 3 + keylength);
+				arc4_crypt(&mycontext, payload, payload, length);
+				arc4_crypt(&mycontext, payload + length, crc, 4);
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 				*((__le32 *)crc) = getcrc32(payload, length);
-				arcfour_init(&mycontext, wepkey, 3+keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload+length, crc, 4);
+				arc4_setkey(&mycontext, wepkey, 3 + keylength);
+				arc4_crypt(&mycontext, payload, payload, length);
+				arc4_crypt(&mycontext, payload + length, crc, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -205,7 +146,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
 	u8 crc[4];
-	struct arc4context	 mycontext;
+	struct arc4_ctx	 mycontext;
 	signed int	length;
 	u32 keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
@@ -229,8 +170,8 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3+keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
+		arc4_setkey(&mycontext, wepkey, 3 + keylength);
+		arc4_crypt(&mycontext, payload, payload,  length);
 
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
@@ -578,7 +519,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u8   ttkey[16];
 	u8 crc[4];
 	u8   hw_hdr_offset = 0;
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	signed int			curfragnum, length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -620,16 +561,16 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
 
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
+					arc4_setkey(&mycontext, rc4key, 16);
+					arc4_crypt(&mycontext, payload, payload, length);
+					arc4_crypt(&mycontext, payload + length, crc, 4);
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
+					arc4_setkey(&mycontext, rc4key, 16);
+					arc4_crypt(&mycontext, payload, payload, length);
+					arc4_crypt(&mycontext, payload + length, crc, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)round_up((SIZE_PTR)(pframe), 4);
@@ -649,7 +590,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u8   rc4key[16];
 	u8   ttkey[16];
 	u8 crc[4];
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	signed int			length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -726,8 +667,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			/* 4 decrypt payload include icv */
 
-			arcfour_init(&mycontext, rc4key, 16);
-			arcfour_encrypt(&mycontext, payload, payload, length);
+			arc4_setkey(&mycontext, rc4key, 16);
+			arc4_crypt(&mycontext, payload, payload, length);
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-- 
2.20.1

