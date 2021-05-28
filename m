Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFE393F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhE1JIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhE1JIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB0C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4122848wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQaiNSE7un6ReV9xY9B/S7XjK0Kbs8xr+fZEepz4I8k=;
        b=yU1zFn7zCAlBTiOADJg/JAqk0hVjBbGOO/x5LjIrPZGuOn/uq7O4Q1fIUOhayuVBpS
         HZtHww+855kuEsuCg03+OtxoIkdM+0eohBonn+Rj2odQwoOFOLWKAevPm7+xAwPLwRRX
         BeXHATNHfQTencjFqEUnFCoeXBc2YRzT/9a4EyzIBGFkMWUdRkKr7i6saIrWzC5mk3cZ
         hL16RVsshvZFDYOLdlO1Z4FD6TIRPzAM8R/96CmrdNVVrq29nht2XOkdoYzJusJNYPq7
         dCxF7jl56OZSn6KyhClb2PvJNx8HPisjARNifO2rreUGDIJDiHZbLCOKN3TT3etPJd6V
         9OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQaiNSE7un6ReV9xY9B/S7XjK0Kbs8xr+fZEepz4I8k=;
        b=OJzNsTBrLAtbMksHFObItBKX3wRfh7oblqNzQTnAhFnRlvMI7bxC+7wN45f5cm+Zi+
         jlcQdj1fqbTxgHFG3zupjby+t3WEU9wvzlD3yu+ueV2cQwgahAluLg3jesTwp3/q8nQi
         9iB4pyZCnhloC4rnKkpct0aHQtgJ1FpUb48LfODRuQ1ZlyeYm0Nv6RBlnRyVCVQptzwW
         tDo9DZBVeXPMq+le1C3B/LeeRfoKo3m6D7VWcNW32FDggdWrJkjsgnHrD7aB4pFc32yh
         pwyGG068vVZZEh+35JAt2aFDBeMjcdH6L0kZ4eh97Ucp0EBACLVDgloKGbk+zYTGv+tv
         1OfA==
X-Gm-Message-State: AOAM532toslN0tV0zXeyHtFDLnFQasr52Xs1WjQZW3cUVlZzSp9f7ZiM
        fiHY2YNdCoWK1BinDkjH4HzPAQ==
X-Google-Smtp-Source: ABdhPJwnS8550TgH2fS+ShKZXKH/79uie9paHrLmPICG5AK08fkSv0tkc7OKQnsjbtE/CY3OHMWMPQ==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr7311621wmj.13.1622192799358;
        Fri, 28 May 2021 02:06:39 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        David Rivshin <drivshin@allworx.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH 07/15] leds: leds-is31fl32xx: Provide missing description for member 'sw_shutdown_func'
Date:   Fri, 28 May 2021 10:06:21 +0100
Message-Id: <20210528090629.1800173-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-is31fl32xx.c:85: warning: Function parameter or member 'sw_shutdown_func' not described in 'is31fl32xx_chipdef'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: David Rivshin <drivshin@allworx.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-is31fl32xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index 2180255ad3393..3b55af9a8c585 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -58,7 +58,8 @@ struct is31fl32xx_priv {
  * @pwm_registers_reversed: : true if PWM registers count down instead of up
  * @led_control_register_base : address of first LED control register (optional)
  * @enable_bits_per_led_control_register: number of LEDs enable bits in each
- * @reset_func:         : pointer to reset function
+ * @reset_func          : pointer to reset function
+ * @sw_shutdown_func    : pointer to software shutdown function
  *
  * For all optional register addresses, the sentinel value %IS31FL32XX_REG_NONE
  * indicates that this chip has no such register.
-- 
2.31.1

