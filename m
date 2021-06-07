Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555239E8BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFGUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:52:06 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:36173 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhFGUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:52:04 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id f35c15bb-c7d1-11eb-ba24-005056bd6ce9;
        Mon, 07 Jun 2021 23:50:11 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/3] usb: typec: intel_pmc_mux: Add missed error check for devm_ioremap_resource()
Date:   Mon,  7 Jun 2021 23:50:06 +0300
Message-Id: <20210607205007.71458-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607205007.71458-1-andy.shevchenko@gmail.com>
References: <20210607205007.71458-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() can return an error, add missed check for it.

Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v2: added Rb tag (Heikki)
 drivers/usb/typec/mux/intel_pmc_mux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 221aa1c0e77a..34e1662ad6ef 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -604,6 +604,11 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 		return -ENOMEM;
 	}
 
+	if (IS_ERR(pmc->iom_base)) {
+		put_device(&adev->dev);
+		return PTR_ERR(pmc->iom_base);
+	}
+
 	pmc->iom_adev = adev;
 
 	return 0;
-- 
2.32.0

