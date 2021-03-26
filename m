Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDD34A403
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCZJQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:16:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:23518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCZJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:52 -0400
IronPort-SDR: 0EeK5dtnWqBwDQrIZl9MCDHcwDaPYZRm6D9GnM7V9hxNA7mY/jnqHnreMzLqQ1Yuj7DNvSXyAK
 ea1Ge9wjhPSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269609"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:52 -0700
IronPort-SDR: XSD5f+12Su5E5ckV7faLA+qNnmQ/U9hChr6EiJCQaYSo5zSEXmHhMlcVN5lp74hkvH40swKIaa
 b1Qpq8uUNYsg==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463219"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 08/11] soundwire: intel: remove useless readl
Date:   Fri, 26 Mar 2021 17:15:11 +0800
Message-Id: <20210326091514.20751-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Cppcheck complains:

drivers/soundwire/intel.c:564:15: style: Variable 'link_control' is
assigned a value that is never used. [unreadVariable]
 link_control = intel_readl(shim, SDW_SHIM_LCTL);

This looks like a leftover from a previous version, remove.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e2e95115832a..fd95f94630b1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -561,8 +561,6 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
 	}
 
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-
 	mutex_unlock(sdw->link_res->shim_lock);
 
 	if (ret < 0) {
-- 
2.17.1

