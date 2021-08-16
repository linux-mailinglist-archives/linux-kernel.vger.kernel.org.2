Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0C3EDC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhHPRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhHPRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:31:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3326C061764;
        Mon, 16 Aug 2021 10:31:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so1317837pjb.3;
        Mon, 16 Aug 2021 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shshp+f6owMomFz5kbGuNE9NZBaJdb72qeBwnp8hDC8=;
        b=QuQmimHZL5HaYJPJt/0XPDGmg2DNnPVhLLRgr2PN+hKYo0GvonbMFi+e1YcI8q5uET
         aimErX4CBB9upkoa+Ec5y+01d2r5kV7FO7LDzCcMPJx3t35FYbCD7Bpka7WbzySYw1af
         DZjSR8SzTXizhSJ63ScmbM3vrtfBIYJvKDiDPN+0qZJuTxBHG9yw0xRmSoTfmPxAterm
         pTaIt66MXE7d/yWpDUt+lOstq2kVjP1jieQCTx/+EG3P/kuVnqh+h7RI5N+dlBWcO17H
         NzjBu4pD/hHj22OVO05KsfZtV0MaacdhgBXiZ/0XUGNZIjfu5fATTO5QDrc1sBP/r07F
         wKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shshp+f6owMomFz5kbGuNE9NZBaJdb72qeBwnp8hDC8=;
        b=KnnBzRv4o6DYdECjxVcOAppPkY1Otcvns/eFOfGmgCRu35dAHbk3r+0FKoi0GthM6a
         yJMmOuD9i5zMxEGQOzsO8ifVtHhUZ1j4T+Njkg5qbm7M7y3FhbNlIaxeyEa5hjxSismO
         R0gnMROZQkPujYZnstXDApng+lgg8nMvD6yCQmx/aX+HuAmp2d65j51dHukXN9bm1Ckz
         H7e2Vfh8lfgKcGKcO1hQ0EP0aSviNoPyRIr0kku02BOvm1OdcupJkVmiya+nAX5alCV5
         rT+xYEoVMMTCrYrCWxGzQOGPEc+6Q1H8+B4341n/sWt1vVSKr3RUHIiq/IVjqrVTRIkY
         cVIg==
X-Gm-Message-State: AOAM530hZTUKSCOhZxn2KJToNH1Q5inYb1sxf6COg4CDEGjS55Eo/xEf
        2SPsIsyYTE9VgBzZ/PfvfjY=
X-Google-Smtp-Source: ABdhPJx/6C39T3P7Jfq6u9J6EQ6/PrEkGbtC38QreRnVAQet23W80ZCypZHPbMh2blVo/qsLP5fyMA==
X-Received: by 2002:a17:902:9046:b029:12c:b5b7:e443 with SMTP id w6-20020a1709029046b029012cb5b7e443mr14028634plz.31.1629135061498;
        Mon, 16 Aug 2021 10:31:01 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id z1sm17146pfg.18.2021.08.16.10.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:31:01 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8732bs: incorrect type in assignment
Date:   Mon, 16 Aug 2021 23:00:42 +0530
Message-Id: <fd60862b159ac6693feadc92e5574ce1e07ac456.1629134725.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629134725.git.aakashhemadri123@gmail.com>
References: <cover.1629134725.git.aakashhemadri123@gmail.com>
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

