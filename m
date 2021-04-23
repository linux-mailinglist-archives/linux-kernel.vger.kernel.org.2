Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3B36957F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbhDWPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbhDWPBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99330C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:00:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y204so24802640wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ck3YsdNSVP0rZ1FtHCUQWW2VZt87Mqq7djATO4TUkHY=;
        b=K1qYfSKbFKzLKwOhZocXaIMZGX25TTmnWPkjp2V63mjSrE6u8r+Hea9puG7453dsOr
         Zvtqb5BSFfAYGe2cTW2T9kczdOShsIj354QoTQyzxCJH4pBDSAaClpm6XydB7tA8zdw+
         qa3YbmXpFYPvR3/MLCoZFQDOPOFSJbNFU920OHVvfS2VsifXq8l8RbjQcX4zpfnv72kE
         UWph23+zmnSOxANksvkTFWrtrXEzi6f+TuSsfD03vBCWQET6gsy2RYwWKjJ2Iy76GNcX
         ApVaf3RtiW1on4Dz+ULcJ8a1fYAbKt6u0vd/TNYjl72UL/GzFgvsKUPtP55BfYr8x1o8
         v/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ck3YsdNSVP0rZ1FtHCUQWW2VZt87Mqq7djATO4TUkHY=;
        b=DrxRNFKwcFkEZ4w3+PGYUH9sr13706wF1udZXZoakH/tipJ/NVvt40MgeLbc383v4Q
         Wvuiw059VHLCfx4NfksidLpkJMr0tI1vqaPvEfhDS9VcYSlIfdK7dZi4LbNwYIuSBf1x
         qVm7+pb9W2o2f3BaKRX4wT3WRSSZr1NCJorNJjt6f33fTMjLP57FGtDOmL6xB8EtXp09
         170YmLiyIBH0liH5q27DFG7VOuuMQzkZrbmvTu2l3v7ADrWRkyRgbNjOAXd5kv0gD6tf
         C5NJrQok3QZHOrNCMBMClMcWBFreGBKi1AlIJJCds9wQZGJaZRjZpNFP8/Gxu0YSrX/w
         5x4g==
X-Gm-Message-State: AOAM530L7jWp+wlMPxUxHAiqK5thKPuyOEqokGanalriC2EVliDgZpTR
        kCQiAZp0dSaiH4psQxXpusFRgRLErJU=
X-Google-Smtp-Source: ABdhPJzG2BYuuphqrqCyCTP5ACW+0ED1Xeg1kgv59UWtZ4nNL6N2F5/SAg/pPp6CbRFz0R4H47URBg==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr4832362wmq.181.1619190004217;
        Fri, 23 Apr 2021 08:00:04 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id h2sm8731913wmc.24.2021.04.23.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:00:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 49/49] staging: rtl8723bs: macro DRIVER_PREFIX expands to lowercase driver name
Date:   Fri, 23 Apr 2021 16:58:40 +0200
Message-Id: <612c1e599b15404c76463d642102985b3ca1470a.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

macro DRIVER_PREFIX expands to lowercase driver name.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 189f02a8300a..3a5b083e95a1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,7 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define DRIVER_PREFIX "RTL8723BS: "
+#define DRIVER_PREFIX "rtl8723bs: "
 
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
-- 
2.20.1

