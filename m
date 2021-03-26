Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBABE34A3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:16:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:23518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCZJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:52 -0400
IronPort-SDR: ObuUqwCAYstyA/Yud4OqLOILFTC1dHgIdCR6TvPNDLMRSC8evRedZO6k4qxRto+1JzcF721ACz
 dQWqyNIslVKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="211269599"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="211269599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:50 -0700
IronPort-SDR: gknePH7WVlzzkNOKPcLV7P5BbGCZwE5pT/6APW03UVEmTyT4+2sy2ISqzONPsn/oPruZKDu8tp
 P3t0eGQA3IuQ==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463209"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:45 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 07/11] soundwire: generic_bandwidth_allocation: remove useless init
Date:   Fri, 26 Mar 2021 17:15:10 +0800
Message-Id: <20210326091514.20751-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Cppcheck complains about two possible null pointer dereferences, but
it's more like there are unnecessary initializations before walking
through a list.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index a9abb9722fde..805f5b6ebe86 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -143,7 +143,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 static void _sdw_compute_port_params(struct sdw_bus *bus,
 				     struct sdw_group_params *params, int count)
 {
-	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_master_runtime *m_rt;
 	int hstop = bus->params.col - 1;
 	int block_offset, port_bo, i;
 
@@ -169,7 +169,7 @@ static int sdw_compute_group_params(struct sdw_bus *bus,
 				    struct sdw_group_params *params,
 				    int *rates, int count)
 {
-	struct sdw_master_runtime *m_rt = NULL;
+	struct sdw_master_runtime *m_rt;
 	int sel_col = bus->params.col;
 	unsigned int rate, bps, ch;
 	int i, column_needed = 0;
-- 
2.17.1

