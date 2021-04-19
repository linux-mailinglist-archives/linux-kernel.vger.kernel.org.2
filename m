Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556C36409A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhDSLeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:34:31 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:58822 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:34:27 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 4C54240050D;
        Mon, 19 Apr 2021 19:33:56 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] linux/mount.h: Remove duplicate struct declaration
Date:   Mon, 19 Apr 2021 19:33:04 +0800
Message-Id: <20210419113342.42849-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkNNT1ZJSh5PTxkaH01JGR5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6Mxw5Hj8PQxRCCxMVTDZK
        OSsKFD9VSlVKTUpDQ0hJS0hMS0hDVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQk1ONwY+
X-HM-Tid: 0a78e9e89294d991kuws4c54240050d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct path is declared at 85th line.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/mount.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..9ebf8af88bff 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -93,8 +93,6 @@ extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
-
-struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
 extern int __mnt_want_write(struct vfsmount *);
 extern void __mnt_drop_write(struct vfsmount *);
-- 
2.25.1

