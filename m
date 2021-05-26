Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAE391865
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhEZNDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhEZNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso443676wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STuRU/wuc0GUpuvMIUPILdBJPB0EkMi/MfUyTQ2qMVk=;
        b=miWQDZMe+7Q4YePFJAgOOrJb6nHoFfFg+iaqvugtF5BTrv2fZ9Tn3s0JE+X5SJsNjQ
         naYBKCPuEj+tqxappTCFq1JKLcbIhFEZV2wSbPk8n+23iZM5OqixbWjmhXBkh7Ph+qx2
         fkrXjGzUPRqzeVHapsb5XM7+1fEGuiLwQT4Fd/a44KzJLS+63zE6L5hrPY2wLOS3b/lh
         TF5CK18z2Z6HNJOrDENrncqjKsK3JF85in6xKMMdJsD1PAZc/nnQilVzGr3aHjRLsdaS
         vETo2DPbH+uDx2BYOkwJASUUdNiBJRplY5xf1+PlDDSrozSIEWPJOEf2NOp+4O4hZ7HV
         sLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STuRU/wuc0GUpuvMIUPILdBJPB0EkMi/MfUyTQ2qMVk=;
        b=jScUJymhl+GksnMK5kjnpLDwTVlnEeb33RlGty2R9z8w1MlKzfmFMun4cpS+vcP2QC
         JbGba33czqkVuxIBLKEUBuHkgOCKCv+qr61qUmlMN2Jc6HgrePcz+iyUsc5X9uPn6sSK
         rNOvJNurpFKRiuPYrbUvbxFRwP2nC+2uRLDeV8U9Sn7PHpIvYtzEaXcg06HeGtkKUZU6
         2wxugKwAJP/WOUvVUawX8j/siftuoUYRaKtRkZLr+53YSziS+u6/bQgZ78r+c8EXbqjP
         s0XsKaPBvsJ7tDQGtL+nWG0r7TT+gi9eN1tTefhYb61kaKAyWTJwtKDW11hqorj0rrJX
         nTUQ==
X-Gm-Message-State: AOAM532Wvrj7gJk/O17y0Ts3ywbnXKrTylMzhiktgonD+AXwHRSgrTyD
        HT9JKtAmRrT5LvsUDe2UoX+C2g==
X-Google-Smtp-Source: ABdhPJyD/0d1YxYV6SkKT4N+wRfvSN8hofhog+J5kCAgUXV6p2b8I6Dm5m1/nn+KjgGcQ7hMYUkizQ==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr28099019wml.182.1622034054497;
        Wed, 26 May 2021 06:00:54 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 08/24] usb: cdns3: cdns3-ti: File headers are not good candidates for kernel-doc
Date:   Wed, 26 May 2021 14:00:21 +0100
Message-Id: <20210526130037.856068-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/cdns3/cdns3-ti.c:20: warning: expecting prototype for cdns3(). Prototype was for USBSS_PID() instead

Cc: Peter Chen <peter.chen@kernel.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/cdns3-ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index eccb1c766bba5..07c3187703623 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * cdns3-ti.c - TI specific Glue layer for Cadence USB Controller
  *
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
-- 
2.31.1

