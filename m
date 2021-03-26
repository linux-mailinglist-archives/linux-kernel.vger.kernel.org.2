Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F634A406
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCZJQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:16:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:55686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCZJQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:16:01 -0400
IronPort-SDR: hmkZerMFZ5K8kxWrYiuKkiBnqqiSQ3Kb2DIfndsPfPOVXXL6TkO7XHB/zm1Ho6qcTKs1pVKl5I
 YH7voB641l7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191143691"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="191143691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:16:01 -0700
IronPort-SDR: M665LzqAs62gKIsLvNEs8YcCr5sZKpj6cYgCE7zVV7hbiTMlS0nPjsNdu2EoGfl36nx3n50csl
 nr3Xk9vBWaxQ==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="416463248"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 02:15:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH 11/11] soundwire: stream: remove useless bus initializations
Date:   Fri, 26 Mar 2021 17:15:14 +0800
Message-Id: <20210326091514.20751-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There is no need to assign a pointer to NULL if it's only used in a
loop and assigned within that loop.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 6a682179cd05..9c064b672745 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1449,7 +1449,7 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 
 	/* Iterate for all Master(s) in Master list */
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
@@ -1471,7 +1471,7 @@ static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
 static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 
 	/* Iterate for all Master(s) in Master list */
 	list_for_each_entry_reverse(m_rt, &stream->master_list, stream_node) {
-- 
2.17.1

