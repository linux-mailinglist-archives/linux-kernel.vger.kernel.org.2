Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534AE3ADDC3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhFTIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 04:38:18 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54562 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFTIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 04:38:17 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jun 2021 04:38:16 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 19E2A20129F;
        Sun, 20 Jun 2021 08:27:11 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id CBDFC80135; Sun, 20 Jun 2021 10:26:34 +0200 (CEST)
Date:   Sun, 20 Jun 2021 10:26:34 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     andriy.shevchenko@linux.intel.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: v5.13-rcX regression - NULL pointer dereference - MFD and software
 node API
Message-ID: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
dereference issue introduced by commit
	42e59982917a ("mfd: core: Add support for software nodes")
in v5.13-rc1:
	https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/

A bisect shows that it is indeed commit 42e59982917a which causes boot to
fail due to a NULL pointer dereference on my work laptop, where "intel-lpss"
is bound to
	00:15.0	Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
and fails to bind to INT3446:

[    6.048087] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    6.050625] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    6.109112] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    6.111348] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    6.172229] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)
[    6.174353] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    6.231865] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)
[    6.233845] idma64 idma64.3: Found Intel integrated DMA 64-bit
[    6.287492] ACPI Warning: SystemMemory range 0x00000000FE028000-0x00000000FE0281FF conflicts with OpRegion 0x00000000FE028000-0x00000000FE028207 (\_SB.PCI0.GEXP.BAR0) (20210331/utaddress-204)
[    6.287704] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    6.289760] intel-lpss: probe of INT3446:00 failed with error -16

Unfortunately, the patch by Andy Shevchenko (applied on top of Linus' tree)
does not fix the issue. A complete revert, however, does fix the issue, and
allows my laptop to boot again.

In my opinion, it is unfortunate that although it has been known for over a
month that commit 42e59982917a is broken, the bugfix (though probably not 
far-reaching enough) has not yet progressed upstream.

Thanks,
	Dominik


[PATCH] Revert "mfd: core: Add support for software nodes"

This reverts commit 42e59982917a25ad254b74e6e8decee5e684763d.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6f02b8022c6d..7a052e61280e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -226,12 +226,6 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_of_entry;
 	}
 
-	if (cell->swnode) {
-		ret = device_add_software_node(&pdev->dev, cell->swnode);
-		if (ret)
-			goto fail_of_entry;
-	}
-
 	for (r = 0; r < cell->num_resources; r++) {
 		res[r].name = cell->resources[r].name;
 		res[r].flags = cell->resources[r].flags;
@@ -292,7 +286,6 @@ static int mfd_add_device(struct device *parent, int id,
 			list_del(&of_entry->list);
 			kfree(of_entry);
 		}
-	device_remove_software_node(&pdev->dev);
 fail_alias:
 	regulator_bulk_unregister_supply_alias(&pdev->dev,
 					       cell->parent_supplies,
@@ -361,8 +354,6 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-	device_remove_software_node(&pdev->dev);
-
 	platform_device_unregister(pdev);
 	return 0;
 }
