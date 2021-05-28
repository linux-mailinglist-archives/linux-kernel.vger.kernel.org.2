Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE517393F45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhE1JI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbhE1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCCC061344
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f11so2566937wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Tpxvrezbz4fVWqGXP5tr+bw/T66XdtDTRoAL/D3c3I=;
        b=At/x6PPBZ6tyK40CZRLPAWb+hzicYLlGXMkRZufynn55TwTjfK/ktiwzgnRY+y39Ao
         z37YAD/D6RCb/kutzgS6QxDYg7TZrYLeLNWAyi9ah5t4g85xxzgoBzXusu+blHsialHo
         gA1RimDyapBS2fw/JcIE+Kmwv0GO/HL7+JrfjyU1sgSWlKJLyVEmlUEHkhoqiG6D2K9C
         NbX4pmCw8KSAb++U1MfHZJwTnpYBADSARDCmwnCt/ZRuV3+S3WZaLZoJKJFO9LcZOHO1
         pcEC4Y7MifaWhlKAolq2tGwHtaV8y2xuUovjn3mCPidIZYPdLnvLLnS/jQ/PG2ptfJN2
         0uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Tpxvrezbz4fVWqGXP5tr+bw/T66XdtDTRoAL/D3c3I=;
        b=L5b3E+1IgCZxMUDK8Tm9OmwT5HbznOaJRuaY3TTMQOe6P4P/rJPp+OoQbZd0eMbDbD
         ZSd8SgeLQ33e8+n/iv/IWFxEefFLNZIP9/c8EGV5tR/jP0jYVjKS5Y5lkUgUehtHUOAt
         FzqOz/8mQYGOyHHO6uqs/uNOfFf/apM+OffpBc0t435EtTNbTAimK2QPFUeEC4EjWISH
         kIMf3DplSvHC7TGgsyPfa2FuvxqU4fnf9kHkcoE0xCBSf9YXLtviFoAkMrE3mW6BFECV
         vC9MpWxGCuYD0SlHJUHD0H9wHWaei/h4dO4u9Tk2i991cQUa0SmZq8K7Wt5Rrhf/y9nv
         B5lQ==
X-Gm-Message-State: AOAM530XJkpaofE6B9OfEUUFrkJz+h09GrCs6L5h5HLJVr8GXKGmn3pK
        tbrEq1e6nyV7uZl4aSHqAI5oPQ==
X-Google-Smtp-Source: ABdhPJxdAvtpA0b+0QMymcnMlaWAoDfamf8vkww1ga54r7T1M00JSMkdV+RgVloVeZ+JQW6SuUkyMA==
X-Received: by 2002:a5d:4b87:: with SMTP id b7mr7312653wrt.129.1622192796118;
        Fri, 28 May 2021 02:06:36 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>, linux-leds@vger.kernel.org
Subject: [PATCH 04/15] leds: leds-bcm6328: Demote kernel-doc abuse
Date:   Fri, 28 May 2021 10:06:18 +0100
Message-Id: <20210528090629.1800173-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-bcm6328.c:97: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Fernández Rojas" <noltari@gmail.com>
Cc: Jonas Gorski <jogo@openwrt.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-bcm6328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-bcm6328.c b/drivers/leds/leds-bcm6328.c
index 226d17d253ed3..2d4d87957a300 100644
--- a/drivers/leds/leds-bcm6328.c
+++ b/drivers/leds/leds-bcm6328.c
@@ -93,7 +93,7 @@ static unsigned long bcm6328_led_read(void __iomem *reg)
 #endif
 }
 
-/**
+/*
  * LEDMode 64 bits / 24 LEDs
  * bits [31:0] -> LEDs 8-23
  * bits [47:32] -> LEDs 0-7
-- 
2.31.1

