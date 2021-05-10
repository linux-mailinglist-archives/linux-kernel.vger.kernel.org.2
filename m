Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E863780A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhEJJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:57:58 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:14268 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhEJJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:57:28 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id f96e6081-b175-11eb-ba24-005056bd6ce9;
        Mon, 10 May 2021 12:56:22 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/2] device property: Don't check for NULL twice in the loops
Date:   Mon, 10 May 2021 12:56:13 +0300
Message-Id: <20210510095613.3302755-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510095613.3302755-1-andy.shevchenko@gmail.com>
References: <20210510095613.3302755-1-andy.shevchenko@gmail.com>
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
 drivers/base/property.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index dd98759d688b..62285f1b79e3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -632,9 +632,10 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 	fwnode_handle_get(fwnode);
 	do {
 		fwnode = fwnode_get_next_parent(fwnode);
-		if (fwnode)
-			dev = get_dev_from_fwnode(fwnode);
-	} while (fwnode && !dev);
+		if (!fwnode)
+			break;
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
+		if (!next_child)
 			break;
-	} while (next_child);
+	} while (!fwnode_device_is_available(next_child));
 
 	return next_child;
 }
-- 
2.31.1

