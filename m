Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828563DCE29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhHAXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:45:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhHAXpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:45:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id EC1771F424CF
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 1/3] mtdblock: Update old JFFS2 mention in Kconfig
Date:   Sun,  1 Aug 2021 20:45:07 -0300
Message-Id: <20210801234509.18774-6-ezequiel@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801234509.18774-1-ezequiel@collabora.com>
References: <20210801234509.18774-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFFS2 can be mounted without 'mtdblock' since
a really, really long time. Some git-log
archaeology shows that in 2006 it was possible
to use 'root=' to mount a JFFS2 rootfs:

  commit e9482b4374e2596e6f3f1ab30c4ea469f4ac6311
  Author: Joern Engel <joern@wh.fh-wedel.de>
  Date:   Tue May 30 14:25:46 2006 +0200

      [MTD] Allow alternate JFFS2 mount variant for root filesystem.

      With this patch, "root=mtd3" and "root=mtd:foo" work for a JFFS2 rootfs.

However, there are still plenty of tutorials that mention
mtdblock, so users are still taking this route. Update the Kconfig
to reflect this is no longer needed.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/mtd/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 79a8ff542883..32bed6c63863 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -127,10 +127,9 @@ config MTD_BLOCK
 	  on RAM chips in this manner. This block device is a user of MTD
 	  devices performing that function.
 
-	  At the moment, it is also required for the Journalling Flash File
-	  System(s) to obtain a handle on the MTD device when it's mounted
-	  (although JFFS and JFFS2 don't actually use any of the functionality
-	  of the mtdblock device).
+	  Note that mounting a JFFS2 filesystem doesn't require using mtdblock.
+	  It's possible to mount a rootfs using the MTD device on the "root="
+	  bootargs as "root=mtd2" or "root=mtd:name_of_device".
 
 	  Later, it may be extended to perform read/erase/modify/write cycles
 	  on flash chips to emulate a smaller block size. Needless to say,
-- 
2.32.0

