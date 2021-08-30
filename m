Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C893FBE34
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhH3V1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbhH3V1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:27:05 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEFC061764;
        Mon, 30 Aug 2021 14:26:11 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso20156620ott.13;
        Mon, 30 Aug 2021 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=katyI+KQhr/PPLVDQX7rP4KnaiR/MitSJ5yqkwZuCwA=;
        b=kDhcgjKNnjwnuWRyIt+9WK5apvWPgIxrKKuW2Yv8e0DRtarziMsdJxa1alMXGKNewm
         yqwGR3GW4g2uRUsgr1froBBhQVytRe9SBljEox3Lj6zk6Y4yn03i4pnKxhqocXeoaSEK
         gF63YFiaDPJ31pv7TZQAs/qIwmqTsHXxJeVbCH3aDFZioCOunoB5tte4/CjWakK1KwPn
         5gg+rB2mi3Z0TDESeIthE9XKr66Mv5CMGVgNnZVWMu8IrZvlXFCVqRdF0VkWP6zGDoDv
         eCqvS1TsvKhsiyDPdA/0Od8iEYjSYlh2D8XpzkarWIKqOmQbR6OrmhJJl0nDMFncSxtO
         A4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=katyI+KQhr/PPLVDQX7rP4KnaiR/MitSJ5yqkwZuCwA=;
        b=qPWepdn8HlGt1b3aN/y40cK8b0JsN5nJ0pY6+qBOxp0ePrLS11iA9qS5cPsQOBzcA8
         3p1pJAizcxhT7y6iGPxYvYg3dVcz061JeUEEAKcz6NJ6CqfI257vOz0D8wVpHEGhgrt3
         E2lFKEXSB4MSyhZ97gtSltL9cn6sDkKIZac9q75ZDOLySVaL+p8nKiTwt6/smrV/yCgD
         /fBJHw74M+D0jeDPARTQK9nrxQOiF68dKxaaTNnIswk+EyQzl3fhtbynCSLNBpHeOdCt
         wIOEsOjhMtYl+vrfHHmIDKHvUStJS8DdDMXeMTmirNc8HquaYeYLUeDbA9uc04M/uV5E
         /6yg==
X-Gm-Message-State: AOAM533/HDZOoCr2gWJUqjTC+vMCn41jUlZTtFu5drGSMHuBzY+LEkav
        AyGyA3phCex/KzmxCnjvBcCXxzVcwZ4=
X-Google-Smtp-Source: ABdhPJxq3XNqe2J4hCi9PeolR1cElQcrZyFjmqZ0uKScrRa+vfGuJMYKs2cnVbfIl145BozjOLvrVQ==
X-Received: by 2002:a9d:4c89:: with SMTP id m9mr22160652otf.255.1630358770912;
        Mon, 30 Aug 2021 14:26:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b25sm3127494ooq.6.2021.08.30.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:26:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.15
Date:   Mon, 30 Aug 2021 14:26:08 -0700
Message-Id: <20210830212608.2704628-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.15 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15

Thanks,
Guenter
------

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.15

for you to fetch changes up to 0e35f63f7f4eebd268ec236fd1bbf4e561ce8de5:

  hwmon: add driver for Aquacomputer D5 Next (2021-08-28 08:53:30 -0700)

----------------------------------------------------------------
hwmon updates for v5.15

New drivers for:
- Aquacomputer D5 Next
- SB-RMI power module

Added chip support t oexisting drivers:
- Support for various Zen2 and Zen3 APUs and for Yellow Carp
  (SMU v13) added to k10temp driver
- Support for Silicom n5010 PAC added to intel-m10-bmc driver
- Support for BPD-RS600 added to pmbus/bpa-rs600 driver

Other notable changes:
- In k10temp, do not display Tdie on Zen CPUs if there is no
  difference between Tdie and Tctl
- Converted adt7470 and dell-smm drivers to use
  devm_hwmon_device_register_with_info API
- Support for temperature/pwm tables added to axi-fan-control
  driver
- Enabled fan control for Dell Precision 7510 in dell-smm driver

Various other minor improvements and fixes in several drivers.

----------------------------------------------------------------
Akshay Gupta (3):
      hwmon: Add support for SB-RMI power module
      hwmon: (sbrmi) Add Documentation
      dt-bindings: sbrmi: Add SB-RMI hwmon driver bindings

Aleksa Savic (1):
      hwmon: add driver for Aquacomputer D5 Next

Armin Wolf (13):
      hwmon: (w83627ehf) Use platform_create_bundle
      hwmon: (w83627ehf) Remove w83627ehf_remove()
      hwmon: (w83627ehf) Switch to SIMPLE_DEV_PM_OPS
      hwmon: (w83627ehf) Make DEVICE_ATTR_RO static
      hwmon: (dell-smm-hwmon) Use platform device
      hwmon: (dell-smm-hwmon) Mark functions as __init
      hwmon: (dell-smm-hwmon) Use devm_add_action_or_reset()
      hwmon: (dell-smm-hwmon) Move variables into a driver private data structure
      hwmon: (dell-smm-hwmon) Convert to devm_hwmon_device_register_with_info()
      hwmon: (dell-smm-hwmon) Fix fan mutliplier detection for 3rd fan
      hwmon: (dell-smm) Mark tables as __initconst
      hwmon: (dell-smm) Mark i8k_get_fan_nominal_speed as __init
      hwmon: (dell-smm) Rework SMM function debugging

Brandon Wyman (1):
      hwmon: (pmbus/ibm-cffps) Fix write bits for LED control

Carlos Alberto Lopez Perez (1):
      hwmon: (dell-smm) Add Dell Precision 7510 to fan control whitelist

Chris Packham (6):
      hwmon: (pmbus/bpa-rs600) Support BPD-RS600
      hwmon: (pmbus/bpa-rs600) Don't use rated limits as warn limits
      hwmon: (pmbus/bpa-rs600) Add workaround for incorrect Pin max
      hwmon: (adt7470) Fix some style issues
      hwmon: (adt7470) Convert to use regmap
      hwmon: (adt7470) Convert to devm_hwmon_device_register_with_info API

David Bartley (1):
      hwmon: (k10temp) support Zen3 APUs

Linus Walleij (3):
      hwmon: (ntc_thermistor) Use library interpolation
      dt-bindings: hwmon: Add bindings for Winbond W83781D
      hwmon: (w83781d) Match on device tree compatibles

Lukas Bulwahn (1):
      hwmon: remove amd_energy driver in Makefile

Mario Limonciello (4):
      hwmon: (k10temp) Add additional missing Zen2 and Zen3 APUs
      hwmon: (k10temp) Don't show Tdie for all Zen/Zen2/Zen3 CPU/APU
      hwmon: (k10temp) Rework the temperature offset calculation
      hwmon: (k10temp) Add support for yellow carp

Martin Hundebøll (1):
      hwmon: intel-m10-bmc-hwmon: add n5010 sensors

Mauro Carvalho Chehab (1):
      dt-bindings: firmware: update arm,scpi.yaml reference

Nuno Sá (3):
      hwmon: (axi-fan-control) Make sure the clock is enabled
      hwmon: (axi-fan-control) Handle irqs in natural order
      hwmon: (axi-fan-control) Support temperature vs pwm points

Randy Dunlap (1):
      hwmon: sht4x: update Documentation for Malformed table

Sebastian Andrzej Siewior (1):
      hwmon: Replace deprecated CPU-hotplug functions.

 .../devicetree/bindings/hwmon/amd,sbrmi.yaml       |   53 +
 .../devicetree/bindings/hwmon/winbond,w83781d.yaml |   41 +
 Documentation/hwmon/aquacomputer_d5next.rst        |   61 ++
 Documentation/hwmon/index.rst                      |    2 +
 Documentation/hwmon/sbrmi.rst                      |   79 ++
 Documentation/hwmon/scpi-hwmon.rst                 |    2 +-
 Documentation/hwmon/sht4x.rst                      |    2 +-
 MAINTAINERS                                        |    7 +
 arch/x86/kernel/amd_nb.c                           |    5 +
 drivers/hwmon/Kconfig                              |   20 +
 drivers/hwmon/Makefile                             |    3 +-
 drivers/hwmon/adt7470.c                            | 1051 ++++++++++----------
 drivers/hwmon/aquacomputer_d5next.c                |  363 +++++++
 drivers/hwmon/axi-fan-control.c                    |  117 ++-
 drivers/hwmon/dell-smm-hwmon.c                     |  910 +++++++++--------
 drivers/hwmon/fam15h_power.c                       |    4 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                |  116 +++
 drivers/hwmon/k10temp.c                            |   30 +-
 drivers/hwmon/ntc_thermistor.c                     |   20 +-
 drivers/hwmon/pmbus/bpa-rs600.c                    |   68 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |    6 +-
 drivers/hwmon/sbrmi.c                              |  359 +++++++
 drivers/hwmon/w83627ehf.c                          |  122 +--
 drivers/hwmon/w83781d.c                            |   11 +
 include/linux/pci_ids.h                            |    1 +
 25 files changed, 2276 insertions(+), 1177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/amd,sbrmi.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml
 create mode 100644 Documentation/hwmon/aquacomputer_d5next.rst
 create mode 100644 Documentation/hwmon/sbrmi.rst
 create mode 100644 drivers/hwmon/aquacomputer_d5next.c
 create mode 100644 drivers/hwmon/sbrmi.c
