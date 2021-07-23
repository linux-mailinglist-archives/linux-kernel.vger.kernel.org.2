Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2332A3D3ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhGWMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:19:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:59478 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhGWMS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:18:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211592049"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211592049"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="660192790"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2021 05:59:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01F63FF; Fri, 23 Jul 2021 15:59:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Giaya <dgiaya@whoi.edu>
Subject: [PATCH v2 1/1] serial: max310x: Use clock-names property matching to recognize EXTCLK
Date:   Fri, 23 Jul 2021 15:59:43 +0300
Message-Id: <20210723125943.22039-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis reported that on ACPI-based systems the clock frequency
isn't enough to configure device properly. We have to respect
the clock source as well. To achieve this match the clock-names
property against "osc" to recognize external clock connection.
On DT-based system this doesn't change anything.

Reported-and-tested-by: Dennis Giaya <dgiaya@whoi.edu>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added Tested-by tag (Dennis), inverted comparison to leave original flow
 drivers/tty/serial/max310x.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ef11860cd69e..3df0788ddeb0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1271,18 +1271,13 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
 
-	s->clk = devm_clk_get_optional(dev, "osc");
+	xtal = device_property_match_string(dev, "clock-names", "osc") < 0;
+	if (xtal)
+		s->clk = devm_clk_get_optional(dev, "xtal");
+	else
+		s->clk = devm_clk_get_optional(dev, "osc");
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
-	if (s->clk) {
-		xtal = false;
-	} else {
-		s->clk = devm_clk_get_optional(dev, "xtal");
-		if (IS_ERR(s->clk))
-			return PTR_ERR(s->clk);
-
-		xtal = true;
-	}
 
 	ret = clk_prepare_enable(s->clk);
 	if (ret)
-- 
2.30.2

