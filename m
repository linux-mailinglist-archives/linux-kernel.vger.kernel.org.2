Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FE39E8BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFGUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:52:18 -0400
Received: from fgw21-7.mail.saunalahti.fi ([62.142.5.82]:33656 "EHLO
        fgw21-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhFGUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:52:16 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id f3d5a950-c7d1-11eb-9eb8-005056bdd08f;
        Mon, 07 Jun 2021 23:50:11 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 3/3] usb: typec: intel_pmc_mux: Put ACPI device using acpi_dev_put()
Date:   Mon,  7 Jun 2021 23:50:07 +0300
Message-Id: <20210607205007.71458-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210607205007.71458-1-andy.shevchenko@gmail.com>
References: <20210607205007.71458-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ACPI devices we have a symmetric API to put them, so use it in the driver.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v2: added Rb tag (Heikki)
 drivers/usb/typec/mux/intel_pmc_mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e1662ad6ef..2cdd22130834 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -600,12 +600,12 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (!pmc->iom_base) {
-		put_device(&adev->dev);
+		acpi_dev_put(adev);
 		return -ENOMEM;
 	}
 
 	if (IS_ERR(pmc->iom_base)) {
-		put_device(&adev->dev);
+		acpi_dev_put(adev);
 		return PTR_ERR(pmc->iom_base);
 	}
 
@@ -676,7 +676,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
-	put_device(&pmc->iom_adev->dev);
+	acpi_dev_put(pmc->iom_adev);
 
 	return ret;
 }
@@ -692,7 +692,7 @@ static int pmc_usb_remove(struct platform_device *pdev)
 		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
-	put_device(&pmc->iom_adev->dev);
+	acpi_dev_put(pmc->iom_adev);
 
 	return 0;
 }
-- 
2.32.0

