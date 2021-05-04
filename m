Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3768A372C57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEDOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:46:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC41C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:45:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m12so13616257eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aobsat+LyL4XDzGNUuAQqRzK0JPmwBTZGHjEuui96xQ=;
        b=hozXt9KIjIVKNg09+84oXxDOsMHWonkbgcE/SnrEtqa9TWsAGINJOaclUDexnrxekk
         wJBu8amBrbwlTPYFsFMQ2GcZPgIbOptQtYxkDJv4HU0pyGRO9lZYgzMmLqoX6Zlc/DUn
         wXIzvbOrMyZa0bnziruB1PxOBwNmXfNaJkH294ooN1lO5SmT3VPyC6xYU7Q1355Up2h7
         1L4dTct4vI6OT3MIxVySt5GSFeE5pw3zUGUL7JWa3F0Sf5gMhWqHyLNFv2NGpQz5bnEA
         8qOj7HZAaf4GKzyGNFr9LLkxh0oDXyM7thqtNEHXVl3f9nmMRjABnl4Aijl8hq3jmen8
         HlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aobsat+LyL4XDzGNUuAQqRzK0JPmwBTZGHjEuui96xQ=;
        b=D87Ug1GMcy0JVgNHCIh4HMP1J9+c9531vzRSZPkQ00wDoWgt1kav+yvcejfBg32wZK
         6wVDWdJwFXh5JOqoPvbTwHZkex7RUJs9dZHV957py3L5wtItJCRTakzLasXE1D5ib5+B
         9urpIqF3IdPdOc4+lA9loWv47UlFEeFEjLFnPCYwQEvqjPglCtvN2VPwrcnRMSrbxbPQ
         kcio2ejG66312iSyWEFLDUHppTnmjP+gUgi2epK0pFYrVoouXfOeKW8rimpX6v6RGK3S
         uGa+iXiQ4KyErF949MllyDCZueRbWu3Abxplo5UUSV/qUJvgknWvAnWe5W6GaHgN7bAZ
         v+jA==
X-Gm-Message-State: AOAM532tLBDDTlqNpN2snPEndANN4iTsLcKEtR8Xomz86b0kvPF1dNwJ
        iWw5QY5pMz6BLPGPRtLM22BC743unvbTEg==
X-Google-Smtp-Source: ABdhPJyI47ORIAsjPykFXlx3vL3k4fHi/jzgwk60hjRhkhYUn0PCkvsOTVfgJh+J/hBVZzN772BD3g==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr22297590ejb.344.1620139536134;
        Tue, 04 May 2021 07:45:36 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id s11sm14630177edt.27.2021.05.04.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:45:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines
Date:   Tue,  4 May 2021 16:45:30 +0200
Message-Id: <11ac26487aab92ded28747c1f0cb42a94183130d.1620139318.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620139318.git.fabioaiuto83@gmail.com>
References: <cover.1620139318.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private aes encryption subroutines with
public in-kernel ones in OMAC1 computation routines.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 114 ++----------------
 1 file changed, 9 insertions(+), 105 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 0cb603aa4ee6..35f8b39d6fdb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -7,6 +7,7 @@
 #include <linux/crc32poly.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
+#include <crypto/aes.h>
 
 static const char * const _security_type_str[] = {
 	"N/A",
@@ -1931,99 +1932,6 @@ const u8 rcons[] = {
 	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
-/*
- * Expand the cipher key into the encryption key schedule.
- *
- * @return	the number of rounds for the given cipher key size.
- */
-static void rijndaelKeySetupEnc(u32 rk[/*44*/], const u8 cipherKey[])
-{
-	int i;
-	u32 temp;
-
-	rk[0] = GETU32(cipherKey);
-	rk[1] = GETU32(cipherKey +  4);
-	rk[2] = GETU32(cipherKey +  8);
-	rk[3] = GETU32(cipherKey + 12);
-	for (i = 0; i < 10; i++) {
-		temp  = rk[3];
-		rk[4] = rk[0] ^
-			TE421(temp) ^ TE432(temp) ^ TE443(temp) ^ TE414(temp) ^
-			RCON(i);
-		rk[5] = rk[1] ^ rk[4];
-		rk[6] = rk[2] ^ rk[5];
-		rk[7] = rk[3] ^ rk[6];
-		rk += 4;
-	}
-}
-
-static void rijndaelEncrypt(u32 rk[/*44*/], u8 pt[16], u8 ct[16])
-{
-	u32 s0, s1, s2, s3, t0, t1, t2, t3;
-	int Nr = 10;
-	int r;
-
-	/*
-	 * map byte array block to cipher state
-	 * and add initial round key:
-	 */
-	s0 = GETU32(pt) ^ rk[0];
-	s1 = GETU32(pt +  4) ^ rk[1];
-	s2 = GETU32(pt +  8) ^ rk[2];
-	s3 = GETU32(pt + 12) ^ rk[3];
-
-#define ROUND(i, d, s) \
-	do { \
-		d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
-		d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
-		d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
-		d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
-	} while (0)
-
-	/* Nr - 1 full rounds: */
-	r = Nr >> 1;
-	for (;;) {
-		ROUND(1, t, s);
-		rk += 8;
-		if (--r == 0)
-			break;
-		ROUND(0, s, t);
-	}
-
-#undef ROUND
-
-	/*
-	 * apply last round and
-	 * map cipher state to byte array block:
-	 */
-	s0 = TE41(t0) ^ TE42(t1) ^ TE43(t2) ^ TE44(t3) ^ rk[0];
-	PUTU32(ct, s0);
-	s1 = TE41(t1) ^ TE42(t2) ^ TE43(t3) ^ TE44(t0) ^ rk[1];
-	PUTU32(ct +  4, s1);
-	s2 = TE41(t2) ^ TE42(t3) ^ TE43(t0) ^ TE44(t1) ^ rk[2];
-	PUTU32(ct +  8, s2);
-	s3 = TE41(t3) ^ TE42(t0) ^ TE43(t1) ^ TE44(t2) ^ rk[3];
-	PUTU32(ct + 12, s3);
-}
-
-static void *aes_encrypt_init(u8 *key, size_t len)
-{
-	u32 *rk;
-
-	if (len != 16)
-		return NULL;
-	rk = rtw_malloc(AES_PRIV_SIZE);
-	if (rk == NULL)
-		return NULL;
-	rijndaelKeySetupEnc(rk, key);
-	return rk;
-}
-
-static void aes_128_encrypt(void *ctx, u8 *plain, u8 *crypt)
-{
-	rijndaelEncrypt(ctx, plain, crypt);
-}
-
 static void gf_mulx(u8 *pad)
 {
 	int i, carry;
@@ -2037,11 +1945,6 @@ static void gf_mulx(u8 *pad)
 		pad[AES_BLOCK_SIZE - 1] ^= 0x87;
 }
 
-static void aes_encrypt_deinit(void *ctx)
-{
-	kfree_sensitive(ctx);
-}
-
 /**
  * omac1_aes_128_vector - One-Key CBC MAC (OMAC1) hash with AES-128
  * @key: 128-bit key for the hash operation
@@ -2058,13 +1961,14 @@ static void aes_encrypt_deinit(void *ctx)
 static int omac1_aes_128_vector(u8 *key, size_t num_elem,
 				u8 *addr[], size_t *len, u8 *mac)
 {
-	void *ctx;
+	struct crypto_aes_ctx ctx;
 	u8 cbc[AES_BLOCK_SIZE], pad[AES_BLOCK_SIZE];
 	u8 *pos, *end;
 	size_t i, e, left, total_len;
+	int ret;
 
-	ctx = aes_encrypt_init(key, 16);
-	if (ctx == NULL)
+	ret = aes_expandkey(&ctx, key, 16);
+	if (ret)
 		return -1;
 	memset(cbc, 0, AES_BLOCK_SIZE);
 
@@ -2087,12 +1991,12 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
 			}
 		}
 		if (left > AES_BLOCK_SIZE)
-			aes_128_encrypt(ctx, cbc, cbc);
+			aes_encrypt(&ctx, cbc, cbc);
 		left -= AES_BLOCK_SIZE;
 	}
 
 	memset(pad, 0, AES_BLOCK_SIZE);
-	aes_128_encrypt(ctx, pad, pad);
+	aes_encrypt(&ctx, pad, pad);
 	gf_mulx(pad);
 
 	if (left || total_len == 0) {
@@ -2110,8 +2014,8 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
 
 	for (i = 0; i < AES_BLOCK_SIZE; i++)
 		pad[i] ^= cbc[i];
-	aes_128_encrypt(ctx, pad, mac);
-	aes_encrypt_deinit(ctx);
+	aes_encrypt(&ctx, pad, mac);
+	memzero_explicit(&ctx, sizeof(ctx));
 	return 0;
 }
 
-- 
2.20.1

