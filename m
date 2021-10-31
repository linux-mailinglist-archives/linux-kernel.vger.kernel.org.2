Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34762441103
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhJaVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhJaVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:36:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87405C061714;
        Sun, 31 Oct 2021 14:33:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s13so18310880wrb.3;
        Sun, 31 Oct 2021 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjWB/oIIVDw6rf0oBoNalWFM14/FZCTWVcKgDXNXbNg=;
        b=lZO/1m/5fR6QzApKkpy+bR70wQ4I25QuMV+MyVzF8njwojfyR9wfvWgzF4uudxwaf/
         LA1vBksCk7h3MZSRHV+A+QZ/hGmVl/p8Ipfk09vaux4fwGEHpsJQQUt4ZOlVVjqsADn/
         RIHke0yBwrIlQCwX+HasBRSZ6AUZmrYK3gYWa/2fpFFygU+a3BBsowBBxSZ2SmhDPumP
         3QLTTuIJpnrUbDldqHEjMmxQNIAjuOlpZifh0D6J6lGplqEjm4b2wd3IaAiDrR42qhEl
         4pynBqN2mcL+CvDvaaNBXCvplARsnZ7RLBBfz/Q3z3s8AjtgtJEpDmx4qacw+/lUfSmd
         xTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjWB/oIIVDw6rf0oBoNalWFM14/FZCTWVcKgDXNXbNg=;
        b=02KLmPE9msmiYTEOgvnEJixOU4ok3PRuxaCiZV3JAtSdRjZbIKaQr5qhZnbUEGKyAu
         VBkkQVQJRyEFsYNoSh8VTJuBx15vlIVCc+1T3u+wahI9SwuU8xnp1hgszwVQyyA8PqxA
         IsWBiXcJ6rnFTRUfBtkADKhd/MW5qF6rbYsZiytMG3uKiwxfktKz6tEKecufH1sdjYGs
         6qY7a/bz7jCeegomppmtwaEHbEdPhj7mERgwQoLcDtxDeQAjKKxJD7uCl/Vema9aKV2t
         Whdm4HVpqEKPMNUIf/TbqzHP9f1YrcVAmWpfIedK24K7h6hBmfzrpRzZwjmYkUiwSVKR
         bzhg==
X-Gm-Message-State: AOAM533a1BANwYWbeJpFVQJ0mQaosu12qCF3Po3vyOQ0vfHWbTYlouBX
        AbSOv19MiNPadadBKZ1aKD8=
X-Google-Smtp-Source: ABdhPJw/LkqJ0iLXrjETfFeMCKvEQPxEJ4kV/FinXXoIv2xbYRXgvZWVNUyAKQdDrqd0MoC1GKjLqg==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr22430791wrm.328.1635716007156;
        Sun, 31 Oct 2021 14:33:27 -0700 (PDT)
Received: from localhost.localdomain ([94.179.15.8])
        by smtp.gmail.com with ESMTPSA id n7sm10526158wro.68.2021.10.31.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 14:33:26 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, kernel@maidavale.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] Update ASUS WMI supported boards
Date:   Sun, 31 Oct 2021 23:32:54 +0200
Message-Id: <20211031213257.123049-1-pauk.denis@gmail.com>
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

@Guenter Roeck: I have changed type of all sensor values to long.

@Ed Brindley: Could you please check changes in asus_wmi_sensors?

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
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
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  24 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 621 ++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 664 ++++++++++++++++++++
 8 files changed, 1435 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 10f0d2ab9aa672707559d46601fd35544759ff70
-- 
2.33.0

