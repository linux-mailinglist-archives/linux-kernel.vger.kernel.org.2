Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F78363B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhDSF14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 01:27:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:44552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhDSF1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 01:27:52 -0400
IronPort-SDR: QsQdhaUdO/5NIA1qZzQehB+27hFOYKq8/Q9G3DNsWqNLHz1zcJArFfIk8P8dezmj9xBS3jzXjl
 1DknVgZxDymQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="193147303"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="193147303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:23 -0700
IronPort-SDR: VYaTSnpADf4uiObR5zT8R0iowTaj61ZhLm47xY8iwmD400Zer/RbbNuoRnfaSlfprIj98lhJpN
 P1miUrhskJNw==
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="426370604"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 22:27:20 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/4] soundwire: add missing kernel-doc description
Date:   Mon, 19 Apr 2021 13:27:01 +0800
Message-Id: <20210419052703.2782-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419052703.2782-1-yung-chuan.liao@linux.intel.com>
References: <20210419052703.2782-1-yung-chuan.liao@linux.intel.com>
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

