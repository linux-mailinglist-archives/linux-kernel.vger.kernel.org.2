Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F135595B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhDFQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhDFQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:40:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:40:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so23000405ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYC5pS0xZoRYRV3BpSxKjUXSyW8aTbxm6/R1LCQeLzw=;
        b=qV50w6B8dKqAjAmUayknbkDnjoTNg3BVKtkUfavuH2Ko5BoDXs6W0KfMdPVqXa4t40
         CFDr4rS4U6HJBrhrhHCWn6mDvzzMXyNckepu1qbjeaHYsUkzgXRxVj0jwXGiM56tZfbg
         F8JFEvZa+GaJBynVMqfAT743ycIV11ef+8zDPhBPQR3OSkI1t4A0TseXbpkcR6NVTmVB
         7RSydu7KZnvqQg0j4kiqfeizcy4KPervJAYw4gKmXA8/j7RXHN6tCcVZQrw9Jx5vjWWR
         6ufSUQMJeCqrFIrAcQAmPv4FpkDArjAVCNCBsqq6vPXACC85QxngpL/MdNWvQ1vFDWbT
         k24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYC5pS0xZoRYRV3BpSxKjUXSyW8aTbxm6/R1LCQeLzw=;
        b=UOFmhAv9YuyW7VN6VGu6tXQxpJTcY3r1cV6Woc19k/8PxWioT56chW24OLWrKntFaD
         RUcr3lM1Ve9ZWDiqDfXQYSILc/PTAEn5Zu1qRvb4zxnxOPMbKskPfzSg+xObJBspLlYl
         vvXsturML4dpxzkZdgoLO0Y4KvGPzCBqy4BHvxGmiqWb+ng/WpGh+Ijl1Xf49Na0fhsc
         hrihwEk2LIXSWgjrYH5nyjHyqj+cB88WmnOOvCtUvuOzHD0rXOts2VhLnEDy/0Qfun7L
         s9zt1c67JcmeG4KKqjLUAyaBTpmTqtXPqZ+6pA/DJq4rLPbz6vin2rvWR/YCmIwSy7Hx
         FCGA==
X-Gm-Message-State: AOAM532lnz1om8CYRbw57QJ9vQYBCpTV0To7uTTbfLRTzXDe5kfpmmsw
        Py6SSp8cUrFT/loWfAPh7+E=
X-Google-Smtp-Source: ABdhPJy7sW6ic8uagw1PdBfYwaIz1gA5ezwo92Wh8hrIC5f8GuoRKE48Me3mP1HmWhy7b0RmPOzZ4g==
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr21808675ejm.543.1617727206298;
        Tue, 06 Apr 2021 09:40:06 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id u24sm14117326edt.85.2021.04.06.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:40:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces around operator in HalBtc8723b1Ant.h
Date:   Tue,  6 Apr 2021 18:40:01 +0200
Message-Id: <20210406164001.13646-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces around operators in file HalBtc8723b1Ant.h. Issue detected
by checkpatch.pl. Spaces are preferred to improve readibility.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
index 59e8c68cdc20..719e19420a3b 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
@@ -15,7 +15,7 @@
 #define	BT_INFO_8723B_1ANT_B_CONNECTION		BIT0
 
 #define	BT_INFO_8723B_1ANT_A2DP_BASIC_RATE(_BT_INFO_EXT_)	\
-		(((_BT_INFO_EXT_&BIT0)) ? true : false)
+		(((_BT_INFO_EXT_ & BIT0)) ? true : false)
 
 #define	BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT 2
 
-- 
2.30.2

