Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416B73D84D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhG1Amf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhG1Am3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:42:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D4C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 17:42:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nb11so1716540ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hacQXSnfRWwcxxKatA3rmakX4p+29xXxzmf6cpokS6s=;
        b=SRc+uT9z6K4GctoLTaNGhADToy4RtU21r2e9Lju1JcnaSNzNZxP4PeDceG0nks1FDJ
         e60tuP1QP5V/IE/IoUECyVXpHNQTkaQVMYBMyC87JQsqwc/NzpJHn87lFQdfOz9lCiYt
         6LF4rq26eHyVuhiWgTDDq1YgLt0AsVoIHFLOKuxxpS9+CwJAVramS4mvter/NH4QKz1O
         Q17u4/AWGggZgUfItB4SpFbWVShHxVfGruvztc+pq+2lEcB6RSrq02kLvF3haf1oa5j/
         KEOMZ1lXrkJDGxrAm1kWzT6W7+nhJxqD13AorHdTmU6B77QHjWIa60DjL44zgvaqxyL9
         TrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hacQXSnfRWwcxxKatA3rmakX4p+29xXxzmf6cpokS6s=;
        b=nOxJ26akQC5vuRrwNRpOFazk+5fUDbM7aw3Hm/SL3epBonHJ1lYjNYl1r/y3uKMej4
         4d59BtsWdcoisrmFkkHudZtdtbOy9enLtoG3m/e7lU0NwDDBPDaAOe1BQtx3Kcho5Evx
         /lDEDiA7i9ZCX/ohZpT3IdnnkjZRENpCYaGcIMbOUUg5BbDG4Ck+ZwM+X1U1oh6th/oz
         9ilPMB2HIoznlsAR8bnU9unF5BFdvtXDXFD3X0ga0k5ClloL7Fd/RAYXKYXi+CSWryYc
         0aRRN46O1M+9Yb6Kr1o7iR9n30sV9v9XBM9zpPIdAwJmxTTM47sNhzE0qg03HgJO0UF2
         Ow3Q==
X-Gm-Message-State: AOAM532o7GlG/9sUzHWh0YdFObKrCzVRjf8dMvziXaT4n0R7oZtO+iXu
        AP9oYL6bq4UUIoZbclxaMwBRXG7PIB8=
X-Google-Smtp-Source: ABdhPJwzlKLmiZQB5pDjZe4FAD39IXCFUwx4tI8DBLvYgO7E2ApTXCjJO+BLtcy+biiJKUfJUO58LQ==
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr23758889ejb.537.1627432946705;
        Tue, 27 Jul 2021 17:42:26 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id e22sm1902617edu.35.2021.07.27.17.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 17:42:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Fix incorrect type in assignment
Date:   Wed, 28 Jul 2021 02:42:23 +0200
Message-Id: <20210728004223.15102-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning: incorrect type in assignment (different base types).

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..527f710c7658 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -35,8 +35,10 @@ const char *security_type_str(u8 value)
 */
 void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 {																	/*  exclude ICV */
-
-	unsigned char crc[4];
+	union {
+	__le32 f0;
+	unsigned char f1[4];
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

