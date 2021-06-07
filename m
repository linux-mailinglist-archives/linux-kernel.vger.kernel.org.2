Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8290439E8BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFGUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:52:22 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:33630 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231177AbhFGUwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:52:20 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id f2d6f560-c7d1-11eb-9eb8-005056bdd08f;
        Mon, 07 Jun 2021 23:50:10 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/3] usb: typec: intel_pmc_mux: Put fwnode in error case during ->probe()
Date:   Mon,  7 Jun 2021 23:50:05 +0300
Message-Id: <20210607205007.71458-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_get_next_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: moved put call into the conditional inside the loop (Heikki)
 drivers/usb/typec/mux/intel_pmc_mux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index dc8689db0100..221aa1c0e77a 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -654,8 +654,10 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			break;
 
 		ret = pmc_usb_register_port(pmc, i, fwnode);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
+		}
 	}
 
 	platform_set_drvdata(pdev, pmc);
-- 
2.32.0

