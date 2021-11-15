Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70131451C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348396AbhKPAQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349521AbhKOVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 16:24:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685DEC0432CF;
        Mon, 15 Nov 2021 13:09:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z10so51272876edc.11;
        Mon, 15 Nov 2021 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/2FQETx8FEx1p6V00eKeH8EmRePqC5+wOFKD9W460c=;
        b=JbcFJG6M4AX8EjEt4sGNwwRelnYqolffj+7ky8nQW1TZlMPaa6Re8/ee7VAkbck/eC
         yH7JguqNWDaGrK3jQhH4p/t4xkb7jj+PWfRR6Sh9vsIlrKz9dguov3Rmhwp09+wRoZBN
         YxSrw6nhWgxaNVxJDvR2sSjK+GmD1+YwIEmv4jmRUBmgTwzkOdRv9xQ6Nk7enicTvrTG
         pmrq6lRo1jDtDRxkKMe3eyoTn010Lj6y4zi4Gpqo1mEdtsQKuy6tn7PcxCeD3Ew/JKSC
         hAPrp37Lp/sIlMAcKOnqR1bHB1istBgR1kFX4NdToammGjQhNB71iGFQvU73qNEl0LjC
         290Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/2FQETx8FEx1p6V00eKeH8EmRePqC5+wOFKD9W460c=;
        b=AuqwQMOPmc4T3vZfV4p8hL5tkR7LLo0qdOZ/ogSO0e0ezsw1FmkouJhpdouJBQC579
         ddhtmXE3kFIce90J+d0Dzd7ZVK9JT7COpmeQTdjYCJb0v3Z0ICzGulW9KQuQ4VszNiaY
         5BXJ4GBjtD7jpqYQe35HRwp4JD4ZEqtzN4wVI+I76PAa4OHqagYAd3/gvcQWWDdWVH8n
         51HCooVDb3L61ynrirxM2zAIyrxeWdlrp6gOxb7fte1yYOYALLkWyErdtpPADhn0EIRg
         jBQN5iNWhHLr7meLaTek3ql1CnNsjcmG2CORNjGlbGyBji0FbqnjClHYhgdfulgkWMJr
         AHIQ==
X-Gm-Message-State: AOAM531QuOzDMPth8CeprOWPuzSG3h7mimNLaSvbZpEPTfa+G+LLbAAD
        jckWP39Lp6vfAb5zVFEJtwFSTvsRCU2HzQ==
X-Google-Smtp-Source: ABdhPJzMLg2VQCembb/x2+0G8hhTQk3xDyBBBoE5ynG6w/kd4v4YVWtgN8vctgr1FGUprLPfwKJMpw==
X-Received: by 2002:a05:6402:1292:: with SMTP id w18mr2589931edv.46.1637010562841;
        Mon, 15 Nov 2021 13:09:22 -0800 (PST)
Received: from localhost.localdomain ([178.94.43.128])
        by smtp.gmail.com with ESMTPSA id h10sm5022678edr.95.2021.11.15.13.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:09:22 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, kernel@maidavale.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/2] Update ASUS WMI supported boards
Date:   Mon, 15 Nov 2021 23:08:39 +0200
Message-Id: <20211115210842.11972-1-pauk.denis@gmail.com>
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
* ROG STRIX Z390-F GAMING
* ROG STRIX B450-E GAMING,
* ROG STRIX B450-F GAMING,
* ROG STRIX B450-I GAMING,
* ROG STRIX X399-E GAMING,
* ROG STRIX X470-F GAMING,
* ROG STRIX X470-I GAMING,
* ROG ZENITH EXTREME,
* ROG ZENITH EXTREME ALPHA.

I have added "ROG STRIX Z390-F GAMING" to list of supported boards in 
asus_wmi_sensors.

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
Changes in v11:
- Add "ROG STRIX Z390-F GAMING" to list of supported boards in 
  asus_wmi_sensors.

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
 Documentation/hwmon/asus_wmi_sensors.rst    |  77 +++
 Documentation/hwmon/index.rst               |   2 +
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  24 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 621 ++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 665 ++++++++++++++++++++
 8 files changed, 1437 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 879af177e7210478f39ea366ce6d95e1e7a48d0e
-- 
2.33.0

