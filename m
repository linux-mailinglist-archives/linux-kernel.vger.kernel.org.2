Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC96397853
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhFAQpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:45:49 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:14814 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhFAQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:45:46 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id DB0122E6AD06
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:44:03 +0200 (CEST)
Received: from s645.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id CA1D82E2C691;
        Tue,  1 Jun 2021 18:44:03 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s645.loopia.se (Postfix) with ESMTP id AE3321579FD4;
        Tue,  1 Jun 2021 18:44:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s645.loopia.se ([172.22.191.5])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with UTF8LMTP id Oqx2T1MCpVu1; Tue,  1 Jun 2021 18:44:03 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 178.28.230.104
Received: from localhost.localdomain (c-b21ce668-74736162.cust.telenor.se [178.28.230.104])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id 86C161579F94;
        Tue,  1 Jun 2021 18:44:02 +0200 (CEST)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Nilsson <daniel.nilsson@flex.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v4 3/5] hwmon: (pmbus/pim4328) Allow phase function even if it's not on page
Date:   Tue,  1 Jun 2021 18:43:18 +0200
Message-Id: <20210601164320.2907-4-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210601164320.2907-1-erik.rosen@metormote.com>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the use of a phase function even if it does not exist not on
the associated page.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cd80cb574267..7c4f7b6c846e 100644
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

