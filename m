Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6719E348359
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhCXVCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:02:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:37999 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238274AbhCXVCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:02:08 -0400
IronPort-SDR: 3mSFtaHGFVhN7eJi/9sQnHnnYnpWREreVgvonCZctDvkAqYt/e4JLWvwr4rfhSBYJE8FXtx0SN
 l8AYESwuVL/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275911419"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="275911419"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:07 -0700
IronPort-SDR: uPn7bLlOSm7iA8LC2fNNvQHT3Li6FIjKf8lCMfiF5IOfUkpWMo2/IQrkeDgvrzvvpEk5WUG0/4
 EcxqC89tD9pg==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="374788401"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:07 -0700
Subject: [PATCH 4/4] cxl/mem: Disable cxl device power management
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:02:07 -0700
Message-ID: <161661972722.1721612.7220170912347353657.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no power management of cxl virtual devices, disable
device-power-management and runtime-power-management to prevent
userspace from growing expectations of those attributes appearing. They
can be added back in the future if needed.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d615f183520c..338923a6b2ef 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1204,6 +1204,7 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);

