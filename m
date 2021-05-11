Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE161379F78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEKGDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:03:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:22072 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhEKGDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:03:05 -0400
IronPort-SDR: iR+HNJ0aRWVFbGVD/ei9HX5GqEyequfixuQ3Jhwo56hICi3mTEypCETVubsEe2cIFNLPlt3gtp
 QameIhnDb07g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179626385"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179626385"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 23:01:58 -0700
IronPort-SDR: nbPHKOeW38Qyu/1ovsiZtH57Ftv8SGgARty5t7lMCfGB35bhsP9Fcqzijsw0nVDs5mXwbCinrv
 ZwuopUyszJAw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="624540173"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 23:01:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire/ASoC: add leading zeroes in peripheral device name
Date:   Tue, 11 May 2021 14:01:37 +0800
Message-Id: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We recently added leading zeroes in dev_dbg() messages but forgot to
do the same for the peripheral device name. Adding leading zeroes
makes it easier to read manufacturer ID and part ID, e.g.:

sdw:0:025d:0700:00
sdw:0:025d:0711:00
sdw:1:025d:0700:00
sdw:1:025d:1308:00
sdw:2:025d:0700:00
sdw:2:025d:0701:00
sdw:3:025d:0700:00
sdw:3:025d:0715:00

The use of '01x' for link_id and unique_id is intentional to show the
value range in the code, it's understood it does not actually change
the format.

To avoid problems with git bisect, the same change needs to be applied
to the Intel SoundWire machine driver, otherwise the components can't
be found and the card registration fails.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/slave.c        | 4 ++--
 sound/soc/intel/boards/sof_sdw.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index ff01b96c6e56..cc1e0fab5905 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -39,12 +39,12 @@ int sdw_slave_add(struct sdw_bus *bus,
 
 	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
 		/* name shall be sdw:link:mfg:part:class */
-		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x",
+		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
 			     bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id);
 	} else {
 		/* name shall be sdw:link:mfg:part:class:unique */
-		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
+		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
 			     bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id, id->unique_id);
 	}
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ecd3f90f4bbe..8df1e69235cc 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -581,13 +581,13 @@ static int create_codec_dai_name(struct device *dev,
 		comp_index = i + offset;
 		if (is_unique_device(link, sdw_version, mfg_id, part_id,
 				     class_id, i)) {
-			codec_str = "sdw:%x:%x:%x:%x";
+			codec_str = "sdw:%01x:%04x:%04x:%02x";
 			codec[comp_index].name =
 				devm_kasprintf(dev, GFP_KERNEL, codec_str,
 					       link_id, mfg_id, part_id,
 					       class_id);
 		} else {
-			codec_str = "sdw:%x:%x:%x:%x:%x";
+			codec_str = "sdw:%01x:%04x:%04x:%02x:%01x";
 			codec[comp_index].name =
 				devm_kasprintf(dev, GFP_KERNEL, codec_str,
 					       link_id, mfg_id, part_id,
-- 
2.17.1

