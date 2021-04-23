Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74475369635
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhDWPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:34:25 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:44801 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:34:23 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 82A1C2466654
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:33:44 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 71F5C2E3A4ED;
        Fri, 23 Apr 2021 17:33:44 +0200 (CEST)
Received: from s476.loopia.se (unknown [172.22.191.6])
        by s630.loopia.se (Postfix) with ESMTP id 5CE1813B942E;
        Fri, 23 Apr 2021 17:33:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s476.loopia.se (s476.loopia.se [172.22.190.16]) (amavisd-new, port 10024)
        with LMTP id ChAuIG7mRKrG; Fri, 23 Apr 2021 17:33:43 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 57CB5157A045;
        Fri, 23 Apr 2021 17:33:43 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 0/2] hwmon: (pmbus/zl6100) Add support for ZLS1003, ZLS4009 and ZL8802
Date:   Fri, 23 Apr 2021 17:33:27 +0200
Message-Id: <20210423153329.33457-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Renesas ZL8802 Dual Channel/Dual Phase PMBus DC/DC
Digital Controller as well as support for the Renesas custom controller
chips ZLS1003 and ZLS4009 to the zl6100 pmbus driver.

The ZL8802 support was tested using a Flex BMR469 converter module,
the ZLS1003 with a Flex BMR466 and the ZLS4009 with a Flex BMR465.

The documentation is updated with new sysfs attribute descriptions and
broken links to technical specifications has been fixed. Also the Renesas
company name was added and Ericsson changed to Flex to reflect new
ownership relations.

Erik Rosen (2):
  Add support for ZLS1003, ZLS4009 and ZL8802
  Update documentation for zl6100 driver

 Documentation/hwmon/zl6100.rst | 132 ++++++++++++++++++++++-----------
 drivers/hwmon/pmbus/zl6100.c   |  94 +++++++++++++++++++----
 2 files changed, 169 insertions(+), 57 deletions(-)


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.20.1

