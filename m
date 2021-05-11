Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63E8379F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhEKFh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:37:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:29548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhEKFh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:37:56 -0400
IronPort-SDR: kHQ65++3hf6F72Eqeq7zPI3uRc1m/vA/sJUpO2gpWn0IqgAb9NlYTAqAagvfD5VjNlgpgzJUOR
 zo+4kf/rg5Aw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284848183"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284848183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:36:50 -0700
IronPort-SDR: SYbQKa5drIbm+oE86mUS4EN3+RL+C3rShrYShk3Yri4qNpU4ttMYi2pEn/Q4OM6otH0bOplS8m
 IFH2tVh984+g==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="536823754"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:36:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH] soundwire: add slave device to linked list after device_register()
Date:   Tue, 11 May 2021 13:36:39 +0800
Message-Id: <20210511053639.28550-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We currently add the slave device to a linked list before
device_register(), and then remove it if device_register() fails.

It's not clear why this sequence was necessary, this patch moves the
linked list management to after the device_register().

Suggested-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/slave.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0eed38a79c6d..ff01b96c6e56 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -65,9 +65,6 @@ int sdw_slave_add(struct sdw_bus *bus,
 	for (i = 0; i < SDW_MAX_PORTS; i++)
 		init_completion(&slave->port_ready[i]);
 
-	mutex_lock(&bus->bus_lock);
-	list_add_tail(&slave->node, &bus->slaves);
-	mutex_unlock(&bus->bus_lock);
 
 	ret = device_register(&slave->dev);
 	if (ret) {
@@ -77,13 +74,15 @@ int sdw_slave_add(struct sdw_bus *bus,
 		 * On err, don't free but drop ref as this will be freed
 		 * when release method is invoked.
 		 */
-		mutex_lock(&bus->bus_lock);
-		list_del(&slave->node);
-		mutex_unlock(&bus->bus_lock);
 		put_device(&slave->dev);
 
 		return ret;
 	}
+
+	mutex_lock(&bus->bus_lock);
+	list_add_tail(&slave->node, &bus->slaves);
+	mutex_unlock(&bus->bus_lock);
+
 	sdw_slave_debugfs_init(slave);
 
 	return ret;
-- 
2.17.1

