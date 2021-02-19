Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4867331F56F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBSHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSHqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:46:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29FFA64EBD;
        Fri, 19 Feb 2021 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613720753;
        bh=xz57ASSCwFW9OVFs0ygUe6Dsqey95Dp2LttOtZ4n3LI=;
        h=From:To:Cc:Subject:Date:From;
        b=GyqpNrZ62jdFY5AUsmcqbnIDCOyt/EZdW3uNNxQzKo0DinSXH8vghu7o/OFp3xqnT
         nZw86xqicSR/y73rJEI+kQll8xxUhtKtE5qgVD9DxDA5oyYkcPM2w06UOIkUagHi7Q
         4UUwFBJVn2K1YimdAA4y5Dh+UEtb6GRaq41nUH1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] Revert "driver core: Set fw_devlink=on by default"
Date:   Fri, 19 Feb 2021 08:45:49 +0100
Message-Id: <20210219074549.1506936-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e590474768f1cc04852190b61dec692411b22e2a.

While things are _almost_ there and working for almost all systems,
there are still reported regressions happening, so let's revert this
default for 5.12.  We can bring it back in linux-next after 5.12-rc1 is
out to get more testing and hopefully solve the remaining different
subsystem and driver issues that people are running into.

Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ea710b33bda6..afc6f9ce6235 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1502,7 +1502,7 @@ static void device_links_purge(struct device *dev)
 #define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
 					 DL_FLAG_PM_RUNTIME)
 
-static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
+static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 static int __init fw_devlink_setup(char *arg)
 {
 	if (!arg)
-- 
2.30.1

