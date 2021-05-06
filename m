Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B543751B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhEFJm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhEFJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:42:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AEC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:41:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so4861558wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGLMaIjJ/59GAV1ofZhUU7K8F2hooQOdMuE41Fq9fiw=;
        b=RkMnsD6KvMi6ZHCsPL8Dnl+4tGuWsXTN0tNVSraD1ZobCZPyShwIr47yrOkmMSQ1YE
         Dbw4UZHC5UpyoSn/gIIW1Ah18Rj9PgOMgz3EcHWBiEuVkdEpttBAnDiMoUtgv5XBIMLQ
         GMvKu7m3Z2D2J5OnzQd4sraDUcwPY83/P/UxzsGnowrwefRRd71b2s7c6YyPqM17BPlL
         JwE7IZI5WMOy+CcJE6XsolcQwzhQOt0DyQqkhxg5WUiYQ4xZwBmxrcsbi7OUhdx14BLe
         DZUW4sxnIOOFW2HnydnhO6RCGjz8Qr6z1ZclNx0bdPzpwnKNhgtgIoEKGqz7vAJ38iSC
         sqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGLMaIjJ/59GAV1ofZhUU7K8F2hooQOdMuE41Fq9fiw=;
        b=fPHwRy4owcjYEJdHSg3+Vo8bfgAHF2rUaKTGsez8Ib7tm0ARbLumzHzbcGgY2uPGn7
         4RMrwIoXxx3yvDb7OA/z8XjjoE7jcGMM9LHGBRvr3/0skw7pKaaM0HlZZFvlotIu3WoC
         ok9j2xX6S0CF31uXjYRQncLhsThYuZ/VWgo9lX78JsL886aDoeEasBV5fCrfEW1sUNkt
         mg2N/dV4987pqbBeX0tx8u+W0OeALob1dMnfMVM3dUDW7HI2tL1DonNTV2dH7tOvhrOy
         AifcSR6A1regt2RQx2Tm3jRpOziX+brSpqEEg3HFChM0jeBxhi/qzRlS/pt6POvQjjpP
         65XA==
X-Gm-Message-State: AOAM533JsQ1fn19dfZwmKaIFNbin59NcQ2KrVXMlY2aKAA5inNtLS1bO
        QH092uKqIqIIRKTdMBAsh9vZZA==
X-Google-Smtp-Source: ABdhPJwfEmWX/6FYzIU3H4cSjuIgImGG9IfqUxLnFTDYk1RcDZyq0ZieLpUOw1Km6YShmQ444UtqXg==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr3802633wrr.324.1620294086330;
        Thu, 06 May 2021 02:41:26 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:2492:c5b6:6c3f:6de4])
        by smtp.gmail.com with ESMTPSA id y14sm3360421wrs.64.2021.05.06.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 02:41:26 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 2/3] mfd: mt6397: keys: use named IRQs instead of index
Date:   Thu,  6 May 2021 11:41:14 +0200
Message-Id: <20210506094116.638527-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210506094116.638527-1-mkorpershoek@baylibre.com>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pmics of the mt6397 family (such as MT6358), have two IRQs per
physical key: one for press event, another for release event.

The mtk-pmic-keys driver assumes that each key only has one
IRQ. The key index and the RES_IRQ resource index have a 1/1 mapping.

This won't work for MT6358, as we have multiple resources (2) for one key.

To prepare mtk-pmic-keys to support MT6358, retrieve IRQs by name
instead of by index.

Note: The keys_resources are not part of the device-tree bindings so
this won't break any DT schemas.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index a83fbc486d26..5818e0c328c9 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -46,13 +46,13 @@ static const struct resource mt6397_rtc_resources[] = {
 };
 
 static const struct resource mt6323_keys_resources[] = {
-	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_PWRKEY),
-	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_FCHRKEY),
+	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
 };
 
 static const struct resource mt6397_keys_resources[] = {
-	DEFINE_RES_IRQ(MT6397_IRQ_PWRKEY),
-	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
+	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_HOMEKEY, "homekey"),
 };
 
 static const struct resource mt6323_pwrc_resources[] = {
-- 
2.27.0

