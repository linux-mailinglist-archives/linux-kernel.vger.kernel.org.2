Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF22D3C2BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGIXoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhGIXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:44:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48475C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 16:41:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p4so1589150plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLnXv1SzF9qxYYtzOl/+0oOxTrnnAS5mnFYqRGSbmEs=;
        b=yf7zWzdl90KQ0dBCQobubD64v+LVUZPgXIzJlYkegEGZOFaOVUTvzlt5EENlu9dyAz
         TAKxEWNxa94pokBCbTR6LViLwV0byIIRJubHSW+TMsswZJmakqC08hcNaJcFdRMd9uxm
         XBzmjRzEdC+SI/bAqZ2Rg3hJXrfoFkNgSQgWi7XDax2IOtB1GH5cEdjfCo36LHOsYPoe
         coNwawiJo0kpmjKM4oKq7yenhJsqIlCYGbWKYQlYF7omiz3DLkYFza0wUiLTKcjjmaXJ
         SWmI80TXV0P/5Qq0rpLTdd1ChYbI1aRT7R8UKsbUORavnST7G2RGTh6vOFJEKPjiagid
         /IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLnXv1SzF9qxYYtzOl/+0oOxTrnnAS5mnFYqRGSbmEs=;
        b=Yc7R8Fj1IYKl1ie6F9e/WcKilTKbbrljP84Yf9L2rGI6PC8ZfTOSU+J582Y9QLbVEA
         JnJfM+70C4hLAQkmrLBUQLnhELNFMiQIzswup7ZqsGiiSTvFozt8+XZ2qqZcQSiZmCkb
         0c1E5UDcF1YV3Ip+nSm6+4bSdS5kMyjH4rqtHyeMIemnVFws9b4UeZ3wP7uew1oafSY3
         FwIm51ekP9CpST2AppKX4OkWJTbvJn6Wd+5aH4mnRYQ5kfFZRNJaRRDmPrWzaLG4lQ87
         zHbfDaPVi1lR/VXjKL7d9w/K5zlhj2pQrte5dz2N1ADVVWQ/8Whq+O+fCZy3r4YfUVwl
         1WAA==
X-Gm-Message-State: AOAM531RP8FgCADBnWNzF6Y1c+LdEQJMF8WgJpx8HtSSNBXfv6RznH+Y
        dEd6CpGIoxt47fJkfAlR5Gk2Qw==
X-Google-Smtp-Source: ABdhPJwW0ABilQNX+m1kxPMZdzjggEYDwVY0VbKYgTf/UNNUHZV/F+SXBL/oJMVAm5IBOQJ//qgd0A==
X-Received: by 2002:a17:90a:b906:: with SMTP id p6mr1293279pjr.143.1625874074725;
        Fri, 09 Jul 2021 16:41:14 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id n5sm2036381pfv.29.2021.07.09.16.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:41:12 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: Defconfig changes for 5.14
Date:   Fri,  9 Jul 2021 16:40:54 -0700
Message-Id: <20210709234054.10288-4-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210709234054.10288-1-olof@lixom.net>
References: <20210709234054.10288-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A set of defconfig changes, we keep them in a separate branch to avoid
conflicts between topics by separating them out. These changes are
almost exclusively turning on new drivers for various platforms, or
turning on modules for new drivers for the shared generic configs.

----------------------------------------------------------------

The following changes since commit 113dd10b4e96dd90a98ed514bc40caa07e4fbc56:

  Merge tag 'arm-dt-5.14' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-defconfig-5.14

for you to fetch changes up to e6adbcb7e2d71b0e0e0deb6f904783aeb79728be:

  Merge tag 'qcom-arm64-defconfig-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig

----------------------------------------------------------------

Adam Ford (1):
      arm64: defconfig: Enable usb2_clksel for R-Car Gen3 and RZ/G2

Adrien Grassein (1):
      arm64: defconfig: Enable LT8912B DRM bridge driver

Alim Akhtar (1):
      arm64: defconfig: Enable Exynos UFS driver

Claudiu Beznea (1):
      ARM: configs: at91_dt_defconfig: configs for sam9x60

Corentin Labbe (2):
      ARM: ixp4xx_defconfig: add CONFIG_SERIAL_OF_PLATFORM
      ARM: ixp4xx_defconfig: add MTD_PHYSMAP

Dmitry Osipenko (1):
      ARM: tegra_defconfig: Enable CONFIG_DEVFREQ_THERMAL

Enric Balletbo i Serra (2):
      arm64: defconfig: Do not override the MTK_PMIC_WRAP symbol
      arm64: defconfig: Allow Mediatek boards to boot from the mmc

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select the Wifi ath10k sdio driver

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v5.13-rc1

Joel Stanley (1):
      ARM: config: aspeed: Add DEBUG_FS and EXT4

Lad Prabhakar (1):
      arm64: defconfig: Enable ARCH_R9A07G044

Marek Szyprowski (2):
      ARM: exynos_defconfig: restore framebuffer support
      arm64: defconfig: add drivers needed for DragonBoard410c

Michael Walle (1):
      arm64: defconfig: enable Layerscape EDAC driver

Nobuhiro Iwamatsu (2):
      arm64: defconfig: Visconti: Enable PWM
      arm64: defconfig: Visconti: Enable GPIO

Olof Johansson (11):
      Merge tag 'renesas-arm-defconfig-for-v5.14-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/defconfig
      Merge tag 'omap-for-v5.14/defconfig-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.14-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/defconfig
      Merge tag 'v5.13-next-defconfig' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/defconfig
      Merge tag 'at91-defconfig-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/defconfig
      Merge tag 'samsung-defconfig-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig
      Merge tag 'tegra-for-5.14-arm-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/defconfig
      Merge tag 'visconti-arm-defconfig-for-v5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig

Sicelo A. Mhlongo (2):
      ARM: omap2plus_defconfig: Add WL1251 and WEXT modules
      ARM: omap2plus_defconfig: Add LP5523 LED driver

Vinod Koul (2):
      arm64: defconfig: qcom: enable interconnect for SM8350
      arm64: defconfig: Enable renesas usb xhci pci host controller


 arch/arm/configs/aspeed_g4_defconfig |  1 +
 arch/arm/configs/aspeed_g5_defconfig |  2 ++
 arch/arm/configs/at91_dt_defconfig   |  2 ++
 arch/arm/configs/exynos_defconfig    |  1 +
 arch/arm/configs/imx_v6_v7_defconfig |  2 ++
 arch/arm/configs/ixp4xx_defconfig    |  3 +++
 arch/arm/configs/omap2plus_defconfig |  5 +++++
 arch/arm/configs/shmobile_defconfig  |  1 -
 arch/arm/configs/tegra_defconfig     |  1 +
 arch/arm64/configs/defconfig         | 17 ++++++++++++++++-
 10 files changed, 33 insertions(+), 2 deletions(-)
