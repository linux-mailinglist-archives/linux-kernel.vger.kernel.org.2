Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0A3EEAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbhHQKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:25:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:56026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236220AbhHQKZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:25:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195621137"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="195621137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 03:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="593304565"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2021 03:24:50 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] ARM: tegra: paz00: Handle device properties with software node API
Date:   Tue, 17 Aug 2021 13:24:48 +0300
Message-Id: <20210817102449.39994-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
References: <20210817102449.39994-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

