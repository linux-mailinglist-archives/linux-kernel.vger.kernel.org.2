Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940423127BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 22:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBGV5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 16:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBGV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 16:57:33 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07620C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 13:56:52 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 70220AF2E94; Sun,  7 Feb 2021 22:56:51 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ipack: Handle a driver without remove callback
Date:   Sun,  7 Feb 2021 22:55:56 +0100
Message-Id: <20210207215556.96371-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210207215556.96371-1-uwe@kleine-koenig.org>
References: <20210207215556.96371-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A driver that only consumes devm-managed resources might well have no
remove callback. Additionally given that the device core ignores the return
value of ipack_bus_remove() stop returning an error code.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/ipack/ipack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index eabc4d08792a..7de9605cac4f 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -72,10 +72,9 @@ static int ipack_bus_remove(struct device *device)
 	struct ipack_device *dev = to_ipack_dev(device);
 	struct ipack_driver *drv = to_ipack_driver(device->driver);
 
-	if (!drv->ops->remove)
-		return -EINVAL;
+	if (drv->ops->remove)
+		drv->ops->remove(dev);
 
-	drv->ops->remove(dev);
 	return 0;
 }
 
-- 
2.29.2

