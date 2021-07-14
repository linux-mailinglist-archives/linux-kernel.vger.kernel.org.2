Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8B3C7CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhGNDZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:9187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237797AbhGNDZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210095740"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210095740"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818143"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 03/10] ASoC: soc-acpi: tgl: add table for SoundWire mockup devices
Date:   Wed, 14 Jul 2021 11:22:02 +0800
Message-Id: <20210714032209.11284-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Follow the same idea as for CNL/UpExtreme and add mockup test
first. They will only be selected if the SSDT is modified to add such
mockup devices.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index 66595e3ab13f..e2488f0eaff8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -8,6 +8,7 @@
 
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
+#include "soc-acpi-intel-sdw-mockup-match.h"
 
 static const struct snd_soc_acpi_codecs tgl_codecs = {
 	.num_codecs = 1,
@@ -351,6 +352,28 @@ EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_machines);
 
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
+	/* mockup tests need to be first */
+	{
+		.link_mask = GENMASK(3, 0),
+		.links = sdw_mockup_headset_2amps_mic,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt711-rt1308-rt715.tplg",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1) | BIT(3),
+		.links = sdw_mockup_headset_1amp_mic,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt711-rt1308-mono-rt715.tplg",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1) | BIT(2),
+		.links = sdw_mockup_mic_headset_1amp,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt715-rt711-rt1308-mono.tplg",
+	},
 	{
 		.link_mask = 0x7,
 		.links = tgl_sdw_rt711_link1_rt1308_link2_rt715_link0,
-- 
2.17.1

