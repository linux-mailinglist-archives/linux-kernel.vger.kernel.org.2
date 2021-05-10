Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5A3780A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhEJJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:57:55 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:20007 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230328AbhEJJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:57:26 -0400
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id f83b9e96-b175-11eb-8ccd-005056bdfda7;
        Mon, 10 May 2021 12:56:20 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/2] device property: Retrieve fwnode from of_node via accessor
Date:   Mon, 10 May 2021 12:56:12 +0300
Message-Id: <20210510095613.3302755-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OF provides a specific accessor to retrieve fwnode handle.
Use it instead of direct dereferencing.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/base/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1421e9548857..dd98759d688b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -21,7 +21,7 @@
 struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-		&dev->of_node->fwnode : dev->fwnode;
+		of_fwnode_handle(dev->of_node) : dev->fwnode;
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
@@ -763,7 +763,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	struct fwnode_handle *fwnode = NULL, *next;
 
 	if (dev->of_node)
-		fwnode = &dev->of_node->fwnode;
+		fwnode = of_fwnode_handle(dev->of_node);
 	else if (adev)
 		fwnode = acpi_fwnode_handle(adev);
 
-- 
2.31.1

