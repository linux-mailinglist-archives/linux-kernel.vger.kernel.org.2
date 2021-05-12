Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32237C9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhELQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhELPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:36:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69174C08C5FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2699112wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDfHlfvGgS7fXLPKGx3FlVf6YEX/1T7ZpXdjwd6txh8=;
        b=utmLTJuzUlAWiJJ2I7sO7sN+rJ0xJZPDgk+sbM8D88/+apd0NE/N7DiJj/z0Y/0SDZ
         7q+qXkA1DehSPGZt2xcQ2ir0d9PzpF4PRLrlKBIANEiB458Sy3aXFuHBJI6aE8P4EIyR
         MLs8nKMA5HZsD+PZgQTWWGj8vRpDaa3xGzS/GWQQCA7TawKJuJbNQbkaPmkmMHhstXZg
         GHWo3dTSkcEAIfK8dJaDHxXYZ7HjyJV8t0H6951/nq2gr9jqFb2MjMAy2gFWKiBBaeHp
         iwYXRRgPcHvjdYHfvrOgNO/y64CptU/XnbA4vNxBxBC89AW3MMdje9w/Whaep2QXYLUZ
         IEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDfHlfvGgS7fXLPKGx3FlVf6YEX/1T7ZpXdjwd6txh8=;
        b=PZCSNtgTAh7f7aj+QhsbEkm07Bgy2mW02T5/EGDR+S4PMRcYvsSyDOCkuO7YSCQn11
         +egzfpALtVuZtSl0FOZsOei68DYkd9+DqsUBgtYOcgCH1RoYdNDEq59//n9ZsQzwtLC2
         Yyouc1fp6yilD+3OO9cZZueIVczLzzQwXIyoC5a1VhD5Ft4nR30edemjV84z8RWhTHy0
         VPAd0fK9Zir5hVizEfcdVVS2NAHmus078oiBPV87w8zjGxh1HwGPCnY9KSm32gZnXNI5
         w8JBhKHcQmJNTXedP/oF8EZc3/92aIshnQW3pklKt42VPAO2cM395+AXEWa4v45MYnI3
         Kryw==
X-Gm-Message-State: AOAM530X3R2Mmu61arrBELXGjdAajQDH0LH/qloxSL/dwT2d9k2krrCj
        aoyRLBuqLAHh01Fs1whv1/f2tA==
X-Google-Smtp-Source: ABdhPJyI3xdXbd5uniPUQaw+qrjIO2uDp1W5G7V6XvL8VFTQ0gpNN9lqEOC5ypH91WGzf0KRYZs71Q==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr38372027wmk.25.1620832585788;
        Wed, 12 May 2021 08:16:25 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.home (lfbn-tou-1-1465-169.w90-89.abo.wanadoo.fr. [90.89.34.169])
        by smtp.gmail.com with ESMTPSA id c15sm30095011wrr.3.2021.05.12.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:16:25 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/3] mfd: MT6358 PMIC button support
Date:   Wed, 12 May 2021 17:16:11 +0200
Message-Id: <20210512151614.36996-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek MT6358 PMIC has support for two buttons: PWR and HOME.

The interrupt logic is a little different than other PMICs from the
same family:
for MT6323 and MT6397, we have one interrupt source per button
* for MT6358, we have two interrupts lines per button: the press and
* release interrupts are distinct sources.

Changes since v1 at [1]:
- cover letter title prefixed with 'mfd'

This series depends on [2]

[1] https://lore.kernel.org/r/20210506094116.638527-1-mkorpershoek@baylibre.com
[2] https://lore.kernel.org/r/20210429143811.2030717-1-mkorpershoek@baylibre.com

Mattijs Korpershoek (3):
  mfd: mt6397: add mt6358 register definitions for power key
  mfd: mt6397: keys: use named IRQs instead of index
  mfd: mt6397: add PMIC keys for MT6358

 drivers/mfd/mt6397-core.c            | 20 ++++++++++++++++----
 include/linux/mfd/mt6358/registers.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.27.0

