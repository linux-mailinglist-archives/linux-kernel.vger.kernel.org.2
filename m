Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777E331CD38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBPPvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBPPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:51:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84FDE614A5;
        Tue, 16 Feb 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613490624;
        bh=99dMmcq1kwMsRQeMnsBSINGQ+qLcEXbZ1FU5t8BRZp0=;
        h=From:To:Cc:Subject:Date:From;
        b=BZlDt/w44yWUTl+k1VdNsSdpauAdQycma3HXUvXioF2yit6H3m5TkD4xSKb6YHo0S
         hOo0xFyZCicjY9rk4sPs7yvaewJlQxX/EDWtNV3Mvt3KDpVUh7kPDKQMMrC5t7eF95
         tG1xVAhmYdwm1AATvkMvKvN6zqgp5NsWhVkjY/7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] time: test_udelay:  remove dentry pointer for debugfs
Date:   Tue, 16 Feb 2021 16:50:20 +0100
Message-Id: <20210216155020.1012407-1-gregkh@linuxfoundation.org>
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

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/test_udelay.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 77c63005dc4e..13b11eb62685 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -21,7 +21,6 @@
 #define DEBUGFS_FILENAME "udelay_test"
 
 static DEFINE_MUTEX(udelay_test_lock);
-static struct dentry *udelay_test_debugfs_file;
 static int udelay_test_usecs;
 static int udelay_test_iterations = DEFAULT_ITERATIONS;
 
@@ -138,8 +137,8 @@ static const struct file_operations udelay_test_debugfs_ops = {
 static int __init udelay_test_init(void)
 {
 	mutex_lock(&udelay_test_lock);
-	udelay_test_debugfs_file = debugfs_create_file(DEBUGFS_FILENAME,
-			S_IRUSR, NULL, NULL, &udelay_test_debugfs_ops);
+	debugfs_create_file(DEBUGFS_FILENAME, S_IRUSR, NULL, NULL,
+			    &udelay_test_debugfs_ops);
 	mutex_unlock(&udelay_test_lock);
 
 	return 0;
@@ -150,7 +149,7 @@ module_init(udelay_test_init);
 static void __exit udelay_test_exit(void)
 {
 	mutex_lock(&udelay_test_lock);
-	debugfs_remove(udelay_test_debugfs_file);
+	debugfs_remove(debugfs_lookup(DEBUGFS_FILENAME, NULL));
 	mutex_unlock(&udelay_test_lock);
 }
 
-- 
2.30.1

