Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D36424991
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhJFW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbhJFW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:27:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF0C061746;
        Wed,  6 Oct 2021 15:25:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j5so16462875lfg.8;
        Wed, 06 Oct 2021 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9LJ/8J2oukzdrKTgF8IimmAsskQ6d87zSHUvyCJOPk=;
        b=VJEiWqZ/xMGvVd0PSEDKLaQ25UZkmRh1QW3eL8BXbN2aWr/QDTqlDrWCx3r85l0yRV
         jcWOYq8zBDMtySWmRO481M9A2wVlTbrHsBo2jiMOWJZAYOr8KH60CqUxF4E4Tuz3mDxI
         EWBa8mdsrltNlS3StBFSnvqr4YsyDZkqL3GWG/On+T6RGdfpR/blmFMyonNQcBrlld8l
         TK8613Y/9vciN9XcGLeBxufnln3xbs3dZpRo4RDJmORpxW0qqE1AEiiDj9eiSyv9jxCk
         f/I4FiBcXDfLr4rTcwh+/nyvDwoyB/HvZ88rtaXvYhSinLtWC5aql47W8y9xQ5HBuT19
         tyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9LJ/8J2oukzdrKTgF8IimmAsskQ6d87zSHUvyCJOPk=;
        b=UX8tZjCwEknTZQIkvONsBBcR5m0+zDPH2sS9JttfnO2jWiaZrCbGcDnlwLKHdpH/fe
         W1CH8XI4RWUxDZmwFRJVU7ApVZMuEcVqVVtQmGYcJmkMfw1JMtTx481Zp5q0gT0E+ViK
         qhZS87IBi8yWbUQqHpeKI4diy+XAUcQWOG7HHsfMpV5+F2YcQQJE1KhfOzYQ5mtJcuSZ
         h7QygePEDEkZHCKRdLET79/LslW4YUFxoCyN6aSyMFMoAu4Y757oldg9NYFoNjjLDYfE
         ePA+JdeMNUwVBtRlyqeTQSxFB12nQKObQMcolvC+Eks3pGfRFBC7Op6KEqe+R1WpUc2r
         vDIQ==
X-Gm-Message-State: AOAM5304EubAAxSSD/sPmMfLXvHxm0b086krxQxrsdE5rwiqPFWrDPOb
        wXhiNEP1XkMO9YbKGbKkjC+IW9fJJ0Q=
X-Google-Smtp-Source: ABdhPJxgNAsQNZ2Foi/mGFOWQ37zWZcMLeoU5rjTqEeiMAhdSnC9WQEKOFwavvDE2WdBbxPWF/RLEw==
X-Received: by 2002:ac2:48ad:: with SMTP id u13mr667601lfg.340.1633559119686;
        Wed, 06 Oct 2021 15:25:19 -0700 (PDT)
Received: from localhost.localdomain (206-20-179-94.pool.ukrtel.net. [94.179.20.206])
        by smtp.gmail.com with ESMTPSA id c2sm1364457lfi.277.2021.10.06.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:25:19 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Ed Brindley <kernel@maidavale.org>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 0/3]  [PATCH v2 0/3] Update ASUS WMI supported boards
Date:   Thu,  7 Oct 2021 01:24:58 +0300
Message-Id: <20211006222502.645003-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to nct6775:
* PRIME B360-PLUS
* PRIME X570-PRO
* ROG CROSSHAIR VIII FORMULA
* ROG STRIX B550-I GAMING
* ROG STRIX X570-F GAMING
* ROG STRIX Z390-E GAMING
* TUF GAMING B550-PRO
* TUF GAMING Z490-PLUS
* TUF GAMING Z490-PLUS (WI-FI)

Add support by WMI interface privided by Asus for B550/X570 boards: 
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

Denis Pauk (3):
  hwmon: (nct6775) Add additional ASUS motherboards
  hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
  hwmon: (asus_wmi_sensors) Support X370 Asus WMI.

 MAINTAINERS                         |   8 +
 drivers/hwmon/Kconfig               |  24 +-
 drivers/hwmon/Makefile              |   2 +
 drivers/hwmon/asus_wmi_ec_sensors.c | 631 ++++++++++++++++++++++++++
 drivers/hwmon/asus_wmi_sensors.c    | 661 ++++++++++++++++++++++++++++
 drivers/hwmon/nct6775.c             |   9 +
 6 files changed, 1334 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwmon/asus_wmi_ec_sensors.c
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c


base-commit: 0889b7c73a4d8eaaa321eafcf66835979ead862a
-- 
2.33.0

