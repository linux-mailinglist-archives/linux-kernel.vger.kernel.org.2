Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6414C330B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCHKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:37:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:40746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhCHKgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:36:53 -0500
IronPort-SDR: k2FYYNbOE3GbzUmuADC205vTfltbd4y050r1JDrozvFET/sJIRHbXZoBAoyezQV2kyDPpVrXgP
 BwQvkX7k3wQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="185617131"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="185617131"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:36:50 -0800
IronPort-SDR: 6BigFXhQSOlYFdcHYgIlt+W6wVQjky0Y1jEJhWKvxJFWKEMMIAaiFIfNNLyhWXD0AH84evL4eT
 fidJsS/N2sjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="519897291"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2021 02:36:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8ECC8147; Mon,  8 Mar 2021 12:36:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] device property: Sync descriptions of swnode array and group APIs
Date:   Mon,  8 Mar 2021 12:36:44 +0200
Message-Id: <20210308103644.81960-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a few updates against swnode APIs the kernel documentation, i.e.
for swnode group registration and unregistration deviates from the one
for swnode array. In general, the same rules are applied to both.
Hence, synchronize descriptions of swnode array and group APIs

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 37179a8b1ceb..46c48d602915 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -880,7 +880,11 @@ EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
  * software_node_register_node_group - Register a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be registered
  *
- * Register multiple software nodes at once.
+ * Register multiple software nodes at once. If any node in the array
+ * has its .parent pointer set (which can only be to another software_node),
+ * then its parent **must** have been registered before it is; either outside
+ * of this function or by ordering the array such that parent comes before
+ * child.
  */
 int software_node_register_node_group(const struct software_node **node_group)
 {
@@ -906,10 +910,14 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * software_node_unregister_node_group - Unregister a group of software nodes
  * @node_group: NULL terminated array of software node pointers to be unregistered
  *
- * Unregister multiple software nodes at once. The array will be unwound in
- * reverse order (i.e. last entry first) and thus if any members of the array are
- * children of another member then the children must appear later in the list such
- * that they are unregistered first.
+ * Unregister multiple software nodes at once. If parent pointers are set up
+ * in any of the software nodes then the array **must** be ordered such that
+ * parents come before their children.
+ *
+ * NOTE: If you are uncertain whether the array is ordered such that
+ * parents will be unregistered before their children, it is wiser to
+ * remove the nodes individually, in the correct order (child before
+ * parent).
  */
 void software_node_unregister_node_group(
 		const struct software_node **node_group)
-- 
2.30.1

