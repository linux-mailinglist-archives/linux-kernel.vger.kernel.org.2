Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6241511C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhIVUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhIVUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u15so10388402wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJNghPoHOove76hh2URD2RvudIykHuzA7svrBXn3LBk=;
        b=gHaMg5ELpj+rzpcl9d5o2rYtxDBtOQbdTo0rVNB/l0gIrUPKS4WVrTPU9lmIJ+bPqo
         KOX8EZNH88e0pPjBI/oT8BGujMklXI6ePbQx1Oq3URQmEUHRD+8YgZUA5Lob2onVyLJ+
         Z2lydoxF9qdeKlZzFxQvDxhNWZCSIjlCN1438EE/Ump93eZAMXp6iWYCq/AthYb5G07a
         eRuBf+cpBmoGDBR1PRx0fx0jeipvO5j9P0yQ4ubZ88Bx19CXzJ79ZIHtvrbuyDgVjyVV
         Q1mqN4fDg69bTCQ2lR9TLswg1Q3bZa0FXeMWmvigV6wbgyTUSqsf43F74PKQ7PDa5R9P
         AXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJNghPoHOove76hh2URD2RvudIykHuzA7svrBXn3LBk=;
        b=sWoMKFcXL9vo2JVQFH4CsBYCTzgEkQjKINiD26PWHc6J6Nh7OcsLnwPTA01pKd/t+A
         NLqfqTYLZhJlZrAI2iBpqM/7eDOrvHt6ItnqDHW7eAL4tqsWJHYL275CVy8EPcxZuGYr
         pqgSd3TN00CE3NS6pjIa7aBkdUvvOlab6HuOsmGfv5kC8UapDBkZtv/7LlGBY0XUnn+6
         oCSwMDS6Y0ZC+C/QWjSw2V1UCNnnr9RwgVaKuMZwqnFJmTdH43wyBKxAmap6jiMwTV7Y
         rCoplQl+pgGlYBPbedtk3DsZp23rDSQ8qWJkSdGBkxN/taTw2uQ2YqjlVxeYi2NhPHUS
         ye9Q==
X-Gm-Message-State: AOAM532b+D4jU+6xRj+O18arNeRKKihepRFb4J+bgisF+UOR0WP1rgrw
        +1SHkxG5TSNFOxIPjM0+d78=
X-Google-Smtp-Source: ABdhPJyBUQqzBSFb8Q+ZDVWiVqxYUllG4c1NBKx9efKz4/k/UEvOcffpk4u9YVeWF1QOOzjIRL2a0g==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr12427193wma.150.1632341160231;
        Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 40/47] staging: r8188eu: remove rtw_set_ie_secondary_ch_offset()
Date:   Wed, 22 Sep 2021 22:04:13 +0200
Message-Id: <20210922200420.9693-41-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_ie_secondary_ch_offset() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 5 -----
 drivers/staging/r8188eu/include/ieee80211.h  | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index cc053a5d0f01..343c2f9a4ce8 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -140,11 +140,6 @@ u8 *rtw_set_ie
 	return pbuf + len + 2;
 }
 
-inline u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len, u8 secondary_ch_offset)
-{
-	return rtw_set_ie(buf, WLAN_EID_SECONDARY_CHANNEL_OFFSET,  1, &secondary_ch_offset, buf_len);
-}
-
 /*----------------------------------------------------------------------------
 index: the information element id index, limit is the limit for search
 -----------------------------------------------------------------------------*/
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index d97ba27f7f72..f0d5a640143f 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1095,8 +1095,6 @@ enum secondary_ch_offset {
 	SCA = 1, /* secondary channel above */
 	SCB = 3,  /* secondary channel below */
 };
-u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
-				   u8 secondary_ch_offset);
 
 u8 *rtw_get_ie(u8 *pbuf, int index, int *len, int limit);
 
-- 
2.33.0

