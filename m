Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FC318497
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBKFXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKFXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:23:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5EDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id a24so810646plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnNepfMt6SkUB80VLnkD+4T2OWTmkVQGDZU4Ef/AiRA=;
        b=hKAPTehETeAxx7YcildAqVGRxa9k7ELIQjfmGk4Buh3w43CGMdrfgNra+j/Iglny9w
         vgW1YGq5Y9ZGcps7qhIbqYR/NRZr5vIJUzI77l4Ze4v/bJLU+QGS8Rd80d4ZDz4w5ZYB
         21CM1nhjRCggoqQyCGLAj2DatNv6lZel+kdhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnNepfMt6SkUB80VLnkD+4T2OWTmkVQGDZU4Ef/AiRA=;
        b=lm0EWApJvlR1i3FsjGNzvqeD2pVRuHz8vhtmAvuARzy5Yk0qnI5I7mNltKImYN7aQF
         9vhN2W3/09WckwjOVN6OWLos9k3aYNKQAXi1kCyLeiwD5GG8bkoMyaAyt6ybQGOMBU82
         CGLydCoOfyJWThgFxnjGu5y4P4coIN3+DXPTh2O2cILdtXqvmCzua54Tyfb4lBCsvqF2
         IUZaqy8PClDoPu4af5SAzSgPm/R2NqYhRfko6Eh9+qJVNf6MYIdyyV7F3XkZykqNKM3o
         IanoohudKbRoBuJ3gqA/NxyGJqrLTdtT/Mec9A9op5C5BVNqqH6DDb2LgfhIucU4AaJJ
         EPMw==
X-Gm-Message-State: AOAM5327+PWLYNt3nEK16WluNjzyyN0kVN7Xkq5mxuV9t4h662VWNxu5
        6sZVVD7NiwH/dBuRWec9rKxdkA==
X-Google-Smtp-Source: ABdhPJxm9oq3kysAb4UsaHFK9obWwRxLAj7T0n4HlVeKP+0AkVLpg2wqoyeo8d/MtmBWD0fi4V2DXw==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr2350979pjs.200.1613020952009;
        Wed, 10 Feb 2021 21:22:32 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id o21sm3493511pjp.42.2021.02.10.21.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 21:22:31 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 0/7] ARM: mstar: Basic MPLL support
Date:   Thu, 11 Feb 2021 14:21:59 +0900
Message-Id: <20210211052206.2955988-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the MPLL block that is present in
MStar/SigmaStar ARMv7 SoCs.

This block is intended to be set and forgotten about before
Linux is running so all it actually does it read the registers
and calculate what the output frequencies should be.

We only care about this block because there are upstream dividers,
gates, muxes etc that need something between the input crystal
and themselves to calculate their own rates.

Changes since v1:
  - The clock output name related parts of the binding
    description are gone. Clock names are generated inside the driver.
    I dropped Rob's reviewed-by because of these changes.
  - A devm helper has been added for clk_hw_register_fixed_factor()
    to allow drivers to register multiple fixed factor clks  
    without having to handle all of the clean up.             
  - Numerous clean ups to the mpll driver itself based on Stephen's 
    feedback.

Daniel Palmer (7):
  dt-bindings: clk: mstar msc313 mpll binding header
  dt-bindings: clk: mstar msc313 mpll binding description
  clk: fixed: add devm helper for clk_hw_register_fixed_factor()
  clk: mstar: MStar/SigmaStar MPLL driver
  ARM: mstar: Select MSTAR_MSC313_MPLL
  ARM: mstar: Add the external clocks to the base dsti
  ARM: mstar: Add mpll to base dtsi

 .../bindings/clock/mstar,msc313-mpll.yaml     |  46 ++++++
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/mstar-v7.dtsi               |  23 +++
 arch/arm/mach-mstar/Kconfig                   |   1 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-fixed-factor.c                |  39 ++++-
 drivers/clk/mstar/Kconfig                     |   5 +
 drivers/clk/mstar/Makefile                    |   6 +
 drivers/clk/mstar/clk-msc313-mpll.c           | 155 ++++++++++++++++++
 include/dt-bindings/clock/mstar-msc313-mpll.h |  19 +++
 include/linux/clk-provider.h                  |   4 +-
 12 files changed, 296 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 create mode 100644 drivers/clk/mstar/Kconfig
 create mode 100644 drivers/clk/mstar/Makefile
 create mode 100644 drivers/clk/mstar/clk-msc313-mpll.c
 create mode 100644 include/dt-bindings/clock/mstar-msc313-mpll.h

-- 
2.30.0.rc2

