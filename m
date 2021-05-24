Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2F38EC50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhEXPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:13:51 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:31263 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhEXPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:04:25 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 260722E6B924
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:53 +0200 (CEST)
Received: from s899.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 157782E2B914;
        Mon, 24 May 2021 17:02:53 +0200 (CEST)
Received: from s475.loopia.se (unknown [172.22.191.6])
        by s899.loopia.se (Postfix) with ESMTP id 113592C8B9BF;
        Mon, 24 May 2021 17:02:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s934.loopia.se ([172.22.191.5])
        by s475.loopia.se (s475.loopia.se [172.22.190.15]) (amavisd-new, port 10024)
        with UTF8LMTP id 7D9-IReWEXmx; Mon, 24 May 2021 17:02:52 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s934.loopia.se (Postfix) with ESMTPSA id 3B1FE7CE987;
        Mon, 24 May 2021 17:02:52 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v3 0/6] hwmon: (pmbus/pim4328) Add pim4328 PMBus driver
Date:   Mon, 24 May 2021 17:02:40 +0200
Message-Id: <20210524150246.90546-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware monitoring support for the Flex power interface modules
PIM4006, PIM4328 and PIM4820.

The modules are equipped with dual feed input and has support for
hotswap, holdup and various circuit protection functionality.

[PATCH 1/6]
The modules have no CAPABILITY or WRITE_PROTECT commands. If these
commands are read, the modules return invalid data (0xFF),
so in addition to the NO_CAPABILITY flag we need a NO_WRITE_PROTECT
flag to tell the pmbus_core driver to not access this register.

[PATCH 2/6]
PIM4328 and PIM4820 use the direct mode data format so a new function
is added to the pmbus_core driver to be able to read and decode
the COEFFICIENTS command.

[PATCH 3/6]
This is a tentative implementation of core driver support for reading
and decoding direct format coefficients. If the new flag
PMBUS_USE_COEFFICIENTS_CMD is set, the driver will use the 
attribute information in the pmbus_sensor_attr structs together
with the COEFFICIENTS command to read and set the relevant
direct mode coefficients.

Please have a look and comment.

[PATCH 4/6]
The two inputs are modelled using virtual phases but there
is a limitation in the pmbus_core that disallows monitoring
of phase functions if there is no corresponding function on
the page level.

In this specific case the PIM4006 module allows
monitoring of current on each input separately,
but there is no corresponding command on the page level.

Is there a specific reason for this limitation?
Otherwise we suggest relaxing this criteria.

[PATCH 5/6]
All modules use manufacturer specific registers (mfr) for
status data and only supports the CML bit in the PMBus
STATUS register. The driver overrides reading the STATUS
register and maps the bits in the mfr registers to the STATUS
register alarm bits.

PATCH 6/6]
Add driver documentation

This patch has been tested with PIM4406, PIM4280 and PIM4328
modules.

v2
-Remove the for_reading parameter from the pmbus_read_coefficients
function.
-Use the correct namespace macro for the pmbus_read_coefficients
function.
-Fix alphabetic ordering of includes
-Remove override of STATUS_WORD since it will never get called by
the core driver.
-Add new patch with tentative implementation of core driver support
for reading direct mode coefficients using the COEFFICIENTS command.

v3
-Rework and simplify the code for initialization of direct mode
coefficients according to comments by Guenter.
-Updated commit message for patch 2/6

Erik Rosen (6):
  Add new pmbus flag NO_WRITE_PROTECT
  Add function for reading direct mode coefficients
  Add support for reading and decoding direct format coefficients
  Allow phase function even if it does not exist not on the associated
    page
  Add PMBus driver for PIM4006, PIM4328 and PIM4820
  Add documentation for the pim4328 PMBus driver

 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/pim4328.rst  | 105 ++++++++++++++
 MAINTAINERS                      |   7 +
 drivers/hwmon/pmbus/Kconfig      |   9 ++
 drivers/hwmon/pmbus/Makefile     |   1 +
 drivers/hwmon/pmbus/pim4328.c    | 240 +++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |   4 +
 drivers/hwmon/pmbus/pmbus_core.c | 145 +++++++++++++++++--
 include/linux/pmbus.h            |  17 +++
 9 files changed, 518 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/hwmon/pim4328.rst
 create mode 100644 drivers/hwmon/pmbus/pim4328.c


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.20.1

