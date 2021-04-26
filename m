Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F237B36B83B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhDZRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhDZRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:43:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC82C061574;
        Mon, 26 Apr 2021 10:42:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n184so31192168oia.12;
        Mon, 26 Apr 2021 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0xqUB7vhwGg6QG1PxUGZKYIR/1pjBJeYaym7WPY33o=;
        b=M83XTrEdEgQwiaWRJNyI+dqw4mnIwvG0XE5n2TfPUHdohsE6XV371Jq8dNIJphE7v0
         pkppoKCqhGIdY/jdVgKBDbb5kxVXCuvuYrdy5N0iUIhKVEKMXojINBtrcmVAqIkaKJU+
         qJjXN/IFO8vWeLUHSINqX8dZuSfgizoH7J968eMpf6rWcQY/bueWI6lT/wliNSXrUpkn
         uM8TPrxE4t3GkzDJT6hkf4aGIRBbQH9MiqID+2q/2ixKvCrk6zlp9bFZpEyI+Xa92Op9
         wa0/IzcsRg9XkU4x8mZHe0+6/DGvsTn5ELuFQ6fCOnOCGPoz5xhcvZkASZlmPhpH7MJN
         zroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=e0xqUB7vhwGg6QG1PxUGZKYIR/1pjBJeYaym7WPY33o=;
        b=Dtd5erk1lM3wlbIgosfWU5BvpfikrcDaS5UHy9+dIwFrWREZ/DLoY2oLyFH0V0xIHO
         9dM5xe8voULpx+rfrunVWJjtwVQpBmJ69fHMwoX3K6KpZCJO7umo/MKcOsLdm8VaK1dE
         OLJaGp8PJ8sI5tjjPdgGFreZhS3lZM11OPWE6iEAi5PrHVjrxnF+Rc7B7j+m5aH21KsD
         CIwNzQttqb3Ks3WZAR5hbyWCel0bq5YBCImaJFhvNIdnYLblhGj4ySIxLweM9bTc7KGg
         IgNcttI8nVTUbbR2xIdFWxOfDqYVYy3zXgSorvIbqoIQWDWUH9fnlm3r86HHN5+A3EPo
         UKQA==
X-Gm-Message-State: AOAM530PkDseGbxVu2KpF9UC+1Qd0E4OqnvPasDLttA04AlQLULUstaU
        uoZIInKaY4ETs2Qi/wxfKQdSRpWdLUc=
X-Google-Smtp-Source: ABdhPJxNJ84vxIVT3Fe0PXX79ewh2yRFjbcjFonHQYH5hOmUqknh3hlxtvZTmQ0O9y63w7fP1Afhew==
X-Received: by 2002:aca:3bc4:: with SMTP id i187mr149405oia.174.1619458952156;
        Mon, 26 Apr 2021 10:42:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d62sm3162910oia.37.2021.04.26.10.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 10:42:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.13
Date:   Mon, 26 Apr 2021 10:42:29 -0700
Message-Id: <20210426174229.103899-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.13 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13

Thanks,
Guenter
------

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.13

for you to fetch changes up to 9049572fb145746725b198a19e27fa2671b80448:

  hwmon: Remove amd_energy driver (2021-04-20 06:52:08 -0700)

----------------------------------------------------------------
hwmon updates for v5.13

The most notable change is the removal of the amd_energy driver. It was
rendered all but unusable by making its attributes privileged-only to work
around a security issue. A suggested remedy was rejected by AMD, so the
only real solution was to remove the driver. For the future, we'll have
to make sure that no privileged-access-only drivers are accepted into the
hwmon subsystem in the first place. The hwmon ABI document was updated
accordingly.

Other changes:

PMBus drivers:
- Added driver for MAX15301
- Added driver for BluTek BPA-RS600
- Added driver for fsp-3y PSUs and PDUs
- Added driver for Infineon IR36021
- Added driver for ST STPDDC60
- Added support for TI TPS53676 to tps53679 driver
- Introduced PMBUS symbol namespace
  This was made necessary by a suggestion to use its exported functions
  from outside the hwmon subsystem.
- Minor improvements and bug fixes

New drivers:
- Driver for NZXT Kraken X42/X52/X62/X72

Driver enhancements:
- Added support for Intel D5005 to intel-m10-bmc-hwmon driver
- Added support for NCT6686D to nct6683 driver

Other:
- Converted sch5627 and amd9240 drivers to hwmon_device_register_with_info()
- Added support for fan drawers capability and present registers to mlxreg-fan
  driver
- Added Dell Latitude E7440 to fan control whitelist in dell-smm driver
- Replaced snprintf in show functions with sysfs_emit
  Done with coccinelle script for all drivers to preempt endless per-driver
  submissions of the same change.
- Use kobj_to_dev()
  Another coccinelle based change to preempt endless per-driver submissions
  of the same change.
- Various minor fixes and improvements

----------------------------------------------------------------
Armin Wolf (4):
      hwmon: (sch5627) Convert to hwmon_device_register_with_info()
      hwmon: (sch5627) Split sch5627_update_device()
      hwmon: (sch5627) Use devres function
      hwmon: (sch5627) Remove unnecessary error path

Bhaskar Chowdhury (1):
      hwmon: (ftsteutates) Rudimentary typo fixes

Chris Packham (5):
      dt-bindings: trivial-devices: Add infineon,ir36021
      hwmon: (pmbus) Add driver for Infineon IR36021
      hwmon: (pmbus) Replace - with _ in device names before registration
      dt-bindings: Add vendor prefix and trivial device for BluTek BPA-RS600
      hwmon: (pmbus) Add driver for BluTek BPA-RS600

Erik Rosen (5):
      hwmon: (pmbus) Add pmbus_set_update() function to set update flag
      hwmon: (pmbus/stpddc60) Add ST STPDDC60 pmbus driver
      dt-bindings: Add trivial device entry for TPS53676
      hwmon: (pmbus/tps53679) Add support for TI TPS53676
      hwmon: (pmbus) Add pmbus driver for MAX15301

Guenter Roeck (9):
      hwmon: (adm9240) Drop log messages from detect function
      hwmon: (adm9240) Store i2c device instead of client in local data
      hwmon: (adm9240) Convert to devm_hwmon_device_register_with_info API
      hwmon: Use kobj_to_dev()
      hwmon: replace snprintf in show functions with sysfs_emit
      MAINTAINERS: Add keyword pattern for hwmon registration functions
      hwmon: (pmbus) Introduce PMBUS symbol namespace
      hwmon: Clarify scope of attribute access
      hwmon: Remove amd_energy driver

Jiapeng Chong (1):
      hwmon: (nct6683) remove useless function

Jiqi Li (1):
      hwmon: (nct6683) Support NCT6686D

Jonas Malaco (1):
      hwmon: add driver for NZXT Kraken X42/X52/X62/X72

Matthew Gerlach (1):
      hwmon: (intel-m10-bmc-hwmon) add sensor support of Intel D5005 card

Paul Fertser (1):
      hwmon: (pmbus/pxe1610) don't bail out when not all pages are active

Sebastian Oechsle (1):
      hwmon: (dell-smm) Add Dell Latitude E7440 to fan control whitelist

Tian Tao (1):
      hwmon: (ds1621) Use kobj_to_dev()

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Add support for fan drawers capability and present registers

Václav Kubernát (1):
      hwmon: Add driver for fsp-3y PSUs and PDUs

Wilken Gottwalt (2):
      hwmon: (corsair-psu) Update calculation of LINEAR11 values
      hwmon: (corsair-psu) add support for critical values

Yang Li (1):
      hwmon: Switch to using the new API kobj_to_dev()

Zihao Tang (1):
      hwmon: (ina2xx) Convert sysfs sprintf/snprintf family to sysfs_emit

zuoqilin (1):
      hwmon: (ftsteutates) Fix spelling typo

 .../devicetree/bindings/trivial-devices.yaml       |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/hwmon/amd_energy.rst                 | 119 ---
 Documentation/hwmon/bpa-rs600.rst                  |  74 ++
 Documentation/hwmon/corsair-psu.rst                |  13 +-
 Documentation/hwmon/fsp-3y.rst                     |  28 +
 Documentation/hwmon/index.rst                      |   7 +-
 Documentation/hwmon/ir36021.rst                    |  63 ++
 Documentation/hwmon/max15301.rst                   |  87 ++
 Documentation/hwmon/nzxt-kraken2.rst               |  42 +
 Documentation/hwmon/stpddc60.rst                   |  90 ++
 Documentation/hwmon/sysfs-interface.rst            |   8 +
 Documentation/hwmon/tps53679.rst                   |  13 +-
 MAINTAINERS                                        |  29 +-
 drivers/hwmon/Kconfig                              |  20 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/adc128d818.c                         |   2 +-
 drivers/hwmon/adm9240.c                            | 982 ++++++++++-----------
 drivers/hwmon/amd_energy.c                         | 379 --------
 drivers/hwmon/applesmc.c                           |  34 +-
 drivers/hwmon/corsair-psu.c                        | 355 ++++++--
 drivers/hwmon/dell-smm-hwmon.c                     |   8 +
 drivers/hwmon/ds1621.c                             |   2 +-
 drivers/hwmon/ftsteutates.c                        |   4 +-
 drivers/hwmon/hwmon.c                              |   2 +-
 drivers/hwmon/ina209.c                             |   6 +-
 drivers/hwmon/ina2xx.c                             |  11 +-
 drivers/hwmon/ina3221.c                            |   2 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                | 122 +++
 drivers/hwmon/it87.c                               |  12 +-
 drivers/hwmon/lineage-pem.c                        |   8 +-
 drivers/hwmon/lm63.c                               |   2 +-
 drivers/hwmon/ltc2945.c                            |   4 +-
 drivers/hwmon/ltc2990.c                            |   4 +-
 drivers/hwmon/ltc4151.c                            |   2 +-
 drivers/hwmon/ltc4215.c                            |   8 +-
 drivers/hwmon/ltc4222.c                            |   4 +-
 drivers/hwmon/ltc4260.c                            |   4 +-
 drivers/hwmon/ltc4261.c                            |   4 +-
 drivers/hwmon/max16065.c                           |  18 +-
 drivers/hwmon/max6697.c                            |   2 +-
 drivers/hwmon/mlxreg-fan.c                         |  51 +-
 drivers/hwmon/nct6683.c                            |  22 +-
 drivers/hwmon/nzxt-kraken2.c                       | 234 +++++
 drivers/hwmon/occ/common.c                         |  69 +-
 drivers/hwmon/occ/sysfs.c                          |   4 +-
 drivers/hwmon/pmbus/Kconfig                        |  51 +-
 drivers/hwmon/pmbus/Makefile                       |   5 +
 drivers/hwmon/pmbus/adm1266.c                      |   1 +
 drivers/hwmon/pmbus/adm1275.c                      |   1 +
 drivers/hwmon/pmbus/bel-pfe.c                      |   1 +
 drivers/hwmon/pmbus/bpa-rs600.c                    | 173 ++++
 drivers/hwmon/pmbus/fsp-3y.c                       | 254 ++++++
 drivers/hwmon/pmbus/ibm-cffps.c                    |   1 +
 drivers/hwmon/pmbus/inspur-ipsps.c                 |  29 +-
 drivers/hwmon/pmbus/ir35221.c                      |   1 +
 drivers/hwmon/pmbus/ir36021.c                      |  80 ++
 drivers/hwmon/pmbus/ir38064.c                      |   1 +
 drivers/hwmon/pmbus/irps5401.c                     |   1 +
 drivers/hwmon/pmbus/isl68137.c                     |   1 +
 drivers/hwmon/pmbus/lm25066.c                      |   1 +
 drivers/hwmon/pmbus/ltc2978.c                      |   1 +
 drivers/hwmon/pmbus/ltc3815.c                      |   1 +
 drivers/hwmon/pmbus/max15301.c                     | 190 ++++
 drivers/hwmon/pmbus/max16064.c                     |   1 +
 drivers/hwmon/pmbus/max16601.c                     |   1 +
 drivers/hwmon/pmbus/max20730.c                     |   1 +
 drivers/hwmon/pmbus/max20751.c                     |   1 +
 drivers/hwmon/pmbus/max31785.c                     |   1 +
 drivers/hwmon/pmbus/max34440.c                     |   1 +
 drivers/hwmon/pmbus/max8688.c                      |   1 +
 drivers/hwmon/pmbus/mp2975.c                       |   1 +
 drivers/hwmon/pmbus/pm6764tr.c                     |   1 +
 drivers/hwmon/pmbus/pmbus.c                        |   1 +
 drivers/hwmon/pmbus/pmbus.h                        |   1 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  63 +-
 drivers/hwmon/pmbus/pxe1610.c                      |  10 +
 drivers/hwmon/pmbus/q54sj108a2.c                   |   1 +
 drivers/hwmon/pmbus/stpddc60.c                     | 249 ++++++
 drivers/hwmon/pmbus/tps40422.c                     |   1 +
 drivers/hwmon/pmbus/tps53679.c                     |  52 +-
 drivers/hwmon/pmbus/ucd9000.c                      |   1 +
 drivers/hwmon/pmbus/ucd9200.c                      |   1 +
 drivers/hwmon/pmbus/xdpe12284.c                    |   1 +
 drivers/hwmon/pmbus/zl6100.c                       |   1 +
 drivers/hwmon/s3c-hwmon.c                          |   4 +-
 drivers/hwmon/sch5627.c                            | 521 +++++------
 drivers/hwmon/sch5636.c                            |  20 +-
 drivers/hwmon/smm665.c                             |   4 +-
 drivers/hwmon/stts751.c                            |  20 +-
 drivers/hwmon/vexpress-hwmon.c                     |  12 +-
 drivers/hwmon/xgene-hwmon.c                        |  14 +-
 drivers/mfd/intel-m10-bmc.c                        |  10 +
 93 files changed, 3126 insertions(+), 1626 deletions(-)
 delete mode 100644 Documentation/hwmon/amd_energy.rst
 create mode 100644 Documentation/hwmon/bpa-rs600.rst
 create mode 100644 Documentation/hwmon/fsp-3y.rst
 create mode 100644 Documentation/hwmon/ir36021.rst
 create mode 100644 Documentation/hwmon/max15301.rst
 create mode 100644 Documentation/hwmon/nzxt-kraken2.rst
 create mode 100644 Documentation/hwmon/stpddc60.rst
 delete mode 100644 drivers/hwmon/amd_energy.c
 create mode 100644 drivers/hwmon/nzxt-kraken2.c
 create mode 100644 drivers/hwmon/pmbus/bpa-rs600.c
 create mode 100644 drivers/hwmon/pmbus/fsp-3y.c
 create mode 100644 drivers/hwmon/pmbus/ir36021.c
 create mode 100644 drivers/hwmon/pmbus/max15301.c
 create mode 100644 drivers/hwmon/pmbus/stpddc60.c
