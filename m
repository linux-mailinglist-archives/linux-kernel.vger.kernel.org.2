Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3C3B926F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhGANkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGANkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:40:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA811C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 06:38:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i5so8533548eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZRgdN0kDk0oQmGi1iFqux6pM8DxSO13sciooIV27VM=;
        b=Eni4UJnV3HDc6+yTz9Dsf7kD8w8uWPFsXomnFjf1WqVcTZoO59pN/Az+UVySlyEpkt
         1SF9gvOYRiwwFLPOCJu6ol+AqezKdbBYiqQGVwD6ox+hEBWwqk9EZIuJ+pRFfY3dZnJ5
         ijTAWi+xTYjHUNSGxlCYYCTOytGLIcU3kb6N8bNNd5jhBde7zg8Xy6t7Inyt6XYTmWfz
         xwfFfuCvI6AOC6AU3Qj9WJwjWLyuZN+6+UVM6mk8rkHIyAmJcBccJJzXgIyOYmcwwfoq
         QfVhMB4dy5cPE4zsN/8JBaLHvQpRyxYEedvWKTr7oN3s54byjdbQLk9Hxk3zyrXuSivS
         vZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZRgdN0kDk0oQmGi1iFqux6pM8DxSO13sciooIV27VM=;
        b=TyAW24HHSaVkapQu79c+/Nw0qYZTNorCzmbmHh8UlgL4OkFkS/7BK0SNZqOXuVlkkU
         bdKbsBTEQM3m0kVXVvE9wxUITLFWc4s5Xgc2Izu0B9KOCkLxoSI/aOzLRt4jGPBzYfMu
         Ss7rs3IZISBv1hRaFMdO9n9kuVmsDF9Jb6xYhh0M+P3BnI53SvWaNS/wIR5yuw0XfNKL
         zVrWyxD8fnWZw9Dt2D9Z0uGB3Ny+R1JsQ1Vm+IH1jdlpM8UAbP5HvHYsABxHyRqXYKB0
         PNLBxQimaftAs5GXd79I53vNc9qEOBrkn00vSpC5J6hSGChbmn7Gbp8PRxkcMlpyvUbD
         faag==
X-Gm-Message-State: AOAM531Rv4jI9zDdFjmoz23V/PPICWADmu1gyRuVd5TXxWxv5/DPvYQS
        tusju8mxRtMIWmzc7NcpRKc=
X-Google-Smtp-Source: ABdhPJzIWzaVGqV87jeYsYSUd0rjWq+IrpvzwiQaRdiKQzb1B7l10/u+Zl0RlqD9/K0GVOEHOgXxQA==
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr53594310edu.362.1625146693291;
        Thu, 01 Jul 2021 06:38:13 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.pool80181.interbusiness.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id z10sm9385378edc.28.2021.07.01.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:38:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Thu,  1 Jul 2021 15:38:09 +0200
Message-Id: <20210701133809.26534-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use crc32_le in place of the custom getcrc32. This change makes GCC
to warn about incorrect castings to the restricted type __le32, but
they can be safely ignored because crc32_le calculates bitwise
little-endian Ethernet AUTODIN II CRC32.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 22 ++++---------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 1b2cb6196463..5f010cb66970 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -111,21 +111,6 @@ static void crc32_init(void)
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
@@ -609,14 +594,15 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 				if ((curfragnum + 1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
 				} else {
 					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload, payload, length);
 					arcfour_encrypt(&mycontext, payload + length, crc, 4);
@@ -682,7 +668,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 			arcfour_init(&mycontext, rc4key, 16);
 			arcfour_encrypt(&mycontext, payload, payload, length);
 
-			*((__le32 *)crc) = getcrc32(payload, length - 4);
+			*((__le32 *)crc) = ~crc32_le(~0, payload, length - 4);
 
 			if (crc[3] != payload[length - 1] ||
 			    crc[2] != payload[length - 2] ||
-- 
2.32.0

