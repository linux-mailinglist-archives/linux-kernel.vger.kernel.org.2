Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBF415115
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhIVUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhIVUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68114C0617B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so10520620wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBFbr5PFWkp2zLyHuCpLtPmPZAWt0KLE/rWvpz0fVXI=;
        b=FnA/zt16amU76xOoG2QWucTBIE9RuXjm7FCmOPZHJt2AjvnLJn2GSV1kd7tbhxBIN9
         /au2SQyprP9mKzF7BDoWFaZdj5+1uLBWg0DMsMhHpNBHAr3klz1ewkbjLzGyz5SKg3K9
         mlEHXfGcxh+ziU14zSJxsWbjWXnxv4gIXvq3POxEiYVOQaHOBWCsEuN0XKjZn5lqzIaL
         +OmoXCHz4SvZU07/A45x5bkdWOypjExUtS6YUeVhwj5yepc6B0vpe3cCAV/boPkTpMl8
         548M43C5gVATeMlemWVsuV4XFOE11KDF4oSAe5Yx7HkDzxnhAahI66CVwSkW/+zwyYbb
         w7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBFbr5PFWkp2zLyHuCpLtPmPZAWt0KLE/rWvpz0fVXI=;
        b=6jb902e8rbEcycp6+dQCO93yiPrSOHyEsMeS6je8NSjZUEcGBYlN/qIce3EaXhPAys
         Lzc700WVL/6JHRKWaBXXxsys1IqOnMJtyHeRWU5thZpxF3IIVebsbRJeHLLNPpuZ5Js5
         I+3UWPhbg1wmITBG2hLEnmt16qOMBn43LqgrHIihvVlvM10LYc5Ghw7ualiKV4pObmp/
         Z515ujvkHEZW/APIZb83DVLwL2HBpkNuQoDJeok0By3eYipOso6fFVwhMgQvj9CSSCnZ
         5EXQtiqBpk1RRargCKqxKcy0iafTZIsaNAnxmShLmlTGrKMISwFiejJwsKtlFWo9QY6P
         mUgw==
X-Gm-Message-State: AOAM532d96gfQMvAKbon5+2f8blezxn6vqlJ6dyucYUI51ThmDRU19bM
        W5BelAz9w0KGrkgpKoJijPg=
X-Google-Smtp-Source: ABdhPJwHsIyEN18Fu0WjbM/YuU4HrXEuUltQ/p4XCT5aj3pAFPk4CzyDxWFGM7feF2ECbo7bvexNQg==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr839804wra.373.1632341155096;
        Wed, 22 Sep 2021 13:05:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 33/47] staging: r8188eu: remove secondary_ch_offset_to_hal_ch_offset()
Date:   Wed, 22 Sep 2021 22:04:06 +0200
Message-Id: <20210922200420.9693-34-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function secondary_ch_offset_to_hal_ch_offset() is not used, remove
it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 12 ------------
 drivers/staging/r8188eu/include/ieee80211.h  |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 9379beeccede..3f0c1a78ccb1 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -151,18 +151,6 @@ inline u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
 	return rtw_set_ie(buf, WLAN_EID_CHANNEL_SWITCH,  3, ie_data, buf_len);
 }
 
-inline u8 secondary_ch_offset_to_hal_ch_offset(u8 ch_offset)
-{
-	if (ch_offset == SCN)
-		return HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-	else if (ch_offset == SCA)
-		return HAL_PRIME_CHNL_OFFSET_UPPER;
-	else if (ch_offset == SCB)
-		return HAL_PRIME_CHNL_OFFSET_LOWER;
-
-	return HAL_PRIME_CHNL_OFFSET_DONT_CARE;
-}
-
 inline u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len, u8 secondary_ch_offset)
 {
 	return rtw_set_ie(buf, WLAN_EID_SECONDARY_CHANNEL_OFFSET,  1, &secondary_ch_offset, buf_len);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 2545d7ca82d9..8df83481bf47 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1099,7 +1099,6 @@ enum secondary_ch_offset {
 	SCA = 1, /* secondary channel above */
 	SCB = 3,  /* secondary channel below */
 };
-u8 secondary_ch_offset_to_hal_ch_offset(u8 ch_offset);
 u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
 			 u8 new_ch, u8 ch_switch_cnt);
 u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
-- 
2.33.0

