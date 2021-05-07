Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6037613C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhEGHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbhEGHhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:37:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FF1C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:36:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so8100486wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76eipqNBNkUeHiS93+YHHFtGscmZKFfCQ8YQ1j3cNTU=;
        b=Lp5tJK11a9FTGaLMTD9ul8YPRKxgIgK86X2OoLVUcHX0egMsSuFHDeGCJLT/dEFI3x
         qfhU8pRl1mVAqFuFygzXasRJw17qjKOI8NucX7vpaE5osxVLHRXNH/QxMLgsDAq0ofwZ
         ypRGheW5b+14yA2RqOpzgzETLSG0bVMiMbyUjAEY6ZbO5YR3P0QVX6LaLDDal1qZPdft
         djgB7vStPHLpP/mdIaxZOZB0SyCoIvBLxpKOLOu2goE0TSTsGCsaQ49Q0OyK52ixugeR
         FNZHS+GYkgEUaL0o742PQQmDcnlS3v4jU816rrgb79URq93+hc99UVM3cyqwakL5YKZo
         KRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76eipqNBNkUeHiS93+YHHFtGscmZKFfCQ8YQ1j3cNTU=;
        b=OEgUxPjnlc49b0j+k1wQTmsr13Wo8YAXRZhGdlxgx5bSkNlExEZQSVAbcSr1ogFZU1
         595a7qCvWWFhcK+6QVITZWKIGwPUXdUdg7ZSY/aaPhmG0BNsI+EV3ieNYLM/KeGeuUav
         AI0g4HJDtuQ3H8Kyv23/GXIT3YzTNt6CBYwu7zWy7BH/mF4+2cMDjKR8qVxZq0+TCdIR
         26A0FR/kbjQEv2wqYBw0+1abbGjS8S1yA5LnPKnz0KcNESdrEDBBOKz4Y2DN9mcMCOEV
         pg3Y2njSqcuMdS9QoKE63PUhAwPWz+pNleYVhC2qsikq+cCiQqEypE49rGu1EUHnIud1
         +ROw==
X-Gm-Message-State: AOAM5324qxE28t8eAM7yIhAaZK+ckH6tZY2jffOHUKm8+GyhaSJQ7pRY
        qbauHQ1f5gTepF1Lj5prqeT5pt96lFHm9A==
X-Google-Smtp-Source: ABdhPJyATMMme9Y67980v46V1wsRCyau+7Wu3bjgWREiYmcGU8zmpGQ/AQ5P1mSd/sMGujyoomNkQw==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr10281204wrw.95.1620372964845;
        Fri, 07 May 2021 00:36:04 -0700 (PDT)
Received: from agape ([5.171.80.53])
        by smtp.gmail.com with ESMTPSA id q10sm6077462wmc.31.2021.05.07.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:36:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8723bs: remove more unused encryption macros
Date:   Fri,  7 May 2021 09:35:58 +0200
Message-Id: <c65d2b2dd06c52c3e0418d8a927521d05109849c.1620372584.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620372584.git.fabioaiuto83@gmail.com>
References: <cover.1620372584.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove more unused logical macros used in removed
private aes encryption.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 619d2fa4e8f2..76076c4f0763 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -248,21 +248,6 @@ struct mic_data {
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
  * public domain by Tom St Denis. */
 
-/* Various logical functions */
-#define RORc(x, y) \
-(((((unsigned long) (x) & 0xFFFFFFFFUL) >> (unsigned long) ((y) & 31)) | \
-   ((unsigned long) (x) << (unsigned long) (32 - ((y) & 31)))) & 0xFFFFFFFFUL)
-#define Ch(x, y, z)       (z ^ (x & (y ^ z)))
-#define Maj(x, y, z)      (((x | y) & z) | (x & y))
-#define S(x, n)         RORc((x), (n))
-#define R(x, n)         (((x)&0xFFFFFFFFUL)>>(n))
-#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
-#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
-#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
-#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
-#ifndef MIN
-#define MIN(x, y) (((x) < (y)) ? (x) : (y))
-#endif
 int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac);
 void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
 void rtw_secmicappendbyte(struct mic_data *pmicdata, u8 b);
-- 
2.20.1

