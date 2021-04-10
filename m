Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B9C35AE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhDJOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhDJOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1FCC06134F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so13020762ejy.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXbSlvie1MvfgOkP1AW3USt/q0/wLLk8BtI55t52f4g=;
        b=lFn8+kNftQ3UlKaoR50PF+v+EmY6zuhi90mKZnwAJPlgUu1bmC5wA1SrYgltETR74k
         GYpk6Fk14aCZ5hiYeTXPdSX36s0v4g2B6jca+PBG240MNlKxGfwIBJPQ0JJSitfxYV6N
         AL+kDzznoPXdDUgplwX33WkeIxTe4FVqEW66quO1DK7RS9OWJT3F67PAe3YvvJxinJDB
         DuJHfxkRNrphkUV0mZoNrrlhmupXtLZOILsW5Exws9ks3/jgXyw8U9C1c7yIAL+221BV
         aAY5dS6xd6kLRecsUVLRise05+m5E1QQ4hhf4WwxXggFU0fo1amsChUgBjIQaRYj0TXY
         Q23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXbSlvie1MvfgOkP1AW3USt/q0/wLLk8BtI55t52f4g=;
        b=A+yBiAarYqL58Dmsxrg8AwhWxHbx617uBXJBx1rOcXRO7UU6i/ZUZv9GJJGszY9fCC
         kv5MwEpf4DKYF99SBWiEpnUYL4UeU12KNS8ack6IEs2AYxjeeysVItFQBo2jpxc+knzQ
         iZ9XGCP7aFfkeUHNmIEckgJ7SHz90jbpGtfipCa81Z/Db9H/ZxjFHBTxsDEmvfF5YH+7
         HgHHJ7RpdMeQdpL0r8isNFdPLRZFTi4u3iaI6ohOuE2HONIbS5Rq3R+o+dnjmaJgz8Tg
         bNpJjpkxj5TlQyJe9F2qZs7Fq7kfHZ5g+q4FQQZPVmdelH970zkRZb7wQlfWm8b3rrUd
         S7SA==
X-Gm-Message-State: AOAM5332JH9IigLP6bpCDaEpEHBDtL1Yg2zImbGPm5g1rOs2D/YDdd5t
        9FZDxEg3kmqrSocNBEjiLA/4Cb6XLrJh6Q==
X-Google-Smtp-Source: ABdhPJz6WxUQDtmCTs3zDrUsGLWLIxtiatlj6B3m7Ap9aBqZftCOSmL4l5mVj+aYuKHy3ikM9s7d8w==
X-Received: by 2002:a17:906:8392:: with SMTP id p18mr17025811ejx.132.1618064479796;
        Sat, 10 Apr 2021 07:21:19 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id p7sm2056848eja.103.2021.04.10.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] staging: rtl8723bs: remove more empty if blocks after DBG_8192C deletion
Date:   Sat, 10 Apr 2021 16:20:38 +0200
Message-Id: <99b111d2bac822b9dc7ff6e1cfd3d3efc62ef836.1618064275.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove more empty if-blocks after DBG_8192C deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 049112a08776..2098384efe92 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -882,8 +882,6 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 
 	/*  Run LPS WL RFOFF flow */
 	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
-	if (ret == _FAIL) {
-	}
 
 	/* 	==== Reset digital sequence   ====== */
 
@@ -914,8 +912,6 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	ret = false;
 	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
 	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
-	if (!ret) {
-	}
 }
 
 static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
-- 
2.20.1

