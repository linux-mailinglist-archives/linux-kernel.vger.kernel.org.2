Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1817400578
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350947AbhICTGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350626AbhICTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:06:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C3C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:05:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x6so60273wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGbmNNalbr+0cEXhwNEc9zJ5EBVfAOBKHrUSQH81oqg=;
        b=NUqcmH7tkkJUcvokrQL2+dtXXqpMI92FMGo8W6Uti26j3dqLpFvMF52rvsD1ceRCvr
         Z22wrC3blIdzhlyWt2mmY8S9+fxx32XZ4TMYTsRLLbMoNn8VeLqmk7SNP1r4r69mVdrG
         6yt7+svdGbdpSxIVA50SDHfYPyX9qp7ppAtz9TcQRE9X+alWgfmbHcViku1Zm/2Bnmxc
         9VJXvsdM6S28ipgTKgrqLyMCZ0VxzLaWXLJqN6uzVp153hztmIbxBgDKMG78BpU9ROI/
         Ssj+Ypt3Lbj6AMwrbqEEBkiLAir6pyXzOALldyOxOjeI0eMlaE/YS6xr3GBEXwwA4w+3
         Rmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGbmNNalbr+0cEXhwNEc9zJ5EBVfAOBKHrUSQH81oqg=;
        b=h6dgMtp1hTdEvmoUULp484ulNn4BsS67knS0uhR23XJI3MuqYn/vOuKskVLV9eOP9f
         74R6BmRzIpL33Hnf08oM3KRzlpFc3VnQNVj2E42ew7LOAK7FyzqmwyFD7zU5+J1mJZZA
         UI1hvjYdqj7Z8AvdpWMFy1ET3vLCRiMEIWbYZAHv9j8d/A+UQHNVKh2FM0HR5Snm7S+8
         eXYh2CosFDU4U3ffTffdTnFQc9GhH22M6Iv8PGBLXHU2hJasB9Pj3QM68kFfZdQmAhlG
         hVlk4MWmsnaxzWNwGJksPIzGHyanZyIbEojj4+lXiaj7gQoRuXCdayxyHmyiG9UO6kN0
         CtWA==
X-Gm-Message-State: AOAM533PzHBJARZ5SKq1rIer9fNaEO1R5ywFWJKTqJRTKl4AspziI8A8
        dZurgW78eGUMFkRX6tSAlflAypF5dDcLUA==
X-Google-Smtp-Source: ABdhPJyj+8Z2u14LC/Ahj2kqd8exxSEdWXcsYuNl3hdDOw8lrWoFAEfwz5ejaVEfY7MYyP2kpNErNw==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr580456wrq.174.1630695900944;
        Fri, 03 Sep 2021 12:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::848c])
        by smtp.gmail.com with ESMTPSA id u25sm229291wmj.10.2021.09.03.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:05:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove unused constant CRC32_POLY
Date:   Fri,  3 Sep 2021 21:04:42 +0200
Message-Id: <20210903190444.15585-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903190444.15585-1-straube.linux@gmail.com>
References: <20210903190444.15585-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused constant CRC32_POLY.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 48f77c6cf43c..d0586af1abad 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -10,8 +10,6 @@
 
 /* WEP related ===== */
 
-#define CRC32_POLY 0x04c11db7
-
 struct arc4context {
 	u32 x;
 	u32 y;
-- 
2.33.0

