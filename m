Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04434F600
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCaBOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:14:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:50710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhCaBOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:14:15 -0400
IronPort-SDR: 11OYt26ZGiRy5hEpwxw/Fy7+jEmtOOGt1BnxM3ESTc+gt0KpOIhkk/j+HjFq2pjGl1Rouz6rNl
 8czoi7miXvkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179020193"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179020193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:15 -0700
IronPort-SDR: NDDo1b2SD8xVgU/wPY6rVx9AvmSYbjDOmRcHed39T5hFHifFsfd//K2jaEgtL7AyV6Pz5LNHwK
 qLRv5k0RDuKA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="418414702"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:14:11 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: add macro to selectively change error levels
Date:   Wed, 31 Mar 2021 09:13:54 +0800
Message-Id: <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We sometimes discard -ENODATA when reporting errors and lose all
traces of issues in the console log, add a macro to add use dev_dbg()
in such cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 40354469860a..8370216f95d4 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
+#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
+	do {								\
+		if (is_err)						\
+			dev_err(dev, fmt, __VA_ARGS__);			\
+		else							\
+			dev_dbg(dev, fmt, __VA_ARGS__);			\
+	} while (0)
+
 #endif /* __SDW_BUS_H */
-- 
2.17.1

