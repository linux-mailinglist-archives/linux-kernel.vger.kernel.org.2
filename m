Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81634F590
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 02:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCaAqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 20:46:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:56146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232874AbhCaAqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 20:46:22 -0400
IronPort-SDR: U9C2u/zvveQ2SQepFxaJ9f+eMr5vu0IFrejTuVuZC6/RLCy/o3di7DjTzHNvgaZEjGcmZr74XL
 As4eEqQWxgGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="253225877"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="253225877"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 17:46:21 -0700
IronPort-SDR: gm0YkBJEVZ4ivykypiNDPO+bUOLrPysK1t06a47gdChVlbVFQkY1n9d1OdeV2ZdiN6OSJweI+/
 VijoLndzWasg==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418407069"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 17:46:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: stream: fix memory leak in stream config error path
Date:   Wed, 31 Mar 2021 08:46:10 +0800
Message-Id: <20210331004610.12242-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

When stream config is failed, master runtime will release all
slave runtime in the slave_rt_list, but slave runtime is not
added to the list at this time. This patch frees slave runtime
in the config error path to fix the memory leak.

Fixes: bbe7379d8040a ("soundwire: Add support for SoundWire stream management")
Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Keyon Jie <yang.jie@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 9c064b672745..1eaedaaba094 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1375,8 +1375,16 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	}
 
 	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
-	if (ret)
+	if (ret) {
+		/*
+		 * sdw_release_master_stream will release s_rt in slave_rt_list in
+		 * stream_error case, but s_rt is only added to slave_rt_list
+		 * when sdw_config_stream is successful, so free s_rt explicitly
+		 * when sdw_config_stream is failed.
+		 */
+		kfree(s_rt);
 		goto stream_error;
+	}
 
 	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
-- 
2.17.1

