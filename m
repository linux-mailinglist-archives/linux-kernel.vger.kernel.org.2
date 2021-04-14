Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1A35F8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhDNQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:25:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:25440 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhDNQZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:25:22 -0400
IronPort-SDR: xw+tH/xAdiyUHMz4/sxTXWmoFDoq31XvER5QDzCiGp0hfaPe5RZ/XtfkCTxfJDZR0HhNg41OCg
 CPSgN/sIioEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215170663"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="215170663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:25:00 -0700
IronPort-SDR: 3G4Fx0vZTDo30J3m3qFqa+u7sX4fIHbezAy5Bjoe6F+aSnF+5QbxBk2bOMUeJxeJKd7ljNHqWN
 smfbrkoJGe5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="461276748"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2021 09:24:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D941142; Wed, 14 Apr 2021 19:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 2/4] devres: Use list_for_each_safe_from() in remove_nodes()
Date:   Wed, 14 Apr 2021 19:25:09 +0300
Message-Id: <20210414162511.59466-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414162511.59466-1-andriy.shevchenko@linux.intel.com>
References: <20210414162511.59466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove_nodes() open codes the list_for_each_safe_from().
Replace it by a generic macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
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

