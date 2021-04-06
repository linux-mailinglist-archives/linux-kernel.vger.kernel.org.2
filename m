Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1A3549D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhDFBBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:01:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:50991 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232600AbhDFBBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:01:20 -0400
IronPort-SDR: KCYblGlzEz4AMtaDb6DgAPcTzO7gFWKm5Yf12xutZyC0XJPqUW0NqswOpAq8lfvPo9r3Y+Qqt/
 l+RmMhcgy4lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256941413"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="256941413"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 18:01:12 -0700
IronPort-SDR: 6iD/G2z2w+mrZJ8DqCNu+CTlcmqDXXqNx50efMxLLpCFr1ZZhJ8oRC25Ohv9gwO7EUb/bc8nux
 Kkot7cYHSBgA==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="420964332"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 18:01:09 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2] soundwire: intel_init: test link->cdns
Date:   Tue,  6 Apr 2021 09:01:01 +0800
Message-Id: <20210406010101.11442-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_link_probe() could return error and dev_get_drvdata() will return
null in such case. So we have to test link->cdns after
link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
Otherwise, we will meet the "kernel NULL pointer dereference" error.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
v2:
 - Rebase to latest code base.
---
 drivers/soundwire/intel_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 05b726cdfebc..30ce95ec2d70 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -178,6 +178,15 @@ static struct sdw_intel_ctx
 		link->pdev = pdev;
 		link->cdns = platform_get_drvdata(pdev);
 
+		if (!link->cdns) {
+			dev_err(&adev->dev, "failed to get link->cdns\n");
+			/*
+			 * 1 will be subtracted from i in the err label, but we need to call
+			 * intel_link_dev_unregister for this ldev, so plus 1 now
+			 */
+			i++;
+			goto err;
+		}
 		list_add_tail(&link->list, &ctx->link_list);
 		bus = &link->cdns->bus;
 		/* Calculate number of slaves */
-- 
2.17.1

