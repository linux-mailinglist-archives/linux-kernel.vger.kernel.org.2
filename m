Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA63C2BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhGIXny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhGIXnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:43:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E04C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 16:41:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t9so11502750pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrt3LSYck7HI2PISkZ8fU++hKW76usCeqgFovHDkJWg=;
        b=BwUz3RhlsctUmer20wZL1Rc9Bh1vVIrk3eucPvm9K8wcaBHawMZSxYCa9A6RZ9FNjL
         RZio/tLAWX4WaMbB14oNLWOO2O21Ood6DMb4PDQhkn95vXJryVfrtONluWVrxbICiIo9
         DFSWTuRR0spA/i9m7efFmp24H+/i3vaV92UNx1S/hU9qOAtdcugdrFQ8f5RdOcVsFjm8
         K09ZLQHPAEEq6N6wEPOzwPBTBfLEpJ7os4AD70z9uubwkM60vFjcAhQrVxz49WQtl26/
         icKh7RRMSkoMa13k3n8Zc8e7KS0KXWw6Wi8xKB+6Ydhbmi65ywSvENQgaqum2I+t2XJh
         bjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrt3LSYck7HI2PISkZ8fU++hKW76usCeqgFovHDkJWg=;
        b=ZUmJaj17FeDbonUaKcxB62EnlZ2Gz4ckBtT7l+nsROT6SFVi7SC/78AvmTrWzIqvgC
         hqZO8q9eYvPOP9rsVFoVcEspx0fOYE+H10hbUqJA2w6psijqFkCaJ8h2Pu21Dfht3Qeq
         bJRu3AKjXkPwvPwAk1SKkrN5ewIijM58IoukRMgWRV3otB/eM2z85h13k4Na/Aej2zl6
         lJTTwcNoOqK1+maWhml+SYJ+gbENumW51rOWWi/l00ofDvsJcnVZFEefjx67CMMaNGKu
         KwSeE4Qb8rH5WodTsJd4pJuTByYCUdUXhQRphZU/kfQS3SiheIhHggXoCqQAdf20JMTW
         gvsw==
X-Gm-Message-State: AOAM5329ph1jeQ4b0Gmxfk1gSln5U7+8bIUSHeDJsDDCMVuwJTNQwWCR
        s8TSJ1NJoB0wmADoYcjv32mjQHb7miYJKQ==
X-Google-Smtp-Source: ABdhPJyAZyxFkURjt+l/ydhnm44jaZq1Rt1O7ZOLaAV/Fh0zNVifazzxinAovmkuKDDJv/goV+D/7w==
X-Received: by 2002:aa7:88d4:0:b029:329:be20:a5c with SMTP id k20-20020aa788d40000b0290329be200a5cmr796227pff.61.1625874067201;
        Fri, 09 Jul 2021 16:41:07 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id n5sm2036381pfv.29.2021.07.09.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:41:05 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/4] ARM: SoC changes for 5.14
Date:   Fri,  9 Jul 2021 16:40:51 -0700
Message-Id: <20210709234054.10288-1-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few SoC (code) changes have queued up this cycle, mostly for minor
changes and some refactoring and cleanup of legacy platforms. This
branch also contains a few of the fixes that weren't sent in by the end
of the release (all fairly minor).

- Adding an additional maintainer for the TEE subsystem (Sumit Garg)

- Quite a significant modernization of the IXP4xx platforms by Linus
Walleij, revisiting with a new PCI host driver/binding, removing legacy
mach/* include dependencies and moving platform detection/config to
drivers/soc. Also some updates/cleanup of platform data.

- Core power domain support for Tegra platforms, and some improvements
in build test coverage by adding stubs for compile test targets.

- A handful of updates to i.MX platforms, adding legacy (non-PSCI) SMP
support on i.MX7D, SoC ID setup for i.MX50, removal of platform data
and board fixups for iMX6/7.

... and a few smaller changes and fixes for Samsung, OMAP, Allwinner,
Rockchip.

----------------------------------------------------------------

The following changes since commit 50be9417e23af5a8ac860d998e1e3f06b8fd79d7:

  Merge tag 'io_uring-5.14-2021-07-09' of git://git.kernel.dk/linux-block

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-soc-5.14

for you to fetch changes up to 42accadb3265f4569620cde217ff448b568b2822:

  Merge branch 'arm/fixes' into arm/soc

----------------------------------------------------------------

Alejandro Lucero (1):
      ARM: OMAP2+: remove duplicated prototype

Anson Huang (1):
      ARM: imx: add smp support for imx7d

Arnd Bergmann (3):
      soc: ixp4xx: move cpu detection to linux/soc/ixp4xx/cpu.h
      pata: ixp4xx: split platform data to its own header
      hw_random: ixp4xx: enable compile-testing

Colin Ian King (1):
      ixp4xx: fix spelling mistake in Kconfig "Devce" -> "Device"

Daniel Palmer (1):
      MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree

Dario Binacchi (2):
      ARM: OMAP2+: CM: remove omap2_set_globals_cm()
      ARM: OMAP2+: remove omap2_set_globals_control()

Dmitry Osipenko (7):
      soc/tegra: regulators: Bump voltages on system reboot
      soc/tegra: Add stub for soc_is_tegra()
      soc/tegra: Add devm_tegra_core_dev_init_opp_table()
      soc/tegra: fuse: Add stubs needed for compile-testing
      soc/tegra: pmc: Add core power domain
      soc/tegra: pmc: Add driver state syncing
      soc/tegra: regulators: Support core domain state syncing

Gowtham Tammana (1):
      ARM: dts: dra7: Fix duplicate USB4 target module node

Icenowy Zheng (1):
      arm64: dts: allwinner: a64-sopine-baseboard: change RGMII mode to TXID

Jonathan Neuschäfer (2):
      ARM: imx: pm-imx5: Fix references to imx5_cpu_suspend_info
      ARM: imx: Initialize SoC ID on i.MX50

Juerg Haefliger (1):
      ARM: OMAP1: Remove leading spaces in Kconfig

Krzysztof Kozlowski (3):
      ARM: exynos: add missing of_node_put for loop iteration
      soc: samsung: pmu: drop EXYNOS_CENTRAL_SEQ_OPTION defines
      MAINTAINERS: Include Samsung PWM in Samsung SoC entry

Linus Walleij (9):
      ARM: dts: ux500: Fix LED probing
      ARM/ixp4xx: Move the virtual IObases
      ARM/ixp4xx: Make NEED_MACH_IO_H optional
      PCI: ixp4xx: Add device tree bindings for IXP4xx
      PCI: ixp4xx: Add a new driver for IXP4xx
      hw_random: ixp4xx: Use SPDX license tag
      hw_random: ixp4xx: Turn into a module
      hw_random: ixp4xx: Add DT bindings
      hw_random: ixp4xx: Add OF support

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete OMAP HWMOD DATA FOR OMAP4-BASED DEVICES

Manivannan Sadhasivam (2):
      ARM: dts: qcom: sdx55-t55: Represent secure-regions as 64-bit elements
      ARM: dts: qcom: sdx55-telit: Represent secure-regions as 64-bit elements

Marco Felsch (1):
      ARM: imx6q: drop of_platform_default_populate() from init_machine

Oleksij Rempel (7):
      ARM: imx6q: remove PHY fixup for KSZ9031
      ARM: imx6q: remove part of ar8031_phy_fixup()
      ARM: imx6q: remove BMCR_PDOWN handler in ar8035_phy_fixup()
      ARM: imx6q: remove clk-out fixup for the Atheros AR8031 and AR8035 PHYs
      ARM: imx6q: remove Atheros AR8035 SmartEEE fixup
      ARM: imx6sx: remove Atheros AR8031 PHY fixup
      ARM: imx7d: remove Atheros AR8031 PHY fixup

Olof Johansson (13):
      Merge tag 'omap-for-v5.14/cleanup-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/soc
      Merge tag 'samsung-soc-5.14' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/soc
      Merge tag 'sunxi-fixes-for-5.13-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'sunxi-core-for-5.14-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/soc
      Merge tag 'v5.13-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'imx-soc-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/soc
      Merge tag 'qcom-dts-fixes-for-5.13' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'tegra-for-5.14-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/soc
      Merge tag 'omap-for-v5.13/fixes-rc6-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'omap-for-v5.14/fixes-not-urgent-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/soc
      Merge tag 'ixp4xx-arm-soc-v5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik into arm/soc
      Merge tag 'tee-reviewer-for-v5.13' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/fixes
      Merge branch 'arm/fixes' into arm/soc

Punit Agrawal (1):
      arm64: dts: rockchip: Update RK3399 PCI host bridge window to 32-bit address memory

Romain Perier (1):
      ARM: debug: add UART early console support for MSTAR SoCs

Salvatore Bonaccorso (1):
      ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode

Samuel Holland (1):
      arm64: sunxi: Build the sun4i timer driver

Sumit Garg (1):
      MAINTAINERS: Add myself as TEE subsystem reviewer

Thierry Reding (2):
      Merge branch 'for-5.14/regulator' into for-5.14/soc
      soc/tegra: fuse: Fix Tegra234-only builds

Tony Lindgren (2):
      Merge branch 'omap-for-v5.13/genpd-cleanup' into omap-for-v5.14/cleanup
      ARM: OMAP2+: Block suspend for am3 and am4 if PM is not configured

Wan Jiabing (1):
      ARM: s3c: Remove unnecessary break in RX1950

Yang Yingliang (1):
      soc/tegra: fuse: Don't return -ENOMEM when allocate lookups failed


 .../bindings/pci/intel,ixp4xx-pci.yaml          | 100 +++
 .../bindings/rng/intel,ixp46x-rng.yaml          |  36 +
 MAINTAINERS                                     |  18 +-
 arch/arm/Kconfig                                |   3 +-
 arch/arm/Kconfig.debug                          |  15 +-
 arch/arm/boot/dts/am5718.dtsi                   |   6 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  |  22 -
 arch/arm/boot/dts/dra71x.dtsi                   |   4 -
 arch/arm/boot/dts/dra72x.dtsi                   |   4 -
 arch/arm/boot/dts/dra74x.dtsi                   |  92 +--
 arch/arm/boot/dts/qcom-sdx55-t55.dts            |   2 +-
 .../arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts |   4 +-
 arch/arm/boot/dts/ste-href.dtsi                 |   7 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    |   2 +-
 arch/arm/mach-exynos/exynos.c                   |   2 +
 arch/arm/mach-imx/Makefile                      |   2 +-
 arch/arm/mach-imx/common.h                      |   3 +
 arch/arm/mach-imx/headsmp.S                     |   9 +
 arch/arm/mach-imx/hotplug.c                     |   3 +
 arch/arm/mach-imx/mach-imx50.c                  |   7 +
 arch/arm/mach-imx/mach-imx6q.c                  |  88 ---
 arch/arm/mach-imx/mach-imx6sx.c                 |  26 -
 arch/arm/mach-imx/mach-imx7d.c                  |  25 +-
 arch/arm/mach-imx/platsmp.c                     |  26 +
 arch/arm/mach-imx/src.c                         | 101 ++-
 arch/arm/mach-imx/suspend-imx53.S               |   4 +-
 arch/arm/mach-ixp4xx/Kconfig                    |  35 +-
 arch/arm/mach-ixp4xx/avila-setup.c              |   1 +
 arch/arm/mach-ixp4xx/common.c                   |  47 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                |   1 +
 arch/arm/mach-ixp4xx/include/mach/cpu.h         |  54 --
 arch/arm/mach-ixp4xx/include/mach/hardware.h    |   2 +-
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h |  61 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h    |  14 -
 arch/arm/mach-ixp4xx/ixp4xx-of.c                |   8 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c            |   1 +
 arch/arm/mach-ixp4xx/nslu2-setup.c              |   1 +
 arch/arm/mach-omap1/Kconfig                     |  12 +-
 arch/arm/mach-omap2/cm.h                        |   1 -
 arch/arm/mach-omap2/cm_common.c                 |  13 -
 arch/arm/mach-omap2/common.h                    |   1 -
 arch/arm/mach-omap2/control.c                   |   5 -
 arch/arm/mach-omap2/control.h                   |   1 -
 arch/arm/mach-omap2/pm33xx-core.c               |  40 ++
 arch/arm/mach-s3c/mach-rx1950.c                 |   1 -
 arch/arm64/Kconfig.platforms                    |   1 +
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   2 +-
 drivers/ata/Kconfig                             |   2 +-
 drivers/ata/pata_ixp4xx_cf.c                    |   1 +
 drivers/char/hw_random/Kconfig                  |   2 +-
 drivers/char/hw_random/ixp4xx-rng.c             |  53 +-
 drivers/crypto/ixp4xx_crypto.c                  |   4 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c        |   2 +
 drivers/net/ethernet/xscale/ptp_ixp46x.c        |   3 +-
 drivers/net/wan/ixp4xx_hss.c                    |   1 +
 drivers/pci/controller/Kconfig                  |   8 +
 drivers/pci/controller/Makefile                 |   1 +
 drivers/pci/controller/pci-ixp4xx.c             | 671 +++++++++++++++++++
 drivers/soc/imx/soc-imx.c                       |   3 +
 drivers/soc/ixp4xx/ixp4xx-npe.c                 |   2 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                |   2 +
 drivers/soc/tegra/Kconfig                       |   2 +
 drivers/soc/tegra/common.c                      |  97 +++
 drivers/soc/tegra/fuse/fuse-tegra.c             |   6 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c           |   3 +-
 drivers/soc/tegra/pmc.c                         | 144 ++++
 drivers/soc/tegra/regulators-tegra20.c          |  94 ++-
 drivers/soc/tegra/regulators-tegra30.c          |  93 ++-
 include/linux/platform_data/pata_ixp4xx_cf.h    |  21 +
 include/linux/soc/ixp4xx/cpu.h                  | 106 +++
 include/linux/soc/samsung/exynos-regs-pmu.h     |   6 -
 include/soc/imx/cpu.h                           |   1 +
 include/soc/tegra/common.h                      |  31 +
 include/soc/tegra/fuse.h                        |  20 +-
 include/soc/tegra/pmc.h                         |   7 +
 76 files changed, 1841 insertions(+), 460 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 create mode 100644 Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/cpu.h
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c
 create mode 100644 include/linux/platform_data/pata_ixp4xx_cf.h
 create mode 100644 include/linux/soc/ixp4xx/cpu.h
