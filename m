Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8634FD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhCaJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhCaJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so29079846ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwUrxvylt3yZIVSmbQay33Opg09VnbrEvLSM4U98oN8=;
        b=oGdh1hqDoJ0ZqEbpJv3GhhODipHewFj0wuYX/Pjuzq5aX5Q7zivjem57+8ZCXXe7tf
         znKeXjAGx/KdMW2obP70TkdQQRETAS1tfurb4j/hvbh7hzXrilPH5xscsYV+O+lqsmeI
         ZTlJOaDnpTtqgte/PcBqDhhjQtpo/7ZnBU6s8i/aW+O4xm5dhLEQILHNfPTsxEj0qnZ0
         7RnJE/fCs6HJ4yoM4BA76XFwSVlYkUqLBR9EURPkC4hnSFR8X5xZzcrG3VMPejhMAmqs
         wJLuT5orODNokIgMmN2BMsMTO1TdoDoPXAN3uNeNo86QEtKK1GVHvkzJDSpVOv6zEncH
         fMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwUrxvylt3yZIVSmbQay33Opg09VnbrEvLSM4U98oN8=;
        b=pft+Z0jJ/V/A6rqa/ezvPntTsi5Os7TjdlvfJ0Jhqd7ATpGlpR0faDKfI+ADHdwAnE
         O3ARdgpoJvbtoqXxFmx9cUuXSuOx5w9WMIRPLvexgcTZm+06+L0+AOlt63NriTN4TDC2
         PM00WHzSTyHKQa3RJukKJ+M2qzto5o0biES9fHvNGxip9TCscE34Ny+cHj8M8qk7mVAv
         JIhq9QegmiEFfs4Pn5GEsak0l7j1ijJcKqtLlThPh+WHAElG/Q/8lQ8oL6T44sgAAJ5+
         xySQaB2/vjgUqVQm5XMI9TdMQ/5PrKWaiXY/dDnESQEauHzXBmAGhouLET9e6V5LU4jv
         zg+Q==
X-Gm-Message-State: AOAM53259mvhmBEjoMVIOl284GtzFZUCA0gSSjdGhLPNruVJnDNLug2q
        6cpNs8y80isHYzwuAKKlKsY=
X-Google-Smtp-Source: ABdhPJxjPxlrjZD34DiT7/cRtCwf+cDYiExocYwQw89ffRGXzLBcRNSRdQP7aVblqufpT/OEeGvLbQ==
X-Received: by 2002:a17:906:170d:: with SMTP id c13mr2449440eje.491.1617183654147;
        Wed, 31 Mar 2021 02:40:54 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id t12sm1165502edy.56.2021.03.31.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 22/40] staging: rtl8723bs: remove commented code block in hal/hal_com_phycfg.c
Date:   Wed, 31 Mar 2021 11:39:50 +0200
Message-Id: <e8aade1657d685c68c8ef07fa6aca628b1cec8e1.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
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

