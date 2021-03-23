Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC787345575
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCWC0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:26:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:33649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCWCZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:25:42 -0400
IronPort-SDR: ybBWTpiSaXAJTlK9ta7/u+28z6sJTsV2PlV+l6iq+2ijzG5I8PO0mzhh67hJlDA2dfo+bvUenc
 O1lbXW0qTJzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177958152"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="177958152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 19:25:42 -0700
IronPort-SDR: Ov9wswf9uFOPGcZiDu+jkVsxI0EX4JqdmTfALU0YnRF1hwGceR0SNSuBGyE3FVgMYll87xhg+K
 qSHEzmqfUtsw==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="414751850"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 19:25:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: add slave device to linked list after device_register()
Date:   Tue, 23 Mar 2021 10:25:29 +0800
Message-Id: <20210323022529.21915-1-yung-chuan.liao@linux.intel.com>
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
index 112b21967c7a..0c92db2e1ddc 100644
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

