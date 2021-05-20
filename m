Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97638B069
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhETNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:51:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:46824 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhETNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:51:47 -0400
IronPort-SDR: 5CAE9O3ytHr2n1JDDuPKlIPKN6avKwiroJN5ZqvPSN/IFbwPpk7zmWQ9y5dkd8xonUriVL+lnr
 aBL4Z3fNP4dA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200931046"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200931046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 06:50:25 -0700
IronPort-SDR: usIQ2blDcpHo2GhwUkQ5zTclH0xpCXHzJYPIi1deRSrWr+15RF5kVxVI/VmBtj7GvFO4x6+lCm
 qisOTp+GmUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="412181833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2021 06:50:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A47012A; Thu, 20 May 2021 16:50:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] coresight: core: Switch to krealloc_array()
Date:   Thu, 20 May 2021 16:50:41 +0300
Message-Id: <20210520135041.56163-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the krealloc_array() check for multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6c68d34d956e..a7971c68b0be 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1730,9 +1730,9 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	if (idx < 0) {
 		/* Make space for the new entry */
 		idx = dict->nr_idx;
-		list = krealloc(dict->fwnode_list,
-				(idx + 1) * sizeof(*dict->fwnode_list),
-				GFP_KERNEL);
+		list = krealloc_array(dict->fwnode_list,
+				      idx + 1, sizeof(*dict->fwnode_list),
+				      GFP_KERNEL);
 		if (ZERO_OR_NULL_PTR(list)) {
 			idx = -ENOMEM;
 			goto done;
-- 
2.30.2

