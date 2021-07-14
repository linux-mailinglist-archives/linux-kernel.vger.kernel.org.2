Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F174D3C7CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhGNDZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:9187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237831AbhGNDZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210095747"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210095747"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818164"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 05/10] soundwire: stream: don't abort bank switch on Command_Ignored/-ENODATA
Date:   Wed, 14 Jul 2021 11:22:04 +0800
Message-Id: <20210714032209.11284-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is needed for support of mockup devices, which by
construction will not provide any answer to a bank switch, but it's
also legit for regular cases.

If for some reason a device loses sync and cannot handle a bank
switch, we should go ahead anyways. The devices can always resync
later.

The only case where the error flow should be used is when there is a
Command_Aborted composite answer from SoundWire devices.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1a18308f4ef4..d84aaf115c13 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -697,7 +697,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	else
 		ret = sdw_transfer(bus, wr_msg);
 
-	if (ret < 0) {
+	if (ret < 0 && ret != -ENODATA) {
 		dev_err(bus->dev, "Slave frame_ctrl reg write failed\n");
 		goto error;
 	}
-- 
2.17.1

