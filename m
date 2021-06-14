Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262D83A7083
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhFNUfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:35:47 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:51579 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233352AbhFNUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:35:44 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id c5062c0b-cd4f-11eb-9eb8-005056bdd08f;
        Mon, 14 Jun 2021 23:33:26 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] platform/chrome: cros_ec_typec: Put fwnode in error case during ->probe()
Date:   Mon, 14 Jun 2021 23:33:10 +0300
Message-Id: <20210614203310.339541-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_for_each_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 27c068c4c38d..fb03c22fa34d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -375,6 +375,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
+	fwnode_handle_put(fwnode);
 	cros_unregister_ports(typec);
 	return ret;
 }
-- 
2.32.0

