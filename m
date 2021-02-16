Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC931CE57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBPQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:45:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:45:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g6so13886598wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=PAXGeHqMomIXFSnFYPBcr/Og6bGBrQhqERVPd3hZ2d0=;
        b=lHcJyneAv0MH1MuGrzj2A3G7VyJ1dh89eNyWsYHvMpfCwEpkKKMdfv6fqXWtlfKgdV
         kXht74nAaYUWJqvWjMwpzmaGOVyW3afIC3UuhkHpGQ4kiOB97nadf1xdYaedKQv/tPGA
         kO+sBqdimoiA5BnXffGbIb6Jimuf9wazJ1iYFBr6wIEJvwSHU2fsEEFtXlkDXWiOuy/z
         ZeRzc1Ph89fJ6ZMgNu8fV7EKzP5SUB7Ko77/gVxlf/0aqsveROLyX2P9KAhQczCwQLHR
         LChtekTBbeCkGfo+64ePKTc6+S9ktSgu3z6SkgtKXp9Ge89AyURZaPOH4XTlos8PHXk8
         Cngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=PAXGeHqMomIXFSnFYPBcr/Og6bGBrQhqERVPd3hZ2d0=;
        b=FVfFQYyidDBZBz4MjB+y5tQ3+tYOO1c+Xsm2M46pQtM5LfcFiJ3PZIUOAe6oXzhm/M
         L4J8ssYtYVw8OZiFYNgpJ60EOzXSY1P/FHX1NFE5kvqskMrLY4Bz8W1I/VV9WZ8trYh8
         jt2W8bQDTsNzi7oWZqub1Fa4uHukmsxvFqecAjf8qrjmJiZx2Y8d7aPaOn5qblbvqiVE
         Fvi9V6goOXwRYQUVS4/bZC3ekdM2wY6LSeHHv7PXuoXhjdWIdpmhJFYVYlRkkcB9se7i
         rvHhm1k4SoFZzXr+AW9f+8SxqrbV+B0v30I+oW4vvAQqWoVC0ZbUWL/pKgbtH8yEHror
         gx/Q==
X-Gm-Message-State: AOAM533U8vQsU2Gb5q4Pd5rOeq+P/c+Cbh2WKOJ/parYNH8jaGJ7SDxk
        usosxXV7zC7vcUDfE2GA9NAWXnB6dfNfTg==
X-Google-Smtp-Source: ABdhPJz1xpsOoZ+xjdX3qxLJV6QC2epoomGa06tbUJOJyKKBzq4/WwNoBAGQMrBgc8/52f/Q/zWjvA==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr25143571wrr.235.1613493908643;
        Tue, 16 Feb 2021 08:45:08 -0800 (PST)
Received: from dell ([91.110.221.165])
        by smtp.gmail.com with ESMTPSA id i8sm36904596wry.90.2021.02.16.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:45:08 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:45:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v5.12
Message-ID: <20210216164505.GB4803@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.12

for you to fetch changes up to 26783d74cc6a440ee3ef9836a008a697981013d0:

  mfd: wm831x-auxadc: Prevent use after free in wm831x_auxadc_read_irq() (2021-02-08 13:54:40 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Standardise MFD_CELL_* helpers

 - New Drivers
   - Add support for Acer Iconia Tab A500 Embedded Controller

 - New Device Support
   - Add support for ROHM BD9574MWF to BD9571MWV
   - Add support for Intel Alder Lake PCH-P PCI to LPSS
   - Add support for Intel Alder Lake PCH-S PCI to LPSS

 - New Functionality
   - Support ACPI enumeration; arizona

 - Fix-ups
   - Managed resources; bd9571mwv
   - DT additions/fix-ups; bd9571mwv, iqs62x, max8997, gateworks-gsc, ene-kb930
   - Convert to SPDX; bd9571mw
   - Fix return values/error handling; sunxi
   - Provide SOFTDEP; arizona
   - Make use of DIV_ROUND_UP; mcp-sa11x0
   - Use generic APIs; arizona
   - Add MAC address sysfs entries; intel-m10-bmc
   - Trivial: Coding-style fix-ups; iqs62x
   - Trivial: Remove superflouous code; iqs62x
   - Clear-up naming conventions; iqs62x

 - Bug Fixes
   - Fix 'pointer from integer' error; altera-sysmgr
   - Convert SGI_MFD_IOC3 from tristate to bool; Kconfig
   - Fix interrupt handling; gateworks-gsc
   - Extend required delay; iqs62x
   - Do not use I2C polling during calibration; iqs62x
   - Do no adjust clock frequency during calibration; iqs62x
   - Fix use-after-free; wm831x-auxad

----------------------------------------------------------------
Andy Shevchenko (1):
      mfd: intel-lpss: Add Intel Alder Lake PCH-P PCI IDs

Arnd Bergmann (1):
      mfd: altera-sysmgr: Fix physical address storing more

Dan Carpenter (1):
      mfd: wm831x-auxadc: Prevent use after free in wm831x_auxadc_read_irq()

Dmitry Osipenko (2):
      dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
      mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500

Hans de Goede (3):
      mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
      mfd: arizona: Replace arizona_of_get_type() with device_get_match_data()
      mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI

Jarkko Nikula (1):
      mfd: intel-lpss: Add Intel Alder Lake PCH-S PCI IDs

Jeff LaBundy (6):
      mfd: iqs62x: Remove superfluous whitespace above fallthroughs
      mfd: iqs62x: Remove unused bit mask
      mfd: iqs62x: Rename regmap_config struct
      mfd: iqs62x: Increase interrupt handler return delay
      mfd: iqs62x: Do not poll during ATI
      mfd: iqs62x: Do not change clock frequency during ATI

Khiem Nguyen (2):
      mfd: bd9571mwv: Make the driver more generic
      mfd: bd9571mwv: Add support for BD9574MWF

Lee Jones (2):
      Merge branches 'ib-mfd-asoc-5.12', 'ib-mfd-bus-5.12' and 'ib-mfd-gpio-regulator-5.12' into ibs-for-mfd-merged
      mfd: Standardise MFD_CELL_* helper names

Russ Weight (1):
      mfd: intel-m10-bmc: Expose MAC address and count

Thomas Bogendoerfer (1):
      mfd: sgi-ioc3: Turn Kconfig option into a bool

Tim Harvey (2):
      mfd: gateworks-gsc: Fix interrupt type
      dt-bindings: mfd: gateworks-gsc: Add fan-tach mode

Timon Baetz (1):
      mfd: max8997: Add of_compatible to Extcon and Charger mfd_cell

Uwe Kleine-König (1):
      mfd/bus: sunxi-rsb: Make .remove() callback return void

Yoshihiro Shimoda (10):
      mfd: bd9571mwv: Use devm_mfd_add_devices()
      dt-bindings: mfd: bd9571mwv: Document BD9574MWF
      mfd: rohm-generic: Add BD9571 and BD9574
      regulator: bd9571mwv: rid of using struct bd9571mwv
      regulator: bd9571mwv: Add BD9574MWF support
      gpio: bd9571mwv: Use the SPDX license identifier
      gpio: bd9571mwv: rid of using struct bd9571mwv
      gpio: bd9571mwv: Add BD9574MWF support
      mfd: bd9571mwv: Use the SPDX license identifier
      mfd: bd9571mwv: Use devm_regmap_add_irq_chip()

Zhen Lei (1):
      dt-bindings: mfd: Correct the node name of the panel LED

Zheng Yongjun (1):
      mfd: mcp-sa11x0: Use DIV_ROUND_UP to calculate rw_timeout

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  21 +++
 .../devicetree/bindings/mfd/bd9571mwv.txt          |   4 +-
 .../devicetree/bindings/mfd/ene-kb930.yaml         |  65 +++++++
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |   3 +-
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  |   2 +-
 drivers/bus/sunxi-rsb.c                            |   4 +-
 drivers/gpio/gpio-bd9571mwv.c                      |  35 ++--
 drivers/mfd/Kconfig                                |  13 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ab8500-core.c                          |  42 ++---
 drivers/mfd/acer-ec-a500.c                         | 202 +++++++++++++++++++++
 drivers/mfd/altera-sysmgr.c                        |   3 +-
 drivers/mfd/arizona-core.c                         |  11 --
 drivers/mfd/arizona-i2c.c                          |  11 +-
 drivers/mfd/arizona-spi.c                          | 138 +++++++++++++-
 drivers/mfd/arizona.h                              |   9 -
 drivers/mfd/axp20x-i2c.c                           |   4 +-
 drivers/mfd/axp20x-rsb.c                           |   4 +-
 drivers/mfd/axp20x.c                               |   4 +-
 drivers/mfd/bd9571mwv.c                            | 178 +++++++++++-------
 drivers/mfd/db8500-prcmu.c                         |   6 +-
 drivers/mfd/gateworks-gsc.c                        |   2 +-
 drivers/mfd/intel-lpss-pci.c                       |  28 +++
 drivers/mfd/intel-m10-bmc.c                        |  43 +++++
 drivers/mfd/iqs62x.c                               | 144 ++++++++-------
 drivers/mfd/max8997.c                              |   4 +-
 drivers/mfd/mcp-sa11x0.c                           |   3 +-
 drivers/mfd/mt6360-core.c                          |  12 +-
 drivers/mfd/wm831x-auxadc.c                        |   3 +-
 drivers/regulator/bd9571mwv-regulator.c            |  59 +++---
 include/linux/mfd/axp20x.h                         |   2 +-
 include/linux/mfd/bd9571mwv.h                      |  45 ++---
 include/linux/mfd/core.h                           |   6 +-
 include/linux/mfd/intel-m10-bmc.h                  |   9 +
 include/linux/mfd/iqs62x.h                         |  11 +-
 include/linux/mfd/rohm-generic.h                   |   2 +
 include/linux/sunxi-rsb.h                          |   2 +-
 37 files changed, 847 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
 create mode 100644 drivers/mfd/acer-ec-a500.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
