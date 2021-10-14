Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C442D382
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhJNH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:28:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF5AC061570;
        Thu, 14 Oct 2021 00:26:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ec8so20387315edb.6;
        Thu, 14 Oct 2021 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3qTxnMX3ADqt/J9bOBlE4FoV+RoUTqNQMD+qoLqjyo=;
        b=BLMVpNxorGP0FGagmx/rK5Ow23sQILrvrXHCD0mw2DWgAHMYKxS++1kFLmO4FHL7SA
         lr4O9DF+BvS/XSoabciFi1rySNzngSLXW/uHe+x/ny3HB4ZPIX81xh8KmTNxToNoa3ZG
         AbMIV2nEikKnns7U+7moxc/3wr3FNWC1lftMVvwaAr7+9uKQrY6JzgCttjT0nx1cUAGF
         VSiTjwvYkSg3vWYu4usPaC1Hb0snLXxqz+76pp9+UKN4HAb5GW2q7xuOGhrIkw793Kcr
         cj7xTlgL9thw+mJcYP0aL3HE2XFiIQ5jLEbXk2YPKiUdmEksHWBlPaZoUJBfvEtss4pR
         IDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3qTxnMX3ADqt/J9bOBlE4FoV+RoUTqNQMD+qoLqjyo=;
        b=SH5GA9wrMYtEHqWXfgt0uHF25Yyc7eAedIBP6v0LW4hvY1+e+oaehAn3KIafudhDIg
         j641ZiJ+HG9WlVuc6w80KveJxLyKLZAAkwTuLHyDEtdmVNy/qje0KlA6euvBSA0TmoZw
         kv8poaMuDBVDu1DwmZmHuJOJpxksdeuoZEueLncbvfasbL+2oXoSCEaNqITd6ch/2MXy
         A0LWC/8xlAMBnZjYMAlFFKayKI/eaoMujE8XOUn00aaJMRoFMeOKeAIG8uFppqVKL3pA
         SJZ47K/nWu/4/CNsXegccdIG1aSzMjhua8UPpSAXji5Tpmnx+2CGVFDtJg1gmUjFNwka
         2i3g==
X-Gm-Message-State: AOAM532DDPjk/AnmDn4lNgFGSP/DXKcwj93FnqXqwTdMcmhxYqEKez/8
        jfyUbnpRxEU3Cwz3xEuwWjgp1vCu1VJ/Ag==
X-Google-Smtp-Source: ABdhPJx50iRsp+hDLVdZa45timmdh/WpbCLcdVFgYcYLEt0NAzPmh1mYCw4bu98bc7q/Xg+jUre4wA==
X-Received: by 2002:a17:906:a4e:: with SMTP id x14mr1735381ejf.1.1634196360837;
        Thu, 14 Oct 2021 00:26:00 -0700 (PDT)
Received: from localhost.localdomain ([94.179.52.32])
        by smtp.gmail.com with ESMTPSA id z4sm1238253ejw.46.2021.10.14.00.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:26:00 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Update ASUS WMI supported boards
Date:   Thu, 14 Oct 2021 10:25:33 +0300
Message-Id: <20211014072537.190816-1-pauk.denis@gmail.com>
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

>There is at least one more sensor hiding in the EC address space: the
> south bridge voltage. And it seems its value is not an integer, so the
> conversion to mV will not be a simple get_unaligned_xx() call when we
> locate and add it.
@Eugene Shalygin: I have updated patch with usage separate function for 
convert binary data to sensors value as you proposed for sensors with 
sophisticated logic. Also I have moved quiery creation logic to sensors 
setup function.

@Guenter Roeck: I have added both sensors to index.rst, fixed usage of 
acpi_os_free in asus_wmi_ec_block_read and fixed 'instrnal' typo in both 
files.

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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
 drivers/hwmon/Kconfig                       |  22 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 637 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 621 +++++++++++++++++++
 8 files changed, 1401 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: be68c4dcc659172af86e875c25d26c6a114b1afc
-- 
2.33.0

