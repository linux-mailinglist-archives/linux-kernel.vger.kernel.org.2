Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CB35B468
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhDKM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:58:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DCEC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so15749270ejy.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRMti9nujvKS8H3X8tITiw1ThPL4vQHA+hUAaNa2c7s=;
        b=TATloitH6Bay+1BTft/k+MhmpWkk8o77IH1l9FwWkEKpw5U9Wd1FnlNc2eDYkaXslp
         FgydzAFqWWNIMNquxm44Ndn+1KAZMpGjiQ3g/TBo5jZFFh1d9JdU8UrXvsn7kZNM5+A+
         ndD3az7bvsdHUDF1xiQaAcZvC4zO0xjFKpOQKdH9JdSZxLqhQ6bo2Oae7mrbDqT+yLet
         ToUnxzfcMkEAl/tXywu6deOWn/Eupaf9kdXhZbtB3XUepxzywSUQTTQufvuzG3TZv9Hl
         FFgLqUWF2+GUxKGpchaDDq81HX6o5UMtbY09gqXPH3+n12zjkpOMrHwRh71Uoxl6sE1k
         ogZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRMti9nujvKS8H3X8tITiw1ThPL4vQHA+hUAaNa2c7s=;
        b=YWHEb1f//wijxtUmrKRT+Q21igi6BNEwcvTR3W0rMGPTZzwLSLb6d/k0a/jzKY2uJV
         N4yoCdRKxr9N4IQLJsu7YMFPblGkN9M0f2b1TU26y74OzDZ8WDSnlfsgE5h7R9AkwoZi
         HlTN/AEk92jsPx8TJdWJH/BoinaqUTcPKAP/QkJfSOewmYoCmk/WyvaT6bhAaXbPhfWA
         MJnS+9/5oSWPyUXhx/F8P1TZ8yw6y7DAZ+vqcRoTQWlLgOh9cd5Cs6gC/+mXuXtiUG8+
         mk/tpwttCO68BMAyDg7qXS25TrbMmkOWvnLeaSdWMAxEcwebNfgfVtBuQm1UUjXnJ9FQ
         x+0g==
X-Gm-Message-State: AOAM5321E7WFCaCDZ+iqMrgIzAK+dcig40ye6BasoMIgFma5TfIEi/is
        B7GRguP3iPfctfQySi9WnxU=
X-Google-Smtp-Source: ABdhPJzQGw6N1wq2MTVUyHdymB4moAe+PKVHgyjw+2glTJMGB8xihypkzLJbxckCSwwh466iIHLE2A==
X-Received: by 2002:a17:906:8303:: with SMTP id j3mr4045920ejx.85.1618145869024;
        Sun, 11 Apr 2021 05:57:49 -0700 (PDT)
Received: from agape ([5.171.72.218])
        by smtp.gmail.com with ESMTPSA id r19sm4031768ejr.55.2021.04.11.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:57:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] staging: rtl8723bs: remove unused variable ret in hal/sdio_halinit.c
Date:   Sun, 11 Apr 2021 14:57:35 +0200
Message-Id: <fbba90b0c8fb9f65b0dc7bc0b02560724a5502ab.1618145345.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618145345.git.fabioaiuto83@gmail.com>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following compiler warning issue:

   drivers/staging/rtl8723bs/hal/sdio_halinit.c:
 In function 'CardDisableRTL8723BSdio':
>> drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5:
warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     881 |  u8 ret = _FAIL;
         |     ^~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 2098384efe92..936181a73d73 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -878,10 +878,9 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 {
 	u8 u1bTmp;
 	u8 bMacPwrCtrlOn;
-	u8 ret = _FAIL;
 
 	/*  Run LPS WL RFOFF flow */
-	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
 
 	/* 	==== Reset digital sequence   ====== */
 
@@ -909,9 +908,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	/* 	==== Reset digital sequence end ====== */
 
 	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
-	ret = false;
 	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
-	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
 }
 
 static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
-- 
2.20.1

