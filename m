Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7348F35ADB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhDJNgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:36:13 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:58796 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhDJNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:36:10 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d61 with ME
        id r1bt2400J3g7mfN031btbK; Sat, 10 Apr 2021 15:35:54 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Apr 2021 15:35:54 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] staging: rtl8723bs: Use existing arc4 implementation
Date:   Sat, 10 Apr 2021 15:35:52 +0200
Message-Id: <6a4aebf9feb9ece975734f2e51da5ecae2996cee.1618055514.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <7e16c40d5baa007dca81a12b967a597ed00d8dd7.1618055514.git.christophe.jaillet@wanadoo.fr>
References: <7e16c40d5baa007dca81a12b967a597ed00d8dd7.1618055514.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use functions provided by <crypto/arc4.h> instead of hand writing them.

The implementations are slightly different, but are equivalent. It has
been checked with a test program which compares the output of the 2 sets of
functions.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 101 ++++--------------
 1 file changed, 21 insertions(+), 80 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 9587d89a6b24..86949a65e96f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -6,6 +6,7 @@
  ******************************************************************************/
 #define  _RTW_SECURITY_C_
 
+#include <crypto/arc4.h>
 #include <linux/crc32poly.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
@@ -31,66 +32,6 @@ const char *security_type_str(u8 value)
 
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
 
@@ -150,7 +91,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
 
 	unsigned char crc[4];
-	struct arc4context	 mycontext;
+	struct arc4_ctx mycontext;
 
 	signed int	curfragnum, length;
 	u32 keylength;
@@ -184,16 +125,16 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
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
@@ -206,7 +147,7 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 {
 	/*  exclude ICV */
 	u8 crc[4];
-	struct arc4context	 mycontext;
+	struct arc4_ctx mycontext;
 	signed int	length;
 	u32 keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
@@ -230,8 +171,8 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		payload = pframe+prxattrib->iv_len+prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3+keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
+		arc4_setkey(&mycontext, wepkey, 3 + keylength);
+		arc4_crypt(&mycontext, payload, payload, length);
 
 		/* calculate icv and compare the icv */
 		*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
@@ -579,7 +520,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	u8   ttkey[16];
 	u8 crc[4];
 	u8   hw_hdr_offset = 0;
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	signed int			curfragnum, length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -621,16 +562,16 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
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
@@ -650,7 +591,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	u8   rc4key[16];
 	u8   ttkey[16];
 	u8 crc[4];
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	signed int			length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -721,8 +662,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 
 			/* 4 decrypt payload include icv */
 
-			arcfour_init(&mycontext, rc4key, 16);
-			arcfour_encrypt(&mycontext, payload, payload, length);
+			arc4_setkey(&mycontext, rc4key, 16);
+			arc4_crypt(&mycontext, payload, payload, length);
 
 			*((u32 *)crc) = le32_to_cpu(getcrc32(payload, length-4));
 
-- 
2.27.0

