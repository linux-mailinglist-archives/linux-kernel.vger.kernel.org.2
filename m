Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523934297CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhJKT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhJKT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:57:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFFC061570;
        Mon, 11 Oct 2021 12:55:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so71868246edc.13;
        Mon, 11 Oct 2021 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+6quUc/p1hTjROFKuI/IIYV+7iDNHoJ7O8PlblBVzE=;
        b=DbuluLr8YaTum9mTNpVdV9mVS7hsdG14mmPD6YTNBrK4QzAAcX8PVQxoVwX59nBz7g
         PwctMY2kiY4Zh3BbmJJH/Ixze6I7qS7Vk9dKhLtKOfU1Whg7mdNXKH5QkGdEBvof6Br6
         ARqkJmA8vi72AMw9HHD3lM6J68qdk9/Bk6LE8VmC9U+CULqC4RcYLTDR2gFTElr9z+Xn
         b/hzpEcdrK5KDflWFx2gdZnqK6CgTCObsDD3QlHAulrHZZH9RmRwonT8wIyQBXS5EtQN
         sIjid3I05Ru5kOkZyIH1UvSw6ICyypo7hf2h1mKIjp7IJPODg0XEA9OCMGRcQyDtxTrQ
         KzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+6quUc/p1hTjROFKuI/IIYV+7iDNHoJ7O8PlblBVzE=;
        b=cHvjda1KxHpm+tmzRxVjsxhua1Ct0va51LUgnDc0lERuKO37EJbdk9+I5f6yWVS9gA
         HIjsikWS0sw/xsuWsgVbgerkVDpLO2HNM9sm7Z28QKz9uJTMmCu0XL6mbqSlu65r9deN
         62/uJyrJ3fgfNszSdAn1Cx8tCZez2xexh8ZWeBDTS7anqfXl/J7XRUC1xBdtyD5S+LVw
         vvdWjws5B5S7OxkghND2fQo7rM43Lpom5RpsfH2ts/yNkF/Hf1nnQc9fE0IEzdcYjb4V
         KGwACFnxftRHzGfPSetCuodjxZmgusZzINv8hrDaVB6o59lBEavl9cBIx9b5wapKeNLq
         Iejw==
X-Gm-Message-State: AOAM531ly1PUzJ6gzQmBYFfpGv7gW0qVXjqOOZbIwDMgI37g7rIJPu1j
        pVxB0267AMEY7E6YWt4h0ZB7ebl2kBOexA==
X-Google-Smtp-Source: ABdhPJyHm41Ytzhq3tEUAQ3gfQo8l1ADSLezouBglYaSx6zYfxlK7l3hYCE3TIg5BvKYqIOGzLDYvg==
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr45174142edj.66.1633982149671;
        Mon, 11 Oct 2021 12:55:49 -0700 (PDT)
Received: from localhost.localdomain ([94.179.1.5])
        by smtp.gmail.com with ESMTPSA id r3sm4654762edo.59.2021.10.11.12.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 12:55:49 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Update ASUS WMI supported boards
Date:   Mon, 11 Oct 2021 22:55:00 +0300
Message-Id: <20211011195503.23153-1-pauk.denis@gmail.com>
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

Fix warning reported by: kernel test robot.

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  22 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 648 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 621 +++++++++++++++++++
 7 files changed, 1410 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 39b483aa38995329326988cbc4077422bebc175a
-- 
2.33.0

