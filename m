Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C936FD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhD3O6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhD3O60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE46C061345
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so15039540edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=jqbhyGlEplZP2BMKcNrr+U+vZCKqEx2sISPjS6uHVvsTF1irqNokECckUgPlPfIhYc
         O1g6zY3WhIOmp7gn7RG+UPQebY8+da2W6G/oUZ9sUEMYqXll/rzswToju9xOK3t9kzEu
         8apCglVqr+k7I5fxH7tSrN9e7mipi3eAcpilDrfZyKBnKCxK+sApgkYKJspVGNDT/WTj
         QRQAXcg4/mh8pheLO8wzm7yKP/NlZn15+e4/mkKXbXcc8Q5mWfUx5wLPTd/5VJphFCpj
         Q9RWhGjKTXUSSZJ89IHffWm9ucohu3u9gqVplEXR9/7cNitSVDjgnXnemh67vhMEaIOX
         349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJJ61W3+Iu0fr3sRea0FAmFrj9yp9rKb5qGmB+mhT84=;
        b=HO1lZik83zTuXf0hvDJvDL4cmJ1IJMmxqSLxt4zlG7hGykTmYVOmg4V4lUocstb26T
         hZNOZJ/nr2Jwor7HoAnHqzltxl8kOTNu0ougpu2XuJgDJFnpuHBYU6ev/f76Oii2S7j0
         ZOdYg8WxbwOfk6TQP9UX2JKPbJ663+YZUoSV2pTYUMc8nsbaV/cB96QEl1GXcpuwFqDa
         /Dq3Z3auVs3IOk90XN9GVPlTz34vdnMJWklf0v4EBAHObMmv57IJr1tWS4IWnGoil3e9
         3lO58/crRB2L3qG9R5c3FzlA/ixsOaDPchAtWi6713Q0KN+XZpglQXfE0wE1q0womY7A
         Zu5w==
X-Gm-Message-State: AOAM531oovJbI0ji9j1E3YX0c4KAC/n8x0MKZq3EfTM10NaLsgpDo+q4
        mBd9DRY0Q2wTzNqM7JuYH/X57pJFbz0=
X-Google-Smtp-Source: ABdhPJzey6mlFSVJ1otmpLoZRWKYm6CewmGTTps93wnKwfAAkT4EmZzEZETKFQZu0M2ajPk/sYfdIQ==
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr6500268edb.264.1619794656532;
        Fri, 30 Apr 2021 07:57:36 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id 9sm2085515ejv.73.2021.04.30.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/43] staging: rtl8723bs: remove commented out RT_ASSERT occurrences
Date:   Fri, 30 Apr 2021 16:56:40 +0200
Message-Id: <3ee98d7bf1685af627e625f413de355fce58d52d.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

