Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03D9415105
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhIVUHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhIVUH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so10368182wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ePovir0ucxA/F6nfbID9RzsPHAhXB11uOBJZw9eZv8=;
        b=L7Jv2c+SIe46UQwet1Vh5BRrRzmgNJBhGVYt3M3zRLRsJm+z+x8BUy5X8KqK28gdiE
         fEZqUZoQQeTKCe2v1HL12EmFqMVvSZHHfJMXnp+QNHMKkYmklSwHJ/ZbkT+DOpnD2E7J
         ohpVDFVkpG9KcLDimGuG+KHSu6rOvSvoOu/JKg21L75Z8faA1lBKllUTzU3uXhGG3PGF
         XSMAm6p1fJOxlN3bANPTBsmoW+y+PrcZbzBbdDoS+iINZcUGNvH84T/XNFZJ8p4wi9aJ
         6d+q0SVD/b0bi3E3Ipq0HdSENGqb/i78miBCJDkaN8KOqECSeL9y9O9vpWr9Pto3ByYu
         +G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ePovir0ucxA/F6nfbID9RzsPHAhXB11uOBJZw9eZv8=;
        b=6uZ6CY4xxZ+WxLAbIWnOrK9EeNSV4N6ngjxqaYMI/Ozp70L3QADQEDnASgP3rceTJm
         6Manyrd7H4DhznoKU4S6bz402EKwnYy/xAV1uMAuvRck6XoCe33r27uG8BvhDdYeyvmr
         tpovvW43rrKCxzSfK1DeVNLdU5C4l24AcEVT9hZCb9ozcuUoOTCqmpTP6zYe+xtWKSwK
         p0Ay8jdC0NtbwlFzBDaAV6IQ4fbkyrzIUT/ddfuCT9usslLCnvz1E18TYY3n+CkxLEFr
         /ME8Bt9Cd0r8nj5aoU4zmZaIAm86rEMlWI/gZrWkkcMpAdfTD6F+fPu5AaFQgYg5GPc+
         N1ag==
X-Gm-Message-State: AOAM533bD2KwuygbbYPHZmLkeK73QzGvHcFaoGHZMIw/zjX0xwu2bTYv
        EZV14Tbae5z1Z7bqwPAkTGU=
X-Google-Smtp-Source: ABdhPJw/JmJuVeLDuUVwb6ooy/ZEo8qOdzpFza2Dbbun/Lp7aLdeHk2kkgtQNLwo8zPJobYvSD1GCQ==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr957634wru.178.1632341145830;
        Wed, 22 Sep 2021 13:05:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 21/47] staging: r8188eu: remove rtw_set_country()
Date:   Wed, 22 Sep 2021 22:03:54 +0200
Message-Id: <20210922200420.9693-22-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_country() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 29 -------------------
 .../staging/r8188eu/include/rtw_ioctl_set.h   |  1 -
 2 files changed, 30 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 9b083829fffa..9fb6e07ae963 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -558,32 +558,3 @@ int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan)
 	/* handle by cmd_thread to sync with scan operation */
 	return rtw_set_chplan_cmd(adapter, channel_plan, 1);
 }
-
-/*
-* rtw_set_country -
-* @adapter: pointer to struct adapter structure
-* @country_code: string of country code
-*
-* Return _SUCCESS or _FAIL
-*/
-int rtw_set_country(struct adapter *adapter, const char *country_code)
-{
-	int channel_plan = RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G;
-
-	DBG_88E("%s country_code:%s\n", __func__, country_code);
-
-	/* TODO: should have a table to match country code and RT_CHANNEL_DOMAIN */
-	/* TODO: should consider 2-character and 3-character country code */
-	if (0 == strcmp(country_code, "US"))
-		channel_plan = RT_CHANNEL_DOMAIN_FCC;
-	else if (0 == strcmp(country_code, "EU"))
-		channel_plan = RT_CHANNEL_DOMAIN_ETSI;
-	else if (0 == strcmp(country_code, "JP"))
-		channel_plan = RT_CHANNEL_DOMAIN_MKK;
-	else if (0 == strcmp(country_code, "CN"))
-		channel_plan = RT_CHANNEL_DOMAIN_CHINA;
-	else
-		DBG_88E("%s unknown country_code:%s\n", __func__, country_code);
-
-	return rtw_set_channel_plan(adapter, channel_plan);
-}
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 5114d217a3d9..2631c85773cd 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -23,7 +23,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
 int rtw_set_scan_mode(struct adapter *adapter, enum rt_scan_type scan_mode);
 int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan);
-int rtw_set_country(struct adapter *adapter, const char *country_code);
 int rtw_change_ifname(struct adapter *padapter, const char *ifname);
 
 #endif
-- 
2.33.0

