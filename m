Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6803D743B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhG0LXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:23:17 -0400
Received: from dd38112.kasserver.com ([85.13.154.158]:56852 "EHLO
        dd38112.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhG0LXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:23:15 -0400
Received: from DESKTOP-E8BN1B0.localdomain (089144219199.atnat0028.highway.a1.net [89.144.219.199])
        by dd38112.kasserver.com (Postfix) with ESMTPSA id 5F6281F01285;
        Tue, 27 Jul 2021 13:23:14 +0200 (CEST)
Date:   Tue, 27 Jul 2021 13:23:11 +0200
From:   Filip Schauer <filip@mg6.at>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers core: Fix oops when driver probe fails
Message-ID: <20210727112311.GA7645@DESKTOP-E8BN1B0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_range_map is freed to early, which might cause an oops when
a driver probe fails.
 Call trace:
  is_free_buddy_page+0xe4/0x1d4
  __free_pages+0x2c/0x88
  dma_free_contiguous+0x64/0x80
  dma_direct_free+0x38/0xb4
  dma_free_attrs+0x88/0xa0
  dmam_release+0x28/0x34
  release_nodes+0x78/0x8c
  devres_release_all+0xa8/0x110
  really_probe+0x118/0x2d0
  __driver_probe_device+0xc8/0xe0
  driver_probe_device+0x54/0xec
  __driver_attach+0xe0/0xf0
  bus_for_each_dev+0x7c/0xc8
  driver_attach+0x30/0x3c
  bus_add_driver+0x17c/0x1c4
  driver_register+0xc0/0xf8
  __platform_driver_register+0x34/0x40
  ...

This issue is introduced by commit d0243bbd5dd3 ("drivers core:
Free dma_range_map when driver probe failed"). It frees
dma_range_map before the call to devres_release_all, which is too
early. The solution is to free dma_range_map only after
devres_release_all.

Fixes: d0243bbd5dd3 ("drivers core: Free dma_range_map when driver probe failed")
Signed-off-by: Filip Schauer <filip@mg6.at>
---
 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index daeb9b5763ae..437cd61343b2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -653,8 +653,6 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	else if (drv->remove)
 		drv->remove(dev);
 probe_failed:
-	kfree(dev->dma_range_map);
-	dev->dma_range_map = NULL;
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
@@ -662,6 +660,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	device_links_no_driver(dev);
 	devres_release_all(dev);
 	arch_teardown_dma_ops(dev);
+	kfree(dev->dma_range_map);
+	dev->dma_range_map = NULL;
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
-- 
2.25.1

