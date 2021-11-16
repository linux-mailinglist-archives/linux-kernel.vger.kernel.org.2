Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD73A453B51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKPVAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhKPVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:00:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431CC061570;
        Tue, 16 Nov 2021 12:57:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so626564edd.10;
        Tue, 16 Nov 2021 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwEHNRU31nXjWRkBQrk3BtdiOsYP/Byx35bv8rgwXIk=;
        b=fHiwtErANnN/Sdzt9e+yGShBgYvcE0v4qoVWRLGGAB2nNQHi2iKDJG/j+P6MguMU/N
         aJE+IooTvUWxpo0gToD5I4gOiWVz3LoNNi9ddYpxls2O5Y3+jCugd/uY+Zmzuf14enlW
         OFrzXxhc/c8UFAgij/v244496pgD8lo0+GHP+rZRNFvho86Otf6r+LuUB1TS1A8BoF1t
         3e9s5tjW7AdCAvoJdASc2/fgPhBhuR6ri+JuhCI9G6eSHk2PW0TmA0wrMztV3hd0UZ6c
         OdZV9mrH6OUGoVpckj1s9jr9J6YE6axMspkxMENJgjC7byuZtZqwcel66XVGUNJIr9iF
         qagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwEHNRU31nXjWRkBQrk3BtdiOsYP/Byx35bv8rgwXIk=;
        b=aDr3h1L+l1V85ZBjg1Az/w4fOvHJk0tskRq0mRVN/Dcekdsai6jspmQBtD2XACmBQx
         qQ5EQEnFv4hRga9aAwO03WRc4FDfGLLD0qePo479Rsfq9bWBjilAyRR+U7+yP2vCwUeL
         Gv4pJEi705YBtfFVIaAxJ+Vs7E2QkgQOL0KPUC6rgBgA7VN4A1KQStIe3KB6orNrp/yo
         HpfB4tVHoNS/I4N7R1rEgE8dqy1zkdGqrsFrjrDddbA0LerkRUZ8su7o2q8JEEYsAXJA
         M4UP57G50cnST0WhHN0yA4h8aYHHUT4YDmOAPFM+hRC62NfBEAIxwgRQV4fRnQg3GbEx
         Avfg==
X-Gm-Message-State: AOAM533lpq/S7nQ7I4FBjdPmh2jpoVM1Z9q6yGvL3FKcmDBWJynJtei2
        hTmqtlv/KA1z7ghfX7oxAXo=
X-Google-Smtp-Source: ABdhPJxyqgj6gsmcs9sZc4tVYZOLcQGF6koMbkVncG32hfvhsfpgedir0efxnuy+EDyv96lqDq4gBQ==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr13827770edt.177.1637096273264;
        Tue, 16 Nov 2021 12:57:53 -0800 (PST)
Received: from localhost.localdomain ([94.179.50.170])
        by smtp.gmail.com with ESMTPSA id qf8sm9042389ejc.8.2021.11.16.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:57:52 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, kernel@maidavale.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 0/2] Update ASUS WMI supported boards
Date:   Tue, 16 Nov 2021 22:57:42 +0200
Message-Id: <20211116205744.381790-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support by WMI interface provided by Asus for B550/X570 boards: 
* PRIME X570-PRO,
* ROG CROSSHAIR VIII HERO
* ROG CROSSHAIR VIII DARK HERO
* ROG CROSSHAIR VIII FORMULA
* ROG STRIX X570-E GAMING
* ROG STRIX B550-I GAMING
* ROG STRIX B550-E GAMING

Add support by WMI interface provided by Asus for X370/X470/
B450/X399 boards:
* ROG CROSSHAIR VI HERO,
* PRIME X399-A,
* PRIME X470-PRO,
* ROG CROSSHAIR VI EXTREME,
* ROG CROSSHAIR VI HERO (WI-FI AC),
* ROG CROSSHAIR VII HERO,
* ROG CROSSHAIR VII HERO (WI-FI),
* ROG STRIX B450-E GAMING,
* ROG STRIX B450-F GAMING,
* ROG STRIX B450-I GAMING,
* ROG STRIX X399-E GAMING,
* ROG STRIX X470-F GAMING,
* ROG STRIX X470-I GAMING,
* ROG ZENITH EXTREME,
* ROG ZENITH EXTREME ALPHA.

I have removed "ROG STRIX Z390-F GAMING" from list of supported boards in 
asus_wmi_sensors that I have added by mistake. I had misunderstood a 
comment in the [1] issue.

I have added separate records for each of modules in MAINTAINERS file. 
Before it was one shared recors for both of modules.

Could you please review?

Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

[1]: https://github.com/electrified/asus-wmi-sensors/issues/78.

---
Changes in v12:
- asus_wmi_sensors: Remove "ROG STRIX Z390-F GAMING" added by mistake.
- Create separate record about asus_wmi_sensors.

Changes in v11:
- asus_wmi_sensors: Add "ROG STRIX Z390-F GAMING" to list of supported boards
  in asus_wmi_sensors.

Changes in v10:
- Use long for sensor values.
- Remove unrequired linux/hwmon-sysfs.h
- Add "ROG STRIX B550-I GAMING" board support in asus_wmi_ec_sensors.
- Change code style in error status return.
- Remove unuses wmi.buffer and fix type of source in asus_wmi_sensors.

Changes in v9:
- Fix memory leaks in asus_wmi_ec_block_read()
- Fix buffer and parameter lengths in decode and encode algorithms
- Simplify encoding in read query
- Reshuffle structures to make pointer arithmetics simpler or
  no-op in some cases
- Shuffle parameters in some functions to make it more logical
- Use temporary variable for EC info data structure
- Many indentation fixes to improve readability (breaks 80 characters rule)
- Fix memory leaks in asus_wmi_sensors:asus_wmi_*().

Changes in v8:
- Add seprate patch for ProArt X570-CREATOR WIFI support.
- Fix codestyle in defines and comments.
- Fix buffer length calculation.
- Use hex2bin/bin2hex for convert values in buffers.
- Remove unrequired acpi_os_free usage.
- Call mutex_lock inside of functions.

Changes in v7:
- Use  for directly get sensors list by board.
- Add depends on ACPI_WMI to Kconfig.
- Add response buffer size check in asus_wmi_ec_decode_reply_buffer.
- Clean up defines names.

Changes in v6:
- asus_wmi_ec_sensors: Generate query for all sensors on sensors setup
- asus_wmi_ec_sensors: Move binary to sensor value logic to separate 
  get_sensor_value (by Eugene Shalygin)
- asus_wmi_ec_sensors: Use acpi_os_free without NULL pointer check.
- Add asus_wmi_sensor to documentation index.
- Add asus_wmi_ec_sensor to documentation index.

Changes in v5:
- Fixes build issue reported by kernel test robot with disabled ACPI_WMI.
- asus_wmi_sensors: Remove sensor->name check as always evaluated to true.

Changes in v4:
 - Implement wmi driver instead platform driver.
 - Update documentation with known issues.

Changes in v3:
 - Use MODULE_DEVICE_TABLE for match devices.
 - asus_wmi_ec_sensors: Use get_unaligned_be32 instead incorrectly used 
   get_unaligned_le32.
 - Add documentaion for drivers.

Changes in v2:
 - asus_wmi_ec_sensors: Rename asus_wmi_sensors to asus_wmi_ec_sensors for 
   B550/X570 boards.
 - asus_wmi_ec_sensors: Use utf8s_to_utf16s/utf16s_to_utf8s instead handmade 
   fuctions.
 - asus_wmi_ec_sensors: Use post increment.
 - asus_wmi_ec_sensors: Use get_unaligned* for convert values.
 - asus_wmi_ec_sensors: Use PTR_ERR_OR_ZERO.
 - asus_wmi_ec_sensors: Specify per-board sensors in a declarative way 
   (by Eugene Shalygin).
 - asus_wmi_sensors: Add support for X370/X470/B450/X399 boards.

---

Denis Pauk (2):
  hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
  hwmon: (asus_wmi_sensors) Support X370 Asus WMI.

 Documentation/hwmon/asus_wmi_ec_sensors.rst |  38 ++
 Documentation/hwmon/asus_wmi_sensors.rst    |  76 +++
 Documentation/hwmon/index.rst               |   2 +
 MAINTAINERS                                 |  14 +
 drivers/hwmon/Kconfig                       |  24 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 621 ++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 664 ++++++++++++++++++++
 8 files changed, 1441 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.33.0

