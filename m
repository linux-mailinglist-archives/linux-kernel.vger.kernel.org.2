Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF83ECBB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHOXFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 19:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhHOXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 19:05:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797CC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 16:05:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z9so21007606wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0vhrXmaCnBUAq1bek/phc8PfY46b3QRQs/x7Py8PZQ=;
        b=NXu8lmZVg19azqMz/JWhrBh01Nf/pLLpZ4EX5RrESK5+0NyAQ5eiQ7n3CY1/htGu7Q
         EcRmMFAMbR1LLStSbqRPOdfMXHbRdUxFb3koFaX0zKo9WYGCwmr1UN4BiStkWmo5L4Zb
         439T0DIGiaDEojISOGooRabuLZ/nbSOSkRMK1g4N8Kn7VYaWhcXkswKrqXqDc1lanBt3
         c09x5Us6oE9j6DAsnLpuqytY2lTcw8QPBHos2sZn8fOUu+xbiM3jZ5zzXMPR4sBRjo0P
         1FioM76aoNXvQSyCXpCibN3ehuKfUvUFmhbFJLfwxHKVByueiY8lw0bcuM74l6g0ks8u
         mvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0vhrXmaCnBUAq1bek/phc8PfY46b3QRQs/x7Py8PZQ=;
        b=edgLLeCBb84WYD7DpzZXsuCssnj8Lw1N1SeyN7rS+eRkR6b5HyjZv9Oh/+mCAyNPkG
         ML65lEAa8EXGusTby1WS2+yCvgstcGInNGpmP4GzIMlA8DQ8YJR+4T8I46l6ZgQ334kz
         opL9psEyUz091CSvXPqfH0wTdHBf1meXmezaPrXumxoLl/kC0TJtDBIN7RPkMCJuTOEk
         rI8iJcBujlW5i7lWk17PgmV6+eTn4g+VT0CJim4K6yfXvOw3lfllpKSPklyxsmiyiq7Z
         28x7ybWpbqwAQqQV8zSEP1ufeVmBlVQD6UtnADYsbU1CIU6vJbJe1XHmKc7CVT5DKFnN
         hoVA==
X-Gm-Message-State: AOAM5336ob4mYbo6HuPNriyY320Tdo1gy44wJ2FSWRbFrpCMC5Nh4f+3
        CMfHbfXsrZdEJxKcFSEpnpym1cbTkZf4uZIgtQQ=
X-Google-Smtp-Source: ABdhPJxwWul77eZdHHvx6oi6bMz+Y4HPZxttbRu7mUGhTdVXHRMQ5s2ff5chvDrRR9kkeBI9UOOiMA==
X-Received: by 2002:adf:f285:: with SMTP id k5mr15177636wro.117.1629068720214;
        Sun, 15 Aug 2021 16:05:20 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id e11sm9545734wrm.80.2021.08.15.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 16:05:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unused variable and DBG_88E in hal/rtl8188e_cmd.c
Date:   Mon, 16 Aug 2021 00:05:18 +0100
Message-Id: <20210815230518.91656-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variable init_rate from rtl8188e_Add_RateATid
function in hal/rtl8188e_cmd.c, as it fixes a kernel test robot warning.
Removing the call to get_highest_rate_idx has no side effects here so is
safe.

Also remove the DBG_88E macro call in this function, as it is not
particularly clear in my opinion. Additionally, rename variable
shortGIrate to short_gi_rate to conform to kernel camel case rules,
and improve general spacing around operators, some of which triggers
checkpatch 'CHECK' messages. These are not related to the test robot
warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 6cbda9ab6e3f..8d03b24dc5af 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -155,33 +155,25 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
 
-	u8 macid, init_rate, raid, shortGIrate = false;
+	u8 macid, raid, short_gi_rate = false;
 
-	macid = arg&0x1f;
+	macid = arg & 0x1f;
 
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 	bitmap &= 0x0fffffff;
 
 	if (rssi_level != DM_RATR_STA_INIT)
 		bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, macid, bitmap, rssi_level);
 
-	bitmap |= ((raid<<28)&0xf0000000);
+	bitmap |= ((raid << 28) & 0xf0000000);
 
-	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
+	short_gi_rate = (arg & BIT(5)) ? true : false;
 
-	shortGIrate = (arg&BIT(5)) ? true : false;
-
-	if (shortGIrate)
-		init_rate |= BIT(6);
-
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 
 	bitmap &= 0x0fffffff;
 
-	DBG_88E("%s=> mac_id:%d, raid:%d, ra_bitmap=0x%x, shortGIrate=0x%02x\n",
-		__func__, macid, raid, bitmap, shortGIrate);
-
-	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
+	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, short_gi_rate);
 }
 
 void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
-- 
2.31.1

