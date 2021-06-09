Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA23A1174
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhFIKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:51:58 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:55598 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbhFIKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:51:46 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id D17512E63298
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 11:32:27 +0200 (CEST)
Received: from s630.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id C07EA2E2DB77;
        Wed,  9 Jun 2021 11:32:27 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s630.loopia.se (Postfix) with ESMTP id A612413B93FC;
        Wed,  9 Jun 2021 11:32:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id W_n53bzfvQuD; Wed,  9 Jun 2021 11:32:27 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.133.180
Received: from localhost.localdomain (h-155-4-133-180.NA.cust.bahnhof.se [155.4.133.180])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 09444157A05B;
        Wed,  9 Jun 2021 11:32:26 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v5 3/5] hwmon: (pmbus/pim4328) Allow phase function even if it's not on page
Date:   Wed,  9 Jun 2021 11:32:07 +0200
Message-Id: <20210609093209.8349-4-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210609093209.8349-1-erik.rosen@metormote.com>
References: <20210609093209.8349-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the use of a phase function even if it does not exist on
the associated page.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d022d3196ae9..80a018cd2a8f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1327,14 +1327,14 @@ static int pmbus_add_sensor_attrs(struct i2c_client *client,
 
 		pages = paged ? info->pages : 1;
 		for (page = 0; page < pages; page++) {
-			if (!(info->func[page] & attrs->func))
-				continue;
-			ret = pmbus_add_sensor_attrs_one(client, data, info,
-							 name, index, page,
-							 0xff, attrs, paged);
-			if (ret)
-				return ret;
-			index++;
+			if (info->func[page] & attrs->func) {
+				ret = pmbus_add_sensor_attrs_one(client, data, info,
+								 name, index, page,
+								 0xff, attrs, paged);
+				if (ret)
+					return ret;
+				index++;
+			}
 			if (info->phases[page]) {
 				int phase;
 
-- 
2.20.1

