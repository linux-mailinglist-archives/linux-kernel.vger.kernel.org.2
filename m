Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F613428050
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 11:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhJJJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhJJJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 05:54:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417CC061570;
        Sun, 10 Oct 2021 02:52:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y3so12100080wrl.1;
        Sun, 10 Oct 2021 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kbar4ZXl4ZRT7vzKdP00Z5mg5AC+y6StUABYdQFO9s=;
        b=Yo1vRELZkG1Ns1eu5evML7x5sseRore8Jyyu6ygtWqc3VxetbfJGSC057dM6ZOZ+lP
         +/MWFUH7GuGaYtRDPwNKM9+imEU2cSY2uWh1hbKafCvPR9KI/NBAYh2tvozsPcI3MWlv
         HlQFl4RKPvxtLSPB+4SP6eCKzmkyAptiyeOMZk1K2fvz9rqgefoXa2I2DrzyveiL231v
         NiusS4Q+6ZFg5dg15FdfvFMFwbpre0DoV/w2N+wOy3SBuV2aOTMXCzmykY/aMOs7uqyw
         s79YVRzVAQ1lVzjPbnyThmbFOrUWulKUj6HCy8U2KNDPHF6L+CEqh1rrnJlmIX7MHaGF
         i7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kbar4ZXl4ZRT7vzKdP00Z5mg5AC+y6StUABYdQFO9s=;
        b=vZm6jzBxSbOQAtuoU0CDqRRsI0lTc9YC3xdo84Pj3QcE2CZp9HCBduxFN8JreyaAzq
         2p/bwhQu0goc6GwI7iHc7q8QfW0qac+V4aOMyBVb8VCuaMAkV6CdsdE5PbkePZdU6qLy
         jQ8LIcOG/to7E3i6R3lpDofjWaVyXKwtOR9mn17pFEfuSmHDHZ86fuGJQ8BRNM+OcVnA
         tSAoO9jncTLKRMsHWxIk5BAPCCBiJIm/YMY2Y2Zak0TeMPVGJSbZooxZi80bZjBJUetN
         Ql8cTAwG+9NKbkmDsstmkcOQVCEarL3t0caI43YF7NqGDTFbf8LlgyRV/by0CVes6pYF
         Co1Q==
X-Gm-Message-State: AOAM5322Sx+hRQ2gNEme6aEg6UNFPhkiUjl3Ow+aak4JtK82INmjQ+m4
        3KN3PZvK7m87OyP0LYeYi/0173hzt47Ivw==
X-Google-Smtp-Source: ABdhPJwO3YdL6MvX+g/6JvvZ6+TEigI40pVUsMam9THOIdOQt72t5hC0K61n4Z1W/PDrilWPh8VrRw==
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr12343973wma.105.1633859550381;
        Sun, 10 Oct 2021 02:52:30 -0700 (PDT)
Received: from localhost.localdomain ([94.179.22.101])
        by smtp.gmail.com with ESMTPSA id k17sm4466683wrc.93.2021.10.10.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 02:52:29 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Update ASUS WMI supported boards
Date:   Sun, 10 Oct 2021 12:52:13 +0300
Message-Id: <20211010095216.25115-1-pauk.denis@gmail.com>
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

Could you please review?

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Signed-off-by: Ed Brindley <kernel@maidavale.org>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

---
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
 Documentation/hwmon/asus_wmi_sensors.rst    |  62 ++
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  22 +
 drivers/hwmon/Makefile                      |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c         | 659 ++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c            | 635 +++++++++++++++++++
 7 files changed, 1423 insertions(+)
 create mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
 create mode 100644 Documentation/hwmon/asus_wmi_sensors.rst
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 39b483aa38995329326988cbc4077422bebc175a
-- 
2.33.0

