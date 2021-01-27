Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8C305746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhA0Jq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:46:58 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:29433 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhA0I7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:59:47 -0500
X-Greylist: delayed 775 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 03:59:44 EST
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 5621D24644FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:42:35 +0100 (CET)
Received: from s500.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 354E52E29A02;
        Wed, 27 Jan 2021 09:42:35 +0100 (CET)
Received: from s471.loopia.se (unknown [172.22.191.6])
        by s500.loopia.se (Postfix) with ESMTP id 241561E28537;
        Wed, 27 Jan 2021 09:42:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s500.loopia.se ([172.22.191.6])
        by s471.loopia.se (s471.loopia.se [172.22.190.11]) (amavisd-new, port 10024)
        with LMTP id qXO9IDQ8dZBx; Wed, 27 Jan 2021 09:42:34 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 94.234.44.220
Received: from localhost.localdomain (unknown [94.234.44.220])
        (Authenticated sender: carl@hgsystem.se)
        by s500.loopia.se (Postfix) with ESMTPSA id 174361E24FD1;
        Wed, 27 Jan 2021 09:42:34 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 0/1] Add ST STPDDC60 pmbus driver
Date:   Wed, 27 Jan 2021 09:41:39 +0100
Message-Id: <20210127084140.35626-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a pmbus client driver for the ST STPDDC60 Universal
Digital Multicell Controller chip. The technical specification is
not made publicly available, but the pmbus parts are described in the
specification for the BMR481 converter.

The patch has been tested with a Flex BMR481 converter module.


Erik Rosen (1):
  Add ST STPDDC60 pmbus driver

 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/stpddc60.rst |  79 +++++++++++++
 MAINTAINERS                      |   7 ++
 drivers/hwmon/pmbus/Kconfig      |  10 ++
 drivers/hwmon/pmbus/Makefile     |   2 +
 drivers/hwmon/pmbus/stpddc60.c   | 188 +++++++++++++++++++++++++++++++
 6 files changed, 287 insertions(+)
 create mode 100644 Documentation/hwmon/stpddc60.rst
 create mode 100644 drivers/hwmon/pmbus/stpddc60.c

-- 
2.20.1

