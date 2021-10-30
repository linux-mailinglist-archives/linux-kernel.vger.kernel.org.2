Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23A440828
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 11:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJ3JT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 05:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3JTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 05:19:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01CDC061570;
        Sat, 30 Oct 2021 02:17:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j9so25895628lfu.7;
        Sat, 30 Oct 2021 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHuy2cIt0h9Kxk01SYVC1I9qFk0wtgciIUKFEik4ujw=;
        b=gaP8mpkWDvuFupEndZ9mSoykhDLxP09fXsUqwqskuGXXS/CtXWzimP5m2R++rileBU
         dKsjMBMt+3EF08tsyXVCOpX29fe5Zn+wVuXbyneWkw35DRmPmAQY2uQmgKuSxlYJcyIg
         ZFoVaTy1Ew5ePgIE9lfQJy8hx5zOqww29Y8fY5BWvnwPSkWJTdkZdfuleRyDorO7V0eu
         daczcnxuVSYV5g3EGsf5n0ojwP/pdLP7e4yXW9XOXs3F+btq7bOlymJShBumkynmdciE
         OqcEcUkHMVlr808tQv5XCHgAyWBOkJu6T2X8zihLC+CKR4iz0dv0yoTs078lhenJqhOg
         6AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHuy2cIt0h9Kxk01SYVC1I9qFk0wtgciIUKFEik4ujw=;
        b=A9xXA75WVTwfIBIBuYtWNexj3pJ6iyyu5+MoY7HafgXGP+s81kZgdUsHX7wOerG4ON
         hDmq/owAHXN49ndYcCey/CYrJQxu4QlZcwi4EG8TonNnSXZRn0rTIjVR9aaRyDV14yOQ
         7IBcuhGrTdMaNND/VBZHca4jvtkQX4plzuhp+LZAkBy8l3D/vDhbXomO4guyAhKpUb/y
         BdiT+Gh6DoKd/6H6GwpOeZGsm9Lep+CxyFCRf7BzAs1eo9Nt2HnL/Wv+/P+aIGcI6tZP
         BbogQNcdWttC9ivOJ8zqrNw3CA7+oSRRfVc9YW3xU2IsPsuO/1ja8YCBrzuMCZ7tikxp
         cVnQ==
X-Gm-Message-State: AOAM530whRXFHZnqJxtVi6UJ/e9jo0ZwGbPs04JJhwNjmfwwG9MZ5qcn
        T5sS7I6+kSiy/3oXD2zo4HAw02IjjIy4pA==
X-Google-Smtp-Source: ABdhPJy+RQJUBUePVR7zQUFtAE9+3e8gj5hssd9LCX1PxCbYfbjCPikJ7aEWslCSHkDW8nvWoKKmEQ==
X-Received: by 2002:a05:6512:3697:: with SMTP id d23mr15234889lfs.187.1635585444050;
        Sat, 30 Oct 2021 02:17:24 -0700 (PDT)
Received: from localhost.localdomain ([94.179.35.89])
        by smtp.gmail.com with ESMTPSA id x26sm868195ljh.24.2021.10.30.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 02:17:23 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/2] Update ASUS WMI supported boards
Date:   Sat, 30 Oct 2021 12:17:03 +0300
Message-Id: <20211030091706.25470-1-pauk.denis@gmail.com>
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

@Andy Shevchenko: I have added your changes to asus_wmi_ec_sensors. Have I 
    correctly applied changes? Thank you.
@Guenter Roeck: I have adeed comments about units in the 
    asus_wmi_scale_sensor_value.

I have added ACPI_FREE for results to all case of 
usage wmi_evaluate_method. Is it correct?

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
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

 Documentation/hwmon/asus_wmi_ec_sensors.rst |  35 ++
 Documentation/hwmon/asus_wmi_sensors.rst    |  74 +++
 Documentation/hwmon/index.rst               |   2 +
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  24 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 612 ++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 657 ++++++++++++++++++++
 8 files changed, 1414 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 10f0d2ab9aa672707559d46601fd35544759ff70
-- 
2.33.0

