Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287D031CC95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBPPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhBPPE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:04:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E5F64E02;
        Tue, 16 Feb 2021 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613487857;
        bh=dFqS/nktC66uzqreX4zuPT90X5LT9qN9HzXMa79Su5s=;
        h=From:To:Cc:Subject:Date:From;
        b=t2xLrlnZ97QVGWSRJYz/K8vzxzGlOwJcQIKXk7No1OGDeG8Qnb9oZRTN22qiDe2+o
         V3sA4F5D0qE/kgCLj5VSLoGbTLeQsjpAlB5pJA3YzAdVSLN2TKyziQFC3JS1y9R5Uc
         SGGe9a+s0b774xdIaGl7nzqaS+p4cTsQE29V85/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     virtualization@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_console: remove pointless check for debugfs_create_dir()
Date:   Tue, 16 Feb 2021 16:04:10 +0100
Message-Id: <20210216150410.3844635-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is impossible for debugfs_create_dir() to return NULL, so checking
for it gives people a false sense that they actually are doing something
if an error occurs.  As there is no need to ever change kernel logic if
debugfs is working "properly" or not, there is no need to check the
return value of debugfs calls, so remove the checks here as they will
never be triggered and are wrong.

Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1836cc56e357..59dfd9c421a1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1456,18 +1456,15 @@ static int add_port(struct ports_device *portdev, u32 id)
 	 */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 
-	if (pdrvdata.debugfs_dir) {
-		/*
-		 * Finally, create the debugfs file that we can use to
-		 * inspect a port's state at any time
-		 */
-		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
-			 port->portdev->vdev->index, id);
-		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
-							 pdrvdata.debugfs_dir,
-							 port,
-							 &port_debugfs_fops);
-	}
+	/*
+	 * Finally, create the debugfs file that we can use to
+	 * inspect a port's state at any time
+	 */
+	snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
+		 port->portdev->vdev->index, id);
+	port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
+						 pdrvdata.debugfs_dir,
+						 port, &port_debugfs_fops);
 	return 0;
 
 free_inbufs:
@@ -2244,8 +2241,6 @@ static int __init init(void)
 	}
 
 	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
-	if (!pdrvdata.debugfs_dir)
-		pr_warn("Error creating debugfs dir for virtio-ports\n");
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 	INIT_LIST_HEAD(&pdrvdata.portdevs);
 
-- 
2.30.1

