Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7693B3C2BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGIXoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGIXn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:43:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F9C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 16:41:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so9133343pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AD8YRQXXVQyAefrRg8KIpd67HaxfSvCQ8la0yF1QSNY=;
        b=1sSdYkGS9b5XpVv+gQnVpDOLucE1O6imslGUZJirY11O+zrXEBS7xuaL5q04+OLIBY
         yz7lXGBFRYZGSkRkMZLMoUbSe/UKkgLFCCA5DaFRfPs+s2iHk+hBHEIIvzJKgBj7Y5qf
         Q5Hs5YZCk3hZ8sJwK6Vm7EVz7FNJdGBOFtmTAAe82UusF2FfJEcRsj4Jjm1JWLbu6zjW
         k47WG8cFmn3HtcHQJORmuU2q0fPDTv/wtg7kCFQ79qw/tnp2xiJLtCjJYKM8Rd+R+kaU
         IauxEgNhm69P2yre5AVYQ8+x0SAXByOsceRRmtk1H+xid9uELcGNCjLHvIOGeRNJue32
         FOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AD8YRQXXVQyAefrRg8KIpd67HaxfSvCQ8la0yF1QSNY=;
        b=sEpYLO67nMd5GE3+rg5hnozeg2knFaHp5vMOT8mhBX5TVYKtd/lSghUdKO1CE6FxIw
         TcBkSZuat9wJAT+4wuQLAId+qSsA8fELVcHn6SIgyaVKvOM2o8b7HAS2XOggIORIko5r
         8EeYNm0zN6NBkijVZWkAWbJVlTskFzH3algu3wFEPJCkQvTPxzGM5q6DbCb3Pzqgf2xw
         xeY9d438urX+NZb1CySXIQD/5jzsk6RL/sU5BBECyl8ikUpfJVueA5+pNi6jJTWlALKX
         XnWhoMb2WOdIcR0tDGxC1hY2GIMNH2Z6XZqyZtdfLnmXCf2RHON6pYbeFI/XYgcsavW7
         b5qw==
X-Gm-Message-State: AOAM531hiNV9gWqabu5E+ytlW2pk07608mkwN6GsEwI9vCico/cjHmnZ
        /ijG2IP4n0r18m9WCz+Lx8TmOA==
X-Google-Smtp-Source: ABdhPJzGpzt6uNpTk9Enuv2909GESM/hD+DR8P6QarxKadgcjtVBFcCjUOpzlw+/oxg+Tv11xkVqpA==
X-Received: by 2002:a17:90a:7e18:: with SMTP id i24mr39208580pjl.130.1625874072292;
        Fri, 09 Jul 2021 16:41:12 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id n5sm2036381pfv.29.2021.07.09.16.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 16:41:10 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: Drivers for 5.14
Date:   Fri,  9 Jul 2021 16:40:53 -0700
Message-Id: <20210709234054.10288-3-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210709234054.10288-1-olof@lixom.net>
References: <20210709234054.10288-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Reset controllers: Adding support for Microchip Sparx5 Switch.

- Memory controllers: ARM Primecell PL35x SMC memory controller
driver cleanups and improvements.

- i.MX SoC drivers: Power domain support for i.MX8MM and i.MX8MN.

- Rockchip: RK3568 power domains support + DT binding updates,
cleanups.

- Qualcomm SoC drivers: Amend socinfo with more SoC/PMIC details,
including support for MSM8226, MDM9607, SM6125 and SC8180X.

- ARM FFA driver: "Firmware Framework for ARMv8-A", defining
management interfaces and communication (including bus model)
between partitions both in Normal and Secure Worlds.

- Tegra Memory controller changes, including major rework to deal
with identity mappings at boot and integration with ARM SMMU
pieces.

----------------------------------------------------------------

The following changes since commit fec22db4f904daf30d123c32b14b6ac9cd66b6d1:

  Merge tag 'arm-drivers-5.14' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-drivers-5.14

for you to fetch changes up to 2afd1c20e7547887f37f638d6b7953138d8c948e:

  Merge tag 'v5.14-rockchip-drivers1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/drivers

----------------------------------------------------------------


 .../devicetree/bindings/arm/amlogic.yaml        |    1 +
 .../devicetree/bindings/arm/bcm/bcm2835.yaml    |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml  |   13 +
 .../devicetree/bindings/arm/intel-ixp4xx.yaml   |    1 +
 .../devicetree/bindings/arm/mediatek.yaml       |   29 +-
 Documentation/devicetree/bindings/arm/qcom.yaml |   14 +
 .../devicetree/bindings/arm/renesas.yaml        |   18 +
 .../devicetree/bindings/arm/rockchip.yaml       |    5 +
 .../devicetree/bindings/arm/sunxi.yaml          |   11 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml  |   35 +
 .../bindings/clock/brcm,iproc-clocks.txt        |  313 --
 .../bindings/clock/brcm,iproc-clocks.yaml       |  395 +++
 .../bindings/clock/nvidia,tegra114-car.txt      |   63 -
 .../bindings/clock/nvidia,tegra124-car.txt      |  107 -
 .../bindings/clock/nvidia,tegra124-car.yaml     |  115 +
 .../bindings/clock/nvidia,tegra20-car.txt       |   63 -
 .../bindings/clock/nvidia,tegra20-car.yaml      |   69 +
 .../bindings/clock/nvidia,tegra210-car.txt      |   56 -
 .../bindings/clock/nvidia,tegra30-car.txt       |   63 -
 .../devicetree/bindings/i2c/i2c-at91.txt        |    2 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml    |    4 +-
 .../bindings/phy/phy-mvebu-comphy.txt           |   12 +-
 .../bindings/power/fsl,imx-gpcv2.yaml           |   10 +
 .../bindings/power/renesas,rzg2l-sysc.yaml      |   63 +
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml   |    3 +
 .../bindings/sound/allwinner,sun4i-a10-i2s.yaml |    3 +
 .../sound/allwinner,sun8i-a23-codec-analog.yaml |    9 +-
 .../timer/allwinner,sun4i-a10-timer.yaml        |   42 +-
 .../devicetree/bindings/vendor-prefixes.yaml    |    8 +
 MAINTAINERS                                     |    1 +
 arch/arm/boot/dts/Makefile                      |   13 +-
 arch/arm/boot/dts/am335x-baltos.dtsi            |    4 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts |    2 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |    2 +-
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts |    4 +-
 arch/arm/boot/dts/am335x-cm-t335.dts            |    4 +-
 arch/arm/boot/dts/am335x-evm.dts                |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |    4 +-
 arch/arm/boot/dts/am335x-icev2.dts              |    4 +-
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |    2 +-
 .../boot/dts/am335x-moxa-uc-8100-common.dtsi    |    2 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |  132 +-
 arch/arm/boot/dts/am335x-shc.dts                |    8 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                |   34 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |    9 +-
 arch/arm/boot/dts/am437x-l4.dtsi                |   49 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |    6 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts       |   13 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |    2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts     |   15 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts        |  119 +-
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts  |   59 +-
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts |    2 +-
 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts  |    2 +-
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts    |    2 +-
 .../arm/boot/dts/aspeed-bmc-bytedance-g220a.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |    2 +-
 .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts    | 2060 +++++++++++-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts |   30 -
 .../arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts |    2 +-
 .../arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts   |    2 +-
 .../arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts |    2 +-
 .../boot/dts/aspeed-bmc-microsoft-olympus.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts    |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts      |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts     |    2 +-
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts      |    2 +-
 .../boot/dts/aspeed-bmc-portwell-neptune.dts    |    2 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts    |    2 +-
 .../boot/dts/aspeed-bmc-supermicro-x11spi.dts   |    2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                |    1 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi        |   10 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               |    2 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts           |   85 +-
 arch/arm/boot/dts/bcm2711-rpi-400.dts           |   45 +
 arch/arm/boot/dts/bcm2711-rpi.dtsi              |   74 +
 arch/arm/boot/dts/bcm2711.dtsi                  |    3 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts        |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts             |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi          |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts        |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts          |    2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |    4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts      |    4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts      |    4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts           |    2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi          |    2 +-
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi      |    2 +-
 .../boot/dts/bcm283x-rpi-usb-peripheral.dtsi    |    2 +-
 arch/arm/boot/dts/bcm283x.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |    4 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |    4 +-
 arch/arm/boot/dts/bcm47094.dtsi                 |    2 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi        |    4 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |   26 +-
 arch/arm/boot/dts/bcm63138.dtsi                 |    2 +-
 arch/arm/boot/dts/bcm7445-bcm97445svmb.dts      |    4 +-
 arch/arm/boot/dts/bcm7445.dtsi                  |    2 +-
 arch/arm/boot/dts/bcm911360_entphn.dts          |    4 +-
 arch/arm/boot/dts/bcm953012k.dts                |    4 +-
 arch/arm/boot/dts/bcm958300k.dts                |    4 +-
 arch/arm/boot/dts/bcm958305k.dts                |    4 +-
 arch/arm/boot/dts/bcm958522er.dts               |    4 +-
 arch/arm/boot/dts/bcm958525er.dts               |    4 +-
 arch/arm/boot/dts/bcm958525xmc.dts              |    4 +-
 arch/arm/boot/dts/bcm958622hr.dts               |    4 +-
 arch/arm/boot/dts/bcm958623hr.dts               |    4 +-
 arch/arm/boot/dts/bcm958625hr.dts               |    4 +-
 arch/arm/boot/dts/bcm958625k.dts                |    4 +-
 arch/arm/boot/dts/bcm963138dvt.dts              |    4 +-
 arch/arm/boot/dts/bcm988312hr.dts               |    4 +-
 arch/arm/boot/dts/da850.dtsi                    |   21 +-
 arch/arm/boot/dts/dm816x.dtsi                   |    6 +-
 arch/arm/boot/dts/dra7-evm.dts                  |    8 +-
 arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi      |    6 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  |   30 +-
 arch/arm/boot/dts/dra71-evm.dts                 |    2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |    6 +-
 arch/arm/boot/dts/dra72x.dtsi                   |    6 +-
 arch/arm/boot/dts/dra74-ipu-dsp-common.dtsi     |    2 +-
 arch/arm/boot/dts/dra74x.dtsi                   |    8 +-
 arch/arm/boot/dts/dra76-evm.dts                 |   43 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    2 +-
 arch/arm/boot/dts/exynos4210-i9100.dts          |    8 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    2 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |    1 +
 arch/arm/boot/dts/exynos4412-midas.dtsi         |    1 +
 arch/arm/boot/dts/exynos4412-n710x.dts          |    4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    1 +
 arch/arm/boot/dts/exynos4412-origen.dts         |    1 +
 arch/arm/boot/dts/exynos4412-p4note.dtsi        |    1 +
 arch/arm/boot/dts/exynos5250-arndale.dts        |    1 +
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |    1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |    1 +
 arch/arm/boot/dts/exynos5422-odroidhc1.dts      |    2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      |    2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi |    4 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      |   11 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts      |    4 +-
 arch/arm/boot/dts/gemini-nas4220b.dts           |    2 +-
 arch/arm/boot/dts/gemini-rut1xx.dts             |   14 +-
 arch/arm/boot/dts/gemini-sl93512r.dts           |    6 +-
 arch/arm/boot/dts/gemini-sq201.dts              |    6 +-
 arch/arm/boot/dts/gemini-wbd111.dts             |    2 +-
 arch/arm/boot/dts/gemini-wbd222.dts             |    2 +-
 arch/arm/boot/dts/gemini.dtsi                   |   13 +-
 arch/arm/boot/dts/hi3620.dtsi                   |    4 +-
 arch/arm/boot/dts/hip01-ca9x2.dts               |    4 +-
 arch/arm/boot/dts/hip01.dtsi                    |    4 +-
 arch/arm/boot/dts/hip04.dtsi                    |    4 +-
 arch/arm/boot/dts/hisi-x5hd2-dkb.dts            |    2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi               |    2 +-
 arch/arm/boot/dts/imx25-pinfunc.h               |   12 +-
 arch/arm/boot/dts/imx28-lwe.dtsi                |  170 +
 arch/arm/boot/dts/imx28-xea.dts                 |   99 +
 .../boot/dts/imx51-digi-connectcore-som.dtsi    |    2 +-
 arch/arm/boot/dts/imx53-ard.dts                 |    2 +-
 arch/arm/boot/dts/imx6dl-b105pv2.dts            |   32 +
 arch/arm/boot/dts/imx6dl-b105v2.dts             |   32 +
 arch/arm/boot/dts/imx6dl-b125pv2.dts            |   30 +
 arch/arm/boot/dts/imx6dl-b125v2.dts             |   30 +
 arch/arm/boot/dts/imx6dl-b155v2.dts             |   32 +
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi           |  413 +++
 arch/arm/boot/dts/imx6dl-b1x5v2.dtsi            |   58 +
 arch/arm/boot/dts/imx6dl-plym2m.dts             |    6 +-
 arch/arm/boot/dts/imx6dl-prtvt7.dts             |   36 +-
 arch/arm/boot/dts/imx6dl-qmx6.dtsi              |  612 ++++
 arch/arm/boot/dts/imx6dl-riotboard.dts          |    2 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi      |    3 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi          |   71 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts         |    2 +-
 arch/arm/boot/dts/imx6q-ds.dts                  |   17 +
 arch/arm/boot/dts/imx6qdl-ds.dtsi               |  458 +++
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |    5 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |   10 +
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi           |   41 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi  |    1 -
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |   50 +-
 arch/arm/boot/dts/imx7d-sdb.dts                 |    7 +
 .../arm/boot/dts/intel-ixp42x-linksys-nslu2.dts |   79 +-
 .../boot/dts/intel-ixp42x-welltech-epbx100.dts  |   76 +
 arch/arm/boot/dts/intel-ixp42x.dtsi             |    4 +
 .../boot/dts/intel-ixp43x-gateworks-gw2358.dts  |  104 +-
 arch/arm/boot/dts/intel-ixp43x.dtsi             |    4 +
 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi      |   33 +
 arch/arm/boot/dts/intel-ixp4xx.dtsi             |   92 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts          |   11 +-
 arch/arm/boot/dts/keystone-k2g.dtsi             |    6 +-
 arch/arm/boot/dts/meson.dtsi                    |    1 +
 arch/arm/boot/dts/mstar-v7.dtsi                 |   14 +
 arch/arm/boot/dts/omap2.dtsi                    |    4 -
 arch/arm/boot/dts/omap2420.dtsi                 |    5 +-
 arch/arm/boot/dts/omap2430.dtsi                 |    2 +-
 .../boot/dts/omap3-evm-processor-common.dtsi    |    2 +-
 arch/arm/boot/dts/omap3-gta04a5.dts             |    2 +-
 arch/arm/boot/dts/omap3.dtsi                    |    8 +-
 arch/arm/boot/dts/omap4-l4.dtsi                 |    4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi       |    2 +-
 arch/arm/boot/dts/omap5-l4.dtsi                 |    4 +-
 arch/arm/boot/dts/openbmc-flash-layout-64.dtsi  |   18 +-
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts       |   58 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi             |  425 +++
 arch/arm/boot/dts/r8a7742.dtsi                  |    6 +-
 arch/arm/boot/dts/r8a7743.dtsi                  |    4 +-
 arch/arm/boot/dts/r8a7744.dtsi                  |    4 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |    4 +-
 arch/arm/boot/dts/r8a77470.dtsi                 |    4 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |    3 +
 arch/arm/boot/dts/r8a7779-marzen.dts            |    2 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |    4 +
 arch/arm/boot/dts/r8a7790-lager.dts             |    8 +
 arch/arm/boot/dts/r8a7790.dtsi                  |   10 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    4 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |    4 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |    8 +
 arch/arm/boot/dts/r8a7792.dtsi                  |    4 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |   10 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |    3 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |   42 +
 arch/arm/boot/dts/r8a7794-silk.dts              |   10 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |    4 +-
 arch/arm/boot/dts/rk3036-kylin.dts              |    2 +-
 arch/arm/boot/dts/rk3036.dtsi                   |   72 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |    5 +
 arch/arm/boot/dts/rk3066a-marsboard.dts         |    4 +
 arch/arm/boot/dts/rk3066a-mk808.dts             |    5 +
 arch/arm/boot/dts/rk3066a-rayeager.dts          |    8 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |   71 +-
 arch/arm/boot/dts/rk3188-bqedison2qc.dts        |    6 +
 arch/arm/boot/dts/rk3188-px3-evb.dts            |    5 +
 arch/arm/boot/dts/rk3188-radxarock.dts          |    4 +
 arch/arm/boot/dts/rk3188.dtsi                   |   74 +-
 arch/arm/boot/dts/rk322x.dtsi                   |  158 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |    2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts              |    4 +-
 arch/arm/boot/dts/rk3288.dtsi                   |   18 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   17 +-
 arch/arm/boot/dts/rv1108.dtsi                   |    2 +-
 arch/arm/boot/dts/s5pv210-goni.dts              |    9 -
 arch/arm/boot/dts/sama5d4.dtsi                  |    2 +-
 arch/arm/boot/dts/sd5203.dts                    |    2 +-
 arch/arm/boot/dts/ste-ab8500.dtsi               |   28 +-
 arch/arm/boot/dts/ste-ab8505.dtsi               |   24 +-
 arch/arm/boot/dts/ste-href-ab8500.dtsi          |    2 +-
 arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi   |    6 +
 arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi   |    4 +-
 arch/arm/boot/dts/ste-href.dtsi                 |    2 +-
 arch/arm/boot/dts/ste-snowball.dts              |    2 +-
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts  |    3 +-
 arch/arm/boot/dts/ste-ux500-samsung-janice.dts  |   11 +-
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts  |    3 +-
 arch/arm/boot/dts/stm32429i-eval.dts            |    8 +-
 arch/arm/boot/dts/stm32746g-eval.dts            |    6 +-
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi          |    2 +-
 arch/arm/boot/dts/stm32f429-disco.dts           |    6 +-
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi        |   72 +-
 arch/arm/boot/dts/stm32f429.dtsi                |   10 +-
 arch/arm/boot/dts/stm32f469-disco.dts           |    6 +-
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi        |   74 +-
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi          |    2 +-
 arch/arm/boot/dts/stm32f746.dtsi                |   12 +-
 arch/arm/boot/dts/stm32f769-disco.dts           |    6 +-
 arch/arm/boot/dts/stm32h743.dtsi                |    4 -
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi        |   33 +
 arch/arm/boot/dts/stm32mp151.dtsi               |   16 +-
 ...mp157a-microgea-stm32mp1-microdev2.0-of7.dts |    2 +-
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi    |    7 +-
 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi  |    7 +-
 arch/arm/boot/dts/stm32mp157c-odyssey.dts       |    2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi   |    7 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi    |   17 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi    |    2 +-
 arch/arm/boot/dts/stm32mp15xx-osd32.dtsi        |    7 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                |    4 +-
 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi        |  106 +
 arch/arm/boot/dts/sun8i-r40-oka40i-c.dts        |  203 ++
 arch/arm/boot/dts/sun8i-r40.dtsi                |   56 +
 arch/arm/boot/dts/sun8i-v3.dtsi                 |   31 +
 .../boot/dts/sun8i-v3s-licheepi-zero-dock.dts   |   17 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                |   48 +
 arch/arm/boot/dts/tegra124.dtsi                 |    3 +-
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts |   21 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |    2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts       |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |   43 +-
 arch/arm/boot/dts/tegra20-plutux.dts            |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |    2 +-
 arch/arm/boot/dts/tegra20-tec.dts               |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts           |    2 +-
 .../dts/tegra30-asus-nexus7-grouper-common.dtsi |   16 +-
 .../tegra30-asus-nexus7-grouper-maxim-pmic.dtsi |    9 +
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi    |   11 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    2 +-
 arch/arm/boot/dts/tegra30-ouya.dts              |    4 +-
 arch/arm/boot/dts/tegra30.dtsi                  |    3 +-
 arch/arm64/boot/dts/allwinner/Makefile          |    1 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi     |   25 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   62 +-
 .../dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts   |  195 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |    9 +
 arch/arm64/boot/dts/amlogic/Makefile            |    1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |    1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi      |    1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |    1 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi     |   41 +-
 .../boot/dts/amlogic/meson-sm1-bananapi-m5.dts  |  646 ++++
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts |   13 +
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts    |   17 -
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts   |   48 +-
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi      |    9 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi      |   10 +
 arch/arm64/boot/dts/arm/juno-base.dtsi          |    6 +-
 arch/arm64/boot/dts/broadcom/Makefile           |    3 +-
 .../arm64/boot/dts/broadcom/bcm2711-rpi-400.dts |    2 +
 .../boot/dts/broadcom/bcm4908/bcm4908.dtsi      |    2 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi    |    8 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |    1 +
 arch/arm64/boot/dts/freescale/Makefile          |    1 +
 .../boot/dts/freescale/fsl-ls1012a-frwy.dts     |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |   14 +-
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |   24 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |   12 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |   24 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |   24 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |   16 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi  |   16 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |    1 -
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |   24 +-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi |   50 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi   |    1 +
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts | 1019 ++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |  363 +-
 .../boot/dts/freescale/imx8mn-beacon-som.dtsi   |    3 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi   |    1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi       |  147 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts    |  139 +
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi  |   25 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi       |   18 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |    1 +
 .../boot/dts/freescale/imx8mq-nitrogen.dts      |  182 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |   16 +
 .../boot/dts/hisilicon/hi3660-coresight.dtsi    |    2 +-
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |    2 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |    2 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts      |    2 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi       |    2 +-
 .../boot/dts/hisilicon/hi6220-coresight.dtsi    |    2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |    2 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |    2 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts     |    2 +-
 arch/arm64/boot/dts/hisilicon/hip05.dtsi        |    2 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts     |    2 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi        |    2 +-
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts     |    2 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi        |    2 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts |    6 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |    8 +
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi   |    3 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dts       |    2 +-
 arch/arm64/boot/dts/mediatek/Makefile           |    8 +
 arch/arm64/boot/dts/mediatek/mt8167.dtsi        |  121 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   60 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     |    5 +
 .../mediatek/mt8183-kukui-jacuzzi-burnet.dts    |   30 +
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts        |   44 +
 .../mt8183-kukui-jacuzzi-fennel-sku6.dts        |   32 +
 .../mediatek/mt8183-kukui-jacuzzi-fennel.dtsi   |   27 +
 .../mediatek/mt8183-kukui-jacuzzi-fennel14.dts  |   16 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts |   16 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts |   12 +
 .../mt8183-kukui-jacuzzi-willow-sku0.dts        |   13 +
 .../mt8183-kukui-jacuzzi-willow-sku1.dts        |   12 +
 .../mediatek/mt8183-kukui-jacuzzi-willow.dtsi   |   26 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi |    8 +
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  |    4 +
 .../boot/dts/mediatek/mt8183-kukui-kodama.dtsi  |    4 +
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi   |    4 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  |   23 +
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts |    5 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        |  110 +-
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |    4 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |    4 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |    4 +-
 .../boot/dts/nvidia/tegra194-p3509-0000.dtsi    |  595 +++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  100 +
 .../boot/dts/nvidia/tegra210-p2371-2180.dts     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi  |    2 +-
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |    4 +-
 arch/arm64/boot/dts/qcom/Makefile               |   15 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |   93 +-
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts    |   24 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts    |   11 +
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts    |   10 +
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi      |   76 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi           |   20 +-
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts   |   26 +
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts  |  454 +++
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi  |  131 +
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts   |   47 +
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts   |   26 +
 .../boot/dts/qcom/msm8994-angler-rev-101.dts    |    4 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi       |    2 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi      |  653 ----
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |  999 +++++-
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi            |   24 +
 arch/arm64/boot/dts/qcom/pm7325.dtsi            |   53 +
 arch/arm64/boot/dts/qcom/pm8150.dtsi            |   12 +-
 arch/arm64/boot/dts/qcom/pm8350c.dtsi           |   32 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi            |    8 +-
 arch/arm64/boot/dts/qcom/pmi8994.dtsi           |   13 +
 arch/arm64/boot/dts/qcom/pmk8350.dtsi           |   51 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi       |  135 +
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi       |  108 +
 arch/arm64/boot/dts/qcom/pmr735a.dtsi           |   32 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |    2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |    4 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts        |   98 +-
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts        |  360 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts         |  169 +-
 .../dts/qcom/sc7180-trogdor-coachz-r1-lte.dts   |    4 +-
 .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts  |   22 +-
 ...lte.dts => sc7180-trogdor-coachz-r3-lte.dts} |    6 +-
 ...achz-r2.dts => sc7180-trogdor-coachz-r3.dts} |    4 +-
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi    |   64 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts   |    9 -
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts   |    9 -
 .../boot/dts/qcom/sc7180-trogdor-lazor-r3.dts   |    9 -
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi     |    9 +
 .../boot/dts/qcom/sc7180-trogdor-pompom-r1.dts  |   12 +
 .../dts/qcom/sc7180-trogdor-pompom-r2-lte.dts   |    4 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom-r2.dts  |   38 +-
 .../dts/qcom/sc7180-trogdor-pompom-r3-lte.dts   |   14 +
 .../boot/dts/qcom/sc7180-trogdor-pompom-r3.dts  |   15 +
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi    |   29 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi    |  121 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi            |  142 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |   36 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi            | 1171 +++++++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi      |    4 -
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |    5 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi    |   18 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts   |  114 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |    4 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts   |    2 +
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts         |   28 +-
 .../dts/qcom/sm8150-microsoft-surface-duo.dts   |  543 +++
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts         |   28 +-
 .../qcom/sm8150-sony-xperia-kumano-bahamut.dts  |   19 +
 .../qcom/sm8150-sony-xperia-kumano-griffin.dts  |   13 +
 .../dts/qcom/sm8150-sony-xperia-kumano.dtsi     |  452 +++
 arch/arm64/boot/dts/qcom/sm8150.dtsi            |   78 +-
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts         |   33 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts         |   10 +
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts  |   15 +
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts  |   35 +
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi   |  636 ++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi            |  192 +-
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts         |    6 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi            |   64 +-
 arch/arm64/boot/dts/renesas/Makefile            |    2 +
 .../dts/renesas/beacon-renesom-baseboard.dtsi   |    4 +-
 .../boot/dts/renesas/beacon-renesom-som.dtsi    |    8 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |    2 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77951.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77960.dtsi       |    8 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi       |   19 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts  |    8 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts  |    2 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |    8 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |    1 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |    1 +
 .../dts/renesas/r8a779a0-falcon-csi-dsi.dtsi    |   21 +
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi       |    7 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi      |  132 +
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi    |   25 +
 .../boot/dts/renesas/r9a07g044l2-smarc.dts      |   21 +
 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi    |   13 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi    |   27 +
 arch/arm64/boot/dts/rockchip/Makefile           |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi          |   28 +-
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts  |    4 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi        |   74 +-
 .../boot/dts/rockchip/rk3326-odroid-go2.dts     |   37 +-
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts     |   36 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts  |    9 +-
 .../boot/dts/rockchip/rk3328-rock-pi-e.dts      |    7 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts  |    5 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |   13 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |    2 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |  162 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi   |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    |    4 +-
 .../boot/dts/rockchip/rk3399-kobol-helios64.dts |  121 +
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts     |    2 +-
 .../arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi |    1 -
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi |   16 +
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi     |    1 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   66 +-
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi  |    1 -
 .../arm64/boot/dts/rockchip/rk3568-evb1-v10.dts |   79 +
 .../arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi | 3111 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi        |  593 ++++
 .../boot/dts/rockchip/rockchip-pinconf.dtsi     |  344 ++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        |  222 +-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi         |    6 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts         |  110 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts          |  121 +
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi     |   63 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |   37 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         |    2 -
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      |    2 -
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts     |    5 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   49 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts  |    2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |   25 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |    6 -
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  |   62 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  126 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |    4 -
 .../arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts |    8 +
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi       |    9 +
 arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi  |    5 +
 include/dt-bindings/mailbox/qcom-ipcc.h         |    1 +
 include/dt-bindings/pinctrl/hisi.h              |    2 +-
 552 files changed, 24060 insertions(+), 3691 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,iproc-clocks.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-car.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra210-car.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-400.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-lwe.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-xea.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b105pv2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b105v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b125pv2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b125v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b155v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-b1x5v2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-qmx6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-ds.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-ds.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-welltech-epbx100.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-r40-oka40i-c.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8155p-adp.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-coachz-r2-lte.dts => sc7180-trogdor-coachz-r3-lte.dts} (69%)
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-coachz-r2.dts => sc7180-trogdor-coachz-r3.dts} (75%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rockchip-pinconf.dtsi
