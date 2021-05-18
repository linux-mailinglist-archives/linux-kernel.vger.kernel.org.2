Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A78387297
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhERGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:50:07 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:30904 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239746AbhERGuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:50:05 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 16f4ce59-b7a5-11eb-8ccd-005056bdfda7;
        Tue, 18 May 2021 09:48:44 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/1] device property: Don't check for NULL twice in the loops
Date:   Tue, 18 May 2021 09:48:43 +0300
Message-Id: <20210518064843.3524015-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fwnode_get_next_available_child_node() we check next_child for NULL
twice. All the same in fwnode_get_next_parent_dev() we may avoid checking
fwnode for NULL twice.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: returned NULLs directly (Rafael)
 drivers/base/property.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index dd98759d688b..c26370aacdc6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -627,14 +627,15 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  */
 struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 {
-	struct device *dev = NULL;
+	struct device *dev;
 
 	fwnode_handle_get(fwnode);
 	do {
 		fwnode = fwnode_get_next_parent(fwnode);
-		if (fwnode)
-			dev = get_dev_from_fwnode(fwnode);
-	} while (fwnode && !dev);
+		if (!fwnode)
+			return NULL;
+		dev = get_dev_from_fwnode(fwnode);
+	} while (!dev);
 	fwnode_handle_put(fwnode);
 	return dev;
 }
@@ -742,10 +743,9 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 
 	do {
 		next_child = fwnode_get_next_child_node(fwnode, next_child);
-
-		if (!next_child || fwnode_device_is_available(next_child))
-			break;
-	} while (next_child);
+		if (!next_child)
+			return NULL;
+	} while (!fwnode_device_is_available(next_child));
 
 	return next_child;
 }
-- 
2.31.1

