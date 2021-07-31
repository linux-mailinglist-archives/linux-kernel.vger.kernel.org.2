Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766353DC1EC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhGaAYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhGaAYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB7C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b11so8008673wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2VOF/6t8T7JeMLQ5ygcpvN7H+OM2r3fEaRqgqDNEFo=;
        b=V1Z3GrSE6R7yKM5Jj5/NFf/SVRqtQGh4fdhRYCKCpTBtrtH36XFnXDksnRG2uqGuev
         wCkVUxlFIVYs5pUmYv3kR6vLodbTbVVmELh9Qn7f4l/cJexQzsnk4VMGMr6+1tt0m3VJ
         Yi+V22zFlTNOrMX+q8JcFpgg9z30a1V39fKVUOW3BoscLoD+8h4DDlteTNbBJAad2gT2
         S0UHWXjd1d72obEXl9L2LYbM3b5MML8Jqhq1Gtl2XMz5MGYd374UyJ9kfmH8Yd1Akr46
         +jlagO8W5fefwLMq5AxQtRdkoF2PWbX4R9tWVxrxDqf7LnvM1CI9aDcC8g+xpMe/s+nG
         2b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2VOF/6t8T7JeMLQ5ygcpvN7H+OM2r3fEaRqgqDNEFo=;
        b=hkz5S35QQbHdZryZ44jZnMKhnZZcU2Vij+YKGmj9qzYukXIsVgPQrgzdOyG7O3V4BF
         tn8fJXZt7agGhhHxknX2mThKa8cC6VVO4J2YpfdzyTCbbu42imLhpqtTP6b4wdyRgxo0
         Gp7T3r2ugCN9JMF5IfEnR9mAPpBunyXwz9UhgXL2+zvxN6Xa7g0cqm2i7hvHuk7TxDLk
         UboVkFvpgsNdShMBYDV4SY6QTOGlhK6DqruFDj3bLzp7h6SdRD4fIKzaqpnxHHsqTdWA
         PXPewUgsfjdoP4IPdlFJ4NJq5wg9Y+fLrqUPOyB5O0OXtxp6z92MJWZ5mciLLSYyee8S
         tAYQ==
X-Gm-Message-State: AOAM530fnc0kJtqyzPv+olPyyBkqiKbu7FIODzoVUWx2tYXT145wT/yM
        4UJl3a1NcEgWgk+2ICy0/t2oQw==
X-Google-Smtp-Source: ABdhPJxkN5wZuWcRhDHG3WUOtItoVLQD6bvbwON4oXgShpeLWDFzkGmw8OqMmYNFtSfzVsDEBhE72Q==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr5780963wrv.20.1627691041380;
        Fri, 30 Jul 2021 17:24:01 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:24:00 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_HWConfig.c
Date:   Sat, 31 Jul 2021 01:23:47 +0100
Message-Id: <20210731002353.68479-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/odm_HWConfig.c, as by removing these
calls in this file and others, we can ultimately then remove the macro
definition itself, which does not follow best practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 93a91cce21ec..5f29535590cd 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -535,15 +535,11 @@ enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
 					   enum rf_radio_path content,
 					   enum rf_radio_path rfpath)
 {
-	ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("===>ODM_ConfigRFWithHeaderFile\n"));
 	if (dm_odm->SupportICType == ODM_RTL8188E) {
 		if (rfpath == RF_PATH_A)
 			READ_AND_CONFIG(8188E, _RadioA_1T_);
-		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, (" ===> ODM_ConfigRFWithHeaderFile() Radio_A:Rtl8188ERadioA_1TArray\n"));
-		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, (" ===> ODM_ConfigRFWithHeaderFile() Radio_B:Rtl8188ERadioB_1TArray\n"));
 	}
 
-	ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("ODM_ConfigRFWithHeaderFile: Radio No %x\n", rfpath));
 	return HAL_STATUS_SUCCESS;
 }
 
@@ -557,8 +553,6 @@ enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
 			READ_AND_CONFIG(8188E, _AGC_TAB_1T_);
 		} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
 			READ_AND_CONFIG(8188E, _PHY_REG_PG_);
-			ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-				     (" ===> phy_ConfigBBWithHeaderFile() agc:Rtl8188EPHY_REG_PGArray\n"));
 		}
 	}
 	return HAL_STATUS_SUCCESS;
-- 
2.31.1

