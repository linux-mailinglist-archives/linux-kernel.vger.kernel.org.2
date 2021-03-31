Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8947E34DEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhC3CsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:48:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:49576 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhC3Crz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:47:55 -0400
IronPort-SDR: xmO7S7AdqNFqv2OhtBpQ5P4GfgnKOl5MASOGgPhnobac5syQ+gO1/TJc+LJ1Vabnqt+SufLUsZ
 X8NhoKn0LVNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="253015185"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="253015185"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:55 -0700
IronPort-SDR: W4Y9kZatkgOf6cVmzrcEWpExF8VT/Ft7zcgMfM88mzZwCJzaAsYCjuGQQn8SZiZCkhxIaZa/G7
 ivoda3/6o2lA==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="527160395"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:55 -0700
Subject: [PATCH v2 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Mon, 29 Mar 2021 19:47:55 -0700
Message-ID: <161707247499.2072157.6441916308192404328.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
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
put_device() if the name set fails.

This type of bug is easier to see if 'alloc' is split from 'add'
operations that require put_device() on failure. So cxl_memdev_alloc()
is split out as a result.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 548d696f1f54..508f0dc483f2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1181,7 +1181,7 @@ static void cxlmdev_unregister(void *_cxlmd)
 	put_device(dev);
 }
 
-static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct cxl_memdev *cxlmd;
@@ -1191,7 +1191,7 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 
 	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	if (!cxlmd)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/*
 	 * @cxlm is released when the driver unbinds so srcu and
@@ -1201,7 +1201,7 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 
 	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
 	if (rc < 0)
-		goto err_id;
+		goto err;
 	cxlmd->id = rc;
 
 	dev = &cxlmd->dev;
@@ -1210,27 +1210,46 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-	dev_set_name(dev, "mem%d", cxlmd->id);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);
+	return cxlmd;
+
+err:
+	kfree(cxlmd);
+	return ERR_PTR(rc);
+}
+
+static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+{
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = cxl_memdev_alloc(cxlm);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
+	dev = &cxlmd->dev;
+	rc = dev_set_name(dev, "mem%d", cxlmd->id);
+	if (rc)
+		goto err;
 
+	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
-		goto err_add;
+		goto err;
 
 	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
 
-err_add:
+err:
 	/*
 	 * The cdev was briefly live, flush any ioctl operations that
 	 * saw that state.
 	 */
 	synchronize_srcu(&cxl_memdev_srcu);
-	ida_free(&cxl_memdev_ida, cxlmd->id);
-err_id:
-	kfree(cxlmd);
-
+	put_device(dev);
 	return rc;
 }
 

