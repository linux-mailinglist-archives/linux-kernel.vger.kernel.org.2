Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7347841511B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhIVUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhIVUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC772C0613A0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so10539534wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTurlrLi0oOKyRWPrSzwZotwZ/ud9/BV2O1T0jtrSPE=;
        b=kiWOmAqhlM5E45Sd2rcUni4bGDr5sJkSUFA9cTaJqc4it7Gtz9BshClgi7+sWsfVNv
         cehuC/FA043t9qpm2jtmcDdMAUwUFsmGGlLPN05Gexi4JSWSoykr7rpOIwUoLQegySav
         pZ3u7iXB0XzLhiDpc66mPz+SS743nYyEYshokA7MvxDrutQRE6JqcMOgglop4/4PaldW
         enJLs8UcMA0vnMQaqFUflEc7j5CzxVZqJhMfV3CEQ/OCXP+1uuubOFJZWFvRfff1hn/9
         j2XXHAf8aeX+m7lkOk5ZsymeXXCmgsxUMThvwg0ne/heO6TKJDF65Xq53jIUQuypN8/Z
         Z01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTurlrLi0oOKyRWPrSzwZotwZ/ud9/BV2O1T0jtrSPE=;
        b=2xzUflh1gU1Q1UiHxoX6NIBoO0gsjLEBYZe0VlFc7Ysy3lntIjzjWYKQ80NQprVyT5
         FnlDyFwChE2iKQO0yQ/gR8gt9p1FA5K1YuO5HpnKp+IATTGaDPonURlO/nMVYJO9ITMV
         wBmP182f1J5kjpaiRewDjRm+wjuPKUc3RtXWkdai0wkipvXZH9wUeLV/fTLdbaj2JDDn
         UFA9yIwwvKuPiUvUCpD9QoWcB4G1HZUDMKMiZEE6UXF6ujzHOCyqmJOLpsHvg+fzd1IL
         DNnSdf96Jloa0MfgCZ1nuZFO0KGs6kiT+6EkC0kIvHy6Tq+yDkIf0UCTmYP26l8dmgdc
         HNRg==
X-Gm-Message-State: AOAM530xpcJr4jjdhEHkKgyA8rkcu7s0UqmRFo7E9D+ZrxO+5+IjM2b/
        XPbDrD+6zGfpoVWqOBKa+Qc=
X-Google-Smtp-Source: ABdhPJwvjl6/x3VdFUzcp1xq676pnHZXzYhx+RYQa3Q9JQ7SpXu9ghgGONR3Iu+wPAQ33AGxK4HGNA==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr2667896wmj.124.1632341159522;
        Wed, 22 Sep 2021 13:05:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 39/47] staging: r8188eu: remove rtw_set_ie_mesh_ch_switch_parm()
Date:   Wed, 22 Sep 2021 22:04:12 +0200
Message-Id: <20210922200420.9693-40-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_ie_mesh_ch_switch_parm() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 13 -------------
 drivers/staging/r8188eu/include/ieee80211.h  |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 06445a4192a0..cc053a5d0f01 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -145,19 +145,6 @@ inline u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len, u8 secondary_ch
 	return rtw_set_ie(buf, WLAN_EID_SECONDARY_CHANNEL_OFFSET,  1, &secondary_ch_offset, buf_len);
 }
 
-inline u8 *rtw_set_ie_mesh_ch_switch_parm(u8 *buf, u32 *buf_len, u8 ttl,
-	u8 flags, u16 reason, u16 precedence)
-{
-	u8 ie_data[6];
-
-	ie_data[0] = ttl;
-	ie_data[1] = flags;
-	*(u16 *)(ie_data + 2) = cpu_to_le16(reason);
-	*(u16 *)(ie_data + 4) = cpu_to_le16(precedence);
-
-	return rtw_set_ie(buf, 0x118,  6, ie_data, buf_len);
-}
-
 /*----------------------------------------------------------------------------
 index: the information element id index, limit is the limit for search
 -----------------------------------------------------------------------------*/
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index ba3b414aae71..d97ba27f7f72 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1097,8 +1097,6 @@ enum secondary_ch_offset {
 };
 u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
 				   u8 secondary_ch_offset);
-u8 *rtw_set_ie_mesh_ch_switch_parm(u8 *buf, u32 *buf_len, u8 ttl,
-				   u8 flags, u16 reason, u16 precedence);
 
 u8 *rtw_get_ie(u8 *pbuf, int index, int *len, int limit);
 
-- 
2.33.0

