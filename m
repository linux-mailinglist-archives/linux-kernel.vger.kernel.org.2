Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83D348358
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhCXVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:02:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:37982 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238227AbhCXVCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:02:02 -0400
IronPort-SDR: yTZEL2TQFsJy0ot+bji1yE8u/GSdhdBxvHvP0aT4mwD0cM5E1dzCGZ1zxeMfuuTjcPGQIQoYPz
 9XlFrOoK4H9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275911380"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="275911380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:02 -0700
IronPort-SDR: kfYrElActq2cIErox7P7fpRMpkbZxrWpXugfzR+FNjRc4BK7BSfgySaWqbO+iXzfW/StzvjjEe
 t9Mm+06nRHYA==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="442415541"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:02 -0700
Subject: [PATCH 3/4] cxl/mem: Do not rely on device_add() side effects for
 dev_set_name() failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:02:01 -0700
Message-ID: <161661972173.1721612.9458160848430375459.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While device_add() will happen to catch dev_set_name() failures it is a
broken pattern to follow given that the core may try to fall back to a
different name.

Add explicit checking for dev_set_name() failures to be cleaned up by
put_device(). Skip cdev_device_add() and proceed directly to
put_device() if the name set failure.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e53d573ae4ab..d615f183520c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1204,12 +1204,14 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-	dev_set_name(dev, "mem%d", cxlmd->id);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);
 
-	rc = cdev_device_add(cdev, dev);
+	rc = dev_set_name(dev, "mem%d", cxlmd->id);
+	if (rc == 0)
+		rc = cdev_device_add(cdev, dev);
+
 	if (rc) {
 		percpu_ref_kill(&cxlmd->ops_active);
 		put_device(dev);

