Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C44457C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 09:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhKTIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 03:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhKTIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 03:10:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EEDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 00:07:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a253608000000b005c202405f52so19520464yba.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/4ZPEXu2kzgGrJkyRdh3gbJQzf2GsdF8NSkpgZarmAU=;
        b=Vns1AMoxQDcl/v0vKfYOnR3Ij3FngKclLCaY1OJhF3z7RzqrXXW2nzHsjP336/7Ljv
         k4tUNDLXA9UKHZv8hK1/co9Gmefb+dOPuPlpfEOZSQO8Qtr7n0oJJIPNXkhTBMtp6DOp
         8x22QzSB3Y+gWwoFAisaAgDB0f8am4Vkl7Fs0wb4kIzXiTW+roNRMtwfsosyiAhNqtlt
         1BV15w7OICG/px/TryfUm6FVFHpJlTKcCIJF7L6uJkdKqC7K0K/emoCf+xoGkETgrme4
         nS3hAMz6HoVPYQAyMuhRs1H2F9UfyIhjq2vW564sAnxJCU9qQXR4946thboieBm2spUV
         N5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/4ZPEXu2kzgGrJkyRdh3gbJQzf2GsdF8NSkpgZarmAU=;
        b=KxKh6J4c+T+Z3p6siUZLJc6fFXRqNVzg0SXUaDoj88QniCFJI1GIt46D4KIcO3Jd9G
         +ELhI6K08UazaO7GhhJhNtO30pk2Us0PdikRoZNMmxDxCJC1z1eeIEaVmjxWoHNB4Raq
         wwgsEioemvQFTe2luOJ6AZYethKAbr0P2dEeS/11CU40gzSLE4H6YBItnzU/s8GSwh/q
         qbsgQ7ILlACDOJ78bM/1J9exLWHDGlOt5aJuxUEb5PROZgdkWGAaNUHUtwh98IZ6ziYs
         QS2MfuFIQGvOo7y+z4NmMlgMJZFcGIIp/2sXS+cgmV5E/4tUv1Snzqz0yzWJI5pDkY7x
         4uOw==
X-Gm-Message-State: AOAM5330NH/wmn8mSjnZNDT0bFaPnGEI3crMubL2l5SOaYG+7ajFBW7m
        qQumV1rgKSN6MG4c2bvyHoXp9rUENA==
X-Google-Smtp-Source: ABdhPJxdIe3JxD6oKvkN+tcIWlloWXn0gMYNo1fumy0kGm5KuUWT5kTwGoGYFFltLMOzQ1BBK7M+MLCCig==
X-Received: from zoebm1.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:e29])
 (user=zoebm job=sendgmr) by 2002:a25:8607:: with SMTP id y7mr1008912ybk.283.1637395668647;
 Sat, 20 Nov 2021 00:07:48 -0800 (PST)
Date:   Sat, 20 Nov 2021 08:06:58 +0000
Message-Id: <20211120080658.1070907-1-zoebm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] Staging: rtl8712: rtl871x_security: fixed a camel case
 variable name coding style issue
From:   Zoeb Mithaiwala <zoebm@google.com>
To:     trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Zoeb Mithaiwala <zoebm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
---
 drivers/staging/rtl8712/rtl871x_security.c | 12 ++++++------
 drivers/staging/rtl8712/rtl871x_security.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index e0a1c30a8fe6..4b341074b1b2 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -269,7 +269,7 @@ static void secmicclear(struct mic_data *pmicdata)
 /* Reset the state to the empty message. */
 	pmicdata->L = pmicdata->K0;
 	pmicdata->R = pmicdata->K1;
-	pmicdata->nBytesInM = 0;
+	pmicdata->nbytes_in_m = 0;
 	pmicdata->M = 0;
 }
 
@@ -285,10 +285,10 @@ void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key)
 static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
 {
 	/* Append the byte to our word-sized buffer */
-	pmicdata->M |= ((u32)b) << (8 * pmicdata->nBytesInM);
-	pmicdata->nBytesInM++;
+	pmicdata->M |= ((u32)b) << (8 * pmicdata->n_bytes_in_m);
+	pmicdata->nbytes_in_m++;
 	/* Process the word if it is full. */
-	if (pmicdata->nBytesInM >= 4) {
+	if (pmicdata->nbytes_in_m >= 4) {
 		pmicdata->L ^= pmicdata->M;
 		pmicdata->R ^= ROL32(pmicdata->L, 17);
 		pmicdata->L += pmicdata->R;
@@ -301,7 +301,7 @@ static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
 		pmicdata->L += pmicdata->R;
 		/* Clear the buffer */
 		pmicdata->M = 0;
-		pmicdata->nBytesInM = 0;
+		pmicdata->nbytes_in_m = 0;
 	}
 }
 
@@ -323,7 +323,7 @@ void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst)
 	secmicappendbyte(pmicdata, 0);
 	secmicappendbyte(pmicdata, 0);
 	/* and then zeroes until the length is a multiple of 4 */
-	while (pmicdata->nBytesInM != 0)
+	while (pmicdata->nbytes_in_m != 0)
 		secmicappendbyte(pmicdata, 0);
 	/* The appendByte function has already computed the result. */
 	secmicputuint32(dst, pmicdata->L);
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index 8461b7f05359..006ce05c798f 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -192,7 +192,7 @@ struct mic_data {
 	u32  K0, K1;         /* Key */
 	u32  L, R;           /* Current state */
 	u32  M;              /* Message accumulator (single word) */
-	u32  nBytesInM;      /* # bytes in M */
+	u32  nbytes_in_m;      /* # bytes in M */
 };
 
 void seccalctkipmic(
@@ -200,11 +200,11 @@ void seccalctkipmic(
 	u8  *header,
 	u8  *data,
 	u32  data_len,
-	u8  *Miccode,
+	u8  *miccode,
 	u8   priority);
 
 void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key);
-void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
+void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nbytes);
 void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst);
 u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe);
 u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe);
-- 
2.20.1

