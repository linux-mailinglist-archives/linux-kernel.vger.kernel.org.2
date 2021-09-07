Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26B3402A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhIGNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbhIGNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:53:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C574C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 06:52:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z4so14565316wrr.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=9tfgIwGkcklR8RrhlQPhAgJqh4xrS4CrFVr1iQLgRu4=;
        b=lvhalh+NF+5bD+ihZuK+oIK9CkhyOmKsKh2daW+5jc4521Y2N9Czz5Jo3yhZ1nmY6A
         kYAqeauKPEWW2toNC8nG2wZs3WUczw4IGzSDJ5KeB2GllzVHgeZrF3+5pq68fol/Fr4R
         I2DajrBw5qudIOKsNY1uam7jnkWQNSDZzR06MG1DFpOnU4Z39UrZCPBSHteeF2d2PB/y
         eFHw7MExa/BoVOrC8wRa3syzKXIIQ3uJFLD4LlTScSAbD5N/tTVTOTVwjaWK5XxYmXe5
         Bi0E1xgST1mtpfeF5vZrHU/BBgva8EqpEWbAHcK2uG7UfxmbQn7+PvEerv2zDWEjwH4q
         VHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=9tfgIwGkcklR8RrhlQPhAgJqh4xrS4CrFVr1iQLgRu4=;
        b=YfS1vMb/j9muFkp+1nKm2DIPvWQs3TSw64GvaDO/SQm35mNMEJffJbuNeGcIE9FuaR
         D+Qzjqv/diSO24jEl8GqcxYjN5kMoFRCWLzFb5E5L/sNyTWvTGhFROa/3AEo3fQly32z
         mHLd7bBLWqswgKb+r/BKV6JSJO11ufArZ93Qz60kLhEZe3Uz3gyDxj27rTzn6yqPPNBs
         Y554flnHIActC9hLCvDik3BfrUIYBV5pgDMai06fu4Q1CuzS2Urxz7yKym9dsWkBDM+h
         MBPPrFcCAn4DEmHQOzgZS3r5Cw9vZsXXhqEx5mwNB+haOySETyNVNQ6Iuw3vNDPFd5zb
         F6zQ==
X-Gm-Message-State: AOAM533dH+NaZp7cyr2cESWZwdrw1KmiBr65oL6nvKWE0LfFYS+WyPif
        +fDszzuBkG8JMpxuDs3op/pKUZZxUufoew==
X-Google-Smtp-Source: ABdhPJyI60TSsiH88YsKkbsGgXlj+UXY9wknwvziU58s0iGJJn0kute4B1QnZ5a7zz2S/kwzSVWK5Q==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr19133238wrn.400.1631022746065;
        Tue, 07 Sep 2021 06:52:26 -0700 (PDT)
Received: from google.com ([31.124.24.230])
        by smtp.gmail.com with ESMTPSA id w9sm2420275wmc.19.2021.09.07.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:52:25 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.15
Message-ID: <YTdulwzbBvdA9kPi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.15

for you to fetch changes up to cdff1eda69326fb46de10c5454212b3efcf4bb41:

  mfd: lpc_sch: Rename GPIOBASE to prevent build error (2021-09-07 08:44:07 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Add support for registering devices via MFD cells to Simple MFD (I2C)

 - New Drivers
   - Add support for Renesas Synchronization Management Unit (SMU)

 - New Device Support
   - Add support for N5010 to Intel M10 BMC
   - Add support for Cannon Lake to Intel LPSS ACPI
   - Add support for Samsung SSG{1,2} to ST-Ericsson's U8500 family
   - Add support for TQMx110EB and TQMxE40x to TQ-Systems PLD TQMx86

 - New Functionality
   - Add support for GPIO to Intel LPC ICH
   - Add support for Reset to Texas Instruments TPS65086

 - Fix-ups
   - Trivial, sorting, whitespace, renaming, etc; mt6360-core, db8500-prcmu-regs, tqmx86
   - Device Tree fiddling; syscon, axp20x, qcom,pm8008, ti,tps65086, brcm,cru
   - Use proper APIs for IRQ map resolution; ab8500-core, stmpe, tc3589x, wm8994-irq
   - Pass 'supplied-from' property through axp288_fuel_gauge via swnode
   - Remove unused file entry; MAINTAINERS
   - Make interrupt line optional; tps65086
   - Rename db8500-cpuidle driver symbol; db8500-prcmu
   - Remove support for unused hardware; tqmx86
   - Provide a standard LPC clock frequency for unknown boards; tqmx86
   - Remove unused code; ti_am335x_tscadc
   - Use of_iomap() instead of ioremap(); syscon

 - Bug Fixes
   - Clear GPIO IRQ resource flags when no IRQ is set; tqmx86
   - Fix incorrect/misleading frequencies; db8500-prcmu
   - Mitigate namespace clash with other GPIOBASE users

----------------------------------------------------------------
Alex Bee (1):
      dt-bindings: mfd: syscon: add Rockchip RK3036/RK3228 qos compatibles

Andre Przywara (1):
      dt-bindings: mfd: axp20x: Add AXP305 compatible (plus optional IRQ)

Andy Shevchenko (1):
      mfd: intel-lpss: Add Intel Cannon Lake ACPI IDs

Chris Blake (1):
      mfd: lpc_ich: Enable GPIO driver for DH89xxCC

Emil Renner Berthing (3):
      dt-bindings: mfd: Convert tps65086.txt to YAML
      mfd: tps65086: Make interrupt line optional
      mfd: tps65086: Add cell entry for reset driver

Fei Shao (1):
      mfd: mt6360: Sort regulator resources

Hans de Goede (2):
      mfd: axp20x: Update AXP288 volatile ranges
      mfd: axp20x: Add supplied-from property to axp288_fuel_gauge cell

Hector Martin (1):
      mfd: syscon: Use of_iomap() instead of ioremap()

Lee Jones (1):
      mfd: simple-mfd-i2c: Add support for registering devices via MFD cells

Liang Chen (1):
      dt-bindings: mfd: syscon: Add rk3568 QoS register compatible

Linus Walleij (4):
      mfd: db8500-prcmu: Adjust map to reality
      mfd: db8500-prcmu: Rename register header
      mfd: db8500-prcmu: Handle missing FW variant
      mfd/cpuidle: ux500: Rename driver symbol

Lukas Bulwahn (1):
      MAINTAINERS: Adjust ARM/NOMADIK/Ux500 ARCHITECTURES to file renaming

Marc Zyngier (1):
      mfd: Don't use irq_create_mapping() to resolve a mapping

Martin Hundebøll (1):
      mfd: intel-m10-bmc: Add N5010 variant

Matthias Schiffer (6):
      mfd: tqmx86: Clear GPIO IRQ resource when no IRQ is set
      mfd: tqmx86: Remove incorrect TQMx90UC board ID
      mfd: tqmx86: Fix typo in "platform"
      mfd: tqmx86: Add support for TQMx110EB and TQMxE40x
      mfd: tqmx86: Add support for TQ-Systems DMI IDs
      mfd: tqmx86: Assume 24MHz LPC clock for unknown boards

Min Li (1):
      mfd: Add Renesas Synchronization Management Unit (SMU) support

Rafał Miłecki (1):
      dt-bindings: mfd: Add Broadcom CRU

Randy Dunlap (1):
      mfd: lpc_sch: Rename GPIOBASE to prevent build error

Tang Bin (1):
      mfd: ti_am335x_tscadc: Delete superfluous error message

satya priya (1):
      dt-bindings: mfd: pm8008: Add gpio-ranges and spmi-gpio compatible

 Documentation/devicetree/bindings/mfd/axp20x.txt         |   3 +-
 Documentation/devicetree/bindings/mfd/brcm,cru.yaml      |  86 ++++++++
 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml   |  13 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml        |   3 +
 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml   | 124 +++++++++++
 Documentation/devicetree/bindings/mfd/tps65086.txt       |  54 -----
 MAINTAINERS                                              |   1 -
 drivers/clk/ux500/u8500_of_clk.c                         |   3 +-
 drivers/cpuidle/cpuidle-ux500.c                          |   2 +-
 drivers/mfd/Kconfig                                      |  28 +++
 drivers/mfd/Makefile                                     |   5 +
 drivers/mfd/ab8500-core.c                                |   2 +-
 drivers/mfd/axp20x.c                                     |  16 +-
 drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} |   0
 drivers/mfd/db8500-prcmu.c                               |  25 +--
 drivers/mfd/intel-lpss-acpi.c                            |  18 ++
 drivers/mfd/intel-m10-bmc.c                              |  12 +-
 drivers/mfd/lpc_ich.c                                    |   1 +
 drivers/mfd/lpc_sch.c                                    |   4 +-
 drivers/mfd/mt6360-core.c                                |   8 +-
 drivers/mfd/rsmu.h                                       |  16 ++
 drivers/mfd/rsmu_core.c                                  |  88 ++++++++
 drivers/mfd/rsmu_i2c.c                                   | 203 +++++++++++++++++
 drivers/mfd/rsmu_spi.c                                   | 273 +++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                             |  41 +++-
 drivers/mfd/simple-mfd-i2c.h                             |  32 +++
 drivers/mfd/stmpe.c                                      |   4 +-
 drivers/mfd/syscon.c                                     |   2 +-
 drivers/mfd/tc3589x.c                                    |   2 +-
 drivers/mfd/ti_am335x_tscadc.c                           |   5 +-
 drivers/mfd/tps65086.c                                   |  22 +-
 drivers/mfd/tqmx86.c                                     |  48 +++-
 drivers/mfd/wm8994-irq.c                                 |   2 +-
 include/linux/mfd/dbx500-prcmu.h                         |   3 +-
 include/linux/mfd/idt82p33_reg.h                         | 112 ++++++++++
 include/linux/mfd/idt8a340_reg.h                         | 729 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rsmu.h                                 |  36 +++
 37 files changed, 1906 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/brcm,cru.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
 rename drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} (100%)
 create mode 100644 drivers/mfd/rsmu.h
 create mode 100644 drivers/mfd/rsmu_core.c
 create mode 100644 drivers/mfd/rsmu_i2c.c
 create mode 100644 drivers/mfd/rsmu_spi.c
 create mode 100644 drivers/mfd/simple-mfd-i2c.h
 create mode 100644 include/linux/mfd/idt82p33_reg.h
 create mode 100644 include/linux/mfd/idt8a340_reg.h
 create mode 100644 include/linux/mfd/rsmu.h
 
-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
