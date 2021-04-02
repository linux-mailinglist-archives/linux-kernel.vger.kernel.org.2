Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A4352EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhDBRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:20609 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235786AbhDBRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:30 -0400
IronPort-SDR: z/+z/GeXA0iKm3SZMw0Hp7n/b3zigJquYGE1QBNM53Aa0lDcZGYrhQ1O+Sl3rzK2uI+jQgtwcK
 nqWP3C0KQh3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="256488269"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="256488269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:26 -0700
IronPort-SDR: UWHi01lu+PSwZDYx0hGm/c1PZfm0tH3Z3XBOgRRnq+qvQsRY5g6RZBh5pP52kN9XH7SSkhNSpB
 LBbMz0pP9gbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="378152796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2021 10:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BF4049; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 01/10] ipmi_si: Switch to use platform_get_mem_or_io()
Date:   Fri,  2 Apr 2021 20:43:25 +0300
Message-Id: <20210402174334.13466-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use new platform_get_mem_or_io() instead of home grown analogue.
Note, we also introduce ipmi_set_addr_data_and_space() helper here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 34 ++++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 129b5713f187..8f2fefc015b2 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -100,32 +100,31 @@ static int acpi_gpe_irq_setup(struct si_sm_io *io)
 }
 #endif
 
+static void ipmi_set_addr_data_and_space(struct resource *r, struct si_sm_io *io)
+{
+	if (resource_type(r) == IORESOURCE_IO)
+		io->addr_space = IPMI_IO_ADDR_SPACE;
+	else
+		io->addr_space = IPMI_MEM_ADDR_SPACE;
+	io->addr_data = r->start;
+}
+
 static struct resource *
 ipmi_get_info_from_resources(struct platform_device *pdev,
 			     struct si_sm_io *io)
 {
 	struct resource *res, *res_second;
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (res) {
-		io->addr_space = IPMI_IO_ADDR_SPACE;
-	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (res)
-			io->addr_space = IPMI_MEM_ADDR_SPACE;
-	}
+	res = platform_get_mem_or_io(pdev, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no I/O or memory address\n");
 		return NULL;
 	}
-	io->addr_data = res->start;
+	ipmi_set_addr_data_and_space(res, io);
 
 	io->regspacing = DEFAULT_REGSPACING;
-	res_second = platform_get_resource(pdev,
-			       (io->addr_space == IPMI_IO_ADDR_SPACE) ?
-					IORESOURCE_IO : IORESOURCE_MEM,
-			       1);
-	if (res_second) {
+	res_second = platform_get_mem_or_io(pdev, 1);
+	if (res_second && resource_type(res_second) == resource_type(res)) {
 		if (res_second->start > io->addr_data)
 			io->regspacing = res_second->start - io->addr_data;
 	}
@@ -275,12 +274,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
 	io.addr_source	= SI_DEVICETREE;
 	io.irq_setup	= ipmi_std_irq_setup;
 
-	if (resource.flags & IORESOURCE_IO)
-		io.addr_space = IPMI_IO_ADDR_SPACE;
-	else
-		io.addr_space = IPMI_MEM_ADDR_SPACE;
-
-	io.addr_data	= resource.start;
+	ipmi_set_addr_data_and_space(&resource, &io);
 
 	io.regsize	= regsize ? be32_to_cpup(regsize) : DEFAULT_REGSIZE;
 	io.regspacing	= regspacing ? be32_to_cpup(regspacing) : DEFAULT_REGSPACING;
-- 
2.30.2

