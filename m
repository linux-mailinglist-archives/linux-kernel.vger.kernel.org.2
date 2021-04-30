Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2336F691
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhD3Hp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhD3HpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC71C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so25136910eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=Df8+PccqxGVzyPU5aq4HxMr8akEVeR1QBUg9wpWf+c6u5UwxAxPILZa1zqVdLP4wmi
         Nh251fhGTdhkE1IKBwAVyUm5L8Lr1yaGeAayplWNeOJdwg2Jr6wkv2O89a9irUA9D9xE
         oBKh6XZcE3C37Wz38gryQGb9K0Oc170GeqFx2gdlYwnxkUFOXde1YCmdegqr1f7KDDbY
         MsAaFAFgdFLOsUQ1SsEZachX6aP3tqAvs1WxLG+pXZvu7nxrGp9W1N6gceZE1CXchKnq
         KFQHHqeLXxFNEVi94RZiFK6PqN/Y/QagZ1xSfatcnrC4/3RZPvG1hvw+3n8uVb6HxVLw
         Eu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=SWFJVomlkOlOc1Ukf6cecvqpZjZTADkQ/GF5r1ThwVt/lFBIwUXwr/yLkaUhUY6w+z
         g+8yfM9JgosW9aprEms3cUiNYLyQRvjCUv7Z/FojrMrE4J0YgPNHdUkRGzRFwVHjMuVu
         ucyYeHJdwwbqYS6/RJFAoorOmZZHArzG14jhtC//k0QWtl44nt24mtEK1ptGjomULBtq
         fGAsOB0Wnc07VWCjSnhDpmlnehjcRTBfQ/N2RWt1bfoIk6sHRXKfL482dZPsjANFTJke
         TW4cwQqxNLiwaKPBBNyZwkGub0qXwMWsO7C7Hpj8Ts3TuN22E3kJMkru/TJhnlNZ43pw
         zPDA==
X-Gm-Message-State: AOAM530fUS6/Lhl/P0jG1wrHDQ0WxHLykxhtzsLBzoI16xOQrSRrJLPN
        dggcTVLCg09iJswdj0FGGNOODYPuruwSQA==
X-Google-Smtp-Source: ABdhPJzox9v1SA5LN+VNJIVGeNTXD1bur23Tw5YLcAJ3VUMXBEMlw/ATpYNDlBrOk1oOFvXtrxfYZA==
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr2890750ejr.501.1619768674162;
        Fri, 30 Apr 2021 00:44:34 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id ss6sm1467359ejb.60.2021.04.30.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 18/43] staging: rtl8723bs: remove commented out RT_ASSERT occurrences
Date:   Fri, 30 Apr 2021 09:43:36 +0200
Message-Id: <008f036ac799cecf2878d76fbfe28e10a2587ce6.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out obsoete RT_ASSERT macro occurences.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c         | 2 --
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 3e671cba6b94..c0689a4b7cb1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1794,8 +1794,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 			/* pTS->RxIndicateState = RXTS_INDICATE_PROCESSING; */
 
 			/*  Indicate packets */
-			/* RT_ASSERT((index<=REORDER_WIN_SIZE), ("RxReorderIndicatePacket(): Rx Reorder buffer full!!\n")); */
-
 
 			/* indicate this recv_frame */
 			/* DbgPrint("recv_indicatepkts_in_order, indicate_seq =%d, seq_num =%d\n", precvpriv->indicate_seq, pattrib->seq_num); */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 082448557b53..4e21d98f7414 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -122,7 +122,6 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 	u8 *bufferPtr = buffer;
 
 	pageNums = size / MAX_DLFW_PAGE_SIZE;
-	/* RT_ASSERT((pageNums <= 4), ("Page numbers should not greater then 4\n")); */
 	remainSize = size % MAX_DLFW_PAGE_SIZE;
 
 	for (page = 0; page < pageNums; page++) {
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index fa285003b427..fd060cf7bc57 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -226,7 +226,6 @@ static void _InitNormalChipOneOutEpPriority(struct adapter *Adapter)
 		value = QUEUE_NORMAL;
 		break;
 	default:
-		/* RT_ASSERT(false, ("Shall not reach here!\n")); */
 		break;
 	}
 
@@ -260,7 +259,6 @@ static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
 		valueLow = QUEUE_NORMAL;
 		break;
 	default:
-		/* RT_ASSERT(false, ("Shall not reach here!\n")); */
 		break;
 	}
 
@@ -325,7 +323,6 @@ static void _InitQueuePriority(struct adapter *Adapter)
 		_InitNormalChipThreeOutEpPriority(Adapter);
 		break;
 	default:
-		/* RT_ASSERT(false, ("Shall not reach here!\n")); */
 		break;
 	}
 
@@ -516,7 +513,6 @@ static void _InitOperationMode(struct adapter *padapter)
 		regBwOpMode = BW_OPMODE_20MHZ;
 		break;
 	case WIRELESS_MODE_A:
-/* 			RT_ASSERT(false, ("Error wireless a mode\n")); */
 		break;
 	case WIRELESS_MODE_G:
 		regBwOpMode = BW_OPMODE_20MHZ;
@@ -530,7 +526,6 @@ static void _InitOperationMode(struct adapter *padapter)
 		regBwOpMode = BW_OPMODE_20MHZ;
 		break;
 	case WIRELESS_MODE_N_5G:
-/* 			RT_ASSERT(false, ("Error wireless mode")); */
 		regBwOpMode = BW_OPMODE_5G;
 		break;
 
-- 
2.20.1

