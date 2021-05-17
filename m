Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FB382C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhEQMa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:30:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:62855 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237013AbhEQMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:30:47 -0400
IronPort-SDR: BBvZ3Ex8azrlwAPrqcU7kiplJ8QbeQ9X6AYmdQgS7lpcOppHmnThsbnqcWNaqrbsY4OwDa4Wjs
 4nyAfnFJphvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200503831"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200503831"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:29:29 -0700
IronPort-SDR: BaBmM9XoIepIKo0Dve6omjLefj5jnAvvoTdof3zzptJNzsB9xGmoLw0CyQJQ3+hQKqduDmfQRA
 hpH34LhUlUWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="611560680"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2021 05:29:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A4E412F; Mon, 17 May 2021 15:29:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 2/4] devres: Use list_for_each_safe_from() in remove_nodes()
Date:   Mon, 17 May 2021 15:29:44 +0300
Message-Id: <20210517122946.53161-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove_nodes() open codes the list_for_each_safe_from().
Replace it by a generic macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of v5.13-rc2

 drivers/base/devres.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 7970217191e0..db1f3137fc81 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -438,20 +438,16 @@ static int remove_nodes(struct device *dev,
 			struct list_head *first, struct list_head *end,
 			struct list_head *todo)
 {
+	struct devres_node *node, *n;
 	int cnt = 0, nr_groups = 0;
-	struct list_head *cur;
 
 	/* First pass - move normal devres entries to @todo and clear
 	 * devres_group colors.
 	 */
-	cur = first;
-	while (cur != end) {
-		struct devres_node *node;
+	node = list_entry(first, struct devres_node, entry);
+	list_for_each_entry_safe_from(node, n, end, entry) {
 		struct devres_group *grp;
 
-		node = list_entry(cur, struct devres_node, entry);
-		cur = cur->next;
-
 		grp = node_to_group(node);
 		if (grp) {
 			/* clear color of group markers in the first pass */
@@ -471,18 +467,14 @@ static int remove_nodes(struct device *dev,
 
 	/* Second pass - Scan groups and color them.  A group gets
 	 * color value of two iff the group is wholly contained in
-	 * [cur, end).  That is, for a closed group, both opening and
-	 * closing markers should be in the range, while just the
+	 * [current node, end). That is, for a closed group, both opening
+	 * and closing markers should be in the range, while just the
 	 * opening marker is enough for an open group.
 	 */
-	cur = first;
-	while (cur != end) {
-		struct devres_node *node;
+	node = list_entry(first, struct devres_node, entry);
+	list_for_each_entry_safe_from(node, n, end, entry) {
 		struct devres_group *grp;
 
-		node = list_entry(cur, struct devres_node, entry);
-		cur = cur->next;
-
 		grp = node_to_group(node);
 		BUG_ON(!grp || list_empty(&grp->node[0].entry));
 
@@ -492,7 +484,7 @@ static int remove_nodes(struct device *dev,
 
 		BUG_ON(grp->color <= 0 || grp->color > 2);
 		if (grp->color == 2) {
-			/* No need to update cur or end.  The removed
+			/* No need to update current node or end. The removed
 			 * nodes are always before both.
 			 */
 			list_move_tail(&grp->node[0].entry, todo);
-- 
2.30.2

