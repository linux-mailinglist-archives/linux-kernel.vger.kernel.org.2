Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4F457D39
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhKTLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbhKTLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 06:15:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989BFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 03:12:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so19836284ybe.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 03:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y0KeUaf6yAD9mUdfrovGwP2ZmXhum3aoW0pYBqDmMns=;
        b=GtHRmlYpGjadB2YppYLoUO91303KsrP06J5UwfaEqnz96UEdfijeBAEcgadkezpigK
         VcDi623/84zGWiPX4cGw6oCI60UMWHlOhYIlrJn/8JWRX0l1I/F/30PEhLj9s93cS+Ok
         UZdlnMUuJvEjlr+6fnn0x/O9oQl0B29gD7UaieAJeoFgsa8mLdHz8/AhpUicZbzzwZXr
         GFbjiE/JjzkcmfGyM3M+3wKjw5hHua/9l4sTrbVnOiea+NcWhGPZGEIR2+R9e4exCV2Y
         tQ+DjGhIBpqujNgTYwkapRvtP1BHejnWWB2uINaobfRLFQgZkHbwHm2Rq5iG+PsNRNYU
         t7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y0KeUaf6yAD9mUdfrovGwP2ZmXhum3aoW0pYBqDmMns=;
        b=M5fP+feiBU9f+qgctmQL0uExNjdUnWkZ1FjkpR41aXOJKsvEAMK95hxhsLfqg/AGbF
         E2dwv/XR4K1hIeQtw3RZD/BF1TerFCf2OwAxX802TuIi31lZ6MOvWHUpPBpxRCa/a7nR
         wllny9dqLmPMVmUTwLYB8nwGqD8nR3Y/tl12fNR3vaXhaX4QDBv+loGuf9WVHCiTN5N5
         fiBYVH1io8vEP7E5O10Rk1ySvj0cBvmE2Os/yep8wHpCB64dajQmSrxyuIsjy6Zf2zMv
         myYGtTDQDP6Ii2NmgSTYNn/NGYcUPJ8FyZUvQO5jJ/dH6poOiAcaZP2mVUT/dx0VgY4D
         3W9w==
X-Gm-Message-State: AOAM531CYhe2qErQsok03Ndy3nVEUws8KWmscjP9L+ldSrLClDWnOebk
        jVv8oILtP0IHxGvruJYd15fZEOaUjw==
X-Google-Smtp-Source: ABdhPJwfrC2hI7KTCTOxBuv0DAf8V5+yxchtiimvYb0Ed7bAykGaLPi8ehRFbLE8Oy5YeoCVkthfS0Or8g==
X-Received: from zoebm1.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:e29])
 (user=zoebm job=sendgmr) by 2002:a05:6902:1208:: with SMTP id
 s8mr49731208ybu.375.1637406741776; Sat, 20 Nov 2021 03:12:21 -0800 (PST)
Date:   Sat, 20 Nov 2021 11:11:51 +0000
In-Reply-To: <YZixPDg8kKHZrGJB@kroah.com>
Message-Id: <20211120111151.1086970-1-zoebm@google.com>
Mime-Version: 1.0
References: <YZixPDg8kKHZrGJB@kroah.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/2] Staging: rtl8712: rtl871x_security: fixed a camel case
 variable name coding style issue
From:   Zoeb Mithaiwala <zoebm@google.com>
To:     greg@kroah.com
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zoeb Mithaiwala <zoebm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed additional 'n' from variable name. Corrected comment indentation.

Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
---
 drivers/staging/rtl8712/rtl871x_security.c | 12 ++++++------
 drivers/staging/rtl8712/rtl871x_security.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index 4b341074b1b2..529527e201e3 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -269,7 +269,7 @@ static void secmicclear(struct mic_data *pmicdata)
 /* Reset the state to the empty message. */
 	pmicdata->L = pmicdata->K0;
 	pmicdata->R = pmicdata->K1;
-	pmicdata->nbytes_in_m = 0;
+	pmicdata->bytes_in_m = 0;
 	pmicdata->M = 0;
 }
 
@@ -285,10 +285,10 @@ void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key)
 static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
 {
 	/* Append the byte to our word-sized buffer */
-	pmicdata->M |= ((u32)b) << (8 * pmicdata->n_bytes_in_m);
-	pmicdata->nbytes_in_m++;
+	pmicdata->M |= ((u32)b) << (8 * pmicdata->bytes_in_m);
+	pmicdata->bytes_in_m++;
 	/* Process the word if it is full. */
-	if (pmicdata->nbytes_in_m >= 4) {
+	if (pmicdata->bytes_in_m >= 4) {
 		pmicdata->L ^= pmicdata->M;
 		pmicdata->R ^= ROL32(pmicdata->L, 17);
 		pmicdata->L += pmicdata->R;
@@ -301,7 +301,7 @@ static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
 		pmicdata->L += pmicdata->R;
 		/* Clear the buffer */
 		pmicdata->M = 0;
-		pmicdata->nbytes_in_m = 0;
+		pmicdata->bytes_in_m = 0;
 	}
 }
 
@@ -323,7 +323,7 @@ void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst)
 	secmicappendbyte(pmicdata, 0);
 	secmicappendbyte(pmicdata, 0);
 	/* and then zeroes until the length is a multiple of 4 */
-	while (pmicdata->nbytes_in_m != 0)
+	while (pmicdata->bytes_in_m != 0)
 		secmicappendbyte(pmicdata, 0);
 	/* The appendByte function has already computed the result. */
 	secmicputuint32(dst, pmicdata->L);
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index 006ce05c798f..1de662940417 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -192,7 +192,7 @@ struct mic_data {
 	u32  K0, K1;         /* Key */
 	u32  L, R;           /* Current state */
 	u32  M;              /* Message accumulator (single word) */
-	u32  nbytes_in_m;      /* # bytes in M */
+	u32  bytes_in_m;     /* # bytes in M */
 };
 
 void seccalctkipmic(
@@ -200,11 +200,11 @@ void seccalctkipmic(
 	u8  *header,
 	u8  *data,
 	u32  data_len,
-	u8  *miccode,
+	u8  *Miccode,
 	u8   priority);
 
 void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key);
-void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nbytes);
+void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
 void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst);
 u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe);
 u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe);
-- 
2.20.1

