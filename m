Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22D3DF1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhHCPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbhHCPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:55:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06CBC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:55:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h13so12378761wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3Qe99v8UbNZBzv0TqH74zmCe3/VSRyNLOmo1741HPY=;
        b=vtZLv5oar/B5RlODHeU0c04yrCBBkSRGWAIeUHVhckyKWgKJGjkQu41xVZtMzq2Zhg
         nVWowqZAbrMbzd8ht5oWpAdlaNvvGieCHWpJYu9VPJ7CHO+tImDBVsmGNFG6r5SAbTUl
         g9xrwWEgvHkH2MsnmrFlfj4HhPYop6GOhta9yZyebxdPkfuqg7ujw0JOzGMaFipTFwT1
         kyUdDWoMHcNRiWsvI+YJpI9PXjvDgcWynCHBMdTTzWEQxbvfCXzvsAvLFWWx8v8hsVob
         IbtxPy4AurPfbk7U0ZIqwrxWUPJ4ytgIzbuN3MIBE3cPQqi/sHbD6MaxWi6mtkcsw07D
         M8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3Qe99v8UbNZBzv0TqH74zmCe3/VSRyNLOmo1741HPY=;
        b=gofK2rjQP6h9fbCFwG4ILeJ3sED/wNDfxOmknjfI4exAgMLoMkqTTz6zsc+NDUousT
         G3zChdTMtJrtRLKjp1fQzFnayii/Ql2FRpdpqm9HwgXnHV2MTX2mgdp6FTnSiPkV9Zpa
         k+dLXLN7poYUy2B9TZPrQFQG0IdUc8IG6jWL++J9xX2caw17iCioZ0L9p9GYAnPmT4Pn
         CxpFOCRcBcW4gJcI/vTVLCdCuoSG3JXW2tjgbirtrXjCT6JhSYeVxELPUVteEgFI4uo7
         y1Nd5fV7oB+F+1mxsx8tZM6VyC763tPxQ3tXPIvuGRGk5cbEOLBE6fTx3SZQOSgyH2Bm
         ksWw==
X-Gm-Message-State: AOAM533cPYDJ1toGmriyH1oczjkmooAt4F+D5VHMx2ommwvlXza6XVeL
        bYOVeN+E2hWRung0Yh6cyVqJAw==
X-Google-Smtp-Source: ABdhPJxkGfZ3XC8Ad+ROmOKHSRUV+FVGsHNcLXhe+1nKISjafT2Wh3utGXI6McdWGEBPHCOdV2NcpA==
X-Received: by 2002:a5d:4410:: with SMTP id z16mr23685196wrq.173.1628006099434;
        Tue, 03 Aug 2021 08:54:59 -0700 (PDT)
Received: from localhost.localdomain ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c10sm14058863wmb.40.2021.08.03.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:54:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH 3/3] power: reset: Enable tristate on restart power-off driver
Date:   Tue,  3 Aug 2021 16:54:52 +0100
Message-Id: <20210803155452.435812-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803155452.435812-1-lee.jones@linaro.org>
References: <20210803155452.435812-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elliot Berman <eberman@codeaurora.org>

Since reboot_mode is an exported symbol, restart power-off driver can be
compiled as module.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4d1192062508d..e155b2e2a75c4 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -192,7 +192,7 @@ config POWER_RESET_REGULATOR
 	  power regulator defined in the devicetree.
 
 config POWER_RESET_RESTART
-	bool "Restart power-off driver"
+	tristate "Restart power-off driver"
 	help
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
-- 
2.32.0.554.ge1b32706d8-goog

