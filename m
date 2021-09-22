Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640B415114
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhIVUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhIVUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09DCC0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so10445968wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzpb6fJs45vqwIx5ZuDi+xk1ZoJWj5oWD4/3xrjT52c=;
        b=IenqC1VXJ+1OXfXOBWg9iLNpVymqEdI+UOmAYUEFhEdwf/vwfh0JuUKix3nQy2+17n
         junUqvMgI9IltfA40CI1ZhR2YFlciaTD+aiNu8vfrCc10+eMjdREj9He2LuZ5RmoGW6O
         ADrvaztz27BZF8ZgVZwQMrufdTUw5Zog1eCqNb7aNhRJKN6uKKf30GXk+oUQ4kYUz2ck
         lbgOm0ovy2r0XcqiaHFmG2fxNOL1VtN2Ck8oEbYaAM4/HYmnT6wrbGoQ307r4ADNuGMb
         jpK7cuHitt40eEdu5I3dybygUlh4PQFFclQsooZFy3VrNM3nQoulPWrdsEeKRvajS9q4
         j0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzpb6fJs45vqwIx5ZuDi+xk1ZoJWj5oWD4/3xrjT52c=;
        b=sqLvY9rhOMdNNMTDtTVg2+vuX6DsXBaxTWv3aXXjC9F95NbCOAcAZ/0LiAJzrvxaYz
         zXOdFc6uLaPLRF0Llo7F3+feXKjoMd8JDY1Tky/57/qCeVWeQIdWPLKiArD4w7gJcmBn
         c+qdovoDqMGLc+CFfeCQJ6EnjnxIjMgN4m/OLiq3B9HAhC9jTyfHCSuLzE8YDk4RgYkS
         PvjUz1nUMYwcqPBt4195ts6LuyOeRFJnu//ot6yAsckwo5lUVnPySvnJhf5KWKiUW8CO
         i9FbqOtz391Nl+cEdbxfeBEwmVXv3WU3FCGpxSuLGmRpN8AVZPF+HJSBP/upx+dCgU3Y
         9soA==
X-Gm-Message-State: AOAM53154cqY+1U1s1xvyYxku7usMFY/o1MOH1UH+vn7+NL+Z6YUAX+f
        LijTrVTI980VgWAqR6QfrEHGyHwPOKUGbA==
X-Google-Smtp-Source: ABdhPJzID3D9VByICdfGpTpa20XsYymyCm7xnw6fT+Ym9/TxmfbKdWnBeRz75gqHTxsOY96mTMGl2A==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr891026wrn.290.1632341154352;
        Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 32/47] staging: r8188eu: remove hal_ch_offset_to_secondary_ch_offset()
Date:   Wed, 22 Sep 2021 22:04:05 +0200
Message-Id: <20210922200420.9693-33-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function hal_ch_offset_to_secondary_ch_offset() is not used, remove
it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 12 ------------
 drivers/staging/r8188eu/include/ieee80211.h  |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 182164e17b3f..9379beeccede 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -163,18 +163,6 @@ inline u8 secondary_ch_offset_to_hal_ch_offset(u8 ch_offset)
 	return HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 }
 
-inline u8 hal_ch_offset_to_secondary_ch_offset(u8 ch_offset)
-{
-	if (ch_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)
-		return SCN;
-	else if (ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
-		return SCB;
-	else if (ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
-		return SCA;
-
-	return SCN;
-}
-
 inline u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len, u8 secondary_ch_offset)
 {
 	return rtw_set_ie(buf, WLAN_EID_SECONDARY_CHANNEL_OFFSET,  1, &secondary_ch_offset, buf_len);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 09d27a0b6476..2545d7ca82d9 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1100,7 +1100,6 @@ enum secondary_ch_offset {
 	SCB = 3,  /* secondary channel below */
 };
 u8 secondary_ch_offset_to_hal_ch_offset(u8 ch_offset);
-u8 hal_ch_offset_to_secondary_ch_offset(u8 ch_offset);
 u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
 			 u8 new_ch, u8 ch_switch_cnt);
 u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
-- 
2.33.0

