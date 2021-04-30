Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28936FCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhD3OrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhD3OqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2ECC06135E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f24so7083081ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=PRbb+ZxzQIXKhEW0PCoQ2yZIPvBDyc+nlsBX/I2sCBIvDhvdTEyy3JgLVztQkHdNbU
         yDgYtSGdZr/2tqYSiBB91XC6C5VNEHoN0vch05eRRivlB0DX6uXb/poDawK7f5duzCG8
         Tuptf7IND8FOLOnfRgWQn0/iQ5N3muKluZl7nvdBQyUwM8/u7E3+nCgkOf5Hju/ZaOGj
         euYiFdr0RJfsmKu2RbEDHq2FzgHwaiW47Pl5DZ6ZqDM1Zdyo0bwoBn3c2DihFO3E32q+
         rxJF8Ur4zRQDcGanoVL5AX6jLDfYOqmluLvpxH1Fvcu9vIUAjKs9pDofOiiA4We+cA0z
         aq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=f3g1+XxSztoNLoRdYiNC5Uaz7f48KGuV8m775eIpAN9ULCkX7G9eUTqeEIYvG9tqPP
         zbBX7O5seUDKA4ETL+FMkvlsouYcDCx/9Jun5ZpIwTOM80Di1Giz6VIzuKYFngKfSpGo
         X/YHcIHm2ak/umhh5p0w70tedoESype4Qx0ncJZxmSH7hfMj5oeDHGO5vWlp74jkGkIS
         FaVSGCLQBiza31tYTk2Ar0SSZlYdTTnmrSFcZoH1VI9FhNZRxh/pWwQq+W6h9IscKKz1
         c7gL+DFC2MrVLlOwwj2D2whtIPN2QRq55rGddNIOWbvAQ08BLWofy6Krecm0JUNegi1+
         nuhg==
X-Gm-Message-State: AOAM532OPkNQlCb09Xtr88jZr48gtUkm22yCkOkXbMqdmWZZT6xvmKM/
        +CibPdu8FHbOBbuOfmYpddQTj2NLuo8=
X-Google-Smtp-Source: ABdhPJw2RYTakUOpINOYkRFDPymlL2BL3toq6Osvp7StV5MUY/5rcYQyc42YwEw26xTUOXA8MzTENw==
X-Received: by 2002:a17:906:6854:: with SMTP id a20mr4593580ejs.329.1619793903806;
        Fri, 30 Apr 2021 07:45:03 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id o22sm1434118edq.60.2021.04.30.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/43] staging: rtl8723bs: remove unused enum
Date:   Fri, 30 Apr 2021 16:44:03 +0200
Message-Id: <6893322de95a5864161b349c6ea1836c78289465.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused enum.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index c5444f965699..c4616a69425d 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -78,12 +78,6 @@ enum {
 	BTC_CHIP_MAX
 };
 
-enum {
-	BTC_MSG_INTERFACE	= 0x0,
-	BTC_MSG_ALGORITHM	= 0x1,
-	BTC_MSG_MAX
-};
-
 /*  following is for BTC_MSG_INTERFACE */
 #define INTF_INIT	BIT0
 #define INTF_NOTIFY	BIT2
-- 
2.20.1

