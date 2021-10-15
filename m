Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D145142E892
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhJOGAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOGAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:00:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917CC061570;
        Thu, 14 Oct 2021 22:58:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d9so33333501edh.5;
        Thu, 14 Oct 2021 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7lf7LUGPaS4QDss+KWCnNxX2/jz7fWtBbSCfzXNCrg=;
        b=OUhHyh3COTqO1BLIuRtk2tPNbsmxX5WrZ5NsVL6FIkd5owHBdlYIT9Z4EKh+1BJHCH
         tgZPUX5ydiO/z8LXIozWjNnXmbftGok6A7/GMQQzAbbpRwTG6O0/diC5BJHm3LguHBsG
         s5UkT5IaLd2hWqBFhdz0IZMcZB3M1jm57Mb970KQuAUJtcmcQ1Dl+Nxc4gLJ9oSUjODu
         wpXXVHq0v6zSJ/6u14jSzMehzJ5XGMDPiOt/7nuYE7NKhgLm3+RWd6qMt2bNKRhDZvaV
         w5l6Fk5NIjz5mBb8F5O8Y4bXuSgYzauMxEM8ONLrqTFXtYF3fcm4EY8QohZPsrg/XOGO
         G9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7lf7LUGPaS4QDss+KWCnNxX2/jz7fWtBbSCfzXNCrg=;
        b=6yvwUGYbsX4M5r0nIjN8D193z2s+RYitXAlrLBy0j3XRKl5E1ZXnMKH47jK/9pbEE4
         YgLHA9URVl9Oq3s6Re48iOpWb+ekYG8zG2tyImweV1vM/aLqYH24tkc2v5d0kONVLudX
         OTdZjgsk2gWd17Ri32ZBAV4jcgjIv5M5wGgBwOCWTJ0dpoZYsUkS9fSkkB07xy8HNGUb
         uN0ORidhqnKEBYNnpn4KogvAG00BcxDLwjEi1/+rqPw91PmeiAmL+2UUA9GmlTLuUIzo
         hD8ohYrmif6EZDE2Dqc1RYb/oSkPVyPWn5YY5PI4jXlZ2bbTf7kaLC5qQ0VH3JHHkvCX
         7u8w==
X-Gm-Message-State: AOAM531iODjvPSwWt+ceUnBUxg7WK9WziK3MOvJMUrwNN3c58bZI+S32
        2cJoRHWh/jp9M3mlPmHhDag=
X-Google-Smtp-Source: ABdhPJzlblEiDz4sUVcySsaH1v0Kmd3ElWH+JaSlUaAio9CscB6+RebJ7PbPaJeHPVKfr+FUzh4mGw==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr4551340ejb.256.1634277494311;
        Thu, 14 Oct 2021 22:58:14 -0700 (PDT)
Received: from localhost.localdomain ([178.94.41.216])
        by smtp.gmail.com with ESMTPSA id ck13sm3872448edb.0.2021.10.14.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:58:13 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Update ASUS WMI supported boards
Date:   Fri, 15 Oct 2021 08:58:04 +0300
Message-Id: <20211015055808.327453-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

I have changed code to use dmi_first_match for directly without callbacks 
get sensors list defined for board, added "depends on ACPI_WMI" for 
both modules and added additional check for input buffer in 
asus_wmi_ec_decode_reply_buffer..

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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
 drivers/hwmon/asus_wmi_ec_sensors.c         | 632 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 617 +++++++++++++++++++
 8 files changed, 1394 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: be68c4dcc659172af86e875c25d26c6a114b1afc
-- 
2.33.0

