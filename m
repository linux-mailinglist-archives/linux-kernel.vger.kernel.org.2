Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEF37B6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhELHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:13:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:29455 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhELHMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:12:49 -0400
IronPort-SDR: NCoC1lWjvjlXQgZ1vJQu0fJL5KlQdMMHUNU8usSmQViWtoiQEm4ZVYqlylpi8yrYB2ilZiOU2t
 MKMM0R3Js5iQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186770470"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="186770470"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:11:35 -0700
IronPort-SDR: w/XWiihzJhvenrY1uSKI27XvFWByHACQtU3DGRHK6vwMStGUtujyfYKvVFCXKknYUth2Jlfgu+
 9t95d7mJzYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="541965920"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2021 00:11:33 -0700
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com,
        guy.zadicario@intel.com
Subject: [PATCH 07/15] misc: nnpi: Disallow host memory resource access if no NNP-I devices exist
Date:   Wed, 12 May 2021 10:10:38 +0300
Message-Id: <20210512071046.34941-8-guy.zadicario@intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210512071046.34941-1-guy.zadicario@intel.com>
References: <20210512071046.34941-1-guy.zadicario@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

