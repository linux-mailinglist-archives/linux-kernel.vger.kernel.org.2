Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF19A326344
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBZN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhBZN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:28:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF87C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:27:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so10918260edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLLlvYr9QKdqQQnfxyPXzWw7zEpLbduYElS6GfnImdY=;
        b=h87/cS62zMT74w+TwzbzqbBJdPMHLTmCzH5RkccgxHZj0m/HbMD3PubLD3SmYRU6+A
         PS5w50QrqEmi02btDIVk0HZWrlU7T//7HDZa7I90yhmx9a6UwOH1blKu+PEopuCQl0wm
         BPQGCTnYPM1KM1MlQ4WnLYKgm85o+Kcmh87bYjq729fp6Y2U2N5fDArgfwSWX4LIjZUt
         1dwQrhNNgha4VXk0QDG7k52j56jZtaqmkiiVUYGsSxj9DsGqTDNUXynsogvBF1p1qEQQ
         8EACM+FfNSaT3nmcbTkIolVvUj+p/MQb0zgAeACzElAYtLJJcKVsf6xccHZq3mZwsy/H
         yGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLLlvYr9QKdqQQnfxyPXzWw7zEpLbduYElS6GfnImdY=;
        b=L/M2XMkBb8cQl6r6Q26mH7LU9Muta4voVX37bYE+lmSSfNMX8P0umxWjO1oTZkszoC
         HSewCjYLH0t/bE/b0fd7JLLQiGzaVrbYziKPC1euXLFA0fyWKd2CKOKBtmJxB7PEF7vZ
         AW1IIaZsIhlUpNywXKKgRmHYfpTps80c/UERcQ80CzGTBXS2nKeB3BgvyPw0kyPrDqTG
         hvkVopfEzYzYi19UY6s261vZ3yq0PidUy9kb3uM8d+IWBm0otFQG0h0szyHwJWnhF5+D
         mjPflR97p3H68SBRgRhsigm4vGjVXoNuTXq0v2C1ZNKa8qHmkS6EFvqknOpAIlHXdDv6
         QMyQ==
X-Gm-Message-State: AOAM53197ziDaHXn5vlHzyB37EsGwDJyD5xu44ldSCh9QTmWWg+zrm85
        uPyb2XL6bo7hwe4cYs2Kcd0=
X-Google-Smtp-Source: ABdhPJw1JgBpVRK3GI27KYxAYcGDeV2InBiC/JLEkTODZ/zbRWCARoOnYGjRYk82Puvu7CMjo1n+8g==
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr3309235edy.232.1614346051406;
        Fri, 26 Feb 2021 05:27:31 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id f20sm5328024ejx.16.2021.02.26.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:27:30 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Lee Gibson <leegib@gmail.com>
Subject: [PATCH v2] staging: rtl8192e: Fix possible buffer overflow in _rtl92e_wx_set_scan
Date:   Fri, 26 Feb 2021 13:27:25 +0000
Message-Id: <20210226132725.401813-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _rtl92e_wx_set_scan calls memcpy without checking the length.
A user could control that length and trigger a buffer overflow.
Fix by checking the length is within the maximum allowed size.

Changes in v2: 
	Changed to use min_t as per useful suggestions

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 16bcee13f64b..407effde5e71 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -406,9 +406,10 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		struct iw_scan_req *req = (struct iw_scan_req *)b;
 
 		if (req->essid_len) {
-			ieee->current_network.ssid_len = req->essid_len;
-			memcpy(ieee->current_network.ssid, req->essid,
-			       req->essid_len);
+			int len = min_t(int, req->essid_len, IW_ESSID_MAX_SIZE);
+
+			ieee->current_network.ssid_len = len;
+			memcpy(ieee->current_network.ssid, req->essid, len);
 		}
 	}
 
-- 
2.25.1

