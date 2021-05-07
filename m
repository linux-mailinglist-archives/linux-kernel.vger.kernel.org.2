Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B4376AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEGTle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:41:34 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:31146 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhEGTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:41:33 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 09E7B1AA0B09
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 21:40:28 +0200 (CEST)
Received: from s934.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id ED3632E36755;
        Fri,  7 May 2021 21:40:27 +0200 (CEST)
Received: from s472.loopia.se (unknown [172.22.191.5])
        by s934.loopia.se (Postfix) with ESMTP id E1DD07CE9EC;
        Fri,  7 May 2021 21:40:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.6])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id BKgoeOWbXQwn; Fri,  7 May 2021 21:40:26 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 9900A157A046;
        Fri,  7 May 2021 21:40:26 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 0/3] hwmon: (pmbus) Add support for additional Flex BMR converters to the pmbus driver
Date:   Fri,  7 May 2021 21:40:20 +0200
Message-Id: <20210507194023.61138-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Flex pmbus converters (BMR310, BMR458, BMR80, BMR490 and BMR491)
end up in an undefined state when trying to read a register that does
not exist in the chip. This causes the following chip access to also
fail even if it is a valid register read or write. This will mess up the
pmbus driver auto-detection process.

One way to reset the pmbus state machine to a known state is to read
a register that is known to exist. This read will fail but will also
reset the chip into a known state.

For such chips we suggest adding a new pmbus flag:
PMBUS_READ_STATUS_AFTER_FAILED_CHECK
By setting this flag the driver will try to read the STATUS register
after each failed register check. This read may fail, but it will put
the chip into a known state so that the auto-detection process can
proceed correctly.

Add support for Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490,
BMR491 and BMR492 to the pmbus driver

This patch has been tested with Flex BMR310, BMR456, BMR457, BMR458,
BMR480, BMR490, BMR491 and BMR492 converter modules

v2
-Copy all flags to pmbus_platform_data struct instead of one by one
-Fix code formatting in pmbus_core documentation
-Add documentation for flag NO_CAPABILITY
-Fix sorting of chip names and prefix in pmbus documentation

Erik Rosen (3):
  Add new flag PMBUS_READ_STATUS_AFTER_FAILED_CHECK
  Add documentation for new flags
  Add support for Flex BMR310, BMR456, BMR457, BMR458, BMR480, BMR490,
    BMR491 and BMR492 to the pmbus driver

 Documentation/hwmon/pmbus-core.rst | 42 +++++++++++++++++++++++++++---
 Documentation/hwmon/pmbus.rst      | 11 +++++---
 drivers/hwmon/pmbus/Kconfig        |  7 ++---
 drivers/hwmon/pmbus/pmbus.c        | 19 ++++++++++++--
 drivers/hwmon/pmbus/pmbus_core.c   |  2 ++
 include/linux/pmbus.h              | 13 +++++++++
 6 files changed, 81 insertions(+), 13 deletions(-)


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.20.1

