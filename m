Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB534F51E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhC3XhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:37:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:51533 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhC3Xgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:36:50 -0400
IronPort-SDR: JDR392dm3ijRqH5Vy2NiuU1kpzcSWZQvUD6cmZW0tMQEAAfgdG9/E/xMyTV1tqoRt4RLHOJ4Iw
 Xh3yN0t4JmVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="253217116"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="253217116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:50 -0700
IronPort-SDR: uVQvczrJXbbnF9QBFUfk7OOOGFuLQpgscxlEJlUhT9Hz8gHMNqC/UvqUJURcPejbixwQoifRex
 J/9hRHgV83qg==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="595689721"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:49 -0700
Subject: [PATCH v3 4/4] cxl/mem: Disable cxl device power management
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Tue, 30 Mar 2021 16:36:48 -0700
Message-ID: <161714740843.2168142.6570516949724974678.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 759713b619ab..a8f750a9e2e4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1210,6 +1210,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);

