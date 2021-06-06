Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06139D133
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFFUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:13:09 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:57732 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhFFUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:13:08 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 5087b670-c703-11eb-8ccd-005056bdfda7;
        Sun, 06 Jun 2021 23:11:01 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/3] usb: typec: intel_pmc_mux: Put fwnode in error case during ->probe()
Date:   Sun,  6 Jun 2021 23:09:09 +0300
Message-Id: <20210606200911.32076-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/usb/typec/mux/intel_pmc_mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 46a25b8db72e..134325444e6a 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -645,6 +645,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	return 0;
 
 err_remove_ports:
+	fwnode_handle_put(fwnode);
 	for (i = 0; i < pmc->num_ports; i++) {
 		typec_switch_unregister(pmc->port[i].typec_sw);
 		typec_mux_unregister(pmc->port[i].typec_mux);
-- 
2.31.1

