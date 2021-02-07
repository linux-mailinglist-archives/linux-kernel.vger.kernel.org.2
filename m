Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FC312800
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 23:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGW5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 17:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 17:57:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E24C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 14:57:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z6so15034327wrq.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 14:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6El5WCTppNM0qvL0uiwmEG0rhEopk6FVWHfgdbdVZg=;
        b=MSnejK1IpoKy7pi8SiX9ew6g0MaSPZ05PsczuGT76RvZZtD9b3J6fMr0oB+i7wKPTd
         SzEUFcwwrHMbqWPA4xOvo6Kx3Rjs2++K5XcwAACHkRstFoMFKiCgfO0mCznSeOIz85BS
         jNxOjkVYfJvJalsFyS1o6SvStQ5JRL0iSCayzliNdZp9kX2vty3wlKVJoySCQjfd+uGo
         G4+NL77Uki1Knvcksxvk5ukUAYA8+xOQ87f5qhZP6QDYdHkUaj/JGtejNbvtNGPpjn1A
         61LH8Et6ehduW5I0FbUageFs/xVWW30pITd9bHuyGsOCX4hIOc15N3+6Oi6omM3dSuX7
         1RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6El5WCTppNM0qvL0uiwmEG0rhEopk6FVWHfgdbdVZg=;
        b=dIPuXk3wwNlF3VQVj8o9GWTLFMLf2LurvgSmXOTYFmfiArwSOTHOIroVo6pvFZ2mp6
         3i6EjEEDw5Tyy3So7NA6XTczVuPEOqi/SoGYiMOG9bKdgtGL5DkGbFMOb7d6BbsbKDNL
         VBzaE+ERz9re6sQjnV5QR7lpbqdGO8io8X5/faULyi/9lsI6h+lRhnQplJD14i1xh8Yg
         3kwPB5RbmLkDaUFIklCEwJt3fiKEri4n/avKpNIIRUOoGu91maCqRLIrq7r8p6m+xHgB
         +Rq15JzZlWnH/hWjA3oqel8XqutbKiUaEy7lmQQdAOWdwJ6cw9VMVqV4Zvg9zuJHwbnI
         HMbg==
X-Gm-Message-State: AOAM5339klbnKJYRnkvVgYx5kzc3WK8FXab5r9FXoWMEXSoD9s8GcHHc
        YOya4g42+lxx8NagekzZTqgCqS4ZGEknlhq2
X-Google-Smtp-Source: ABdhPJyBO4nFCEM6p+AEqwVp5rTIdppXsQI9l1SnMf4AEp0H7wCfDusVJhFZ75uXfLDNUb7x6U6NlQ==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr16567930wru.375.1612738627114;
        Sun, 07 Feb 2021 14:57:07 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id x18sm6339906wmi.8.2021.02.07.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 14:57:06 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        romain.perier@gmail.com, apais@linux.microsoft.com
Subject: [PATCH] staging: rtl8192e: remove braces from single-line block
Date:   Sun,  7 Feb 2021 22:57:03 +0000
Message-Id: <20210207225703.114229-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the braces from the if statement that checks the
wps_ie_len and ieee->wps_ie values in rtllib_association_req of
rtllib_softmac.c as this block contains only one statement.
Fixes a checkpatch warning.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2c752ba5a802..2d3be91b113d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1352,9 +1352,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 		rtllib_WMM_Info(ieee, &tag);
 	}
 
-	if (wps_ie_len && ieee->wps_ie) {
+	if (wps_ie_len && ieee->wps_ie)
 		skb_put_data(skb, ieee->wps_ie, wps_ie_len);
-	}
 
 	if (turbo_info_len) {
 		tag = skb_put(skb, turbo_info_len);
-- 
2.29.2

