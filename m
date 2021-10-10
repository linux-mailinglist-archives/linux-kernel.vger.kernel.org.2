Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6854283B1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhJJVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJJVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:08:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F75C061570;
        Sun, 10 Oct 2021 14:06:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a25so43463015edx.8;
        Sun, 10 Oct 2021 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gQ2KVUd8DCi5DdgGacGB/Bif0hOdRztQJCe1iIZeK8=;
        b=JUiUbZ+yhAzPgctRna9ZmSTREywX5/vB1bj3wrVZMt12Pig29zB0tYE77Q75+c9Rmb
         fchWZrzU5HK7ZDJguJJP82ySUD7uMgQw1gKP/HHgIaB11d3kw76uNUiJ+YRogc2JfE3u
         800znk4nRnOapaXUUbRBYDqtFwxqVX3Pif9Gir0qjOzWj/c6dojlvkCXwl6PxgPXdQoi
         21quDwfCejulFfCC6OW7/EhDf5eEBF7JzJYmHlgV6SARcTkCqVRl1VNkPtP1O/hOHIj2
         zrm+QBW6FKIW3qMl3yjX0wJgT9vtsa/V3Q71FiL4+xG3uW01istJSe8U3Gk5sX4OVTdN
         tYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gQ2KVUd8DCi5DdgGacGB/Bif0hOdRztQJCe1iIZeK8=;
        b=TKptND7EDNGfp5yyGTKXjz7GNH63ojGRCX8TOYwdxDzp/3KbrPdHypJESEp1Y8H3e9
         dKzreBHctXZEzGQv1Yo9DzGQosQJFu1G80PkTsNoxok+rl0qeB3Sn0oxP3I1cmL7vP63
         achmOjrU4R/Ytt+v5TJJgpntPmK6DW9e2w/8UwDo+ylFma9o7CW5vLew9FJvx4cf9IMX
         u8F3P+vdg+0m77EmiaZqUYg98kHsdlH+tqx8wYRi+KSeuE7Bij3whArdh8l5ipqFsa7J
         3lkymP4oIZ8s3vGWiKkO3QnZjfQXzWCDooD+gGG/w8Symmc9pq75dWrN6Vb/qw27nUob
         nFwA==
X-Gm-Message-State: AOAM533mexXYyUhoZVGBgtmP2EkqRAA4r3Wj24aAc5U1DXvyPN6pIn4o
        /PErNRmiVSNVcEpazXKX40tgZ3DhOtdHzg==
X-Google-Smtp-Source: ABdhPJzp+UkBFeTe1Kb/4LWPfqL0Eh/KhrLdlB22UIQ3KHsTcQ9x85eRGN7bBfDTp6z8ACEOwCmFFA==
X-Received: by 2002:a17:906:1359:: with SMTP id x25mr21510332ejb.145.1633899978020;
        Sun, 10 Oct 2021 14:06:18 -0700 (PDT)
Received: from localhost.localdomain ([94.179.9.244])
        by smtp.gmail.com with ESMTPSA id j4sm3037089edk.9.2021.10.10.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:06:17 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Update ASUS WMI supported boards
Date:   Mon, 11 Oct 2021 00:05:10 +0300
Message-Id: <20211010210513.343925-1-pauk.denis@gmail.com>
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

I have removed link to https://bugzilla.kernel.org/show_bug.cgi?id=204807 
as not directly related to patches.

Could you please review?

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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
 drivers/hwmon/asus_wmi_ec_sensors.c         | 644 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 620 +++++++++++++++++++
 7 files changed, 1405 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 39b483aa38995329326988cbc4077422bebc175a
-- 
2.33.0

