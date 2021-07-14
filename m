Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAC3C7CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhGNDZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:61186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237860AbhGNDZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="295924115"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="295924115"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818208"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:45 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 09/10] soundwire: cadence: add debugfs interface for PDI loopbacks
Date:   Wed, 14 Jul 2021 11:22:08 +0800
Message-Id: <20210714032209.11284-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

For debug, it's interesting to create a loopback stream for each link
and use debugfs to set a source and target PDI. The target PDI would
need to be an RX port and use the same register configurations as the
source PDI. This capability allows e.g. for the headphone playback
stream to be snooped on the headset capture stream, or alternatively
for the addition of a dedicated loopback stream, in addition of
regular capture for that link.

This patch only adds the debugfs part, the port/PDI handling will be
handled in the next patches.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 44 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  3 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9a9b6110e763..3e740fcebdfe 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -450,6 +450,40 @@ static int cdns_parity_error_injection(void *data, u64 value)
 DEFINE_DEBUGFS_ATTRIBUTE(cdns_parity_error_fops, NULL,
 			 cdns_parity_error_injection, "%llu\n");
 
+static int cdns_set_pdi_loopback_source(void *data, u64 value)
+{
+	struct sdw_cdns *cdns = data;
+	unsigned int pdi_out_num = cdns->pcm.num_bd + cdns->pcm.num_out;
+
+	if (value > pdi_out_num)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	cdns->pdi_loopback_source = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cdns_pdi_loopback_source_fops, NULL, cdns_set_pdi_loopback_source, "%llu\n");
+
+static int cdns_set_pdi_loopback_target(void *data, u64 value)
+{
+	struct sdw_cdns *cdns = data;
+	unsigned int pdi_in_num = cdns->pcm.num_bd + cdns->pcm.num_in;
+
+	if (value > pdi_in_num)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	cdns->pdi_loopback_target = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cdns_pdi_loopback_target_fops, NULL, cdns_set_pdi_loopback_target, "%llu\n");
+
 /**
  * sdw_cdns_debugfs_init() - Cadence debugfs init
  * @cdns: Cadence instance
@@ -464,6 +498,16 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 
 	debugfs_create_file("cdns-parity-error-injection", 0200, root, cdns,
 			    &cdns_parity_error_fops);
+
+	cdns->pdi_loopback_source = -1;
+	cdns->pdi_loopback_target = -1;
+
+	debugfs_create_file("cdns-pdi-loopback-source", 0200, root, cdns,
+			    &cdns_pdi_loopback_source_fops);
+
+	debugfs_create_file("cdns-pdi-loopback-target", 0200, root, cdns,
+			    &cdns_pdi_loopback_target_fops);
+
 }
 EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 0e7f8b35bb21..6c039d456ba8 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -129,6 +129,9 @@ struct sdw_cdns {
 	struct sdw_cdns_streams pcm;
 	struct sdw_cdns_streams pdm;
 
+	int pdi_loopback_source;
+	int pdi_loopback_target;
+
 	void __iomem *registers;
 
 	bool link_up;
-- 
2.17.1

