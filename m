Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A172F39D132
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFFUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:13:02 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:27354 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhFFUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:13:01 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 558f3bca-c703-11eb-ba24-005056bd6ce9;
        Sun, 06 Jun 2021 23:11:10 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 3/3] usb: typec: intel_pmc_mux: Put ACPI device using acpi_dev_put()
Date:   Sun,  6 Jun 2021 23:09:11 +0300
Message-Id: <20210606200911.32076-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606200911.32076-1-andy.shevchenko@gmail.com>
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ACPI devices we have a symmetric API to put them, so use it in the driver.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index de40276cc18b..2d0a863956c7 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -582,12 +582,12 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
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
 
@@ -657,7 +657,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
 		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
-	put_device(&pmc->iom_adev->dev);
+	acpi_dev_put(pmc->iom_adev);
 
 	return ret;
 }
@@ -673,7 +673,7 @@ static int pmc_usb_remove(struct platform_device *pdev)
 		usb_role_switch_unregister(pmc->port[i].usb_sw);
 	}
 
-	put_device(&pmc->iom_adev->dev);
+	acpi_dev_put(pmc->iom_adev);
 
 	return 0;
 }
-- 
2.31.1

