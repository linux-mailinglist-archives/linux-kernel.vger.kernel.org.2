Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0583E34DEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhC3CsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:48:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:61820 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhC3CsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:48:02 -0400
IronPort-SDR: 1HN2UIaxVjf4A7agWqaRva9JeKSgltpX/lPuNH0RaAvosZiB7jtVtRLeXgMPWmLXxiWv8YDfPa
 QIms4ZK0NRzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171688822"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="171688822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:48:00 -0700
IronPort-SDR: aV4tRo1DiejQ29OmxKZq6KVD3MrFlrkXbCad2sni1iAb71OTbrxFxn6hrVh8g+230mG846KeKq
 0qvFoYjjxIlg==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="445022360"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:48:00 -0700
Subject: [PATCH v2 4/4] cxl/mem: Disable cxl device power management
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Mon, 29 Mar 2021 19:48:00 -0700
Message-ID: <161707248015.2072157.4111152670292507770.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 508f0dc483f2..e578e82eb33d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1210,6 +1210,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);

