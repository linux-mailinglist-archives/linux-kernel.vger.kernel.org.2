Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDC36FCBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhD3OqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhD3Opb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE06C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so22342725ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=Sz/zjJpMWKi/lgGWUrf0NvR02MajjEHB6CEN5gc3EPrd+qWVOk/zJ+gbLzR5+bD8dI
         DWJWlDONT3gheOF/HvhCVqenFpKlrIr3RNt7vMZ4fAq3J4Q3p+FEQIc66t56AahpuPPS
         XRESqCxRV9/FFen5KwBSfowWNo0KVGqz+XFoR7imbkt1RSNjXKjffveRDJJ7MF2H9pcC
         EIBufiPnqnXi8bwhNaAtjEYllSkIupVBRzsWxCYezaFkgvQuOWmqCbu2S9ccYWCLpjtb
         0MaP8Zgs0DewnmWpdz1w2zzitEpIY2KlV8NuZdQ+gML04qXx/xG0zUWQcSmGDHwtz/6H
         bYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=knXOdYrWcsFci5CT5tC8Dvq3Vy6z/IHUePAZBejjMbxdiYg0SqDY/2JmrdcWQSCTgu
         rAInp3HfF33Z+YEHtF6wrX4fl30M1/stV0ttzfOe6nK+g0bWK9qFwQX6UtMOp4KPZOdN
         1k/f1wDkM/oomxqIxRCwNqAkdL/Q0g/gdEHw4vJD18N2zpRUmwcJkog+7u4qlFB7Fvrw
         mfM7Eep5NGyIgK+WhhPPUArXc4FfPYGLRRzQSuyA5bB3hXPHVuippN/aU/4Yy9EVM2LN
         j6XhZMmr+109HwSDGcJCdFXQba2nQIJ1NlsFaMdY4bsUFa8cMy2uegQhOFUsMm1rfqXP
         SE/w==
X-Gm-Message-State: AOAM531+ulwv3/U/lia5tTs0yG2+2eJ0ErQ1vg3s/cnfVV/YbZCwv9SK
        6A7l5FSbB5M/uPm7uixqzD3fA8mURcU=
X-Google-Smtp-Source: ABdhPJz6Ba7T6+nX9O4+EX9Ig9Ha4VB5Kf16NljCPZE/LuLgYPOIB+rAdQQOU/hpfe7/EC3RO3cNgw==
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr4773621ejz.219.1619793881661;
        Fri, 30 Apr 2021 07:44:41 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id pw11sm2048158ejb.88.2021.04.30.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/43] staging: rtl8723bs: remove commented out RT_ASSERT occurrences
Date:   Fri, 30 Apr 2021 16:43:48 +0200
Message-Id: <0c29df66f691f82fe894b153139869cc474cd7ae.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

