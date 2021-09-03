Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BCC400579
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350956AbhICTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350945AbhICTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:06:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D993C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:05:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so235476wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUDG+kXf4dTjbdDqMNwNv9gOfhHcrXZhxjOwR67JUzc=;
        b=kBZKn+HSlHYwG8cmbTyv2+KH9WWh0xUTFzKS4uNtbayBAG0Jn8bahqh92XI7AIw0k3
         b8f00Jx7NS/3tBcheo9O55q7N1wYsXcOtSN1uGPlMvgpasnXSg0or/frwOk22nw5EZ9c
         kU53tAUPDp5MpTKl5crwwsM0pPPGhgFbhjRBmqsWck3CDoU19/I/pKolrYa2RaJ/0DJq
         1kRyuWZNbSLGO4sVEgkCnO0w1LdIA99AUMp2HXOrygW+mBHXThZMFa6fwJrp5Byqfzy8
         +4eDE6MgZvCoKsqME0HGJ+O2gj6xyUFSHL+IuaAlLqBkSNakL7f5Q7N7FT0rTxtCoA7Y
         kWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUDG+kXf4dTjbdDqMNwNv9gOfhHcrXZhxjOwR67JUzc=;
        b=Govlkqwa0hjeG0AVixewz/jR0/FcZgLBIqlItEzq3miYgfRvbKvkUTsfHhxOtQMILk
         hCeG/5svo8H89/vRY3E17d+7YyUVXOy7EnrM2AkVg6CJAoNFs5cmVBCZd79S/bCEyb+Z
         3oK/zoHV8fmsBAn1YbxLerBJVtxZ/afsy9bxdZIhpxOyi9qjtrbrmK0nH9wx9PEgozsq
         H4vh37oXnG9/Mpp7a4NuEcPny6vZqIgwIa3708rKRThMXOQHpDpzuLg6yy78drnav+Qx
         8mLGz1wLcZP7m17bzUvPVlqIxORM625X/IhNH7+QA3sd0TMMmvMtGkIIYdRNDJyOQC8G
         1AfQ==
X-Gm-Message-State: AOAM530kw9cXHJitgdcAwlMpH2woOEy4NjHgqfEevPTR6gXaumLOkYjv
        0aSz0ZoPGgh2uy86yw27e9k=
X-Google-Smtp-Source: ABdhPJxWOCawnkkAkIojBTmGc1HwpUdoFf1kSr035/nFikyPj83mtt8Guo7CqrXzmBy+RDMTI9+B+g==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr237502wmi.88.1630695901842;
        Fri, 03 Sep 2021 12:05:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::848c])
        by smtp.gmail.com with ESMTPSA id u25sm229291wmj.10.2021.09.03.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:05:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: use in-kernel arc4 encryption
Date:   Fri,  3 Sep 2021 21:04:43 +0200
Message-Id: <20210903190444.15585-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903190444.15585-1-straube.linux@gmail.com>
References: <20210903190444.15585-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom arc4 implementation with in-kernel one.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c   | 102 ++++--------------
 .../staging/r8188eu/include/rtw_security.h    |   5 +
 2 files changed, 25 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index d0586af1abad..a7f769048a44 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -10,68 +10,6 @@
 
 /* WEP related ===== */
 
-struct arc4context {
-	u32 x;
-	u32 y;
-	u8 state[256];
-};
-
-static void arcfour_init(struct arc4context *parc4ctx, u8 *key, u32	key_len)
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
-
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
-
-	return state[(sx + sy) & 0xff];
-}
-
-static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32 len)
-{
-	u32	i;
-
-	for (i = 0; i < len; i++)
-		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
-
-}
-
 /*
 	Need to consider the fragment  situation
 */
@@ -81,7 +19,6 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		__le32 f0;
 		u8 f1[4];
 	} crc;
-	struct arc4context	 mycontext;
 
 	int	curfragnum, length;
 	u32	keylength;
@@ -92,6 +29,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
+	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 
 	if (!pxmitframe->buf_addr)
 		return;
@@ -114,15 +52,15 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-				arcfour_init(&mycontext, wepkey, 3 + keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
+				arc4_setkey(ctx, wepkey, 3 + keylength);
+				arc4_crypt(ctx, payload, payload, length);
+				arc4_crypt(ctx, payload + length, crc.f1, 4);
 			} else {
 				length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 				crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
-				arcfour_init(&mycontext, wepkey, 3 + keylength);
-				arcfour_encrypt(&mycontext, payload, payload, length);
-				arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
+				arc4_setkey(ctx, wepkey, 3 + keylength);
+				arc4_crypt(ctx, payload, payload, length);
+				arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 				pframe += pxmitpriv->frag_len;
 				pframe = (u8 *)RND4((size_t)(pframe));
@@ -135,13 +73,13 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 {
 	/*  exclude ICV */
-	struct arc4context	 mycontext;
 	int	length;
 	u32	keylength;
 	u8	*pframe, *payload, *iv, wepkey[16];
 	u8	 keyindex;
 	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
 
 	pframe = precvframe->rx_data;
 
@@ -157,8 +95,8 @@ void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 
 		/* decrypt payload include icv */
-		arcfour_init(&mycontext, wepkey, 3 + keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
+		arc4_setkey(ctx, wepkey, 3 + keylength);
+		arc4_crypt(ctx, payload, payload, length);
 	}
 }
 
@@ -509,7 +447,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		u8 f1[4];
 	} crc;
 	u8   hw_hdr_offset = 0;
-	struct arc4context mycontext;
 	int			curfragnum, length;
 
 	u8	*pframe, *payload, *iv, *prwskey;
@@ -518,6 +455,7 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
+	struct arc4_ctx *ctx = &psecuritypriv->xmit_arc4_ctx;
 	u32	res = _SUCCESS;
 
 	if (!pxmitframe->buf_addr)
@@ -554,16 +492,16 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
+					arc4_setkey(ctx, rc4key, 16);
+					arc4_crypt(ctx, payload, payload, length);
+					arc4_crypt(ctx, payload + length, crc.f1, 4);
 				} else {
 					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 					crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload + length, crc.f1, 4);
+					arc4_setkey(ctx, rc4key, 16);
+					arc4_crypt(ctx, payload, payload, length);
+					arc4_crypt(ctx, payload + length, crc.f1, 4);
 
 					pframe += pxmitpriv->frag_len;
 					pframe = (u8 *)RND4((size_t)(pframe));
@@ -588,7 +526,6 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 		__le32 f0;
 		u8 f1[4];
 	} crc;
-	struct arc4context mycontext;
 	int			length;
 
 	u8	*pframe, *payload, *iv, *prwskey;
@@ -596,6 +533,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 	struct	sta_info		*stainfo;
 	struct	rx_pkt_attrib	 *prxattrib = &precvframe->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct arc4_ctx *ctx = &psecuritypriv->recv_arc4_ctx;
 	u32		res = _SUCCESS;
 
 	pframe = precvframe->rx_data;
@@ -629,8 +567,8 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 
 			/* 4 decrypt payload include icv */
 
-			arcfour_init(&mycontext, rc4key, 16);
-			arcfour_encrypt(&mycontext, payload, payload, length);
+			arc4_setkey(ctx, rc4key, 16);
+			arc4_crypt(ctx, payload, payload, length);
 
 			crc.f0 = cpu_to_le32(~crc32_le(~0, payload, length));
 
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 1fc1a4f30eec..8ff583cdc0a6 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -6,6 +6,7 @@
 
 #include "osdep_service.h"
 #include "drv_types.h"
+#include <crypto/arc4.h>
 
 #define _NO_PRIVACY_			0x0
 #define _WEP40_				0x1
@@ -106,6 +107,10 @@ struct security_priv {
 	union Keytype	dot118021XGrprxmickey[4];
 	union pn48	dot11Grptxpn;		/* PN48 used for Grp Key xmit.*/
 	union pn48	dot11Grprxpn;		/* PN48 used for Grp Key recv.*/
+
+	struct arc4_ctx xmit_arc4_ctx;
+	struct arc4_ctx recv_arc4_ctx;
+
 #ifdef CONFIG_88EU_AP_MODE
 	/* extend security capabilities for AP_MODE */
 	unsigned int dot8021xalg;/* 0:disable, 1:psk, 2:802.1x */
-- 
2.33.0

