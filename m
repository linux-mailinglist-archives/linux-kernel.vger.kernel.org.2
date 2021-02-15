Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02B31B4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 05:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBOEm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 23:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBOEmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 23:42:21 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF32C061574;
        Sun, 14 Feb 2021 20:41:40 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id s107so4998399otb.8;
        Sun, 14 Feb 2021 20:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xvNrMCNzeG5peRpvoYDXlqkLQtIOmANJBYJ6+Met1ik=;
        b=Zc2HjOiEpoRZipF3j47aZ9UNmDjbLhP48VhnL9+WrloRaq688ocY/vyWs6eM54ULdQ
         JVzGAx8qYcUMT95HIR6qrPWpzOyh5GcEdaYl3MhIOGRom8f6bbwQ8Ucb6YSKHRiRaCDd
         qXJli+FCuUqPlea6QFH3z8JrVhqIZPQSl4I/IVunQGXAwNH73Wl+crf/RRXXLIyNZtx8
         fWyOI8OWMMi4C196oTBpmEoSPutO6A22qVOr1wDvghVKvNuZ/85pHBy4oYCWiI+d5KzL
         IFdHIWUrmZwEIB4lq6QOnGYuR8fkT9QTMokwMiIN56eumoDJIGs+lSN//sMDfzvUZOT7
         wGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xvNrMCNzeG5peRpvoYDXlqkLQtIOmANJBYJ6+Met1ik=;
        b=bxbStxutfkGO0+tc+/pLryJxLF4f30uasbs31//3kmLfz28mz9wmLDzzSamo/9my7t
         lxXQNlM//qGL9mcQSWz1C2pOre19LyJ0cBIf5F15lEy1VtlZPThkSKO/B/ulxAEDYe+g
         NacOhw80baxWdI8hiTq5yZxRhQ1hIP5NBQADOAMyQGmOrVzTSrH0v05RVGUciIdnA+z8
         CAcFuMgvagNee8Twj0qzTd/+YFiQcQbiH9cup+C1eO/fsZkMlKEf6x11vMFOG5Owcljp
         JFWWmLKIzI2gvVyLpNipBIiVE9EAWFGPPx8YT0tU5qnHHKGPDpbS8V7FeL5lTXMyn1mo
         fbzw==
X-Gm-Message-State: AOAM5303rx2Ao60+9mulQuoiLKgzGDTzGWWmSe95Tw6wzwk8bVdF4Tld
        issLZgKmKGi84mRx9iRL4LZoTVyYeio=
X-Google-Smtp-Source: ABdhPJwODt0seuDPiIfGBYDb0e9YwpwXJ9Jc2K68Zt37I8Lvt3MxXSAsNhtZHqXtIXsTDbG2cGxu5Q==
X-Received: by 2002:a9d:7986:: with SMTP id h6mr9991790otm.310.1613364099891;
        Sun, 14 Feb 2021 20:41:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z24sm3454358ote.1.2021.02.14.20.41.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Feb 2021 20:41:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.12
Date:   Sun, 14 Feb 2021 20:41:38 -0800
Message-Id: <20210215044138.35831-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.12 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.12

Thanks,
Guenter
------

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.12

for you to fetch changes up to 6ab3332cc692ad04dfa30c92d3391aea8b971ef2:

  MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE (2021-02-12 07:02:55 -0800)

----------------------------------------------------------------
hwmon updates for v5.12

- New drivers
  Texas Instruments TPS23861 driver
  AHT10 Temperature and Humidity Sensor Driver

- Support for new chips/variants to existing drivers
  Add AMD family 19h model 30h x86 match to amd_energy driver
  Add Zen3 Ryzen Desktop CPUs support to k10temp driver
  Add support for MAX16508 to max16601 driver
  Support revision "B" of max31785
  Add support for ASRock boards to nct6683 driver

- Driver removals
  (abx500) Decomission abx500 driver

Various other minor fixes and improvements.

----------------------------------------------------------------
Blaž Hrastnik (1):
      hwmon: (nct6683) Support ASRock boards

Dan Carpenter (1):
      hwmon: (aht10) Unlock on error in aht10_read_values()

Eddie James (2):
      hwmon: (pmbus) Add a PMBUS_NO_CAPABILITY platform data flag
      hwmon: (pmbus/ibm-cffps) Set the PMBUS_NO_CAPABILITY flag

Erik Rosen (2):
      hwmon: (pmbus) Clear sensor data after chip write
      hwmon: (pmbus/lm25066) Remove unnecessary pmbus_clear_cache function call

Gabriel Craciunescu (1):
      hwmon: (k10temp) Zen3 Ryzen Desktop CPUs support

Guenter Roeck (3):
      hwmon: (abx500) Decomission abx500 driver
      hwmon: (pmbus/max16601) Determine and use number of populated phases
      hwmon: (pmbus/max16601) Add support for MAX16508

Jiapeng Zhong (2):
      hwmon: (applesmc) Assign boolean values to a bool variable
      hwmon: (pmbus) Simplify the calculation of variables

Johannes Cornelis Draaijer (datdenkikniet) (1):
      hwmon: Add AHT10 Temperature and Humidity Sensor Driver

Matthew Barth (1):
      hwmon: (pmbus/max31785) Support revision "B"

Mauro Carvalho Chehab (1):
      hwmon: (ina2) update ti,ina2xx.yaml reference in documentation

Naveen Krishna Chatradhi (1):
      hwmon: (amd_energy) Add AMD family 19h model 30h x86 match

Paul Barker (2):
      hwmon: (pwm-fan) Store tach data separately
      hwmon: (pwm-fan) Support multiple fan tachometers

Robert Marko (3):
      dt-bindings: hwmon: Add TI TPS23861 bindings
      hwmon: add Texas Instruments TPS23861 driver
      MAINTAINERS: Add entry for Texas Instruments TPS23861 PoE PSE

Thomas Hebb (1):
      hwmon: (dell-smm) Add XPS 15 L502X to fan control blacklist

Tian Tao (5):
      hwmon: (w83627ehf) Switch to using the new API kobj_to_dev()
      hwmon: (gpio-fan) Switch to using the new API kobj_to_dev()
      hwmon: (max6650) Switch to using the new API kobj_to_dev()
      hwmon: (aspeed-pwm-tacho) Switch to using the new API kobj_to_dev()
      hwmon: (da9052) Switch to using the new API kobj_to_dev()

Tom Rix (1):
      hwmon: (smsc47m1) Remove 'h' from printk format specifier

Uwe Kleine-König (1):
      hwmon: (pwm-fan) stop using legacy PWM functions and some cleanups

Zheng Yongjun (1):
      hwmon: (pc87360) convert comma to semicolon

 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |  51 ++
 Documentation/hwmon/ab8500.rst                     |  26 -
 Documentation/hwmon/abx500.rst                     |  32 --
 Documentation/hwmon/aht10.rst                      |  46 ++
 Documentation/hwmon/ina2xx.rst                     |   2 +-
 Documentation/hwmon/index.rst                      |   4 +-
 Documentation/hwmon/max16601.rst                   | 197 +++----
 Documentation/hwmon/nct6683.rst                    |   1 +
 Documentation/hwmon/tps23861.rst                   |  41 ++
 MAINTAINERS                                        |   9 +
 drivers/hwmon/Kconfig                              |  34 +-
 drivers/hwmon/Makefile                             |   3 +-
 drivers/hwmon/ab8500.c                             | 224 --------
 drivers/hwmon/abx500.c                             | 487 -----------------
 drivers/hwmon/abx500.h                             |  69 ---
 drivers/hwmon/aht10.c                              | 348 ++++++++++++
 drivers/hwmon/amd_energy.c                         |   1 +
 drivers/hwmon/applesmc.c                           |   2 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   4 +-
 drivers/hwmon/da9052-hwmon.c                       |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   7 +
 drivers/hwmon/gpio-fan.c                           |   2 +-
 drivers/hwmon/k10temp.c                            |   3 +-
 drivers/hwmon/max6650.c                            |   2 +-
 drivers/hwmon/nct6683.c                            |   3 +
 drivers/hwmon/pc87360.c                            |   4 +-
 drivers/hwmon/pmbus/Kconfig                        |   4 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |   2 +-
 drivers/hwmon/pmbus/lm25066.c                      |   5 -
 drivers/hwmon/pmbus/max16601.c                     |  91 +++-
 drivers/hwmon/pmbus/max31785.c                     |  13 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  12 +-
 drivers/hwmon/pwm-fan.c                            | 159 +++---
 drivers/hwmon/smsc47m1.c                           |   2 +-
 drivers/hwmon/tps23861.c                           | 601 +++++++++++++++++++++
 drivers/hwmon/w83627ehf.c                          |   2 +-
 include/linux/pmbus.h                              |   9 +
 37 files changed, 1416 insertions(+), 1088 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
 delete mode 100644 Documentation/hwmon/ab8500.rst
 delete mode 100644 Documentation/hwmon/abx500.rst
 create mode 100644 Documentation/hwmon/aht10.rst
 create mode 100644 Documentation/hwmon/tps23861.rst
 delete mode 100644 drivers/hwmon/ab8500.c
 delete mode 100644 drivers/hwmon/abx500.c
 delete mode 100644 drivers/hwmon/abx500.h
 create mode 100644 drivers/hwmon/aht10.c
 create mode 100644 drivers/hwmon/tps23861.c
