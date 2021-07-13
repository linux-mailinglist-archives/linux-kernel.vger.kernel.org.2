Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF503C76AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGMSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMStZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:49:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47CC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:46:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c17so43230035ejk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZCD8zEFZfiBDd2pp94vqMa1qM/uM1MO0tR4Do8NO9I=;
        b=QOm25nPiezRVaPDCN4I2K3StsoeQ23bPBgiWI6sVxjua0vNHSjaI09mJxA0bpLM857
         4eNJ7StB9ZeM3mri41JlknuVuZTIa0m+2bg7GdXPalWBwRKHqRRuIhuyTXj6SX4dhDPs
         I9RI1mOcnnDhenDyRZaJYuOOdFNAmaOE+WKwZot/MMo5EfEBMZKmFmy/0w3cHNBa9N89
         dHFwF16BodoZm20xhSm5cg6wh8zKS1jdd4gCM8JSaWBQ+PpFL02mpjOjlnXzCi4hGGt/
         /2ILlFWp3oQQRnySnWJRtQnxNTshIYe37ZG4vc+Wikrfd3XiOkcXgOk/2pcc0XUVuHgj
         Jb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZCD8zEFZfiBDd2pp94vqMa1qM/uM1MO0tR4Do8NO9I=;
        b=ZKPKKdoq7azvsBWD1QBYUHem5FORA2i7BEsgsKn6OVPovI7clfNh/As9IH9VUft6oL
         1tNdwuotbPGLk2t4VZaZvxBh3/iJa69YK4xhUI4Ks05dIUTWhhJyMOvjHZES22lI6lgD
         K4IWy5Y1Wj/Iv6iOc6QLIjZOkFU4UZGNfO1ASCk5wCVogLrbRMqQ94jDWhrEv94HCcnc
         lHHQsb6VNuLCWfWlajcHLoqHC1jJ2j6dvSDEgEkOw2vMYcjnCzHcE6v2DzfnRxKqBesL
         OUtI/axwl2lFzQm9rBcvhVgTaRAMA/v9zySyaumip0+aPeD6PXxohkteavaifmYmoBZL
         oCTQ==
X-Gm-Message-State: AOAM530321A9aX7V9kxH44IkXvAufK2sAi1Bl+ODs1IWHJoFZ/HJSeFy
        /DMnwlQDAeLvGxWIDsDyYfM=
X-Google-Smtp-Source: ABdhPJwpFI+wg5vNsqtctNDH9anW4yZdnwDnJA1smF+y5f6Ubqk4ED4Nlzymj3oJu4a9g0wSvyly/A==
X-Received: by 2002:a17:906:5957:: with SMTP id g23mr7361434ejr.484.1626201993247;
        Tue, 13 Jul 2021 11:46:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id a16sm6419317edv.69.2021.07.13.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 11:46:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Tue, 13 Jul 2021 20:46:29 +0200
Message-Id: <20210713184629.7358-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel API crc32_le() in place of the custom getcrc32().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 --> v2:
Use cpu_to_le32() to assign native endian return value of crc32_le to
crc.

 drivers/staging/rtl8188eu/core/rtw_security.c | 23 ++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 1b2cb6196463..e9de61afe881 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -11,6 +11,7 @@
 #include <wifi.h>
 #include <osdep_intf.h>
 #include <net/lib80211.h>
+#include <linux/types.h>
 
 /* WEP related ===== */
 
@@ -111,21 +112,6 @@ static void crc32_init(void)
 	bcrc32initialized = 1;
 }
 
-static __le32 getcrc32(u8 *buf, int len)
-{
-	u8 *p;
-	u32  crc;
-
-	if (bcrc32initialized == 0)
-		crc32_init();
-
-	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
-
-	for (p = buf; len > 0; ++p, --len)
-		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
-}
-
 /* Need to consider the fragment  situation */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
@@ -609,14 +595,15 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
 				} else {
 					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length));
+
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
@@ -682,7 +669,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			arcfour_init(&mycontext, rc4key, 16);
 			arcfour_encrypt(&mycontext, payload, payload, length);
 
-			*((__le32 *)crc) = getcrc32(payload, length - 4);
+			*((__le32 *)crc) = cpu_to_le32(~crc32_le(~0, payload, length - 4));
 
 			if (crc[3] != payload[length - 1] ||
 			    crc[2] != payload[length - 2] ||
-- 
2.32.0

