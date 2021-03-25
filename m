Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E383489C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCYHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:00:27 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:34108 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:00:18 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id E90809804B6;
        Thu, 25 Mar 2021 15:00:14 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biggers <ebiggers@google.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] include: linux: struct path is declared twice
Date:   Thu, 25 Mar 2021 15:00:06 +0800
Message-Id: <20210325070008.856967-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSEgeQh1ITUpNQ0MYVkpNSk1NTk5NSk5JTEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6TSo4ED8LFj4IIzEWMxw9
        DC0aFBdVSlVKTUpNTU5OTUpNSk1CVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0xDNwY+
X-HM-Tid: 0a78682f04c1d992kuwse90809804b6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct path has been declared at 85th line. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/mount.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..30272f961af7 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -94,7 +94,6 @@ extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
-struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
 extern int __mnt_want_write(struct vfsmount *);
 extern void __mnt_drop_write(struct vfsmount *);
-- 
2.25.1

