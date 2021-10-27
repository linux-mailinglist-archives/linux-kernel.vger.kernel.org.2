Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5143C943
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhJ0MMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:12:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:22295 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241781AbhJ0MML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:12:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227600339"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="227600339"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 05:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="486650016"
Received: from dev01.bj.intel.com ([10.238.158.57])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2021 05:09:43 -0700
From:   Huaisheng Ye <huaisheng.ye@intel.com>
To:     dan.j.williams@intel.com, hch@lst.de, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH 2/4] libnvdimm/pmem: implement ->set_read_only to hook into BLKROSET processing
Date:   Wed, 27 Oct 2021 20:09:35 +0800
Message-Id: <20211027120937.1163744-3-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211027120937.1163744-1-huaisheng.ye@intel.com>
References: <20211027120937.1163744-1-huaisheng.ye@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the ->set_read_only method for nd_pmem.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 drivers/nvdimm/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ef4950f80832..38ede1f44f5f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -282,6 +282,7 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.set_read_only =	nd_set_ro,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
-- 
2.27.0

