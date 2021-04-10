Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A472435AD1E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhDJL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:57:15 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:48137 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJL5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:57:13 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d50 with ME
        id qzwx2400d3g7mfN03zwy1i; Sat, 10 Apr 2021 13:56:58 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Apr 2021 13:56:58 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] staging: rtl8712: Use existing arc4 implementation
Date:   Sat, 10 Apr 2021 13:56:57 +0200
Message-Id: <a793f56d34e53397607df54c683943d2c48b84f7.1618055514.git.christophe.jaillet@wanadoo.fr>
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
 drivers/staging/rtl8712/rtl871x_security.c | 118 +++++----------------
 1 file changed, 29 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 1c7df65db3c9..b546e2f19620 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -16,6 +16,7 @@
 
 #define  _RTL871X_SECURITY_C_
 
+#include <crypto/arc4.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -38,66 +39,6 @@
 
 /* =====WEP related===== */
 
-struct arc4context {
-	u32 x;
-	u32 y;
-	u8 state[256];
-};
-
-static void arcfour_init(struct arc4context *parc4ctx, u8 *key, u32 key_len)
-{
-	u32	t, u;
-	u32	keyindex;
-	u32	stateindex;
-	u8 *state;
-	u32	counter;
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
-static u32 arcfour_byte(struct arc4context *parc4ctx)
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
-static void arcfour_encrypt(struct arc4context	*parc4ctx,
-		     u8 *dest, u8 *src, u32 len)
-{
-	u32 i;
-
-	for (i = 0; i < len; i++)
-		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
-}
-
 static sint bcrc32initialized;
 static u32 crc32_table[256];
 
@@ -151,7 +92,7 @@ static u32 getcrc32(u8 *buf, u32 len)
 void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 {	/* exclude ICV */
 	unsigned char	crc[4];
-	struct arc4context  mycontext;
+	struct arc4_ctx  mycontext;
 	u32 curfragnum, length, keylength, pki;
 	u8 *pframe, *payload, *iv;    /*,*wepkey*/
 	u8 wepkey[16];
@@ -182,22 +123,22 @@ void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 					pattrib->icv_len;
 				*((__le32 *)crc) = cpu_to_le32(getcrc32(
 						payload, length));
-				arcfour_init(&mycontext, wepkey, 3 + keylength);
-				arcfour_encrypt(&mycontext, payload, payload,
-						length);
-				arcfour_encrypt(&mycontext, payload + length,
-						crc, 4);
+				arc4_setkey(&mycontext, wepkey, 3 + keylength);
+				arc4_crypt(&mycontext, payload, payload,
+					   length);
+				arc4_crypt(&mycontext, payload + length,
+					   crc, 4);
 			} else {
 				length = pxmitpriv->frag_len -
 					 pattrib->hdrlen - pattrib->iv_len -
 					 pattrib->icv_len;
 				*((__le32 *)crc) = cpu_to_le32(getcrc32(
 						payload, length));
-				arcfour_init(&mycontext, wepkey, 3 + keylength);
-				arcfour_encrypt(&mycontext, payload, payload,
-						length);
-				arcfour_encrypt(&mycontext, payload + length,
-						crc, 4);
+				arc4_setkey(&mycontext, wepkey, 3 + keylength);
+				arc4_crypt(&mycontext, payload, payload,
+					   length);
+				arc4_crypt(&mycontext, payload + length,
+					   crc, 4);
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)RND4((addr_t)(pframe));
 			}
@@ -209,7 +150,7 @@ void r8712_wep_decrypt(struct _adapter  *padapter, u8 *precvframe)
 {
 	/* exclude ICV */
 	u8 crc[4];
-	struct arc4context  mycontext;
+	struct arc4_ctx mycontext;
 	u32 length, keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
 	u8  keyindex;
@@ -233,8 +174,8 @@ void r8712_wep_decrypt(struct _adapter  *padapter, u8 *precvframe)
 			   u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3 + keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
+		arc4_setkey(&mycontext, wepkey, 3 + keylength);
+		arc4_crypt(&mycontext, payload, payload, length);
 		/* calculate icv and compare the icv */
 		*((__le32 *)crc) = cpu_to_le32(getcrc32(payload, length - 4));
 	}
@@ -563,7 +504,7 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 	u8 rc4key[16];
 	u8 ttkey[16];
 	u8 crc[4];
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	u32 curfragnum, length;
 
 	u8 *pframe, *payload, *iv, *prwskey;
@@ -606,11 +547,11 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 					     pattrib->icv_len;
 					*((__le32 *)crc) = cpu_to_le32(
 						getcrc32(payload, length));
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload,
-							payload, length);
-					arcfour_encrypt(&mycontext, payload +
-							length, crc, 4);
+					arc4_setkey(&mycontext, rc4key, 16);
+					arc4_crypt(&mycontext, payload,
+						   payload, length);
+					arc4_crypt(&mycontext, payload +
+						   length, crc, 4);
 				} else {
 					length = pxmitpriv->frag_len -
 						 pattrib->hdrlen -
@@ -618,12 +559,11 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 						 pattrib->icv_len;
 					*((__le32 *)crc) = cpu_to_le32(getcrc32(
 							payload, length));
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload,
-							 payload, length);
-					arcfour_encrypt(&mycontext,
-							payload + length, crc,
-							4);
+					arc4_setkey(&mycontext, rc4key, 16);
+					arc4_crypt(&mycontext, payload,
+						   payload, length);
+					arc4_crypt(&mycontext,
+						   payload + length, crc, 4);
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)RND4((addr_t)(pframe));
 				}
@@ -643,7 +583,7 @@ void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe)
 	u8 rc4key[16];
 	u8 ttkey[16];
 	u8 crc[4];
-	struct arc4context mycontext;
+	struct arc4_ctx mycontext;
 	u32 length;
 	u8 *pframe, *payload, *iv, *prwskey, idx = 0;
 	union pn48 txpn;
@@ -682,8 +622,8 @@ void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe)
 			phase2(&rc4key[0], prwskey, (unsigned short *)
 			       &ttkey[0], pnl);
 			/* 4 decrypt payload include icv */
-			arcfour_init(&mycontext, rc4key, 16);
-			arcfour_encrypt(&mycontext, payload, payload, length);
+			arc4_setkey(&mycontext, rc4key, 16);
+			arc4_crypt(&mycontext, payload, payload, length);
 			*((__le32 *)crc) = cpu_to_le32(getcrc32(payload,
 					length - 4));
 		}
-- 
2.27.0

