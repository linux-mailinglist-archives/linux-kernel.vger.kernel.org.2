Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477AB350ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhCaX1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:27:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbhCaX0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:50 -0400
IronPort-SDR: t6VUOuc+d71QB1s/SemwvQmS4zDEIWZ4DZl0YIHSd0fjU9EJpbqCshbjrE9AVSZM23uDk0r2D8
 aCC0XkT9qBvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528090"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528090"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:50 -0700
IronPort-SDR: Y65ggN80rR2uOX56y5PZu3LJH4KCdOqIZQ0K9x4l2JO9Vn7zI0Gt7ydzDMY42k8+BNF92f0ia6
 CjOQZnYZThIA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685767"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:48 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/7] devcoredump: fix kernel-doc warning
Date:   Wed, 31 Mar 2021 18:26:14 -0500
Message-Id: <20210331232614.304591-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove make W=1 warnings

drivers/base/devcoredump.c:208: warning:
Function parameter or member 'data' not described in
'devcd_free_sgtable'

drivers/base/devcoredump.c:208: warning:
Excess function parameter 'table' description in 'devcd_free_sgtable'

drivers/base/devcoredump.c:225: warning:
expecting prototype for devcd_read_from_table(). Prototype was for
devcd_read_from_sgtable() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/devcoredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 352de5d41466..8eec0e0ddff7 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -202,7 +202,7 @@ static int devcd_match_failing(struct device *dev, const void *failing)
  * NOTE: if two tables allocated with devcd_alloc_sgtable and then chained
  * using the sg_chain function then that function should be called only once
  * on the chained table
- * @table: pointer to sg_table to free
+ * @data: pointer to sg_table to free
  */
 static void devcd_free_sgtable(void *data)
 {
@@ -210,7 +210,7 @@ static void devcd_free_sgtable(void *data)
 }
 
 /**
- * devcd_read_from_table - copy data from sg_table to a given buffer
+ * devcd_read_from_sgtable - copy data from sg_table to a given buffer
  * and return the number of bytes read
  * @buffer: the buffer to copy the data to it
  * @buf_len: the length of the buffer
-- 
2.25.1

