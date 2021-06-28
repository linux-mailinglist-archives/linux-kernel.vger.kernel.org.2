Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E63B5EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhF1Nfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1Nfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:35:51 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E03C061574;
        Mon, 28 Jun 2021 06:33:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so2107065otg.9;
        Mon, 28 Jun 2021 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NqPsnXv3qU78yqkKqfVcnXc+rnvVyoL/+Kid9Rvc9mA=;
        b=BaXBPZJSTZJOpibKRmS8oyQNxRrgHjyG33AKFMOoh8Ejdm3HZrfZPtR91OY8XTxjPl
         uL5N/vHHP/m0imtZx35NE4ipPEMZTfhSZ2QRCRj7cRCo75v6B1PhbY9FLB0HTtsImh8F
         KwIC8jZi7cOqDSXvzTR4ccuxX7qthfxQ7KmwxO5+M79ZnUYpxPRtm8rJkFNg1ZArz6qR
         ixoC1O5t6/sg/j4Ma8HdyxSBsoqzMTEegM4p27uvIDH7u0VKQePpwGz0I1f+h/52UJUx
         c8qXmnZgyPmU40pm3IIXQcdynoSTqahvb1Fkjo7QE+hFbRGQCg+Cdtmqdr/HdwtCurAr
         acwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NqPsnXv3qU78yqkKqfVcnXc+rnvVyoL/+Kid9Rvc9mA=;
        b=Jyd9gd8UOOrFJofz6aJKdXSut/TDwSi//j694+eYMNk4zwcFDDJKualOTy87VRz6vY
         7ZvhABp8qcJRZ/fqj3UbDXC1mjbxybDixX9aQzewxLkCcxr4x5OrwucOf+N7M66hpIq1
         O0YN2uwQBGs2BrPxSbOjUATeKwm5iM2PRV8O93AT8gFnCbq0ywMjkNTjPSzuXr/WjzYa
         bgAT4TAbsbFMa4MSPeCkUnOW7dOyqTGCk0kL0HTEvRVoyIZI9suPMx4DkUiizU4oJXKh
         S2v0lN6Ed0N3jR6iwg1C6NFHCKKrMu4n/+pHYkVOCizehzUXaxCE8HjwTRRMf5ZqefC0
         PDNA==
X-Gm-Message-State: AOAM530cpG7OBojXI9s5iYn3RrrDsY11sAIGCyLa3MXHS9x9amrbFKs6
        Yr05A/uOIt9xdpb2DHsJkUfdxoGREek=
X-Google-Smtp-Source: ABdhPJwhOBo86AWpYHv6mZYex4APztoOI/py0KnbxCVVuV4WEm1br42WKTgc089hr+k2b9Yv64uncw==
X-Received: by 2002:a05:6830:1049:: with SMTP id b9mr1022162otp.203.1624887204581;
        Mon, 28 Jun 2021 06:33:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k84sm3155550oia.8.2021.06.28.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:33:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.14
Date:   Mon, 28 Jun 2021 06:33:22 -0700
Message-Id: <20210628133322.374614-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.14 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.14

Thanks,
Guenter
------

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.14

for you to fetch changes up to a5f6c0f85a09f46c88c0ac53f3d2f70eef105a65:

  hwmon: Support set_trips() of thermal device ops (2021-06-24 07:15:28 -0700)

----------------------------------------------------------------
hwmon updates for v5.14

New drivers:
- Delta DPS920AB
- Flex PIM4006, PIM4328 and PIM4820
- MPS MP2888
- Sensirion SHT4X

Added chip support to existing drivers:
- Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490, BMR491, and BMR492
- TI TMP1075
- Renesas ZLS1003, ZLS4009 and ZL8802

Other;
- Dropped explicit ACPI support for MAX31722 and LM70;
  the APIC IDs in those drivers do not exist.
- Support set_trips() callback into thermal subsystem
- Minor fixes and improvements in various drivers

----------------------------------------------------------------
Andy Shevchenko (1):
      hwmon: (lm70) Use SPI_MODE_X_MASK

Armin Wolf (4):
      hwmon: (sch56xx) Use devres functions for watchdog
      hwmon: (sch56xx-common) Use strscpy
      hwmon: (sch56xx-common) Use helper function
      hwmon: (sch56xx-common) Simplify sch56xx_device_add

Chris Packham (1):
      hwmon: (pmbus/bpa-rs600) Handle Vin readings >= 256V

Chu Lin (1):
      hwmon: (adm1275) enable adm1272 temperature reporting

Dan Carpenter (1):
      hwmon: (pmbus/dps920ab) Delete some dead code

Dmitry Osipenko (6):
      hwmon: (lm90) Don't override interrupt trigger type
      hwmon: (lm90) Use hwmon_notify_event()
      hwmon: (lm90) Unmask hardware interrupt
      hwmon: (lm90) Disable interrupt on suspend
      hwmon: (lm90) Prevent integer underflows of temperature calculations
      hwmon: Support set_trips() of thermal device ops

Erik Rosen (10):
      hwmon: (pmbus/zl6100) Add support for ZLS1003, ZLS4009 and ZL8802
      hwmon: (pmbus/zl6100) Update documentation for zl6100 driver
      hwmon: (pmbus) Add new flag PMBUS_READ_STATUS_AFTER_FAILED_CHECK
      hwmon: (pmbus) Add documentation for new flags
      hwmon: (pmbus) Add support for additional Flex BMR converters to pmbus
      hwmon: (pmbus) Add new pmbus flag NO_WRITE_PROTECT
      hwmon: (pmbus) Add support for reading direct mode coefficients
      hwmon: (pmbus) Allow phase function even if it's not on page
      hwmon: (pmbus/pim4328) Add PMBus driver for PIM4006, PIM4328 and PIM4820
      hwmon: (pmbus/pim4328) Add documentation for the pim4328 PMBus driver

Fabio Estevam (1):
      docs: hwmon: Add an entry for mp2888

Guenter Roeck (7):
      hwmon: (lm70) Revert "hwmon: (lm70) Add support for ACPI"
      hwmon: (max31722) Remove non-standard ACPI device IDs
      hwmon: (max31790) Fix fan speed reporting for fan7..12
      hwmon: (max31790) Report correct current pwm duty cycles
      hwmon: (max31790) Fix pwmX_enable attributes
      hwmon: (max31790) Clear fan fault after reporting it
      hwmon: (max31790) Detect and report zero fan speed

Joe Perches (1):
      hwmon: (sht4x) Fix sht4x_read_values return value

Jonathan Cameron (1):
      hwmon: (ntc_thermistor) Drop unused headers.

Madhava Reddy Siddareddygari (1):
      hwmon: (pmbus_core) Check adapter PEC support

Mauro Carvalho Chehab (3):
      docs: hwmon: ir36021.rst: replace some characters
      docs: hwmon: avoid using UTF-8 chars
      docs: hwmon: adm1177.rst: avoid using ReSt :doc:`foo` markup

Navin Sankar Velliangiri (1):
      hwmon: Add sht4x Temperature and Humidity Sensor Driver

Ninad Malwade (1):
      hwmon: (ina3221) use CVRF only for single-shot conversion

Robert Marko (5):
      hwmon: (lm75) Add TI TMP1075 support
      dt-bindings: hwmon: Add Texas Instruments TMP1075
      hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
      dt-bindings: trivial-devices: Add Delta DPS920AB
      MAINTAINERS: Add Delta DPS920AB PSU driver

Vadim Pasternak (3):
      hwmon: (pmbus) Increase maximum number of phases per page
      hwmon: (pmbus) Add support for MPS Multi-phase mp2888 controller
      dt-bindings: Add MP2888 voltage regulator device

Zhen Lei (1):
      hwmon: (bt1-pvt) Remove redundant error printing in pvt_request_regs()

 Documentation/devicetree/bindings/hwmon/lm75.yaml  |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 Documentation/hwmon/adm1177.rst                    |   3 +-
 Documentation/hwmon/dps920ab.rst                   |  73 ++++
 Documentation/hwmon/index.rst                      |   4 +
 Documentation/hwmon/ir36021.rst                    |   2 +-
 Documentation/hwmon/lm75.rst                       |   6 +-
 Documentation/hwmon/ltc2992.rst                    |   2 +-
 Documentation/hwmon/max31790.rst                   |   5 +-
 Documentation/hwmon/mp2888.rst                     | 113 ++++++
 Documentation/hwmon/pim4328.rst                    | 105 ++++++
 Documentation/hwmon/pm6764tr.rst                   |   2 +-
 Documentation/hwmon/pmbus-core.rst                 |  42 ++-
 Documentation/hwmon/pmbus.rst                      |  11 +-
 Documentation/hwmon/sht4x.rst                      |  45 +++
 Documentation/hwmon/zl6100.rst                     | 132 ++++---
 MAINTAINERS                                        |   7 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/bt1-pvt.c                            |   4 +-
 drivers/hwmon/hwmon.c                              |  36 ++
 drivers/hwmon/ina3221.c                            |  22 +-
 drivers/hwmon/lm70.c                               |  28 +-
 drivers/hwmon/lm75.c                               |  13 +
 drivers/hwmon/lm90.c                               |  92 ++++-
 drivers/hwmon/max31722.c                           |   9 -
 drivers/hwmon/max31790.c                           |  72 ++--
 drivers/hwmon/ntc_thermistor.c                     |   4 -
 drivers/hwmon/pmbus/Kconfig                        |  34 +-
 drivers/hwmon/pmbus/Makefile                       |   3 +
 drivers/hwmon/pmbus/adm1275.c                      |  14 +-
 drivers/hwmon/pmbus/bpa-rs600.c                    |  29 ++
 drivers/hwmon/pmbus/dps920ab.c                     | 206 +++++++++++
 drivers/hwmon/pmbus/mp2888.c                       | 408 +++++++++++++++++++++
 drivers/hwmon/pmbus/pim4328.c                      | 233 ++++++++++++
 drivers/hwmon/pmbus/pmbus.c                        |  19 +-
 drivers/hwmon/pmbus/pmbus.h                        |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 151 +++++++-
 drivers/hwmon/pmbus/zl6100.c                       |  94 ++++-
 drivers/hwmon/sch5627.c                            |  18 +-
 drivers/hwmon/sch5636.c                            |   9 +-
 drivers/hwmon/sch56xx-common.c                     |  65 +---
 drivers/hwmon/sch56xx-common.h                     |   4 +-
 drivers/hwmon/sht4x.c                              | 296 +++++++++++++++
 include/linux/pmbus.h                              |  30 ++
 45 files changed, 2202 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/hwmon/dps920ab.rst
 create mode 100644 Documentation/hwmon/mp2888.rst
 create mode 100644 Documentation/hwmon/pim4328.rst
 create mode 100644 Documentation/hwmon/sht4x.rst
 create mode 100644 drivers/hwmon/pmbus/dps920ab.c
 create mode 100644 drivers/hwmon/pmbus/mp2888.c
 create mode 100644 drivers/hwmon/pmbus/pim4328.c
 create mode 100644 drivers/hwmon/sht4x.c
