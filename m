Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1579B325717
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhBYTwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhBYTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:42:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E1C06178C;
        Thu, 25 Feb 2021 11:42:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n4so6424246wrx.1;
        Thu, 25 Feb 2021 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9um242iCHB300BD9k7qw2Txw9JjwLSguwC+abttFn+k=;
        b=iKEYA9uD61YuyyZhKRBJK/4HehtHC3bMDkMrExOg/wZiPOxNefn5LUt/8kQN8TsNGT
         5gpZk/avut5Y7FpzANYLpDw5wviZ4JAyP0Hyf5Yt6JYMv36nYcsrNw304pnC8IIDNEAF
         cZsyZPnuvhDBuLq2ZWTlHbmZW7O2GFe8TXqfy1HNkk+5gWPo5pXcvx6ZZ70dtnoyJrWf
         sPLkHh5/nBUWBSJIzBIvKNyrljy1Lmn/TADpZCOhY9J4oV19yHfOSqlSOPqUeSXBcm4X
         Rxr/OF7b7cu7Pos6Z7je01pZQGb0S9Ps1aRLeNrK2TqwH9IaK8aQa1IVmr8+Pu5hEUnn
         RztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9um242iCHB300BD9k7qw2Txw9JjwLSguwC+abttFn+k=;
        b=UuXCdWKFNGUeKgui4OfcqU8As40y3We1Q+ClUupfJNqGnXo6Sis6hVQWUamseAXP3v
         X6O7F15ViX25bxwXRONf1tSbpEoPgn9+r/Mt3lOO4shQqe1AYDJjyh8l6p5dduDG4n/2
         KoKhonLVBrLXAWhY9dEtLoJey6xUtq9GaUhr2b/KkLGbo9GL6pmfFP5htLDkVs1GxerD
         N/3YUxHvtnLWOirG4QcBNBdPpHOaiC/zRn+B7AEbDY8OUjHfT+k5PB3MpruROfLON0T7
         VkR+c3gWnqp2HwYGrGP8ytvZNfCEbnnaaJn5g4blFdtabbIDAPU01k/dG2hhOJa/wZjo
         /LOQ==
X-Gm-Message-State: AOAM530HpXNtErDuUnLx5PTOysqtJDcaLYH5XpLjMzperwj6zOSj7kLO
        TLUvSOc4AOjayCJQFz3SBbg=
X-Google-Smtp-Source: ABdhPJwlC8EUWRDFTZiHHNE9uXS4gfVOcxocHpKijHRbeQd8FkDDkntUIu2akkthH8hSLVmEW8ufGg==
X-Received: by 2002:adf:a418:: with SMTP id d24mr4982711wra.187.1614282123073;
        Thu, 25 Feb 2021 11:42:03 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id a198sm890603wmd.11.2021.02.25.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:42:02 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] clk: add BCM63268 timer clock and reset
Date:   Thu, 25 Feb 2021 20:41:57 +0100
Message-Id: <20210225194201.17001-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom BCM63268 has a timer clock and reset controller which has the
following layout:
  #define POR_RESET_STATUS            (1 << 31)
  #define HW_RESET_STATUS             (1 << 30)
  #define SW_RESET_STATUS             (1 << 29)
  #define USB_REF_CLKEN               (1 << 18)
  #define UTO_EXTIN_CLKEN             (1 << 17)
  #define UTO_CLK50_SEL               (1 << 16)
  #define FAP2_PLL_CLKEN              (1 << 15)
  #define FAP2_PLL_FREQ_SHIFT         12
  #define FAP1_PLL_CLKEN              (1 << 11)
  #define FAP1_PLL_FREQ_SHIFT         8
  #define WAKEON_DSL                  (1 << 7)
  #define WAKEON_EPHY                 (1 << 6)
  #define DSL_ENERGY_DETECT_ENABLE    (1 << 4)
  #define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)
  #define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)
  #define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)
  #define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)

Álvaro Fernández Rojas (4):
  mips: bmips: add BCM63268 timer clock definitions
  mips: bmips: add BCM63268 timer reset definitions
  dt-bindings: clock: Add BCM63268 timer binding
  clk: bcm: Add BCM63268 timer clock and reset driver

 .../clock/brcm,bcm63268-timer-clocks.yaml     |  40 +++
 drivers/clk/bcm/Kconfig                       |   9 +
 drivers/clk/bcm/Makefile                      |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c          | 232 ++++++++++++++++++
 include/dt-bindings/clock/bcm63268-clock.h    |  13 +
 include/dt-bindings/reset/bcm63268-reset.h    |   4 +
 6 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

-- 
2.20.1

