Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3234F0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhC3SQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:16:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:15274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhC3SQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:53 -0400
IronPort-SDR: FhmeeGjIiHJ6KX5qT22maa7rlllnQKte9mvSsK9hc99btRikTL/Ql/RwspkWBj9Dgs3I62hqHy
 cD889hrFb75Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179369062"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179369062"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:52 -0700
IronPort-SDR: K5/QiG7a7aWG7PiVPnlyEM+EKkNDWlzUzvvDZmHyL2eznNRr3TLTT0DM6J2tP3xOD9LZVfCX8t
 01zOiwUlYxeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="606862464"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2021 11:16:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 183D0133; Tue, 30 Mar 2021 21:17:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 01/10] ipmi_si: Switch to use platform_get_mem_or_io()
Date:   Tue, 30 Mar 2021 21:16:40 +0300
Message-Id: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use new platform_get_mem_or_io() instead of home grown analogue.
Note, we also introduce ipmi_set_addr_data_and_space() helper here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 40 +++++++++++-----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 129b5713f187..d7bd093f80e9 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -100,35 +100,32 @@ static int acpi_gpe_irq_setup(struct si_sm_io *io)
 }
 #endif
 
+static void ipmi_set_addr_data_and_space(struct resource *r, struct si_sm_io *io)
+{
+	io->addr_data = r->start;
+	if (resource_type(r) == IORESOURCE_IO)
+		io->addr_space = IPMI_IO_ADDR_SPACE;
+	else
+		io->addr_space = IPMI_MEM_ADDR_SPACE;
+}
+
 static struct resource *
 ipmi_get_info_from_resources(struct platform_device *pdev,
 			     struct si_sm_io *io)
 {
-	struct resource *res, *res_second;
+	struct resource *res, *second;
 
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
-		if (res_second->start > io->addr_data)
-			io->regspacing = res_second->start - io->addr_data;
-	}
+	second = platform_get_mem_or_io(pdev, 1);
+	if (second && resource_type(second) == resource_type(res) && second->start > io->addr_data)
+		io->regspacing = second->start - io->addr_data;
 
 	return res;
 }
@@ -275,12 +272,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
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

