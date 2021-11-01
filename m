Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4872441D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhKAPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhKAPrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:47:22 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D4C061714;
        Mon,  1 Nov 2021 08:44:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso19392726otj.10;
        Mon, 01 Nov 2021 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qM7ryczK1TrfWAzLUUUGncdEXd1XmxHZByJuDH63eGQ=;
        b=j5k4POaAWcvoaC5jGtPLwtbhSpx0OlC06ebLDbZK9jofWfwMl7zqfvf1prBwfnR4MY
         pNZJTZ8AMFbBtudxRxERolsDfT7Xz0aib5pI8gPWeyQSNCZThjI+TJb8z+j9FmRyMwYr
         DMsiCn+0LSKOR9Jm2p/tM3BBywyxSSxpj/tv+fvXqsbn4NhAunjITyFqoowN0IlzD8Ar
         J3GX0HmBl49VmRE99qy+9UglGyJPJBHkJ8jNj4Nqk+CKQMd3CyItIaBHzZmRKDNUWlId
         85b78P9lLJ4THf600lYnJGXzen3Ld6Q7PLdxd8dSOMgNSooVn+Flg2x7O1ekEWRfyTXL
         gMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qM7ryczK1TrfWAzLUUUGncdEXd1XmxHZByJuDH63eGQ=;
        b=u1Jb22W260FRvysdn/t3Czx+xOawUaaqz70hkHPOF6bxFquAMLFR6eR/U2Z66/c+Sr
         1UUn29pfWrw9PPlOAeuDg8Dptuc1MqKOA+xXLDnDh0NfxxayJ9+iaGbEczXM8F/062dX
         w5iVUeF7iE3WgFFoWNW7lepBmrOUADguO3O44C0ryl8JUpCIvUTGIMPiKMdDMHH7vcD7
         Pi+4nSc9w7qemcZQXr0bgaE+9XU5W2crfziu/Vevx2dKh6807fLSuPStJH58Hb0MNvIN
         Hcx1CeQf9PLPCEgQEkRfc7KIQj5lEeZw+Uyz/5GNQ2TPDUCRFz/eyLoolubZqXH/Xfzc
         FcBQ==
X-Gm-Message-State: AOAM530lXR/Q1WCkLutZqusCrhYVpeFKMAA8VN1fy7ZOsM0Dz6cjDySX
        TZyG9edP6qXtUEG3YZpQ2cg95lhogZs=
X-Google-Smtp-Source: ABdhPJy0UYxYIpeqh4u70cA1VjNtbc4kNz3QQjxeEjnlZQY9i7M7PauR4PC5R2JNhzehwgSt3CBrBw==
X-Received: by 2002:a9d:2271:: with SMTP id o104mr22156753ota.64.1635781487987;
        Mon, 01 Nov 2021 08:44:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i205sm4297894oih.54.2021.11.01.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:44:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.16
Date:   Mon,  1 Nov 2021 08:44:45 -0700
Message-Id: <20211101154445.591872-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.16 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.16

Thanks,
Guenter
------

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.16

for you to fetch changes up to 10f0d2ab9aa672707559d46601fd35544759ff70:

  hwmon: (nct7802) Add of_node_put() before return (2021-10-28 21:27:38 -0700)

----------------------------------------------------------------
hwmon updates for v5.16-rc1

New drivers:
- Maxim MAX6620

Notable functional enhancements:
- Add Asus WMI support to nct6775 driver, and list boards supporting it
- Move TMP461 support from tm401 driver to lm90 driver
- Add support for fanX_min, fanX_max and fanX_target to dell-smm driver,
  and clean it up while doing so
- Extend mlxreg-fan driver to support multiple cooling devices and
  multiple PWM channels. Also increase number of supported fan tachometers.
- Add a new customer ID (for ASRock) to nct6683 driver
- Make temperature/voltage sensors on nct7802 configurable
- Add mfg_id debugfs entry to pmbus/ibm-cffps driver
- Support configurable sense resistor values in pmbus/lm25066,
  and fix various coefficients
- Use generic notification mechanism in raspberrypi driver

Notable cleanup:
- Convert various devicetree bindings to dtschema, and add missing bindings
- Convert i5500_temp and tmp103 drivers to devm_hwmon_device_register_with_info
- Clean up non-bool "valid" data fields
- Improve devicetree configurability for tmp421 driver

----------------------------------------------------------------
Armin Wolf (9):
      hwmon: (i5500_temp) Convert to devm_hwmon_device_register_with_info
      hwmon: (raspberrypi) Use generic notification mechanism
      hwmon: (dell-smm) Remove unnecessary includes
      hwmon: (dell-smm) Add support for fanX_min, fanX_max and fanX_target
      hwmon: (dell-smm) Sort includes in alphabetical order
      hwmon: (dell-smm) Use strscpy_pad()
      hwmon: (dell-smm) Return -ENOIOCTLCMD instead of -EINVAL
      hwmon: (dell-smm) Add comment explaining usage of i8k_config_data[]
      hwmon: (dell-smm) Speed up setting of fan speed

Arun Saravanan Balachandran (1):
      hwmon: Add Maxim MAX6620 hardware monitoring driver

Brandon Wyman (2):
      hwmon: (pmbus/ibm-cffps) Add mfg_id debugfs entry
      hwmon: (pmbus/ibm-cffps) Use MFR_ID to choose version

Colin Ian King (1):
      hwmon: (mlxreg-fan) Fix out of bounds read on array fan->pwm

Daniel Dawson (1):
      hwmon: (nct6683) Add another customer ID for NCT6683D sensor chip on some ASRock boards

Denis Pauk (5):
      hwmon: (nct6775) Use superio_*() function pointers in sio_data.
      hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
      hwmon: (nct6775) Support access via Asus WMI
      hwmon: (nct6775) Add additional ASUS motherboards.
      hwmon: (nct6775) add ProArt X570-CREATOR WIFI.

Guenter Roeck (3):
      hwmon: (lm90) Introduce flag indicating extended temperature support
      hwmon: (lm90) Add basic support for TI TMP461
      hwmon: (tmp401) Drop support for TMP461

Krzysztof Adamski (11):
      hwmon: (tmp421) introduce MAX_CHANNELS define
      hwmon: (tmp421) introduce a channel struct
      dt-bindings: hwmon: add missing tmp421 binding
      hwmon: (tmp421) add support for defining labels from DT
      hwmon: (tmp421) support disabling channels from DT
      hwmon: (tmp421) support specifying n-factor via DT
      hwmon: (tmp421) really disable channels
      hwmon: (tmp421) support HWMON_T_ENABLE
      hwmon: (tmp421) update documentation
      hwmon: (tmp421) ignore non-channel related DT nodes
      dt-bindings: hwmon: allow specifying channels for tmp421

Krzysztof Kozlowski (14):
      dt-bindings: hwmon: lm90: convert to dtschema
      dt-bindings: hwmon: lm90: do not require VCC supply
      dt-bindings: hwmon: lm70: move to trivial devices
      dt-bindings: hwmon: ti,tmp108: convert to dtschema
      dt-bindings: hwmon: ti,tmp102: add bindings and remove from trivial devices
      dt-bindings: hwmon: lltc,ltc4151: convert to dtschema
      dt-bindings: hwmon: microchip,mcp3021: convert to dtschema
      dt-bindings: hwmon: sensirion,sht15: convert to dtschema
      dt-bindings: hwmon: lm75: remove gmt,g751 from trivial devices
      dt-bindings: hwmon: dps650ab: move to trivial devices
      dt-bindings: hwmon: hih6130: move to trivial devices
      dt-bindings: hwmon: jedec,jc42: convert to dtschema
      dt-bindings: hwmon: ibm,cffps: move to trivial devices
      dt-bindings: hwmon: jedec,jc42: add nxp,se97b

Linus Walleij (1):
      dt-bindings: hwmon: Convert NTC thermistor to YAML

Maxime Ripard (1):
      dt-bindings: hwmon: Add IIO HWMON binding

Oleksandr Natalenko (1):
      hwmon: (nct6775) add Pro WS X570-ACE

Oleksij Rempel (1):
      hwmon: (tmp103) Convert tmp103 to use new hwmon registration API

Oskar Senft (2):
      dt-bindings: hwmon: Add nct7802 bindings
      hwmon: (nct7802) Make temperature/voltage sensors configurable

Paul Fertser (1):
      hwmon: cleanup non-bool "valid" data fields

Rafael J. Wysocki (1):
      hwmon: (acpi_power_meter) Use acpi_bus_get_acpi_device()

Uwe Kleine-König (2):
      hwmon: (adt7x10) Make adt7x10_remove() return void
      hwmon: (max31722) Warn about failure to put device in stand-by in .remove()

Vadim Pasternak (5):
      hwmon: (mlxreg-fan) Extend the maximum number of tachometers
      hwmon: (mlxreg-fan) Extend driver to support multiply PWM
      hwmon: (mlxreg-fan) Extend driver to support multiply cooling devices
      hwmon: (mlxreg-fan) Modify PWM connectivity validation
      hwmon: (mlxreg-fan) Support distinctive names per different cooling devices

Wan Jiabing (2):
      hwmon: (tmp421) Add of_node_put() before return
      hwmon: (nct7802) Add of_node_put() before return

Yang Yingliang (1):
      hwmon: Fix possible memleak in __hwmon_device_register()

Zev Weiss (8):
      hwmon: (pmbus/lm25066) Add offset coefficients
      hwmon: (pmbus/lm25066) Adjust lm25066 PSC_CURRENT_IN_L mantissa
      hwmon: (pmbus/lm25066) Avoid forward declaration of lm25066_id
      hwmon: (pmbus/lm25066) Let compiler determine outer dimension of lm25066_coeff
      hwmon: (pmbus/lm25066) Mark lm25066_coeff array const
      hwmon: (pmbus/lm25066) Add OF device ID table
      hwmon: (pmbus/lm25066) Support configurable sense resistor values
      dt-bindings: hwmon/pmbus: Add ti,lm25066 power-management IC

 .../devicetree/bindings/hwmon/dps650ab.txt         |  11 -
 .../devicetree/bindings/hwmon/hih6130.txt          |  12 -
 .../devicetree/bindings/hwmon/ibm,cffps1.txt       |  26 -
 .../devicetree/bindings/hwmon/iio-hwmon.yaml       |  37 ++
 Documentation/devicetree/bindings/hwmon/jc42.txt   |  46 --
 .../devicetree/bindings/hwmon/jedec,jc42.yaml      |  78 +++
 .../devicetree/bindings/hwmon/lltc,ltc4151.yaml    |  41 ++
 Documentation/devicetree/bindings/hwmon/lm70.txt   |  22 -
 Documentation/devicetree/bindings/hwmon/lm90.txt   |  51 --
 .../devicetree/bindings/hwmon/ltc4151.txt          |  18 -
 .../devicetree/bindings/hwmon/mcp3021.txt          |  21 -
 .../bindings/hwmon/microchip,mcp3021.yaml          |  43 ++
 .../devicetree/bindings/hwmon/national,lm90.yaml   |  78 +++
 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  | 141 ++++
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |  44 --
 .../devicetree/bindings/hwmon/nuvoton,nct7802.yaml | 145 +++++
 .../bindings/hwmon/pmbus/ti,lm25066.yaml           |  54 ++
 .../devicetree/bindings/hwmon/sensirion,sht15.yaml |  43 ++
 Documentation/devicetree/bindings/hwmon/sht15.txt  |  19 -
 .../devicetree/bindings/hwmon/ti,tmp102.yaml       |  47 ++
 .../devicetree/bindings/hwmon/ti,tmp108.yaml       |  50 ++
 .../devicetree/bindings/hwmon/ti,tmp421.yaml       | 110 ++++
 Documentation/devicetree/bindings/hwmon/tmp108.txt |  18 -
 .../devicetree/bindings/trivial-devices.yaml       |  26 +-
 Documentation/hwmon/dell-smm-hwmon.rst             |   3 +
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/lm25066.rst                    |   2 +
 Documentation/hwmon/lm90.rst                       |  10 +
 Documentation/hwmon/max6620.rst                    |  46 ++
 Documentation/hwmon/tmp401.rst                     |  15 +-
 Documentation/hwmon/tmp421.rst                     |  10 +
 MAINTAINERS                                        |   4 +-
 drivers/acpi/scan.c                                |   1 +
 drivers/hwmon/Kconfig                              |  15 +-
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/abituguru3.c                         |   6 +-
 drivers/hwmon/acpi_power_meter.c                   |  13 +-
 drivers/hwmon/ad7414.c                             |   4 +-
 drivers/hwmon/ad7418.c                             |   6 +-
 drivers/hwmon/adm1021.c                            |   4 +-
 drivers/hwmon/adm1025.c                            |   4 +-
 drivers/hwmon/adm1026.c                            |   4 +-
 drivers/hwmon/adm1029.c                            |   4 +-
 drivers/hwmon/adm1031.c                            |   6 +-
 drivers/hwmon/adt7310.c                            |   3 +-
 drivers/hwmon/adt7410.c                            |   3 +-
 drivers/hwmon/adt7x10.c                            |   3 +-
 drivers/hwmon/adt7x10.h                            |   2 +-
 drivers/hwmon/amc6821.c                            |   8 +-
 drivers/hwmon/applesmc.c                           |   2 +-
 drivers/hwmon/asb100.c                             |   4 +-
 drivers/hwmon/asc7621.c                            |   4 +-
 drivers/hwmon/atxp1.c                              |  10 +-
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     | 103 ++-
 drivers/hwmon/dme1737.c                            |   4 +-
 drivers/hwmon/ds1621.c                             |   4 +-
 drivers/hwmon/ds620.c                              |   4 +-
 drivers/hwmon/emc6w201.c                           |   4 +-
 drivers/hwmon/f71805f.c                            |   4 +-
 drivers/hwmon/f71882fg.c                           |   4 +-
 drivers/hwmon/f75375s.c                            |   4 +-
 drivers/hwmon/fschmd.c                             |   4 +-
 drivers/hwmon/g760a.c                              |   2 +-
 drivers/hwmon/gl518sm.c                            |   4 +-
 drivers/hwmon/gl520sm.c                            |   4 +-
 drivers/hwmon/hwmon.c                              |   6 +-
 drivers/hwmon/i5500_temp.c                         | 114 ++--
 drivers/hwmon/ibmaem.c                             |   2 +-
 drivers/hwmon/ibmpex.c                             |   4 +-
 drivers/hwmon/it87.c                               |  12 +-
 drivers/hwmon/lineage-pem.c                        |   2 +-
 drivers/hwmon/lm63.c                               |   6 +-
 drivers/hwmon/lm77.c                               |   4 +-
 drivers/hwmon/lm78.c                               |   4 +-
 drivers/hwmon/lm80.c                               |   6 +-
 drivers/hwmon/lm83.c                               |   4 +-
 drivers/hwmon/lm85.c                               |   4 +-
 drivers/hwmon/lm87.c                               |   4 +-
 drivers/hwmon/lm90.c                               |  75 ++-
 drivers/hwmon/lm92.c                               |   4 +-
 drivers/hwmon/lm93.c                               |   4 +-
 drivers/hwmon/lm95241.c                            |   8 +-
 drivers/hwmon/ltc4151.c                            |   2 +-
 drivers/hwmon/ltc4215.c                            |   2 +-
 drivers/hwmon/ltc4261.c                            |   4 +-
 drivers/hwmon/max16065.c                           |   2 +-
 drivers/hwmon/max1619.c                            |   4 +-
 drivers/hwmon/max1668.c                            |   4 +-
 drivers/hwmon/max31722.c                           |   8 +-
 drivers/hwmon/max6620.c                            | 514 +++++++++++++++
 drivers/hwmon/max6639.c                            |   4 +-
 drivers/hwmon/max6642.c                            |   2 +-
 drivers/hwmon/mlxreg-fan.c                         | 138 ++--
 drivers/hwmon/nct6683.c                            |   3 +
 drivers/hwmon/nct6775.c                            | 717 ++++++++++++++-------
 drivers/hwmon/nct7802.c                            | 131 +++-
 drivers/hwmon/pc87360.c                            |   4 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |  23 +-
 drivers/hwmon/pmbus/lm25066.c                      |  88 ++-
 drivers/hwmon/raspberrypi-hwmon.c                  |   2 +-
 drivers/hwmon/sch5636.c                            |   4 +-
 drivers/hwmon/sht21.c                              |   4 +-
 drivers/hwmon/sis5595.c                            |   4 +-
 drivers/hwmon/smm665.c                             |   2 +-
 drivers/hwmon/smsc47b397.c                         |   4 +-
 drivers/hwmon/smsc47m192.c                         |   4 +-
 drivers/hwmon/thmc50.c                             |   4 +-
 drivers/hwmon/tmp103.c                             | 105 ++-
 drivers/hwmon/tmp401.c                             |  31 +-
 drivers/hwmon/tmp421.c                             | 186 +++++-
 drivers/hwmon/via686a.c                            |   4 +-
 drivers/hwmon/vt1211.c                             |   4 +-
 drivers/hwmon/vt8231.c                             |   4 +-
 drivers/hwmon/w83627ehf.c                          |   8 +-
 drivers/hwmon/w83627hf.c                           |   6 +-
 drivers/hwmon/w83781d.c                            |   4 +-
 drivers/hwmon/w83791d.c                            |   4 +-
 drivers/hwmon/w83792d.c                            |   6 +-
 drivers/hwmon/w83793.c                             |   6 +-
 drivers/hwmon/w83795.c                             |   6 +-
 drivers/hwmon/w83l785ts.c                          |   4 +-
 drivers/hwmon/w83l786ng.c                          |   4 +-
 123 files changed, 2895 insertions(+), 954 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/dps650ab.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc4151.txt
 delete mode 100644 Documentation/devicetree/bindings/hwmon/mcp3021.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/national,lm90.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/sht15.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/tmp108.txt
 create mode 100644 Documentation/hwmon/max6620.rst
 create mode 100644 drivers/hwmon/max6620.c
