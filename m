Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00FC415106
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhIVUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhIVUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D8C0613F0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q11so10345672wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzGv9wYKIGtojpQmz9/kkZo6gxYvKQ+KisEz8eUqRLc=;
        b=DUVyhr6wKWjzocD9RJ9zqVyrxB6pSBMIdDWbWLFNTvKJmCdta0JYN9Pq17Q/axOqFn
         nzA3DyN3uVpu0FoOh51vSYQ9akDSVR+etf/qrMyWfzwl1bI3R67c8kStB93JjTxG14b+
         q804LxyDbbIhSB/mOIrEZQzfRV+b3qGedieo8gf41Agil+1hR2UhEmKj9wxmEB9YJI4F
         xLjwSvnOOLeIaVjhE8BEHds4OJKkSmmZitvJ4kKL3xdVH+qUFskOshzf6lsv+TYZQGCg
         BeCGuYGpReFVHL9tTCfKeMniCrtaHdFVrDJBehFN8G3q5NjQh85UnDf6KqP6vnVxAqZ8
         z0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzGv9wYKIGtojpQmz9/kkZo6gxYvKQ+KisEz8eUqRLc=;
        b=nXF00pyXnWKCr4kcvM9ynVm2c0rAtAzh0KMwXa+WSrnGWMciNdNqSThSDwB4bbHNwx
         ZBXMSVDgrdnwaRXjtYfaw6gpUEvy0pNIaLMJn2YsP5rFBxC8OmbBFAEKckj9ywC5+hGA
         a5uScY61VEIdi33ZPWTtU9QlpvOU94yA1vl4ADxPRgiQe9KuTyF7y75LVNtiYeTjUJIY
         QUykBiI0qvtHsXKkF4XJ0fdl6Z3qIveZaVt+MnFT9JEHQfN9+w9+cVSKZThD0huCoE/s
         o3Jx0UrtNBsMpHYRxum0qNwwIRex6seE0zXNdpnZhpYjmzpS6WMZW4rj78pE2+JGXz7X
         9/2A==
X-Gm-Message-State: AOAM530In3v+rOMF0CoytVjGQK9j5cfOpfxOJ9W7PwmgXE4LOkQoUO0r
        b64NEH+z2XOSZ4xr77vUHNq00fsJQ8urTw==
X-Google-Smtp-Source: ABdhPJzKhTnhgwJYoKjtssOTCKpzDCi6Bx44brJtqX/q7u/RbsSj5j/UszDg9S/1mAsRy879pqalng==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr921494wrw.174.1632341146805;
        Wed, 22 Sep 2021 13:05:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 22/47] staging: r8188eu: remove rtw_set_scan_mode()
Date:   Wed, 22 Sep 2021 22:03:55 +0200
Message-Id: <20210922200420.9693-23-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_scan_mode() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 17 -----------------
 drivers/staging/r8188eu/include/rtw_ioctl_set.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 9fb6e07ae963..222c7f696279 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -529,23 +529,6 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	return max_rate;
 }
 
-/*
-* rtw_set_scan_mode -
-* @adapter: pointer to struct adapter structure
-* @scan_mode:
-*
-* Return _SUCCESS or _FAIL
-*/
-int rtw_set_scan_mode(struct adapter *adapter, enum rt_scan_type scan_mode)
-{
-	if (scan_mode != SCAN_ACTIVE && scan_mode != SCAN_PASSIVE)
-		return _FAIL;
-
-	adapter->mlmepriv.scan_mode = scan_mode;
-
-	return _SUCCESS;
-}
-
 /*
 * rtw_set_channel_plan -
 * @adapter: pointer to struct adapter structure
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 2631c85773cd..32885d8e42ff 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -21,7 +21,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
 u8 rtw_set_802_11_ssid(struct adapter *adapt, struct ndis_802_11_ssid *ssid);
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
-int rtw_set_scan_mode(struct adapter *adapter, enum rt_scan_type scan_mode);
 int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan);
 int rtw_change_ifname(struct adapter *padapter, const char *ifname);
 
-- 
2.33.0

