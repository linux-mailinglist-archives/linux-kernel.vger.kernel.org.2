Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6499A35F991
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhDNRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:3013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhDNRNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:13:01 -0400
IronPort-SDR: sLLzQrk2Q41M7AlU6ROAtI7CGJOVt2qh7OjgVeeayBk0Kb02ClGHRJTMq1tAAvWg2SSWGMcg3E
 wTHNjecTywlQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181811897"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181811897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:12:40 -0700
IronPort-SDR: xq7zsRgEmql1xpR+Ta6qnODAbgKsglwSOlh5Id4qoLYyFyofhtrziI/OEi0PVKQplOAGoBUD5Y
 LRZVVS0AsKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382427918"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 10:12:38 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/7] stm class: Remove an unused function
Date:   Wed, 14 Apr 2021 20:12:45 +0300
Message-Id: <20210414171251.14672-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Fix the following clang warning:

drivers/hwtracing/stm/policy.c:60:21: warning: unused function
'stp_policy_node_name' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/policy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 603b4a9969d3..42103c3a177f 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -57,11 +57,6 @@ void stp_policy_node_get_ranges(struct stp_policy_node *policy_node,
 	*cend	= policy_node->last_channel;
 }
 
-static inline char *stp_policy_node_name(struct stp_policy_node *policy_node)
-{
-	return policy_node->group.cg_item.ci_name ? : "<none>";
-}
-
 static inline struct stp_policy *to_stp_policy(struct config_item *item)
 {
 	return item ?
-- 
2.30.2

