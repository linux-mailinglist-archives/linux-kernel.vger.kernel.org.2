Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB231CCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBPPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:11:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:11:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z9so6098489pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rj1Cme7HGhwAEo9lvgu9bg14f3OadyDnyVkycWOifno=;
        b=mV2Yoj1q/aBPPmAXjdpBHT9kzJqfMyVk4uSi/vKScj5EbMB62jaKkxU7xGYVk4AWne
         /6gWYBf0SEVwoiHulqZlLVybF7bFGx8oJenaSGHqtwilXtM2s4Dhk7k5rIM+9UCMqnq7
         lsLgQZc998d1pGqhqifMbR++ueqQWAKyPkSCGbElt+iA1bn2iTSVP/z6rnp8GFf2qXpz
         Co7WWkg/5vAKuntQhSk/8OwNkoifB0+yGNoSS9cwZ8FWtnJbp5DSXS29J5ogZawrFNK/
         /G8y9YgubKm/VekzmrZjIJ9xo2bZhrm1ZSrUu+Xi0R7O5ZAZs1R4W1sqW9VjcYNZ9G0X
         d5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rj1Cme7HGhwAEo9lvgu9bg14f3OadyDnyVkycWOifno=;
        b=mre2WJgJRiZQ0UK7eUh9RoPvA6VhvGdcfKqjFgED1DF/Mz7oeCuQ6WDOiOgJti8xjf
         MYVytkdl7v5lRnVzjmtYbNuLvkS80TUpnoKXzYTaq7mr1oClMty9xIP6vSzhLZl3Lkbt
         ++s9l3yGTZJq27zx/2egh5oUY1nk2n6oqztAXoE81nPag7MKD6g8TTa80q6WJVDSSplJ
         Ntl3SPWgE3qNiFsJIMACNAIGs7uIzfqRSuFQ3ZAXSqjXb8LZ48DCXg6sux93hA+kZT9/
         WrBZM/ewI94rBVphUoonFbm8DoId8iOsavCDeZeSuXRUrv/R7IMhSFMi+S/f1S+neM7K
         ttow==
X-Gm-Message-State: AOAM533HEXx1dKHVC9VdzwaLaXfVLWv8C/3/UveRCS1OpXByHDfGYYMt
        cNtPNROP4qVx24OwGUbm/jk=
X-Google-Smtp-Source: ABdhPJxuWc/dpqa1OAEiNmyGatAMdO4U/Uxs7qdpaKsyYXIRElmC8hGK9OUMn9YftgxO7ipoxySvaw==
X-Received: by 2002:a17:90a:4ce2:: with SMTP id k89mr4753423pjh.16.1613488263127;
        Tue, 16 Feb 2021 07:11:03 -0800 (PST)
Received: from localhost.localdomain ([115.99.81.22])
        by smtp.gmail.com with ESMTPSA id s18sm20839912pfm.129.2021.02.16.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:11:02 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, gustavo@embeddedor.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: ks7010: ks_hostif: fixed parentheses coding style issue
Date:   Tue, 16 Feb 2021 20:40:58 +0530
Message-Id: <20210216151058.12638-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
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
2.17.1

