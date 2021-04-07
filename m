Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6F356213
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348385AbhDGDpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbhDGDpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:45:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD5C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 20:45:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t3so11178174qtp.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 20:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fsNlnoBHDn0D0rh5TFoEuxCJYypVBSKRudJbJjcd978=;
        b=QPdGZ2bdnuKErbQcBlWnWoMYrFDtveC9lvkVTtgM4CLZ4gOm1EHqXqqZiiHWi+J3I8
         HfZ9VcEOCbh3h8cOspjHrpUc7czYWIeFGnvTd3RziQk6QxHCOpB6aLOST+A7sUbdMMha
         qJWj1IwvFd9k4mipLYYKrTlj0rrelIeh4SDJ/t0/EQnAbqg3gIZQtvPcXQcXXLf8hfch
         Y/36NqUsRDSNBFmE7QezVkRA0Yl32GouzjiZ2MPYX+wPmPOfGhvbKlUtC08XoY5vb2ey
         RlDKCZqStCcjxrFnIINSIi5o6blaw6dLCS8g86RxLfnkA2l9PNBmPJ333iaPtPA/dMFX
         JBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fsNlnoBHDn0D0rh5TFoEuxCJYypVBSKRudJbJjcd978=;
        b=HBjlRKUMB0UavOZDI9tCJoEC1Eo7Nx7QKHmdFIUXm9Azdhq6D+Y1wm8+gbdO1cZAUw
         UsX9aPq+KPI5LZXv/sj0TgN+TsEjxpUhs/4x9AFnK+e7tMTU+7Qz4LtB11AAO127Clap
         MzQPFOD1VawV+3UYnbyNzB/2bifBMiQ9tRm/kh4mzA5ka2MkTGd9WUadUKcm2OXyy8Uj
         6lx3y2T9pFryhah3eycYIK6HsagmeoKsUQQXDVdYPDeemraFVsUiasMmX9DArt4ogLgE
         OpgU6isizMcGh8B/aOdjjg2hjBg3DqjT0M+chIKZMXCyY+CQiHcoZg4uabRXY073uIIg
         0DOA==
X-Gm-Message-State: AOAM530IG9X96jH+mk0eR8pVmbBQ145xY/mrBxE12HzLlzwNanOP/Pcb
        6Erq/pHjg2noCE84oIN4dvPX5XxTxXml1ys=
X-Google-Smtp-Source: ABdhPJyaKbIZaJQ+wXBMKqdm7/KWLSF60IGx8arwaxJqn6g1wRemlhZNtQAEIOAc+oH9DRR8KG0eDjBpSMhPSzI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:2dae:f92:7d76:4244])
 (user=saravanak job=sendgmr) by 2002:ad4:5767:: with SMTP id
 r7mr1465354qvx.27.1617767104587; Tue, 06 Apr 2021 20:45:04 -0700 (PDT)
Date:   Tue,  6 Apr 2021 20:44:55 -0700
In-Reply-To: <20210407034456.516204-1-saravanak@google.com>
Message-Id: <20210407034456.516204-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210407034456.516204-1-saravanak@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v1 2/2] clk: Add support for sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks can be turned on (by the hardware, bootloader, etc) upon a
reset/boot of a hardware platform. These "boot clocks" could be clocking
devices that are active before the kernel starts running. For example,
clocks needed for the interconnects, UART console, display, CPUs, DDR,
etc.

When a boot clock is used by more than one consumer or multiple boot
clocks share a parent clock, the boot clock (or the common parent) can
be turned off when the first consumer probes. This can crash the device
or cause poor user experience.

Fix this by explicitly enabling the boot clocks during clock
registration and then removing the enable vote when the clock provider
device gets its sync_state() callback. Since sync_state() callback comes
only when all the consumers of a device (not a specific clock) have
probed, this ensures the boot clocks are kept on at least until all
their consumers have had a chance to vote on them (in their respective
probe functions).

Also, if a clock provider is loaded as a module and it has some boot
clocks, they get turned off only when a consumer explicitly turns them
off. So clocks that are boot clocks and are unused never get turned off
because the logic to turn off unused clocks has already run during
late_initcall_sync(). Adding sync_state() support also makes sure these
unused boot clocks are turned off once all the consumers have probed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++-
 include/linux/clk-provider.h |  1 +
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d6301a3351f2..cd07f4d1254c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -72,6 +72,8 @@ struct clk_core {
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	bool			need_sync;
+	bool			boot_enabled;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -1215,6 +1217,15 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_unprepare_unused_subtree(child);
 
+	/*
+	 * Orphan clocks might still not have their state held if one of their
+	 * ancestors hasn't been registered yet. We don't want to turn off
+	 * these orphan clocks now as they will be turned off later when their
+	 * device gets a sync_state() call.
+	 */
+	if (dev_has_sync_state(core->dev))
+		return;
+
 	if (core->prepare_count)
 		return;
 
@@ -1246,6 +1257,15 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	/*
+	 * Orphan clocks might still not have their state held if one of their
+	 * ancestors hasn't been registered yet. We don't want to turn off
+	 * these orphan clocks now as they will be turned off later when their
+	 * device gets a sync_state() call.
+	 */
+	if (dev_has_sync_state(core->dev))
+		return;
+
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
@@ -1319,6 +1339,38 @@ static int __init clk_disable_unused(void)
 }
 late_initcall_sync(clk_disable_unused);
 
+static void clk_unprepare_disable_dev_subtree(struct clk_core *core,
+					      struct device *dev)
+{
+	struct clk_core *child;
+
+	lockdep_assert_held(&prepare_lock);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_unprepare_disable_dev_subtree(child, dev);
+
+	if (core->dev != dev || !core->need_sync)
+		return;
+
+	clk_core_disable_unprepare(core);
+}
+
+void clk_sync_state(struct device *dev)
+{
+	struct clk_core *core;
+
+	clk_prepare_lock();
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_unprepare_disable_dev_subtree(core, dev);
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node)
+		clk_unprepare_disable_dev_subtree(core, dev);
+
+	clk_prepare_unlock();
+}
+EXPORT_SYMBOL_GPL(clk_sync_state);
+
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
 {
@@ -1725,6 +1777,30 @@ int clk_hw_get_parent_index(struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent_index);
 
+static void clk_core_hold_state(struct clk_core *core)
+{
+	if (core->need_sync || !core->boot_enabled)
+		return;
+
+	if (core->orphan || !dev_has_sync_state(core->dev))
+		return;
+
+	core->need_sync = !clk_core_prepare_enable(core);
+}
+
+static void __clk_core_update_orphan_hold_state(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->orphan)
+		return;
+
+	clk_core_hold_state(core);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		__clk_core_update_orphan_hold_state(child);
+}
+
 /*
  * Update the orphan status of @core and all its children.
  */
@@ -3392,6 +3468,7 @@ static void clk_core_reparent_orphans_nolock(void)
 			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
+			__clk_core_update_orphan_hold_state(orphan);
 		}
 	}
 }
@@ -3550,6 +3627,8 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = core->req_rate = rate;
 
+	core->boot_enabled = clk_core_is_enabled(core);
+
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
 	 * don't get accidentally disabled when walking the orphan tree and
@@ -3572,6 +3651,7 @@ static int __clk_core_init(struct clk_core *core)
 		}
 	}
 
+	clk_core_hold_state(core);
 	clk_core_reparent_orphans_nolock();
 
 
@@ -3837,8 +3917,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		core->rpm_enabled = true;
 	core->dev = dev;
 	core->of_node = np;
-	if (dev && dev->driver)
+	if (dev && dev->driver) {
 		core->owner = dev->driver->owner;
+		dev_set_drv_sync_state(dev, clk_sync_state);
+	}
 	core->hw = hw;
 	core->flags = init->flags;
 	core->num_parents = init->num_parents;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 58f6fe866ae9..429c413dadce 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1112,6 +1112,7 @@ void devm_clk_unregister(struct device *dev, struct clk *clk);
 
 void clk_hw_unregister(struct clk_hw *hw);
 void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
+void clk_sync_state(struct device *dev);
 
 /* helper functions */
 const char *__clk_get_name(const struct clk *clk);
-- 
2.31.1.295.g9ea45b61b8-goog

