Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD9136D690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhD1Lel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhD1Lek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71444C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e7so73682194edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hJ076sy9pVna7YQDPLSat0KUjjKGv3lXcjm2Wa8PnI=;
        b=MGPO7igde+CUkjMBdr0MSCg4rDhl1Wmpu/RDuySNCtNXEWFnpTm6knupqo9XDt5TkZ
         5cvq/83Z9Lp2W3kwTSj8PKvvrMIyeAJEiW7sNKN09ER+WhAPXB2jzyVuv5xWujAAvwM2
         RtbVTQlS75qSFDhQO53ahu594ISkP1uI+cl5TXqfZt6wsuDp5mExfKQ873vs6S7nwHnW
         t3zQsrwuSRquAKGjOqOAlyVNaPde6ltHTHNzZBGcBd3IUUxGJYLfFC0gGU/owwzo3vRj
         as0Dg9j6KlKFoqBYhrVbvVASkLgImGwlW+tY8q5+p6ryFz9ohSN9DVudUbma+96U3peX
         8gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hJ076sy9pVna7YQDPLSat0KUjjKGv3lXcjm2Wa8PnI=;
        b=RmJHlZVqo09y520VjL5HEzbVZkA9lwyaxLIwIJh8HYBVlaLGg9PRDl4G6pcIVg9Jfj
         VTlzPwReRsMp/6hByuaUEFlMaEqrxKI+XkjQsNE5dLniOha497rqfbAmbmVPl4+b4ARD
         KCXLLrB5VpXnKcQq4pv51I7PxWm6yzRhvMUztmP+BGwHCj5ZggC8Fztx0LQG+wMKdUUQ
         KQfGRgvFNZ3tmfvIMDjF2ebgiQw2j+9CPdIOreGt32MHtZnoDPZFiuOCLMK+4+FI9Hny
         HzdMPg1S5tea0Lug+QM6JfFCbEcZcZcAB2F0JGKYS1iFVUeRfIW4XKMVOhCZ7ssLMeMU
         q72w==
X-Gm-Message-State: AOAM532MyojAuJ7pW3AykwoVeMFvKLRNr54eA/iR/HcGwNR4i0p8LDjG
        Ih5nYXGCGc9WSYCsKnck8Do=
X-Google-Smtp-Source: ABdhPJwF72tKwjC3U4roW3UGhf92mJpoWrOhTVLvlHBUan7sLVvNVmCtQYvpPvUa5FoIo7/qlS06OA==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr10478955edv.321.1619609634249;
        Wed, 28 Apr 2021 04:33:54 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id u19sm4677187edy.23.2021.04.28.04.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:33:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Wed, 28 Apr 2021 13:33:45 +0200
Message-Id: <20210428113346.28305-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428113346.28305-1-fmdefrancesco@gmail.com>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed four set but unused variables. Issue detected by gcc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 082448557b53..96cb4426a0f4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			u32 cmd;
 			u32 ra_info1, ra_info2;
 			u32 rate_mask1, rate_mask2;
-			u8 curr_tx_rate, curr_tx_sgi, hight_rate, lowest_rate;
 
 			cmd = 0x40000100 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
 			msleep(10);
 			ra_info1 = rtw_read32(padapter, 0x2F0);
-			curr_tx_rate = ra_info1&0x7F;
-			curr_tx_sgi = (ra_info1>>7)&0x01;
 
 			cmd = 0x40000400 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
@@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			ra_info2 = rtw_read32(padapter, 0x2F4);
 			rate_mask1 = rtw_read32(padapter, 0x2F8);
 			rate_mask2 = rtw_read32(padapter, 0x2FC);
-			hight_rate = ra_info2&0xFF;
-			lowest_rate = (ra_info2>>8)  & 0xFF;
 
 		}
 		break;
-- 
2.31.1

