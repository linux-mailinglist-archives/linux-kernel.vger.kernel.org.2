Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6F389794
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhESULt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:11:49 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:55880 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhESULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:11:46 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 394BD2E633F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:10:21 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 28CB72E2B065;
        Wed, 19 May 2021 22:10:21 +0200 (CEST)
Received: from s476.loopia.se (unknown [172.22.191.6])
        by s630.loopia.se (Postfix) with ESMTP id 0EBB013B94CB;
        Wed, 19 May 2021 22:10:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s899.loopia.se ([172.22.191.6])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with LMTP id RTyEceadJ5La; Wed, 19 May 2021 22:10:20 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s899.loopia.se (Postfix) with ESMTPSA id 0DA3D2C8BBB8;
        Wed, 19 May 2021 22:10:20 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 0/5] hwmon: (pmbus/pim4328) Add pim4328 PMBus driver
Date:   Wed, 19 May 2021 22:10:10 +0200
Message-Id: <20210519201015.83989-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware monitoring support for the Flex power interface modules
PIM4006, PIM4328 and PIM4820.

The modules are equipped with dual feed input and has support for
hotswap, holdup and various circuit protection functionality.

[PATCH 1/5]
PIM4328 and PIM4820 use the direct mode data format so a new function
is added to the pmbus_core driver to be able to read and decode
the COEFFICIENTS command.

[PATCH 2/5]
The modules have no CAPABILITY or WRITE_PROTECT commands. If these
commands are read, the modules return invalid data (0xFF),
so in addition to the NO_CAPABILITY flag we need a NO_WRITE_PROTECT
flag to tell the pmbus_core driver to not access this register.

[PATCH 3/5]
The two inputs are modelled using virtual phases but there
is a limitation in the pmbus_core that disallows monitoring
of phase functions if there is no corresponding function on
the page level.

In this specific case the PIM4006 module allows
monitoring of current on each input separately,
but there is no corresponding command on the page level.

Is there a specific reason for this limitation?
Otherwise we suggest relaxing this criteria.

[PATCH 4/5]
All modules use manufacturer specific registers (mfr) for
status data and only supports the CML bit in the PMBus
STATUS register. The driver overrides reading the STATUS
register and maps the bits in the mfr registers to the STATUS
register alarm bits.


Addendum
In view of the comment in the generic pmbus driver on adding
support for direct mode, we did look into it but decided against
it because (1) we do not really have a usecase for it and (2) to
implement truly generic direct mode support we need to handle
the siuation when there are different coefficients for reading
or writing a register.

This patch has been tested with PIM4406, PIM4280 and PIM4328
modules. 

Erik Rosen (5):
  Add function for reading direct mode coefficients
  Add new pmbus flag NO_WRITE_PROTECT
  Allow phase function even if it's not on page
  Add PMBus driver for PIM4006, PIM4328 and PIM4820
  Add documentation for the pim4328 PMBus driver

 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/pim4328.rst  | 105 +++++++++++
 MAINTAINERS                      |   7 +
 drivers/hwmon/pmbus/Kconfig      |   9 +
 drivers/hwmon/pmbus/Makefile     |   1 +
 drivers/hwmon/pmbus/pim4328.c    | 299 +++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |   4 +
 drivers/hwmon/pmbus/pmbus_core.c |  63 +++++--
 include/linux/pmbus.h            |   9 +
 9 files changed, 487 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/hwmon/pim4328.rst
 create mode 100644 drivers/hwmon/pmbus/pim4328.c


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.20.1

