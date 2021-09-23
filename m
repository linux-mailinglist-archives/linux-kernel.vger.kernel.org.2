Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE622415880
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhIWG5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhIWG5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:57:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:55:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y5so941696pll.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmWq9SbwrmVcYQXqbOudIpr4L0AR6cg4qMF13tN786o=;
        b=On0oxMzCr2gt/8NejZK3kYR/EO3dvskZYTlcGLu8gDKR+DnZf5k5y/rjK6myt08FKq
         E8B27+oFGcZ7XXAlkmpWzHn3vdIEgCmbuGuugm1fhOfqg6+JqaZAYM7H8WKsegqpGtt4
         1hOCHLvJkXoe3t/Ct42W9nKgIXHq5uXAZmYmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmWq9SbwrmVcYQXqbOudIpr4L0AR6cg4qMF13tN786o=;
        b=NDWdZI9wOlcrJ/jiXOahffqi7uwrOdC9uSDoiwstrZlIx4jiscIuXY/2x2a5BJ4VUk
         dSK+YqefShVzxpAPehIxTwHBUMqOaqOZBDQ9E2ZUYq/kIPsF3b3SHyPLILf8JlofJ75r
         CIUYmf55PxZN8/fJ/J0vVDJJqZoHF2B9XpJYhrU/8yZf8bUDICMDZVe3GVY4/81vorpx
         v28pQfGbU25Rv4n3iMb7jtW5iQKp8M8xNtLIiuidipNT3h5EQVQQHgbBZQclthHZ6x6S
         /YkMAyJEDdxgxM3dQa0KraeLIloBi6v/Jxmi67XRfJlp19Kl6ydRdhEr65HCuJWPL03L
         kiBw==
X-Gm-Message-State: AOAM530M7YSMuhwjyMMES6/DByBG7NA4FDT2WsJnNwH7jyXkzsClymzC
        t9hbpCSa7i73ECNjcaJauSV5SA==
X-Google-Smtp-Source: ABdhPJzwl9SAOMvhQ9teA4ReWM9oVUM2ZPM+DZVNLVyVCtjew7NBoOmLZS6RHuD9OjQuNz8J5ui5zQ==
X-Received: by 2002:a17:902:7882:b0:131:2e12:c928 with SMTP id q2-20020a170902788200b001312e12c928mr2876342pll.74.1632380137887;
        Wed, 22 Sep 2021 23:55:37 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id e12sm1581888pgv.82.2021.09.22.23.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:55:37 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, pavel@ucw.cz,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 00/11] gpio: msc313: Add gpio support for ssd20xd
Date:   Thu, 23 Sep 2021 15:54:49 +0900
Message-Id: <20210923065500.2284347-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a little series to add a compatible string for the Sigmastar
SSD201 and SSD202D to the msc313 gpio driver, add the specific offsets
for the pins on these chips, and then a bunch of DT wiring stuff so
that the LEDs on the M5 stack unitv2 work and it can control the
power switch for the USB connected.

Changes since v1:
  - Add a fix for the led binding to squash the warning about the
    activity trigger in the unitv2 dts.
  - Fix up the regulator node names so they pass dtb check

Daniel Palmer (11):
  dt-bindings: gpio: msc313: Add compatible for ssd20xd
  dt-bindings: gpio: msc313: Add offsets for ssd20xd
  dt-bindings: leds: Document "activity" trigger
  gpio: msc313: Code clean ups
  gpio: msc313: Add support for SSD201 and SSD202D
  ARM: dts: mstar: Set gpio compatible for ssd20xd
  ARM: dts: mstar: unitv2: Wire up LEDs
  ARM: dts: mstar: unitv2: Add core regulator
  ARM: dts: mstar: unitv2: Add io regulator
  ARM: dts: mstar: unitv2: Add DRAM regulator
  ARM: dts: mstar: unitv2: Add wifi switch

 .../bindings/gpio/mstar,msc313-gpio.yaml      |   4 +-
 .../devicetree/bindings/leds/common.yaml      |   2 +
 .../dts/mstar-infinity2m-ssd202d-unitv2.dts   |  46 +++
 .../boot/dts/mstar-infinity2m-ssd20xd.dtsi    |   5 +
 drivers/gpio/gpio-msc313.c                    | 266 +++++++++++++++++-
 include/dt-bindings/gpio/msc313-gpio.h        |  71 +++++
 6 files changed, 389 insertions(+), 5 deletions(-)

-- 
2.33.0

