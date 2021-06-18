Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FF3AD3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhFRU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhFRU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:57:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D104C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e22so8537431wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLy32YRyoZ5czfNPvX937n5z68mS5Dt/8atvgtKFvwQ=;
        b=o/CxikdrQRF61Z372ZRwM8wBTTiCxbifjXJIC3UGwCkgtcL13kW7xV0v/vTJs2Sr3F
         vlPtDKAg8kJYDqOmDjgxNdAFaCR04GmBfkXNUhPrev9TOHVMZeL2+Wfov/QhfOVKLFOG
         jegTkNUcslewWDomJoVX0T5ZLe11r3JNKcolewJTcbOv3wd/6iWA2vA/rjaZhwb41Szx
         DioqP02R44mK7ygcc3qEswJDNyUigoT/UOHVudcQEn0rfOEvffu5wczNPas/qR+79Svl
         BmP/XDKP2/FnlaZ7ShvOX9ZXNhkXWdEbRYqVl2JDUslwtDVdmgSvGyWu1DVzK3CtcCat
         P4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLy32YRyoZ5czfNPvX937n5z68mS5Dt/8atvgtKFvwQ=;
        b=MEfkJWdQeJG3w9NDrcq8k+UzphNoS4xX5bD6uQy8CRQUnOWgyD/7HErFxBCr4YaRnA
         rXAauvhXCNGYry7/TjbUJMxE3FXvv7jyRG8T/oYu1Y7MCilj3XsBv0jtHjnoCYvoFCqD
         btvUFcFT36Pux7jhfgV29Fe1SDKwsz+2m50ywRc1rG0601FYvLYx+UtY6VEL/aQVRsau
         L7u0I92Y938DE5P6AtkcZ7ln50MmZRUJFcL9zhxlwrgoC2tAprcwIyO9y1aUJz+Z0inY
         f/8h6jR/D68VnYe5telm8/OpYvI2QDxxzxd/5l0VhMsLfyXsmbD1kv0ci0rsfOPdN9JU
         s/fA==
X-Gm-Message-State: AOAM531Xv65eOP+57EWsmao5Zn/eSol2ThVnqtDfymzI+luHJMFk2qC2
        8BdjoF5Bwt7RUFO4+u85AdFwaA==
X-Google-Smtp-Source: ABdhPJwvWUKDVSAk9UEA2yUXUvp1Q8PkiE4s34baCHlp7pzILntItWvnWGhPX6sz0+OyVzlYwdJe+g==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr14828957wro.37.1624049740671;
        Fri, 18 Jun 2021 13:55:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm9745476wrt.69.2021.06.18.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:55:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/5] ARM: gemini: add two more board
Date:   Fri, 18 Jun 2021 20:55:28 +0000
Message-Id: <20210618205533.1527384-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have two boards with a SL3516 SoC. Both are NAS box.

Changes since v1:
- ssi1328 use now redboot-fis partitions
- added pinctrl as asked by Linus Walleij

Corentin Labbe (5):
  ARM: dts: gemini: add labels for USB, IDE, flash and ethernet
  dt-bindings: add vendor prefix for edimax
  dt-bindings: add vendor prefix for ssi
  ARM: gemini: add device tree for edimax NS2502
  ARM: gemini: add device tree for ssi1328

 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/gemini-ns2502.dts           | 148 ++++++++++++++++++
 arch/arm/boot/dts/gemini-ssi1328.dts          | 138 ++++++++++++++++
 arch/arm/boot/dts/gemini.dtsi                 |  12 +-
 5 files changed, 298 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/gemini-ns2502.dts
 create mode 100644 arch/arm/boot/dts/gemini-ssi1328.dts

-- 
2.31.1

