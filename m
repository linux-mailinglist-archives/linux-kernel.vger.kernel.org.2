Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1157232A330
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhCBIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:49:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:8982 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376871AbhCBIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:34:16 -0500
IronPort-SDR: iP8N4cOLfyjlKeCClkK2asUKEnhuVe+ijBi14Yn/R2LfDXX61NlK/JXy5jr+fu0TfJIo7WjDqR
 mP+db+CJisPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="183340399"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="183340399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:27 -0800
IronPort-SDR: xzUH+VpJ2Blm1Pyxqgv7oFZxl+dKh4M9T1P5NmH3vtdqMM7Ltxkz9lLLKaOMOF9FmcnBJ8hWUB
 1UygBo3qJ8Og==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406613410"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:27:23 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/3] soundwire: add master quirks for bus clash and parity
Date:   Tue,  2 Mar 2021 16:27:18 +0800
Message-Id: <20210302082720.12322-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently quirks are only allowed for Slave devices. This patch
describes the need for two quirks at the Master level.

a) bus clash
The SoundWire specification allows a Slave device to report a bus clash
with the in-band interrupt mechanism when it detects a conflict while
driving a bitSlot it owns. This can be a symptom of an electrical conflict
or a programming error, and it's vital to detect reliably.

Unfortunately, on some platforms, bus clashes are randomly reported by
Slave devices after a bus reset, with an interrupt status set even before
the bus clash interrupt is enabled. These initial spurious interrupts are
not relevant and should optionally be filtered out, while leaving the
interrupt mechanism enabled to detect 'true' issues.

This patch suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

b) parity

Additional tests on a new platform with the Maxim 98373 amplifier
showed a rare case where the parity interrupt is also thrown on
startup, at the same time as bus clashes. This issue only seems to
happen infrequently and was only observed during suspend-resume stress
tests while audio is streaming. We could make the problem go away by
adding a Slave-level quirk, but there is no evidence that the issue is
actually a Slave problem: the parity is provided by the Master, which
could also set an invalid parity in corner cases.

BugLink: https://github.com/thesofproject/linux/issues/2578
BugLink: https://github.com/thesofproject/linux/issues/2533

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d08039d65825..25f2a14e2e83 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -405,6 +405,7 @@ struct sdw_slave_prop {
  * command
  * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
  * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
+ * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -421,8 +422,29 @@ struct sdw_master_prop {
 	u32 err_threshold;
 	u32 mclk_freq;
 	bool hw_disabled;
+	u64 quirks;
 };
 
+/* Definitions for Master quirks */
+
+/*
+ * In a number of platforms bus clashes are reported after a hardware
+ * reset but without any explanations or evidence of a real problem.
+ * The following quirk will discard all initial bus clash interrupts
+ * but will leave the detection on should real bus clashes happen
+ */
+#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
+
+/*
+ * Some Slave devices have known issues with incorrect parity errors
+ * reported after a hardware reset. However during integration unexplained
+ * parity errors can be reported by Slave devices, possibly due to electrical
+ * issues at the Master level.
+ * The following quirk will discard all initial parity errors but will leave
+ * the detection on should real parity errors happen.
+ */
+#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
+
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
 
-- 
2.17.1

