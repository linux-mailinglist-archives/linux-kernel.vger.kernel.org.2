Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839A73780CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEJKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:05:29 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:28488 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhEJKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:05:28 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 1702a08c-b177-11eb-8ccd-005056bdfda7;
        Mon, 10 May 2021 13:04:21 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] hwmon: (ltc2992) Put fwnode in error case during ->probe()
Date:   Mon, 10 May 2021 13:01:36 +0300
Message-Id: <20210510100136.3303142-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In each iteration fwnode_for_each_available_child_node() bumps a reference
counting of a loop variable followed by dropping in on a next iteration,

Since in error case the loop is broken, we have to drop a reference count
by ourselves. Do it for port_fwnode in error case during ->probe().

Fixes: b0bd407e94b0 ("hwmon: (ltc2992) Add support")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/hwmon/ltc2992.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 4382105bf142..2a4bed0ab226 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -900,11 +900,15 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
 
 	fwnode_for_each_available_child_node(fwnode, child) {
 		ret = fwnode_property_read_u32(child, "reg", &addr);
-		if (ret < 0)
+		if (ret < 0) {
+			fwnode_handle_put(child);
 			return ret;
+		}
 
-		if (addr > 1)
+		if (addr > 1) {
+			fwnode_handle_put(child);
 			return -EINVAL;
+		}
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
 		if (!ret)
-- 
2.31.1

