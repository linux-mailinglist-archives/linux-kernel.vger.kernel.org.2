Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82C34F5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhCaBDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:03:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:7087 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCaBDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:03:02 -0400
IronPort-SDR: c/1ZRYVTq25DESPHXSN7yC8vBE/31I0NP4KoDKN2rCVOHm9QFARkAJbpyQAKP/0c0MEM0v7Ngs
 BBmyvlhgchSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="212116462"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="212116462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:03:01 -0700
IronPort-SDR: W1H3FstvuZ72pE56Mky52VbKZbMWhYDK+3MgGyltDYYnwwU8LDJ+6sWPg9quL2uj7xLN6c8Wm4
 ClcYGJk2KMNQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="411887968"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 18:02:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: intel_init: test link->cdns
Date:   Wed, 31 Mar 2021 09:02:50 +0800
Message-Id: <20210331010250.14151-1-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/intel_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 5b32a2ffd376..5ef5bd0defab 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -250,6 +250,15 @@ static struct sdw_intel_ctx
 		link = &ldev->link_res;
 		link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
 
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

