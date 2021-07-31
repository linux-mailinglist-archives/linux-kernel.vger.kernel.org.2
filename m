Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64EC3DC20D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhGaAkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhGaAjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1BC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so7440113wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2VOF/6t8T7JeMLQ5ygcpvN7H+OM2r3fEaRqgqDNEFo=;
        b=peZS5FzuXtr3oQ9RpPLqTQ4DB7LgvrjNRpJEzhtW8ykQ2ZmmG7Vrbs9cmce83/5cy3
         TzLDnG/pzs0lMxCZjQJx7ICBCKxe9hwoHfxDN2VB4lyxRZ5fhjR5zt7tixICOpVUifod
         XHRfaDngoCkuFUMh0btrY0bn1DZSyiwtX6By3/wFByfrM3/g3Z5uqqg8vp/N+RubJl7V
         QknExQdSiKTKnRxHLXjN5wy5tkqFR5wTwcIJ0oMmJp4n0gItQQQUjcxk4jh37MjM+Lw2
         ps2lrHHEhKaMc/kGczq5qH3pQ5Dq5sxLyK3tdkGlee1WlOrJtLqgeivMpg+xtiDT/xWQ
         Ytjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2VOF/6t8T7JeMLQ5ygcpvN7H+OM2r3fEaRqgqDNEFo=;
        b=B/w4rjr+tk5DYCZ6M5IhOwXbMt4le+kHlNEEDPj6EzXZBOaCHUFiix3++oQLQlBFiM
         wOkAZAOV+WluIalB9ftAjYKGNjV0I02kLB0qr1mDawUVoziPBCaXnddsrmWdf/sjcI4j
         1L9UPbRHwt8ZqpsJ5sJqlUy3dtnyzVCMiE6tcCsUBBP/dRsDSYFQ2kqLoDG40HaDxK8y
         q6cJq228tJr+cuWGTnpsRkCS0ZTy7z+of1F8LOW0BO2PaUPnVOlPHNtZonXl5vsbLwA+
         vxxnfBwGgceM0zBqQ6WZRfjUntgtYJ64dHAMa+s3JCNfdH7l+AYdu2SCtoz7C5/h49yk
         ia4w==
X-Gm-Message-State: AOAM531YTlHCBAjf07qwhsLi6O8M+8zbNQC4eRsn3p9CajoNgMPZkwCb
        Tk/kvcIPPNXgIHqi5cGoqoG3/A==
X-Google-Smtp-Source: ABdhPJwiAep0brjFq/rPm4G6fftgTAxQ5G5L2SnKj4HehFQ3hAHVDoqu/dhwpY2RveHpx1B718tKGg==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr5609310wmk.71.1627691985338;
        Fri, 30 Jul 2021 17:39:45 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:44 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/14 resent] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_HWConfig.c
Date:   Sat, 31 Jul 2021 01:39:31 +0100
Message-Id: <20210731003937.68615-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
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

