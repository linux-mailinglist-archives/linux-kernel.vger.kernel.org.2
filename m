Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B93A8B68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFOVxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:53:21 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:42402 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231354AbhFOVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:53:20 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id cdd81c57-ce23-11eb-9eb8-005056bdd08f;
        Wed, 16 Jun 2021 00:51:13 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/1] platform/chrome: cros_ec_typec: Put fwnode in error case during ->probe()
Date:   Wed, 16 Jun 2021 00:51:11 +0300
Message-Id: <20210615215111.377348-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_for_each_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---
v2: added comment (Prashant), added Rb tag (Prashant)
 drivers/platform/chrome/cros_ec_typec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 27c068c4c38d..99fdc1156392 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -375,6 +375,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
+	/* Drop the referece that bumped by device_for_each_child_node() */
+	fwnode_handle_put(fwnode);
 	cros_unregister_ports(typec);
 	return ret;
 }
-- 
2.32.0

