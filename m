Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A463E34BD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhHGKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhHGKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:24:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A80BC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:23:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so26449177pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yH4hz4BZgvksEYgE0/fFmqtyEvctv5FaZMZGgBgGT5w=;
        b=Li9fDITftwBhbcaHAmtOxaLB3RtvYq8BDWL+o5aTQMeSASjEUvJZlReE6tw3IP+f9n
         BzJ19KXu1dLaoWo0qfEsvev4aXFcJu/OqJdEskAtYJd2ZAZzzuhSte3N/qIW9BHiDpji
         i17KDURt6CsUGc4Iv3qcsuot7rPrMGFg19swjMxKV7H5TdV56iUjCPy6D3L7D3xSYeFm
         FO0NDMeUceGEEqRE/mF87RiMeYpSAY84V/9LgmTI/QxyrUdnG6cOVQqO2NZd86hw4Rrz
         8jSyQuNGyhL4n3WJ1ULl50XhdpVBU3m82Ak7l8MpKesfsDWTsFbX4OFVQRv0IL2XHxva
         kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yH4hz4BZgvksEYgE0/fFmqtyEvctv5FaZMZGgBgGT5w=;
        b=PPpUuBuNzcU/nY5CxUGZCOSEAev81AOM5ajn87We6TtSiXVN34ZX1/+O2+/PDEck7+
         Iod2uNpv+5NkuDzVOmOBpRcv4MjjwEYWIbQr0RpQvSouRAD6W3rivNmoM0+qRo97PF3o
         bIYqRPs3RdW3ZxLs86/xb3aPEGYIroB3lV9gaTeTt1PMp55yp/hfudiLePWlKMXaeDHV
         vqP5k4eX+WsoUhD52M7+1Lnbk1tCDF38rurGISnj4elVx7xm7bxcXTiuSUdYPv7cIFzG
         mDNHPEiqXizdBdCdp16Fjqv/Sgpa1yespx4VW1bXdgoYs4d2teMQXhdJXbOG8PvMHW/k
         s2IA==
X-Gm-Message-State: AOAM53011jXvS+7Dzw5Y0bu0+7+IuAtUN7D/1EkOh7Tq5OIl0hcI0wZz
        44aL94nW2ImTnMKRYpXCJ5U=
X-Google-Smtp-Source: ABdhPJwOeO7xjrdqoBaztlrOsgqVYIOyRF3lx7R733dgCanNaJIHuLaN8yyQHUGUQk4gY5BID+niWA==
X-Received: by 2002:a17:90b:f10:: with SMTP id br16mr14585311pjb.76.1628331837181;
        Sat, 07 Aug 2021 03:23:57 -0700 (PDT)
Received: from user.. ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id d17sm13290717pfn.110.2021.08.07.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:23:56 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: rtl8192e: rtl_core: remove unused global variable
Date:   Sat,  7 Aug 2021 15:52:31 +0530
Message-Id: <20210807102232.6674-4-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807102232.6674-1-saurav.girepunje@gmail.com>
References: <20210807102232.6674-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused global variable channels from rtl_core.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e85d9c2cdc96..dffae61b517b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -23,7 +23,6 @@
 #include "rtl_pm.h"
 
 int hwwep = 1;
-static int channels = 0x3fff;
 static char *ifname = "wlan%d";
 
 
@@ -2642,8 +2641,6 @@ MODULE_FIRMWARE(RTL8192E_DATA_IMG_FW);
 
 module_param(ifname, charp, 0644);
 module_param(hwwep, int, 0644);
-module_param(channels, int, 0644);
 
 MODULE_PARM_DESC(ifname, " Net interface name, wlan%d=default");
 MODULE_PARM_DESC(hwwep, " Try to use hardware WEP support(default use hw. set 0 to use software security)");
-MODULE_PARM_DESC(channels, " Channel bitmask for specific locales. NYI");
-- 
2.30.2

