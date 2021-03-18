Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE033FD6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCRCxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCRCwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:52:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FBC06174A;
        Wed, 17 Mar 2021 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/Xme+FpO6M8DVIBymGV9zFrkHimaGzjIL5qitTnVrBs=; b=phFFX3xK64viv27lmuMzEDly7w
        5WJuEuRZTfNZYXWHlN/druBjuQ8mofPJS+LLtSCtRkMAr+xRx/CcqLy05Va4GtgAQjqoAhwZrg5Pg
        WXgodTUCWYe+v/Z9wxrasmJxncsLBC5Ol3FPHJBDITSP0V0G90BZAkkDPyWcsQpvs4VMlsQztUqvR
        LVPo9rh+PovUl9XjUdFB9461DqMKF7IqlVsO5jRtnfMeVqe9g89oodbgAUIqZCeqAi0WlM3NSvVbK
        8QSGo6FAmY/xhVkUASABlHv+LH/b9hMXir871RFYTodqkYL8d7kx61Cx+2u+0q6sGYUa9dWABvWay
        hoENtiDg==;
Received: from [2601:1c0:6280:3f0::9757] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMilz-002Rj4-4W; Thu, 18 Mar 2021 02:52:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] fs/namespace: corrent/improve kernel-doc notation
Date:   Wed, 17 Mar 2021 19:52:25 -0700
Message-Id: <20210318025227.4162-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in fs/namespace.c:

./fs/namespace.c:1379: warning: Function parameter or member 'm' not described in 'may_umount_tree'
./fs/namespace.c:1379: warning: Excess function parameter 'mnt' description in 'may_umount_tree'
./fs/namespace.c:1950: warning: Function parameter or member 'path' not described in 'clone_private_mount'

Also convert path_is_mountpoint() comments to kernel-doc.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
Jon, Al has OK-ed you to merge this patch (and the next one, please).

 fs/namespace.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-next-20210317.orig/fs/namespace.c
+++ linux-next-20210317/fs/namespace.c
@@ -1242,8 +1242,9 @@ struct vfsmount *mntget(struct vfsmount
 }
 EXPORT_SYMBOL(mntget);
 
-/* path_is_mountpoint() - Check if path is a mount in the current
- *                          namespace.
+/**
+ * path_is_mountpoint() - Check if path is a mount in the current namespace.
+ * @path: path to check
  *
  *  d_mountpoint() can only be used reliably to establish if a dentry is
  *  not mounted in any namespace and that common case is handled inline.
@@ -1369,7 +1370,7 @@ void mnt_cursor_del(struct mnt_namespace
 
 /**
  * may_umount_tree - check if a mount tree is busy
- * @mnt: root of mount tree
+ * @m: root of mount tree
  *
  * This is called to check if a tree of mounts has any
  * open files, pwds, chroots or sub mounts that are
@@ -1939,10 +1940,11 @@ void drop_collected_mounts(struct vfsmou
 
 /**
  * clone_private_mount - create a private clone of a path
+ * @path: path to clone
  *
- * This creates a new vfsmount, which will be the clone of @path.  The new will
- * not be attached anywhere in the namespace and will be private (i.e. changes
- * to the originating mount won't be propagated into this).
+ * This creates a new vfsmount, which will be the clone of @path.  The new mount
+ * will not be attached anywhere in the namespace and will be private (i.e.
+ * changes to the originating mount won't be propagated into this).
  *
  * Release with mntput().
  */
