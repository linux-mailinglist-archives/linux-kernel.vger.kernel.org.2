Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302363408D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCRP1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhCRP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so5983959wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gD0XPk1OJXjVtF656u9g3SevBYs7zy6UJ7aTHOt1giA=;
        b=mzR2Gk7t2RJfJIOCdVFxQFsgAu7/0IYBiP2Gk56zJEgwqToXIqAzb5NLS2Q+OezgBh
         VD0KHwaZ80WPzvYtBrUdjv+GjsPo2qdSHr1h+laGeZrysTqqnyUymAQP7QzPIdZNNeBn
         +wc1dVl/uO5LX54q8Lvrw4vkVR2B6sBZfS0yaFB1PlgGjtHe5+H4Mvfen2+TSmytxpKx
         91FSzGDmRGdLybM6IaQfnzokPzzXzy2ee/n5xjqBUCDKbaveZO+g666tgk/wazrbJZv1
         QJHXmkCUNKeZkiEHBfkGiddX8awniFO1B+JzEaV3ISQv8mXsLutUmkHlvlqqESCnxiNn
         dEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gD0XPk1OJXjVtF656u9g3SevBYs7zy6UJ7aTHOt1giA=;
        b=XtG4FYc7ruzFSPPiw+tH1enSusCyhrU5WWVa5r7mSVuqeVjGphutb2agj++Z0dp20T
         He/ZmXOUJ5xzBzligHuD/rO5R3zjTM6kAbbbWpyX3CBzxdCOkwR4xjzsgMmabXhm0FKC
         bMgK8WOOTIHFnxZGzPMvKArz2xt0IHxUcdCd3BRJuLzrVaGBDnaggZ+eJpOaPI58LpGQ
         CleImhKqoDUryL++rO06lGqnJfsAWUmFCrS/a0C0OdN3TsmFfdZR8YvA3/PET9Pi/b4I
         5DhG345z4AEuoPKmEzDdkrDK+6w4lfj60yz8DgttUQlqP4o7caJZ/ee+n8BcZSs2DYB2
         CZ/g==
X-Gm-Message-State: AOAM5329SjMwbsTx0K+qujszbK/O8PQTGxckCh8iq1kWy0SHreoyhXn2
        Ee51fVDFCaDiIK69c/0kfwY=
X-Google-Smtp-Source: ABdhPJz56A48NXwgZLp+Cg1NMQH0ToB1PEt6tRHWGGHAHhPhwwKAa2IRLVzF6ufa88+GBr5T3E9erg==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr10542345wrn.352.1616081221744;
        Thu, 18 Mar 2021 08:27:01 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id z7sm3494135wrt.70.2021.03.18.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/15] staging: rtl8723bs: remove unnecessary logging in hal/hal_com_phycfg.c
Date:   Thu, 18 Mar 2021 16:26:02 +0100
Message-Id: <20210318152610.16758-8-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
201: FILE: drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:201:
+	/* DBG_871X("===>%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
265: FILE: drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:265:
+	/* DBG_871X("<===%s\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 7405f9229117..20d81198f316 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -198,8 +198,6 @@ struct adapter *padapter
 {
 	u8 path, base;
 
-	/* DBG_871X("===>%s\n", __func__); */
-
 	for (path = ODM_RF_PATH_A; path <= ODM_RF_PATH_B; ++path) {
 		base = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, path, RF_1TX, MGN_11M);
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_2_4G, path, CCK, RF_1TX, base);
@@ -261,8 +259,6 @@ struct adapter *padapter
 		phy_SetTxPowerByRateBase(padapter, BAND_ON_5G, path, VHT_3SSMCS0_3SSMCS9, RF_3TX, base);
 		/* DBG_871X("Power index base of 5G path %d 3Tx VHT3SS = > 0x%x\n", path, base); */
 	}
-
-	/* DBG_871X("<===%s\n", __func__); */
 }
 
 u8 PHY_GetRateSectionIndexOfTxPowerByRate(
-- 
2.20.1

