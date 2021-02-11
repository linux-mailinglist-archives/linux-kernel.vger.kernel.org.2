Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA5318539
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBKG0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKG0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:26:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 22:25:50 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m22so6573792lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 22:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a172++GKBLp4j2cPZ3xSzTWnzK4BLacsMzqqmF8v+TE=;
        b=WBpA8brY2RCW6NuIzbHlbWFdDzpUcH0uxC8tByIVFAxMDnfaB1GmcSu96JbG2cG++4
         Qmm+TEp1d5x5i3XD9b4mPmqa47rUy4qh4nZFQ81VkUZHe2iv4FZ6Sn7vks+65Ud0Wrel
         hBKhv+cf6FwOFup48Xi4ztNVwIhr21FD/0f9SJ/gVubrqPz+5P6WUagdgvT8yTzbW9hB
         Nr6rVR06R41X3fYBsRjrdVZccp2UxmfrtNaZRJekVWAxPm/dukdS/wTWvag7hIgLazcI
         MpjverAgYDmrJI7uMJaa4oOLXsdOUT2Gk/4ONACyt+GViqLlfPI4puvC9+Rfg+13H3Ow
         vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a172++GKBLp4j2cPZ3xSzTWnzK4BLacsMzqqmF8v+TE=;
        b=TVAfegsu2SRJdEImoDwRhLH/9r2zHQs6cFDW+xV5K54CG4C8UsjeZ29yxeI4ILI7f0
         Qv6eUBRI+GBL629FfqrGSS9wB8GgO7O6/iFP0z9vN0gNDImeM2NuRazWIhZm1eQryPQY
         cnpRCQYulQl55k1wJgCuVizLHbxRl4Azyjv+zDtmpFyfO/kZsnVZ41MRFCgQ27tkEUII
         9DGiKT8lfu9sUSb4bWayAXrSK6D9ZzY7cOmUVST9lXpNifdbI6i+o+8aC35YFnndpQrg
         AZrjcQXK6kZbL3nFQto5fJQ0H0V0+aclLNPqxm8BvuDHWz5h2We0LcgK6rjiaoSZ/Qet
         4h+A==
X-Gm-Message-State: AOAM531e1iLyHRM99RxqEi1xaggiXhy9N6aF7NYFtZaN2tGAMsclD+8d
        r4iUcPsR/n4hQXSBaFKSd2E=
X-Google-Smtp-Source: ABdhPJzQ8QWb+QBHz9JARn4nvO4Z+FjrNcSK/SiqjhEGuwa9KBxwoLNr7RNApN81B+t3NDXVlB45gg==
X-Received: by 2002:a19:9154:: with SMTP id y20mr3460756lfj.2.1613024748279;
        Wed, 10 Feb 2021 22:25:48 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([213.143.229.14])
        by smtp.gmail.com with ESMTPSA id l24sm794420lje.50.2021.02.10.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:25:47 -0800 (PST)
From:   Fatih YILDIRIM <yildirim.fatih@gmail.com>
To:     gregkh@linuxfoundation.org, gustavo@embeddedor.com
Cc:     Fatih YILDIRIM <yildirim.fatih@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Macros with complex values should be enclosed in parentheses.
Date:   Thu, 11 Feb 2021 09:25:43 +0300
Message-Id: <20210211062543.9817-1-yildirim.fatih@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Fatih YILDIRIM <yildirim.fatih@gmail.com>
---
Hi,
I have a coding style fix.
By the way, I'm following the Eudyptula Challenge Linux kernel tasks
and this is my first patch related to my task no 10.
I hope I'm doing it the right way.
Thanks for your understanding and kind comments.

 drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 39138191a556..c62a494ed6bb 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
 #define TX_RATE_FIXED		5
 
 /* 11b rate */
-#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
-#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
+#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
+#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */
 
 /* 11g rate */
-#define TX_RATE_6M	(u8)(60 / 5)	/* 11g basic rate */
-#define TX_RATE_12M	(u8)(120 / 5)	/* 11g basic rate */
-#define TX_RATE_24M	(u8)(240 / 5)	/* 11g basic rate */
-#define TX_RATE_9M	(u8)(90 / 5)
-#define TX_RATE_18M	(u8)(180 / 5)
-#define TX_RATE_36M	(u8)(360 / 5)
-#define TX_RATE_48M	(u8)(480 / 5)
-#define TX_RATE_54M	(u8)(540 / 5)
+#define TX_RATE_6M	((u8)(60 / 5))	/* 11g basic rate */
+#define TX_RATE_12M	((u8)(120 / 5))	/* 11g basic rate */
+#define TX_RATE_24M	((u8)(240 / 5))	/* 11g basic rate */
+#define TX_RATE_9M	((u8)(90 / 5))
+#define TX_RATE_18M	((u8)(180 / 5))
+#define TX_RATE_36M	((u8)(360 / 5))
+#define TX_RATE_48M	((u8)(480 / 5))
+#define TX_RATE_54M	((u8)(540 / 5))
 
 static inline bool is_11b_rate(u8 rate)
 {
-- 
2.20.1

