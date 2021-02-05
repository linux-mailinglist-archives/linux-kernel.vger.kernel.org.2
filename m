Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887E5311A84
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhBFDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhBFCxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:53:16 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22EC08EC44
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:04 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 95E15AEDEFF; Fri,  5 Feb 2021 23:29:02 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/5] dax-device: Drop an empty .remove callback
Date:   Fri,  5 Feb 2021 23:28:41 +0100
Message-Id: <20210205222842.34896-5-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dax core properly handles a dax driver not having a remove callback.
So drop it without changing the effective behaviour.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/dax/device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 5da2980bb16b..db92573c94e8 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -452,15 +452,9 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
-static int dev_dax_remove(struct dev_dax *dev_dax)
-{
-	/* all probe actions are unwound by devm */
-	return 0;
-}
-
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
-	.remove = dev_dax_remove,
+	/* all probe actions are unwound by devm, so .remove isn't necessary */
 	.match_always = 1,
 };
 
-- 
2.29.2

