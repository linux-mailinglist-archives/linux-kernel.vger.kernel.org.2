Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6638CE39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhEUThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhEUThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:37:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:35:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so5094298wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMPp6HPzP/Z/gUwGloJk24nCk2wzxJtGMMbT5lZO+5o=;
        b=q1qKnsjkZUrocABLo94M7Hfw0Q7xLmCXEJswBta33OeEFvzutzEaY9xoT1T+mItREq
         3fPyLqWGAoDivCgVX7+dD1C6Tkisml4vr0JMQapDFKzOfeKKlUSeO1RJkZlyfaFxpF0A
         91c9hhlCDThf4iJZJZKu0bXo7aVlOMrhkz1L3ihcYO0Z6FdUJCthypZEGlWewKGjnJWy
         OHwKzXqjXh76G0lwVuIf40ZSL3fJPGJhSn7flrN30Ue+HFiDHI5YBqYgB3DFUM6F7lS6
         kaUFFkDwr+gk7+Mt6Zyf8xGxWkYWyISjdvNnFJTTr7oIi7xBmA7910geunzd1atRUyA1
         e3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMPp6HPzP/Z/gUwGloJk24nCk2wzxJtGMMbT5lZO+5o=;
        b=Jml+zUs7RaB2hJEGtSAsQQl8azy1I4F/oXbGWxJXjPEka3gESEfTdFpoXP5kGsq5m6
         7cSjgjN6RGsaB5Zd1PO+ccQCOZGTB7eaVhF/IkjQwQRuKV4O5KcZfHV+fO0cGroCIH5x
         dpeSR3/RLaqSU9UJN1bRYbGWuelBaRmHrr1zREyw0wAIrcTShfI6R3wEmNZdx5bYgCyG
         qjuKdWDdHP1MUUFCQ/f1BN8s59YSJlD0eaicCTryL2Dchc7Y3iFboqnXKxteaQadrU08
         aF79NlAtY1WTtIzCy4WKHbwelHg9zQpN/jRaFKSd5h5eXk9YoqsveXGWWfMDMC3yHZ/f
         83DQ==
X-Gm-Message-State: AOAM532fvi0AlrUXBBj45KBjM4HoTH2roPBdkcagNWy4w+mhr9nHjTe6
        ehL2/ae42iViemy0evEmcu/8Sw==
X-Google-Smtp-Source: ABdhPJwgUxMVnXG+KcLbTk+NgdIdXciecDGOurZpwiGKz40ow2N6m4Rhfg37a+KsIJwMbKuRim59SA==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr9805966wmi.15.1621625746546;
        Fri, 21 May 2021 12:35:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k11sm479694wmj.1.2021.05.21.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:35:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] ARM: dts: gemini-dlink-dns-313: rename gpio-i2c to i2c
Date:   Fri, 21 May 2021 19:35:39 +0000
Message-Id: <20210521193540.16164-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes dtcheck warning:
arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml: gpio-i2c: $nodename:0: 'gpio-i2c' does not match '^i2c(@.*)?'

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 34597f21647b..89de8e5145a8 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -82,7 +82,7 @@ fan0: gpio-fan {
 
 
 	/* Global Mixed-Mode Technology G751 mounted on GPIO I2C */
-	gpio-i2c {
+	i2c {
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpio0 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&gpio0 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
-- 
2.26.3

