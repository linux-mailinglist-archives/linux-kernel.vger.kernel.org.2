Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07F9369566
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243420AbhDWPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbhDWPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA36C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j5so47740355wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWR3xIwcvAYs30wacpInm8yfy/J1zl7gAnK+J7z1umw=;
        b=hnVj5Ff93UBLRRCpqhNp3OfY8XfEP8wnCd4YzsLtAy09ESfWd2Y05o8QRA16cEJ0Py
         TBfkbyMFihsBP84ARA+iwedOu2q4xx38o5Mijl1CCNxormbPkRNoiOwutbpSuIip3HFp
         nfsdnhjaDG625nuY5zmnss1qJ1uiRSzBIZTfc5fRD0F++fHMepBcJU9zpCHukbLzLmFM
         AafBpezeabacmgraWurppvsx2Oa7zriqmJYviZ0scBaBloeUFdFvSLtPC4iCqZQKSMFp
         7qxL1xdNuTLEgezBfy32Oq/1drXgu/v9SYOuFgachRnkCeyIZS9Mp3EKnGucyuzqziOn
         BQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWR3xIwcvAYs30wacpInm8yfy/J1zl7gAnK+J7z1umw=;
        b=RFfd32eHmnODSOnwxLxHK1P8KdJllfGkr8EHcGbhaB8UILBfxtEOG03w+M7Ho5IrnF
         +EXpC/VhQPPLeUpTx7LonDGFdb/Q0vqf+o8wtoTMYuMwUOv5x4tH6kmWMb8n8nHdiJ4n
         9N0vZlchZVAJBWha4ARPRssNjRGltxuLIU2hiuJ7kLuFeNNkhjcxQjTrGww9+lNUfkqw
         KeO3lcJRDxBGIakspD7sgJQkxujSlEnCUfWCQZLxLrx8EPogSd1WhLnQzdd5f1E4AZkF
         mKkxbhebatChYVsYmvIJXCNP8h3ICmOpOGDyCSoI2nVacQf4aktzeFvcgD68VL9vJAIp
         3aVQ==
X-Gm-Message-State: AOAM5306/65V6gEgEmigNuqa3SzgtxGl0+SNlRAYjvjYQ+l47BUu/rDK
        0QoImohphBq/XdbTI2w6WY7JJNA784M=
X-Google-Smtp-Source: ABdhPJzZTiXcv9uCp0WrxDGVgpnEfrk2WRIcrAxkgg0j725fjccScibdjvboKK0TCv/tQreZkq6+JA==
X-Received: by 2002:adf:a294:: with SMTP id s20mr5290615wra.54.1619189971146;
        Fri, 23 Apr 2021 07:59:31 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 66sm13119497wmb.36.2021.04.23.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 30/49] staging: rtl8723bs: remove debug macros related to hal/sdio_halinit.c tracing
Date:   Fri, 23 Apr 2021 16:58:21 +0200
Message-Id: <1add977c53d8c0aa400e382177f558d3c5cad837.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to hal/sdio_halinit.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index abd90026a8c7..7c52c90d1566 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _SDIO_HALINIT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4da881e3a0c0..4146acb1cbb2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_hal_init_c_		BIT(15)
 #define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
@@ -28,9 +27,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
-	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
-#elif defined _RTL871X_IOCTL_C_
+#if defined _RTL871X_IOCTL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
 #elif defined _RTL871X_IOCTL_SET_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
-- 
2.20.1

