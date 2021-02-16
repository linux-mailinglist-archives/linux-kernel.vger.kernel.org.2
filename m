Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EF31CCB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBPPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhBPPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:12:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F78B64DEC;
        Tue, 16 Feb 2021 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613488334;
        bh=7Pcqfnsbw4bFEVDUe2IIairHS69tv7n1JgUuaqdgl/k=;
        h=From:To:Cc:Subject:Date:From;
        b=G5lOgyPmrzy2FOgW6mJWqu34NwqfVb5/gDSlsEwlnrvzxL/6zRQ2/qSMKj6YFSVgp
         5aTKnpyHI+XRzdZoJG7U/FjbbBnJC0F+gKvMyO0/1MyTaEhme0l4r6U21St/Zi9bfP
         uoDg3WvEP0fCfFZUeCli7SbHWyXifNPc4SkG9XX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drivers: vmw_balloon: remove dentry pointer for debugfs
Date:   Tue, 16 Feb 2021 16:12:09 +0100
Message-Id: <20210216151209.3954129-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep the dentry pointer around for the created
debugfs file, as it is only needed when removing it from the system.
When it is to be removed, ask debugfs itself for the pointer, to save on
storage and make things a bit simpler.

Cc: Nadav Amit <namit@vmware.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_balloon.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index b837e7eba5f7..f1d8ba6d4857 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -346,11 +346,6 @@ struct vmballoon {
 	/* statistics */
 	struct vmballoon_stats *stats;
 
-#ifdef CONFIG_DEBUG_FS
-	/* debugfs file exporting statistics */
-	struct dentry *dbg_entry;
-#endif
-
 	/**
 	 * @b_dev_info: balloon device information descriptor.
 	 */
@@ -1709,14 +1704,14 @@ DEFINE_SHOW_ATTRIBUTE(vmballoon_debug);
 
 static void __init vmballoon_debugfs_init(struct vmballoon *b)
 {
-	b->dbg_entry = debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
-					   &vmballoon_debug_fops);
+	debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
+			    &vmballoon_debug_fops);
 }
 
 static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
 {
 	static_key_disable(&balloon_stat_enabled.key);
-	debugfs_remove(b->dbg_entry);
+	debugfs_remove(debugfs_lookup("vmmemctl", NULL));
 	kfree(b->stats);
 	b->stats = NULL;
 }
-- 
2.30.1

