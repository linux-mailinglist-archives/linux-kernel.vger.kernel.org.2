Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64D538741D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhERIcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:32:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:41124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236556AbhERIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:31:47 -0400
IronPort-SDR: XEX155PAes4zsULmg+t4mOKwx5vD+5/1AnpOb/c+Pf0vpnt2yWIMoIIVnPZS4z5EravjxOfKYm
 HXm4xnIi5GoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221708580"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="221708580"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 01:30:29 -0700
IronPort-SDR: bKs9DkyRlQSiAcSq65eYz2oBWy8Mf6SpNobo3qr97iGzry57jQ/XJQNqY2mC58YdqWZzaNDh2r
 MgnXxNifHiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="541658143"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 01:30:27 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: tegra: paz00: Handle device properties with software node API
Date:   Tue, 18 May 2021 11:30:45 +0300
Message-Id: <20210518083046.23302-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/board-paz00.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index b5c990a7a5af5..18d37f90cdfe3 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -36,7 +36,7 @@ static struct gpiod_lookup_table wifi_gpio_lookup = {
 
 void __init tegra_paz00_wifikill_init(void)
 {
-	platform_device_add_properties(&wifi_rfkill_device, wifi_rfkill_prop);
+	device_create_managed_software_node(&wifi_rfkill_device.dev, wifi_rfkill_prop, NULL);
 	gpiod_add_lookup_table(&wifi_gpio_lookup);
 	platform_device_register(&wifi_rfkill_device);
 }
-- 
2.30.2

