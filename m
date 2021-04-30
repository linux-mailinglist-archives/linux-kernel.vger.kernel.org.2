Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9227A36FD1B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhD3O7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhD3O65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B8C061355
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f24so7145498ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=nKeBhsTC/8rjGBpua0mTmIOPgSdF7/aB8EqOb2PFCUFMRIB1troydDdf1jYXXhfYKA
         4pqT8IW9I7kxoGJB4qHsN78lubfr05xIaz/jkWaotu4qCVgs4TcE5bUdPLR1nqJlX8hY
         N/KkYsncX69e9vhen3jecNx9m9sTPpwTl+Fyy7e7DBlfWsilQr134oFcmdURIzQg9JYq
         wgf9DgLBNOWHocjmZioP8nEZS011mxTXmrayYr0gkmF2cbr52VH26LioMbcN7XNXxTpE
         tn3LWQOmaDZ9VcOo0uG1Q/2IaVUQSHOW09kpOVLukIKMj0EdtsCCGZDm7ZZWsicOO5Qf
         v40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=Tge3e8RzespnWlv30uASqXeYeUC/Q+tshwuItfycMm2Y7jOxR9Uvpra6hJnFMRWFzd
         5KLK8vELGjWVDTtDT0t/sW6Ke+ckK3hyQfaOfpuLDeB/Ys05VeZUAo5P3ayRZYo9jh5R
         tsVwxbs+TufAUgZ6xCTsNa1Y4VnpXnPtPs7jZ7bFgxZWVDrZvn4EMysZS4/KehCaRfOC
         Kbnovl9uvRQBekr0DxMO9ws8pAeZxU51Zqw8DzEX/xkBILMLW40nnrAhABNkx79cuK1x
         oA18ysJs6eDDZhb5rd54bqm8gIVqJvRl8DktvRNHycpSqZTahT72oHLSkJwzObMKcv/Z
         7NuA==
X-Gm-Message-State: AOAM5310z1Lb2uT0BdPH+3gAyUGnoMFLyUdsH/uwdBIWO5lpmXq7ha9A
        rSlwM/I9i+HNLXhclhnPsni7HWchfoA=
X-Google-Smtp-Source: ABdhPJzhe2S0b7ukQqof4118OOSqK5krVjl2deH+lVNCH9hNQ7d4C/JICbudXA5gyvNPrW+ZzbaBBA==
X-Received: by 2002:a17:907:2623:: with SMTP id aq3mr4719540ejc.262.1619794681187;
        Fri, 30 Apr 2021 07:58:01 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id u1sm1425763edv.90.2021.04.30.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 33/43] staging: rtl8723bs: remove unused enum
Date:   Fri, 30 Apr 2021 16:56:55 +0200
Message-Id: <029a9639ef046e44defc59854d6bb9a86dd3db4f.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

