Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4262A460B90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbhK2A0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbhK2AYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:13 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE35C06175A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 132so20972701qkj.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCgXLgppxFx/+yBAvu+NIds6u6sh50A8uraUotdl8hw=;
        b=dm/PmPeohFP+EK9dFQ+1/yxwAuq8o/L5f+U/BrlHrevero4Zud15jVH/1GURrBPysW
         y6bwnByusfQ9D6P3UqmSi2kzb87TiW8eUX+7qIEPL3uedzGl0C4dvD0G27BoIzODdS39
         59Gkq7+VtHVpiR6YdV+Dsw4KHl9KUCin65MbpvkYIurgVY7rDEQDtgzOIGVVzzmUo810
         EptBCqdiUgkkf5L0OmbzpcLxDSm7EeRxJIh80XXX1JtkKe1qudVu4LCuvWQyuOiIVeDo
         Z67I/zRvBcqZ/MnzYxdOHtXpcsTKmzD/Dy/smddCIem6P6EQo5Ct5eA2/oelXrJw8Mr0
         VWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCgXLgppxFx/+yBAvu+NIds6u6sh50A8uraUotdl8hw=;
        b=X/wzm269DAAmPmN7SXAQWusWhJ4zYkyu73Jw/DxKG4NYFfCe2StlhehMl0IuEORfcK
         5LifByy+AshXSVNf16r6nUy5Oxz8wcTCVtVlyvb83914EelPe8kUxKWD02QFonQv5fEy
         go+T7DF/4Rj+7qTpOkrYHtFZ6IRqOtPhl4zA8gNgn6ozirteQPSf9oUiiwYAwVM+jbhh
         6VkrjiAGZeRL3ErQG2pTmgWjXRihLeAjVRvZqEnFCQS1UMqQEzrU7HL+VRcRQxXZVJpU
         jWPKJXkASOHWhmlFBabGFVPY5yMWbJtQ1JpV1EEdMlthwYlld1Y5Xw/c9Tr5yOOI6Dmb
         naxw==
X-Gm-Message-State: AOAM5320U0rxztT6V5Dj8xYjBcb4u2oBPdiyWGt9HvaZ8GSCeIRSwXxy
        nxcPoG4JPriaMZN7AfoeNOf0pQ==
X-Google-Smtp-Source: ABdhPJzopBkJkxAnz5/2xSMBFyHFNb1CfIOvA81OkPa0b+x7z11KHtZH//Un1OnnFA4bF4Q/EEatkQ==
X-Received: by 2002:a05:620a:ec2:: with SMTP id x2mr33234378qkm.400.1638145255992;
        Sun, 28 Nov 2021 16:20:55 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:55 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: r8188eu: remove DBG_88E_LEVEL macro from include/rtw_debug.h
Date:   Mon, 29 Nov 2021 00:20:41 +0000
Message-Id: <20211129002041.865-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129002041.865-1-phil@philpotter.co.uk>
References: <20211129002041.865-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the DBG_88E_LEVEL macro definition from include/rtw_debug.h, as
it has no callers and is surplus to requirements. This is motivated by
ongoing efforts to remove all non-standard debugging code from the
driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 39b69b9ad0a3..311051757715 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -54,12 +54,6 @@
 
 extern u32 GlobalDebugLevel;
 
-#define DBG_88E_LEVEL(_level, fmt, arg...)				\
-	do {								\
-		if (_level <= GlobalDebugLevel)				\
-			pr_info(DRIVER_PREFIX"INFO " fmt, ##arg);	\
-	} while (0)
-
 #define DBG_88E(...)							\
 	do {								\
 		if (_drv_err_ <= GlobalDebugLevel)			\
-- 
2.33.1

