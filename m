Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB55379D44
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKDCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:02:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:43215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhEKDCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:02:14 -0400
IronPort-SDR: rVfuBHX5NIEEeO8Aw/TTeQ9NED79HhBmKIRXzYnw8ev+oquwCZfug4FCJQf4v3XCw48Jm6btyg
 YSO+XjhtRgnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="196248770"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="196248770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:01:08 -0700
IronPort-SDR: tJP5K7eGhmicQRWS4KhYBSzq2e6FYZQfBD5Bu9oGnWc2jz03U89I4R3rbYB9Un4M9Q53YxOpbG
 4/h/gCfIB7XA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436431142"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:01:03 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 2/4] soundwire: add missing kernel-doc description
Date:   Tue, 11 May 2021 11:00:46 +0800
Message-Id: <20210511030048.25622-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
References: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

For some reason we never added a description for the clk_stop
callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 5d93d9949653..8ca736e92d5a 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -612,6 +612,7 @@ struct sdw_bus_params {
  * @update_status: Update Slave status
  * @bus_config: Update the bus config for Slave
  * @port_prep: Prepare the port with parameters
+ * @clk_stop: handle imp-def sequences before and after prepare and de-prepare
  */
 struct sdw_slave_ops {
 	int (*read_prop)(struct sdw_slave *sdw);
-- 
2.17.1

