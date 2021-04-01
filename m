Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1200F351211
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhDAJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhDAJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b7so1876662ejv.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwUrxvylt3yZIVSmbQay33Opg09VnbrEvLSM4U98oN8=;
        b=f93FHJiX8L0rS1HYbiHDXeFn1Z1Trmn85IE8Yo/oo492xrMADwzmZOGdvW+gF+KJ/h
         /WoOQKYNt53PfkwZJUyPYo3OAIZ/8hjpmddquymmMI8JVXNenigzuM6TehHASH8nIuvp
         RHqAtEC1OG2jZWwTrBTHBvKHy98di7pf6iaPfzB3YhnpWKtqv59HHGvDUkXIEwd8e+al
         3NtlQC33PgrLzmwQ6jH88V9S7ZdoQrrX7Fbsi6pFA9Dp6Qp8MOlpLpcL3gWQU7jVea9z
         rpcAYC1dnao1MhwxsnyIgbjHvyoUAiAMSGEj3XOzftDu/ix7ZvwNbkeJsaNlix0AeHpa
         xm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwUrxvylt3yZIVSmbQay33Opg09VnbrEvLSM4U98oN8=;
        b=Vf/2KvomnZXr2yw8sJLS3CyV62VA+WcXsBCEQ+JpNF8DwoXZgJmuEuj6/Yz7o4bydZ
         K9FFnXey+dG4veQh2/9uu+gVgSiyIEGDslUDii5spTpSkLbYgEJZF/KUq4+MjSFXIXer
         nY5T0qpWmMb62tNRwEvudKxpNGRrX2PwXmi9tUVgh4UXq9rlTS1f10Evwp4/ekGcvRnq
         OqzvDblmkb2KyZ+pRqE0XvGzQtCTkfrYhKFxYWK4Ot39hxi39HQkGX2UeWdEo6nLl/G0
         9xDOSVHVXSKEKVcCl1aJwSOlyMIBChfDoNqsDl0AA3guTevUWnkqKrsWMnPHyhFwC6qg
         kZwQ==
X-Gm-Message-State: AOAM5307uJK6p+HuMuSpL1YV4OwS53x9CNzEU8egoiIiTqGqJyegNJyy
        9Ftz7IGxmbDxtCZu0m6xvSY=
X-Google-Smtp-Source: ABdhPJxp1uexH9mkMIVaEa2jZdRk8Y4gFx3V+w4NVhEPTONKa17iUw7dAxN7NZeHZNXUMahYgIFzzQ==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr7973599ejo.546.1617268934525;
        Thu, 01 Apr 2021 02:22:14 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id s18sm3291145edc.21.2021.04.01.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 31/49] staging: rtl8723bs: remove commented code block in hal/hal_com_phycfg.c
Date:   Thu,  1 Apr 2021 11:21:01 +0200
Message-Id: <5af521bcb3e036a390ef2c434d9c0262770525d9.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented 5G code block in hal/hal_com_phycfg.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 9b16265b543d..a7ecdf501a14 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1780,26 +1780,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		DBG_871X("No power limit table of the specified band\n");
 	}
 
-	/*  combine 5G VHT & HT rate */
-	/*  5G 20M and 40M HT and VHT can cross reference */
-	/*
-	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
-		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
-			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
-				 idx_band, idx_bandwidth,
-				 idx_rate_sctn, rf_path));
-			if (idx_rate_sctn == 2)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][4][idx_channel][rf_path];
-			else if (idx_rate_sctn == 4)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][2][idx_channel][rf_path];
-			else if (idx_rate_sctn == 3)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][5][idx_channel][rf_path];
-			else if (idx_rate_sctn == 5)
-				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][3][idx_channel][rf_path];
-		}
-	}
-	*/
-
 	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
 	/*		idx_regulation, hal_data->CurrentBandType, bandwidth, rf_path, data_rate, channel, pwr_lmt); */
 	return pwr_lmt;
-- 
2.20.1

