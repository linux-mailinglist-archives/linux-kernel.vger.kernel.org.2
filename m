Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BD393F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhE1JId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbhE1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453FC06138D
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so1961317wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xy+teow2EA1aY3LFpYUkd6V1bBiGK9r/LOeL5mAnek0=;
        b=wKiM1Mks171OZR7VXl51gMpR92TKJuOplvHoegprgOUV8NZ3fvfdxnZbiwLrSfFQ6k
         dJpW1tjOZjrvHUPeF6OAAVjikjqyBdBciXBAJcGIuAsh0eiaqAsikf5y0om3YmLJvLVa
         loCi49V6OclzpetmrwUpHBGpjZ4wcbjBnhSFHm4M5S3WmiOb+sI+NPGHa3VIEN6kC81X
         MLO/yq43NDiVTEgsPNATX+JQWLYRFOdWpAiJzCAvtD1o3zVJFQsxI48dJLv8eMWD3RSg
         rfkwl9B8iwfkaEkaP3f395UpVNT4LihHpW5kHyLpS1tT3/73gNWmdPg15E85IhBJiCSL
         jKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xy+teow2EA1aY3LFpYUkd6V1bBiGK9r/LOeL5mAnek0=;
        b=epj1S/3OD5UB14xsx0uCe3V11AtMAxTSWAeb/wcpJrpMf8sej//xdklf3nwCJP5vej
         OUPKAl26B2oADSoysjiGRZgkzivyieGwUyQHTbkPtpc4DeUbq5TGqcivSxOFDRjmAWDn
         z5dDWg72xkR92vATrAZGUvwasmBNiYLjuASXavTQ9QmwApnQJ755mS8hBKolzRE2zdXd
         BWJMBQISLY4q1l2deUdLTDpaGSYTuhi1FtvSuUTDx+9KhWOpvkZnTFQePcDJQGXHuSKq
         95wGxZ/8OvE+ZrSPrY7w937MECGpCnYvOrb2FrJ6C6BlQqP/9sGBZhaLEdnSpStzGrMM
         wf9w==
X-Gm-Message-State: AOAM531MTuGXJISvrVvSEKrFC/DRQANy/GwMTVrfGi4PdrfQ9sybyPi0
        +119BdCySkuEbkayCpA6XILRpPv1+fCmLw==
X-Google-Smtp-Source: ABdhPJxLcIhNp/h0ipNq9LfbyfZxWzXUNpfrSBFsLn9+Kaw6L6f0B9lKEMh6h9ZrhLysHPtvWSzJ8g==
X-Received: by 2002:a1c:3c55:: with SMTP id j82mr7450966wma.21.1622192794206;
        Fri, 28 May 2021 02:06:34 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        linux-leds@vger.kernel.org
Subject: [PATCH 02/15] leds: leds-gpio-register: Supply description for param 'id'
Date:   Fri, 28 May 2021 10:06:16 +0100
Message-Id: <20210528090629.1800173-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-gpio-register.c:24: warning: Function parameter or member 'id' not described in 'gpio_led_register_device'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-gpio-register.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-gpio-register.c b/drivers/leds/leds-gpio-register.c
index b9187e71e0cf2..de3f12c2b80d7 100644
--- a/drivers/leds/leds-gpio-register.c
+++ b/drivers/leds/leds-gpio-register.c
@@ -11,6 +11,7 @@
 /**
  * gpio_led_register_device - register a gpio-led device
  * @pdata: the platform data used for the new device
+ * @id: platform ID
  *
  * Makes a copy of pdata and pdata->leds and registers a new leds-gpio device
  * with the result. This allows to have pdata and pdata-leds in .init.rodata
-- 
2.31.1

