Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C979243DA81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1Ert (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJ1Erq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:47:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:45:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l186so5180092pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4OISxA/W7Ea7fGLkHeskh3EaoItPM6YwHT8EDyfGs54=;
        b=gu6/JH11MBZugObAKhGfQ7IriVDZqholcnkBpmp2QHiT7+bIhbb+6zaGFaMuWyXenB
         u5D6p7x17K1yi+aJ9VH11WPUK35UoIzu/2sq3zyXiYDHNUBa9ruXhc6hKaBmJ0Nz/Vur
         RJClnNJCMJfF70KebEqttu9pNh4IeIZrc9DCKrHYdeIoznA3UwYhgYUm+Cpkwv99fNQK
         ZbIQTlcngfXm3h0qC6dZZExvjRG1S8gxr2go/l4Z5u/C6gAtEOsyxRDP1eBHx+fa0wd8
         LdMqQP4Ig7iKRCWDEhY7oDWc6DmutuHDg0iC0rnUBC52JESDZuavKawfe/I/y4kRZkRN
         8eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4OISxA/W7Ea7fGLkHeskh3EaoItPM6YwHT8EDyfGs54=;
        b=e9szxjk9to3eYxURTy7EFmwYzUz/yZGxM1V+sOsOz25nm9idQJFMNf93OJ8OpLqPNt
         2eFyAmeOLVPzs1kCVuqRO6dSRqDhMGvgMA7c4+IQK5y7oJyNFmMaAtVuzslRrFLeHgD8
         lKog9+/mBceeKkPFOzRku680IZ+U/J+vpCkaEePOpbsli8gMGanz608kFiWKAYjusW3A
         pqFf6e3SlT8Xciq5lSZ9cbu8gWBte/g4S9A7EXt3eMTRV90M1nMGOZn8OpAcOk52B8+V
         hE9IxjgEE3HEc+J1rHfxZQhs8+CNYIUTANu3RmCgRqpdmVp1D9OmRZZGCAck3yiV2gu4
         178A==
X-Gm-Message-State: AOAM533gl4g2FjNPIaqQ7jrbYsyDPGD8Q14E8YNM0Ifao/z3v5KeNeWq
        Yk10qyd/wv92kI1nXO3Ky+U=
X-Google-Smtp-Source: ABdhPJwPXaA5X0uwkTX41sHOwR8seDp1Vs0plHgCBExDwyhr8UdHIM93SlAc+teWEXuCTeq+L9psUg==
X-Received: by 2002:a62:524a:0:b0:47b:e7ba:d9e with SMTP id g71-20020a62524a000000b0047be7ba0d9emr2011564pfb.53.1635396319990;
        Wed, 27 Oct 2021 21:45:19 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.83.133])
        by smtp.gmail.com with ESMTPSA id m6sm1665964pfk.110.2021.10.27.21.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:45:19 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:15:13 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: hal remove the assignment to itself
Message-ID: <YXoq2ViLxPVwAgLq@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assignment of variable to itself.
Assigning the variable to itself not make any difference on value.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index cce3e7e80953..f1fc077ed29c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2746,19 +2746,7 @@ void rtl8723b_update_txdesc(struct xmit_frame *pxmitframe, u8 *pbuf)
 	struct tx_desc *pdesc;

 	rtl8723b_fill_default_txdesc(pxmitframe, pbuf);
-
 	pdesc = (struct tx_desc *)pbuf;
-	pdesc->txdw0 = pdesc->txdw0;
-	pdesc->txdw1 = pdesc->txdw1;
-	pdesc->txdw2 = pdesc->txdw2;
-	pdesc->txdw3 = pdesc->txdw3;
-	pdesc->txdw4 = pdesc->txdw4;
-	pdesc->txdw5 = pdesc->txdw5;
-	pdesc->txdw6 = pdesc->txdw6;
-	pdesc->txdw7 = pdesc->txdw7;
-	pdesc->txdw8 = pdesc->txdw8;
-	pdesc->txdw9 = pdesc->txdw9;
-
 	rtl8723b_cal_txdesc_chksum(pdesc);
 }

--
2.33.0

