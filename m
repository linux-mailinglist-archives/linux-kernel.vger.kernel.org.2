Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A33EDC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhHPRgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhHPRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:36:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5352C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a5so21515797plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shshp+f6owMomFz5kbGuNE9NZBaJdb72qeBwnp8hDC8=;
        b=snG0N+LZ3BeGB4xeF7DAqkGpoE5hlsvN23oaaFzyby4vWBY7MsXHKRqnr/gMqzJmBe
         /n6f27K/hQtMFGFIzlwFv7Jbe5/KsNu0bcoxR8FcflSKyCJrNCPwtRTyDFkSjCN8G3m2
         w16lT/tLHF4k0HDQGIIXigNK5vKZucgoRkDhtcTG5HIos3v8dO+34Zhrm2YmOTHRhdrn
         4kq3yhsMBmxqi55qY1Yi8xn/HlMFdMzGNIk8T+lXwgPMQPWYFE855zCm11fYY7tNrOwI
         MQ30QoAKEN1/umzqPthtMFmZ4lW1EACufxslXsEApH4EiCEuwyPJy4GApla7UF6JqCOr
         i2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shshp+f6owMomFz5kbGuNE9NZBaJdb72qeBwnp8hDC8=;
        b=pT7xpQFs6v5Cal5bDz7agahj1CRjbbg4uxpS2ylQSHF5/9C0kLgECLxDRXm8NEzcW7
         2LaJiDQ68Qxj6v0hRSnBqnuc/FQxPpfI//lLI7Ns5+UJhYWx9YGoZkInCVN8VanK9MZI
         gdRJLAQ1eAbg2MTC4Druv57XzpMbDUbicVlJWSCAHFNN+5abGc7vNn6NHLjEQWqfOEgp
         CF/MbQubesAOpJb30FaOub4gKRzwFWdfkO/5m7wFp368guPcjSczSuFPwDteCWn6cuMJ
         1xqCWK0KIDE0s6wlTzn+7vcKl5ZV2UNK3ZE3Q0KUbPxVi894UvTEFz7x+bn9C8dc/nXA
         r57A==
X-Gm-Message-State: AOAM533SyW0hTlZbVxGETHgNaObZSOCluzJbOSQPM2sWpBA56J1BjbCr
        vWYtoNWIFdgbKjibLQcWrF7eZtbEgPmvNQ==
X-Google-Smtp-Source: ABdhPJyQGwNqXxd0CSV8vm/Q/+9RvOBtY+AGz5gr7kNng4MCzaiALd2lN229sfuX9/697AonPTeT8Q==
X-Received: by 2002:a63:ff5e:: with SMTP id s30mr17302398pgk.390.1629135335273;
        Mon, 16 Aug 2021 10:35:35 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u10sm14030pgj.48.2021.08.16.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:35:34 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8732bs: incorrect type in assignment
Date:   Mon, 16 Aug 2021 23:05:06 +0530
Message-Id: <fd60862b159ac6693feadc92e5574ce1e07ac456.1629135143.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629135143.git.aakashhemadri123@gmail.com>
References: <cover.1629135143.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast u32 to __le32 with __cpu_to_le32 to fix sparse warning:

warning: incorrect type in assignment (different base types)
expected restricted __le32 [usertype]
got unsigned int

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a99f439328f1..381deeea99d0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -8,6 +8,7 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <crypto/aes.h>
+#include <linux/byteorder/little_endian.h>
 
 static const char * const _security_type_str[] = {
 	"N/A",
@@ -69,7 +70,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
 
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				*((__le32 *)crc) = __cpu_to_le32(~crc32_le(~0, payload, length));
 
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
@@ -77,7 +78,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 			} else {
 				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-				*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+				*((__le32 *)crc) = __cpu_to_le32(~crc32_le(~0, payload, length));
 				arc4_setkey(ctx, wepkey, 3 + keylength);
 				arc4_crypt(ctx, payload, payload, length);
 				arc4_crypt(ctx, payload + length, crc, 4);
@@ -506,7 +507,8 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					*((__le32 *)crc) =
+						__cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
@@ -514,7 +516,8 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+					*((__le32 *)crc) =
+						__cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arc4_setkey(ctx, rc4key, 16);
 					arc4_crypt(ctx, payload, payload, length);
-- 
2.32.0

