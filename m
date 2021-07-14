Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92893C7CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhGNDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:9200 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237850AbhGNDZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210095751"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210095751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818176"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 06/10] soundwire: add flag to ignore all command/control for mockup devices
Date:   Wed, 14 Jul 2021 11:22:05 +0800
Message-Id: <20210714032209.11284-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

SoundWire mockup devices don't take part in the command/control
protocol, so all commands will complete with -ENODATA or
Command_Ignored results. With a flag, we can suppress such errors in
the bus management and make it appear as if all read/writes succeed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 3 +++
 sound/soc/codecs/sdw-mockup.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a48ac3e77301..76ce3f3ac0f2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -661,6 +661,8 @@ struct sdw_slave_ops {
  * initialized
  * @first_interrupt_done: status flag tracking if the interrupt handling
  * for a Slave happens for the first time after enumeration
+ * @is_mockup_device: status flag used to squelch errors in the command/control
+ * protocol for SoundWire mockup devices
  */
 struct sdw_slave {
 	struct sdw_slave_id id;
@@ -683,6 +685,7 @@ struct sdw_slave {
 	struct completion initialization_complete;
 	u32 unattach_request;
 	bool first_interrupt_done;
+	bool is_mockup_device;
 };
 
 #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
diff --git a/sound/soc/codecs/sdw-mockup.c b/sound/soc/codecs/sdw-mockup.c
index a4f79eb2c69d..8ea13cfa9f8e 100644
--- a/sound/soc/codecs/sdw-mockup.c
+++ b/sound/soc/codecs/sdw-mockup.c
@@ -263,6 +263,8 @@ static int sdw_mockup_sdw_probe(struct sdw_slave *slave,
 	dev_set_drvdata(dev, sdw_mockup);
 	sdw_mockup->slave = slave;
 
+	slave->is_mockup_device = true;
+
 	ret =  devm_snd_soc_register_component(dev,
 					       &snd_soc_sdw_mockup_component,
 					       sdw_mockup_dai,
-- 
2.17.1

