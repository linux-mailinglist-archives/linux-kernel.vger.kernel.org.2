Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D830B14D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhBAUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:05:42 -0500
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:48037 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhBAUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:04:14 -0500
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 870D3708E0B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:59:54 +0100 (CET)
Received: from s645.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 677962E2C946;
        Mon,  1 Feb 2021 20:59:54 +0100 (CET)
Received: from s472.loopia.se (unknown [172.22.191.6])
        by s645.loopia.se (Postfix) with ESMTP id 582F61579F39;
        Mon,  1 Feb 2021 20:59:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s499.loopia.se ([172.22.191.5])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id V4hAb4oufpMl; Mon,  1 Feb 2021 20:59:53 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.176
Received: from localhost.localdomain (h-155-4-131-176.NA.cust.bahnhof.se [155.4.131.176])
        (Authenticated sender: carl@hgsystem.se)
        by s499.loopia.se (Postfix) with ESMTPSA id 525251CDD839;
        Mon,  1 Feb 2021 20:59:53 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 1/2] Clear sensor data after chip write
Date:   Mon,  1 Feb 2021 20:59:28 +0100
Message-Id: <20210201195929.1200-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210201195929.1200-1-erik.rosen@metormote.com>
References: <20210201195929.1200-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the sensor->data field to -ENODATA to force a chip access next time
the sensor value is read.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b3b7a2..e27f23eee1e3 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -974,7 +974,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 	if (ret < 0)
 		rv = ret;
 	else
-		sensor->data = regval;
+		sensor->data = -ENODATA;
 	mutex_unlock(&data->update_lock);
 	return rv;
 }
-- 
2.20.1

