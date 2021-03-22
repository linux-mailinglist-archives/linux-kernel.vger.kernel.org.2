Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7DD343F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCVLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:12:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:63080 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhCVLMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:12:35 -0400
IronPort-SDR: 0r1DVUhRVaiPq8MB4DUrDtYEdEYt15A7DJUNYW9O3fHCHk3OONo8o/uNQr/Qm71hBAOgg7HX97
 FI0/EGUg2IGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="254247616"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="254247616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 04:12:33 -0700
IronPort-SDR: RNI6TEEpZmnkks7/3wJ5Br5bQT+uiNHCT39xpi+T3yylzGLTJRVa9nWpX5J7G6SMo36NMOcbCW
 Xc0Lf7m0yqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="513270016"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2021 04:12:32 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: tegra: paz00: Handle device properties with software node API
Date:   Mon, 22 Mar 2021 14:12:45 +0300
Message-Id: <20210322111245.3784-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old device property API is going to be removed.
Replacing the device_add_properties() call with the software
node API equivalent, device_create_managed_software_node().

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

