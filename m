Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1D437EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhJVUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhJVUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:03:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127CC061764;
        Fri, 22 Oct 2021 13:01:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e19so230885edy.0;
        Fri, 22 Oct 2021 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZja5cIzLz+Lu2kHmv8dqHZy1vZFHhj+hFqgwv/88Cc=;
        b=E5pqvPMjsUCQC8LOBOVke87j1ZAlvqMEfUbVKnRBh5pvMktt7TOPOJ5UQjFArYW8su
         pHoXPNHfX8uRVbWv9zY7KR+0ZHKR3CVactpLHNhTmlDxUMAcvDWFtS1QRDg2VNAMD2jF
         K9f5aEWA3V4dSveNAS+vGH/KYCecUVkPyOb5Isdo+qeax5QFna7jiEloxQ18LRbmifp6
         JErjFQGXp+ccy/DeXFiym2bqm4RfvSjLfJ8AgwGOMh9imaM/fXCIa15JHqF6t1mHFLVl
         Nos1gK3ShULnE93TYlxYtEmrXMoapSpBTDEGVHTNikWATNgE7wt+V4r6KupnPdql3/3o
         rCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YZja5cIzLz+Lu2kHmv8dqHZy1vZFHhj+hFqgwv/88Cc=;
        b=RRTtjPhfxrlEchmL2IseeqqEqKwziSbaY07qwUrvMs3jHcbMeZRlBJds4nXax/UIC+
         YUWmgFMYb8XFRn2gWG6IbsCoELxMYHaF1qb98davhR0tFK5LqsElpf6FymAtevK+L7Xe
         W6yygZSc+aFgjy+XDjOPNSX1jJscQdUxae9CwRGG/aE8sESSNBgYYZRbfKDzCna0+bBG
         91EVqEifhDjUlhcR0/cd/aE5mvha39fH6WD0bgW4xmcwwQMgUcfQTOjyEohaFs5B6sa+
         M0nMnAnb19BhG80ZaosgqkMBgco7i97nC2g4gYecMDAqoBe6vIU442zaLW1kQJ2GocBG
         lh0g==
X-Gm-Message-State: AOAM532PsEbXn7Rs1JOzZ7Z+cgKBxl2E98WDE4TPslNwa3Q4EE3GT8t5
        LS4Fd0XagEzH3a66Elw7KlcI0cza1NcZGA==
X-Google-Smtp-Source: ABdhPJy3ewfgrcmq7AfLJiqEmIdDRKe4jJ4gStSVXEiEOBQj87YzaiiRvSm0KyJgeEXjxvk1HpK9Yg==
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr1813234ejc.353.1634932889439;
        Fri, 22 Oct 2021 13:01:29 -0700 (PDT)
Received: from localhost.localdomain ([94.179.44.246])
        by smtp.gmail.com with ESMTPSA id d3sm4213475ejb.35.2021.10.22.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:01:29 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] Update ASUS WMI supported boards
Date:   Fri, 22 Oct 2021 23:00:28 +0300
Message-Id: <20211022200032.23267-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ASUS WMI supported boards

Add support by WMI interface privided by Asus for B550/X570 boards: 
* PRIME X570-PRO,
* ROG CROSSHAIR VIII HERO
* ROG CROSSHAIR VIII DARK HERO
* ROG CROSSHAIR VIII FORMULA
* ROG STRIX X570-E GAMING
* ROG STRIX B550-E GAMING

Add support by WMI interface privided by Asus for X370/X470/
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

Add support to nct6775:
* ProArt X570-CREATOR WIFI.

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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


Denis Pauk (3):
  hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
  hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
  hwmon: (nct6775) Add ProArt X570-CREATOR WIFI support.

 Documentation/hwmon/asus_wmi_ec_sensors.rst |  35 ++
 Documentation/hwmon/asus_wmi_sensors.rst    |  74 +++
 Documentation/hwmon/index.rst               |   2 +
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  24 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 618 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 616 +++++++++++++++++++
 drivers/hwmon/nct6775.c                     |   1 +
 9 files changed, 1380 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: c0d79987a0d82671bff374c07f2201f9bdf4aaa2
-- 
2.33.0

