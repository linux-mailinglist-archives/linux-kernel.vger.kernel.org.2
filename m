Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B929E4531CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhKPMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236236AbhKPMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:08:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 172EF61B39;
        Tue, 16 Nov 2021 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064350;
        bh=RzYJiPe0MQQ5yuETSfop/8ZsyC6/3KQUXUFe+BQQeuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyOmqjmaQzhXB42QVZBZYQhphJ9dKsoYuvs4mDU6qGQziqDGgaSRgbmICn//3rSgY
         Blb29l//AqMTUI02oYILKDjFLwnYO9EWnRiS6kOvgyvgXgw2vJMpzLAQH+ps2NJ9YT
         Nxt2CHpVfseB5JJbyAQ9UIjMIaG4Eh19ftDbtfkURqePYJvcXlRXEXZ+uMqtG5U9Wx
         SqP0L2OCTxKzlrJmNdyCJhV8mGm0K7B6204O5x895bT6Z8roabOPwIFzGRX+vka4RB
         ENm9Ch0U/bbp9e+IFD0pkdDzDIlo6B47pyH6unPQIZ3O5keZ3HA0xI6q/rP49fkND5
         YIcBqQJKCy3BQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxDe-00A9CF-Fw; Tue, 16 Nov 2021 12:05:46 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Wei Xu" <xuwei5@hisilicon.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] clk: wait for extra time before disabling unused clocks
Date:   Tue, 16 Nov 2021 12:05:43 +0000
Message-Id: <e984318c61da720f4a46e919141162c0672dc5c9.1637064075.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637064075.git.mchehab+huawei@kernel.org>
References: <cover.1637064075.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some tests with HiKey970, with several drivers compiled as
modules, clk_disable_unused() has been called too early,
before the init code from the drivers built as module to be called.

If the system is left to disable unused clocks, those are the last
messages at the console:

	[   22.348592] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.366973] calling  fb_logo_late_init+0x0/0x20 @ 1 irqs_disabled() 0
	[   22.373432] initcall fb_logo_late_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0

	[   22.381800] calling  clk_disable_unused+0x0/0xe8 @ 1 irqs_disabled() 0
				==================

	<SoC dies here... no other messages>

Preventing clk_disable_unused to be called, there are several other initcall
logs after it:

	[   22.340305] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 @ 1 irqs_disabled() 0
	[   22.348594] dwmmc_k3 fc183000.dwmmc2: card claims to support voltages below defined range
	[   22.348592] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa8 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.366973] calling  fb_logo_late_init+0x0/0x20 @ 1 irqs_disabled() 0
	[   22.373432] initcall fb_logo_late_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0

	[   22.356984] initcall clk_disable_unused+0x0/0xe8 returned 0 after 117 usecs, irqs_disabled() 0
				==================

	[   22.372335] initcall imx_clk_disable_uart+0x0/0x88 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.387946] initcall regulator_init_complete+0x0/0x58 returned 0 after 2 usecs, irqs_disabled() 0
	[   22.404163] initcall of_platform_sync_state_init+0x0/0x20 returned 0 after 1 usecs, irqs_disabled() 0
	[   22.426508] initcall alsa_sound_last_init+0x0/0x90 returned 0 after 6239 usecs, irqs_disabled() 0
	[   22.703071] initcall inet6_init+0x0/0x358 [ipv6] returned 0 after 13341 usecs, irqs_disabled() 0
	[   22.723861] initcall xt_init+0x0/0x1000 [x_tables] returned 0 after 8 usecs, irqs_disabled() 0
	[   22.744405] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 23 usecs, irqs_disabled() 0
	[   23.467003] initcall fuse_init+0x0/0x154 [fuse] returned 0 after 392 usecs, irqs_disabled() 0
	[   23.537742] initcall drm_core_init+0x0/0x1000 [drm] returned 0 after 122 usecs, irqs_disabled() 0
	[   24.519076] initcall rfkill_init+0x0/0x12c [rfkill] returned 0 after 15654 usecs, irqs_disabled() 0
	[   24.622168] initcall hi3670_pcie_phy_driver_init+0x0/0x1000 [phy_hi3670_pcie] returned 0 after 836 usecs, irqs_disabled() 0
	[   24.665100] initcall hi3670_phy_driver_init+0x0/0x1000 [phy_hi3670_usb3] returned 0 after 1888 usecs, irqs_disabled() 0
	[   24.694668] initcall typec_init+0x0/0x1000 [typec] returned 0 after 89 usecs, irqs_disabled() 0
	[   24.732557] initcall cpu_feature_match_ASIMD_init+0x0/0x1000 [crct10dif_ce] returned 0 after 8838 usecs, irqs_disabled() 0
	[   24.746636] initcall tcpci_i2c_driver_init+0x0/0x1000 [tcpci] returned 0 after 8607 usecs, irqs_disabled() 0
	[   24.774541] initcall hisi_hikey_usb_driver_init+0x0/0x1000 [hisi_hikey_usb] returned 0 after 35860 usecs, irqs_disabled() 0
	[   24.892957] initcall rt1711h_i2c_driver_init+0x0/0x1000 [tcpci_rt1711h] returned 0 after 21500 usecs, irqs_disabled() 0
	[   24.956528] initcall wl1271_init+0x0/0x1000 [wlcore_sdio] returned 0 after 83582 usecs, irqs_disabled() 0
	[   25.039853] initcall cfg80211_init+0x0/0xdc [cfg80211] returned 0 after 26291 usecs, irqs_disabled() 0
	[   25.118288] initcall ieee80211_init+0x0/0x40 [mac80211] returned 0 after 15 usecs, irqs_disabled() 0
	[   25.335203] initcall wl18xx_driver_init+0x0/0x1000 [wl18xx] returned 0 after 134423 usecs, irqs_disabled() 0
	[   26.277300] initcall ecdh_init+0x0/0xd0 [ecdh_generic] returned 0 after 302 usecs, irqs_disabled() 0
	[   26.435409] initcall bt_init+0x0/0xcc [bluetooth] returned 0 after 63051 usecs, irqs_disabled() 0
	[   26.508033] initcall btusb_driver_init+0x0/0x1000 [btusb] returned 0 after 305 usecs, irqs_disabled() 0
	[   27.333049] initcall kirin_pcie_driver_init+0x0/0x1000 [pcie_kirin] returned 0 after 805983 usecs, irqs_disabled() 0

So, just like regulator_init_complete code at drivers/regulator/core.c
does, we need to also delay the call to the actual logic which
disables the unused clocks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/2] at: https://lore.kernel.org/all/cover.1637064075.git.mchehab+huawei@kernel.org/

 drivers/clk/clk.c | 51 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f467d63bbf1e..3e6f80b90594 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/clkdev.h>
+#include <linux/workqueue.h>
 
 #include "clk.h"
 
@@ -1206,7 +1207,7 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static void clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
@@ -1236,7 +1237,7 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static void clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
@@ -1290,30 +1291,42 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
+static void __clk_disable_unused(struct work_struct *w)
+{
+	struct clk_core *core;
+
+	clk_prepare_lock();
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_disable_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node)
+		clk_disable_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_unprepare_unused_subtree(core);
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node)
+		clk_unprepare_unused_subtree(core);
+
+	clk_prepare_unlock();
+}
+DECLARE_DELAYED_WORK(disable_unused, __clk_disable_unused);
+
 static int __init clk_disable_unused(void)
 {
-	struct clk_core *core;
-
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
 	}
 
-	clk_prepare_lock();
-
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_unprepare_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_unprepare_unused_subtree(core);
-
-	clk_prepare_unlock();
+	/*
+	 * We punt completion for an arbitrary amount of time since
+	 * systems with enable clocks during module load are initialized
+	 * after late_initcall_sync(), as module drivers will be probed
+	 * and initialized afterwards.
+	 */
+	schedule_delayed_work(&disable_unused, msecs_to_jiffies(15000));
 
 	return 0;
 }
-- 
2.33.1

