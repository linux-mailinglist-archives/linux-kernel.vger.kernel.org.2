Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB923349A63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCYTij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230182AbhCYTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sA2IsUt5TUJ7Q8X23cK1/HRHhK285FznrLQ34cjxZ4E=;
        b=dur7/kCxm+giYYpZ9TzwT/DjS4QPR5ElxqUVJbRhkGI6s20Q0jjkGf5YU6j2rUe0biDltC
        BUUKPVlHqUO484qYCb378xAiLVFdGggqTjbZlCW+tMzSGMSLFiY2qvnikRSjhn/wFRPTZQ
        ElmK7qJWQCrUaImH2AM4CicmFrtO47c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-yFdr2m1ePry2gtaXItAO_A-1; Thu, 25 Mar 2021 15:38:00 -0400
X-MC-Unique: yFdr2m1ePry2gtaXItAO_A-1
Received: by mail-ed1-f70.google.com with SMTP id i6so3224359edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sA2IsUt5TUJ7Q8X23cK1/HRHhK285FznrLQ34cjxZ4E=;
        b=lS4aihSzfe/bmDC8lRrXMET0Eu2E9zSzI9XCM9aYXGSISTc+mam2xVweiWW8JmPskG
         qcCGYLIl18/yi0BvVNZSexzHV5kY3YDXpGGOEk542rU7CK/8c6m9FwyI5GJc+8peSswe
         m0K7IyzUYRhsJl3zYCDuINzejvIK++BPDQJsvR6QWoKNuxCqaMII9sGPZ05PYnJFWjFe
         DeFN1kIsx+r8M4nON4YARyLi5lXgFyh5snVG4U5Rke8bCjR7Q5wjPQ6WtKxBVM3EPzOd
         WsKEBasmYTPcDmN8usc2I9wLu/+MXcVpjonQYjo7AWBhN5SFJVL6kJRkelhNS3lE9wQv
         zTCw==
X-Gm-Message-State: AOAM530BJvJ+AvjcvLVccsPUKNiHUNDzZBoTRey5Mzkk2SdXGv5k5tps
        TRlFUhYSmkHMi66aSDFrt4OHfPuwxbDe8UK6zCb90UuaFwfu1eyRNHSgdWU9rL8c0DZpRETlzXs
        R9bMExX1vLjFmm9nAlxYdTr3r
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr11208612ejb.444.1616701079596;
        Thu, 25 Mar 2021 12:37:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx73o6FftwsKmIBG8gJ1GEVS5/J0OoIV5j7j9DDzhcq8sDX5W9e22pO5ShXXXA0Uhd4tPJowQ==
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr11208602ejb.444.1616701079487;
        Thu, 25 Mar 2021 12:37:59 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:37:59 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH v3 02/18] ecryptfs: stack fileattr ops
Date:   Thu, 25 Mar 2021 20:37:39 +0100
Message-Id: <20210325193755.294925-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stacking for the fileattr operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Tyler Hicks <code@tyhicks.com>
---
 fs/ecryptfs/inode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..7169ea873347 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/fileattr.h>
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
@@ -1118,6 +1119,23 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 	return rc;
 }
 
+static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
+}
+
+static int ecryptfs_fileattr_set(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct fileattr *fa)
+{
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	int rc;
+
+	rc = vfs_fileattr_set(&init_user_ns, lower_dentry, fa);
+	fsstack_copy_attr_all(d_inode(dentry), d_inode(lower_dentry));
+
+	return rc;
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1139,6 +1157,8 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.permission = ecryptfs_permission,
 	.setattr = ecryptfs_setattr,
 	.listxattr = ecryptfs_listxattr,
+	.fileattr_get = ecryptfs_fileattr_get,
+	.fileattr_set = ecryptfs_fileattr_set,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1146,6 +1166,8 @@ const struct inode_operations ecryptfs_main_iops = {
 	.setattr = ecryptfs_setattr,
 	.getattr = ecryptfs_getattr,
 	.listxattr = ecryptfs_listxattr,
+	.fileattr_get = ecryptfs_fileattr_get,
+	.fileattr_set = ecryptfs_fileattr_set,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.30.2

