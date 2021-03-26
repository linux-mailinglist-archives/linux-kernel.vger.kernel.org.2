Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BD34A3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCZJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:15:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:23498 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhCZJPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:37 -0400
IronPort-SDR: u9CsXPnI/HEAweJSjpLj3XjfZdH8C7M9V3KssNhkLu7L3snDHULLbgchLZ8uTJK8/C4XHqAEo6
 t5IkzbDTvcrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269557"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269557"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:29 -0700
IronPort-SDR: wakWu590u1fj/QX2ZX55eYBrOP/7Rg+7N9gtsePFygXwMEt+JRV6oTLkU/hWAy/T7kGi9Lq8gi
 HXxavQpwMh+g==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463097"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:27 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 01/11] soundwire: bus: use correct driver name in error messages
Date:   Fri, 26 Mar 2021 17:15:04 +0800
Message-Id: <20210326091514.20751-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

None of the existing codec drivers set the sdw_driver.name, but
instead set sdw_driver.driver.name.

This leads to error messages such as
[   23.935355] rt700 sdw:2:25d:700:0: Probe of (null) failed: -19

We could remove this sdw_driver.name if it doesn't have any
purpose. This patch only suggests using the proper indirection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 575b9bad99d5..893296f3fe39 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -82,6 +82,7 @@ static int sdw_drv_probe(struct device *dev)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
 	const struct sdw_device_id *id;
+	const char *name;
 	int ret;
 
 	/*
@@ -108,7 +109,10 @@ static int sdw_drv_probe(struct device *dev)
 
 	ret = drv->probe(slave, id);
 	if (ret) {
-		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
+		name = drv->name;
+		if (!name)
+			name = drv->driver.name;
+		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
 		return ret;
 	}
@@ -174,11 +178,16 @@ static void sdw_drv_shutdown(struct device *dev)
  */
 int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
 {
+	const char *name;
+
 	drv->driver.bus = &sdw_bus_type;
 
 	if (!drv->probe) {
-		pr_err("driver %s didn't provide SDW probe routine\n",
-		       drv->name);
+		name = drv->name;
+		if (!name)
+			name = drv->driver.name;
+
+		pr_err("driver %s didn't provide SDW probe routine\n", name);
 		return -EINVAL;
 	}
 
-- 
2.17.1

