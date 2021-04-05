Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485A3545AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhDEQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhDEQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60397C061797
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k128so5988998wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7BFqSIqisVb+P8mMvuvvRlADBX0+TPMxqh1kGTuZXM=;
        b=iG9q5XUtIHMDcHH7CsOFSN7JYSmNEWyPNz/jOrLZpz7bboDc3H4PFOnmRhLNwCF53T
         TnEgmVkO5WlVzHgp7bY7ldZ7NsqLgqJggU1Hqza/ikbtDr/RlYRWGOJKt1idCMoffBNw
         7QhMsh2uTurgReczK/rgRWsaznuzKHxk8+2K3lYi6LeXgMkbO5lVD7Qlkel9icCIb4c8
         93Dgzj+Dm9Somh3q9ZbdNqv/U6VqMm8Twanw2hmxiCcFosaPtaY0XZD7VKwpQwFBDwPB
         6FQCGN0aNddOVY/+D6L3x1iFWW1XiGLPA91tLmYpnfW1xqZrRnTpNDsCDsZa3+YWYr+G
         vVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7BFqSIqisVb+P8mMvuvvRlADBX0+TPMxqh1kGTuZXM=;
        b=P2IZPoIfW07deISnvsLpVYAzJLEPAmHeGF5C3HzGbTyzyM3pNBf8gFCyJ8wqkxrC5w
         45CgigEkxGj4u4evcNzoNpSEZIuT1bnhckUu27htU2I1SuJiJGcwkoPmvJh/10g53AGb
         1M1ROTbNhFWt/odd/2Rdts8pCDCMFRnvqt6XmmqunajIUWO/tBIvBmsGjpQOqsFKnuya
         dbjEejiP46F8/HRFrjzG9X6fAhPapIxZxMdEJp2/GQroz66su2uIqLGfvlDgLpZySV2P
         Mjcp9FlT386bAOVWUOSJEdz4c+WWc0hGLCK+DmySyRisX72sSx+pG6miIGW0ijktUtD2
         XaXw==
X-Gm-Message-State: AOAM531z1rKKzaYJkmACtjpbm0HiKVAwygTEiteJ9+tJGUdru5kdeM/k
        Ix60LBVr94FPflDOQdgAL4k=
X-Google-Smtp-Source: ABdhPJwMwa2NsjlE95FpdPqliEGDD8OGda7R1VX9xHRjszt7i9zH02Y9H6yI8+uCcLbQG1vtRinZZw==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr65886wmd.42.1617641431169;
        Mon, 05 Apr 2021 09:50:31 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id l21sm46969wmg.41.2021.04.05.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/10] staging: rtl8723bs: remove commented code block
Date:   Mon,  5 Apr 2021 18:49:57 +0200
Message-Id: <b930cfc476c97f2ae5c5b90c1314a6270d56a539.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented 5G code block in hal/hal_com_phycfg.c
which contained removed RT_TRACE log

as reported in the driver's TODO file:

    - find and remove remaining code valid only for 5 GHz.
      Most of the obvious ones have been removed,
      but things like channel > 14 still exist.

so just removed obsolete commented code.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index f52cc4e7a6e6..a7ecdf501a14 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1780,25 +1780,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		DBG_871X("No power limit table of the specified band\n");
 	}
 
-	/*  combine 5G VHT & HT rate */
-	/*  5G 20M and 40M HT and VHT can cross reference */
-	/*
-	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
-		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
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

