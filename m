Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B737F499
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhEMJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:00:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:47049 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhEMI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:59:40 -0400
IronPort-SDR: 6mOf+j7CA5/2p8+RPdAFXB1fBkyui7JebkMGKjStEPsZHXEdGM8x5tdakpj0Tsf9vpgyuVFdra
 wHFAeJQAk9LQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187032274"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187032274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:58:16 -0700
IronPort-SDR: lRWXZKGXPRgDn15qhlNfjzD1Bzgih4ObhjuUsqu8rfo5JOkAu+SW9cw0Djtz8chtNO67vkwt/y
 Ln4c5pFt8JrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625928300"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 01:58:15 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH v2 07/15] misc: nnpi: Disallow host memory resource access if no NNP-I devices exist
Date:   Thu, 13 May 2021 11:57:17 +0300
Message-Id: <20210513085725.45528-8-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210513085725.45528-1-guy.zadicario@intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point allowing a user application to create host resources
on a system that does not equipped with any NNP-I devices.
Fail openning the nnpi_host character device when no NNP-I devices are
attached.
It is OK to do that check without any synchronization as a race would not
be an issue.

Signed-off-by: Guy Zadicario <guy.zadicario@intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/misc/intel-nnpi/device.c       | 5 +++++
 drivers/misc/intel-nnpi/device.h       | 2 ++
 drivers/misc/intel-nnpi/host_chardev.c | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/misc/intel-nnpi/device.c b/drivers/misc/intel-nnpi/device.c
index 0f98398..a3c6a1d 100644
--- a/drivers/misc/intel-nnpi/device.c
+++ b/drivers/misc/intel-nnpi/device.c
@@ -13,6 +13,11 @@
 
 static DEFINE_IDA(dev_ida);
 
+bool nnpdev_no_devices(void)
+{
+	return ida_is_empty(&dev_ida);
+}
+
 /**
  * nnpdev_init() - initialize NNP-I device structure.
  * @nnpdev: device to be initialized
diff --git a/drivers/misc/intel-nnpi/device.h b/drivers/misc/intel-nnpi/device.h
index 7d7ef60..562bbc4 100644
--- a/drivers/misc/intel-nnpi/device.h
+++ b/drivers/misc/intel-nnpi/device.h
@@ -36,6 +36,8 @@ struct nnp_device_ops {
 	int (*cmdq_write_mesg)(struct nnp_device *nnpdev, u64 *msg, u32 size);
 };
 
+bool nnpdev_no_devices(void);
+
 /*
  * Functions exported by the device framework module which are
  * called by the lower layer NNP-I device driver module
diff --git a/drivers/misc/intel-nnpi/host_chardev.c b/drivers/misc/intel-nnpi/host_chardev.c
index 6048fda..fad5954 100644
--- a/drivers/misc/intel-nnpi/host_chardev.c
+++ b/drivers/misc/intel-nnpi/host_chardev.c
@@ -217,6 +217,13 @@ static int host_open(struct inode *inode, struct file *f)
 	if (!is_host_file(f))
 		return -EINVAL;
 
+	/*
+	 * No point to serve host resource creation while no
+	 * NNP-I devices exist in the system.
+	 */
+	if (nnpdev_no_devices())
+		return -ENODEV;
+
 	user_info = kzalloc(sizeof(*user_info), GFP_KERNEL);
 	if (!user_info)
 		return -ENOMEM;
-- 
1.8.3.1

