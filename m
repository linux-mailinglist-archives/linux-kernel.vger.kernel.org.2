Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E740360BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhDOOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:38:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:50014 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233345AbhDOOiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:38:17 -0400
IronPort-SDR: GEzcX6VWFcBVFCXuXLPIxc5WjO81fpGP7MI0mVnAo8o3qB86jHrJo5TrZY8rs9/zK7cfECOUW4
 eVQ6FaJqN9mA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194975336"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194975336"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:37:45 -0700
IronPort-SDR: BGvb9CnNE+3hJ44yKpVysWJC+0nWnLvDs07AdBmA8RvT2cyO9ZO2b/1AZAPc890tzjU2q07BEU
 W5yJm7549imQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="382745459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2021 07:37:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7483BA; Thu, 15 Apr 2021 17:37:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Date:   Thu, 15 Apr 2021 17:37:54 +0300
Message-Id: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strictly speaking the comparison between guid_t and raw buffer
is not correct. Return to plain memcmp() since the data structures
haven't changed to use uuid_t / guid_t the current state of affairs
is inconsistent. Either it should be changed altogether or left
as is.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvdimm/btt_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 05feb97e11ce..82bcd2e86a18 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -244,13 +244,14 @@ struct device *nd_btt_create(struct nd_region *nd_region)
  */
 bool nd_btt_arena_is_valid(struct nd_btt *nd_btt, struct btt_sb *super)
 {
+	static const u8 null_uuid[16];
 	const u8 *parent_uuid = nd_dev_to_uuid(&nd_btt->ndns->dev);
 	u64 checksum;
 
 	if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
 		return false;
 
-	if (!guid_is_null((guid_t *)&super->parent_uuid))
+	if (memcmp(super->parent_uuid, null_uuid, 16) != 0)
 		if (memcmp(super->parent_uuid, parent_uuid, 16) != 0)
 			return false;
 
-- 
2.30.2

