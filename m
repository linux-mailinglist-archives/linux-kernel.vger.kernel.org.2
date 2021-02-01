Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3292030B155
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhBAUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:06:45 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:47988 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhBAUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:03:58 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 29CE01A93D85
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:59:49 +0100 (CET)
Received: from s500.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 0A8342E2C94B;
        Mon,  1 Feb 2021 20:59:49 +0100 (CET)
Received: from s470.loopia.se (unknown [172.22.191.5])
        by s500.loopia.se (Postfix) with ESMTP id 0635D1E272BF;
        Mon,  1 Feb 2021 20:59:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s499.loopia.se ([172.22.191.5])
        by s470.loopia.se (s470.loopia.se [172.22.190.10]) (amavisd-new, port 10024)
        with LMTP id Cl2g_L6fVlvh; Mon,  1 Feb 2021 20:59:48 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.176
Received: from localhost.localdomain (h-155-4-131-176.NA.cust.bahnhof.se [155.4.131.176])
        (Authenticated sender: carl@hgsystem.se)
        by s499.loopia.se (Postfix) with ESMTPSA id 3BE6B1CE5F16;
        Mon,  1 Feb 2021 20:59:48 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 0/2] Set sensor->data to -ENODATA after write
Date:   Mon,  1 Feb 2021 20:59:27 +0100
Message-Id: <20210201195929.1200-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
When clear_cache() is called from within the pmbus_write_word_data()
callback, the sensor data is set _after_ the function returns to
pmbus_set_sensor(). The effect is that all sensor values are cleared
except the one just written to. This behaviour prevents reloading of
the sensor value as expected in the lm25066 driver.

Proposed solution:
Set the data field to -ENODATA after updates of the sensor value.
This will force a read from the chip next time the sensor value is
read. This will also ensure that the cached value matches the actual
value stored in the chip.
The impact would be that a sensor read after a write will always
trigger a chip access.


Erik Rosen (2):
  Clear sensor data after chip write
  Remove unnecessary pmbus_clear_cache function call

 drivers/hwmon/pmbus/lm25066.c    | 5 -----
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.20.1

