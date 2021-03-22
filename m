Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3B344811
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCVOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhCVOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Su5HH4RiF+W/Zr5XDd86GPqq3KJsWhOK7dETED+hxaI=;
        b=i799UTxEC8iAPs9h7oEzYXAJpzFB+3IpTmd0Ha8n62HlEDtNMlRrHud1sTyLVTxLgS/MeI
        eBEA502GNhxJdRHaZh8Lyy2FMBPjOmGMn84TV1nKWIx7HhwMHZ4ekM+U6d1Q52AU3dQ9AK
        S8MfEZlKc1C+0awg49gPHOiYG1QpNc8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-BIRhl5HhP8yB6N3QJccvag-1; Mon, 22 Mar 2021 10:49:23 -0400
X-MC-Unique: BIRhl5HhP8yB6N3QJccvag-1
Received: by mail-ej1-f70.google.com with SMTP id di5so19949831ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Su5HH4RiF+W/Zr5XDd86GPqq3KJsWhOK7dETED+hxaI=;
        b=Sf8fh4WagcoIldUAXuhOR6Skuih3ZvXUpM2opZ+TrJ5uGRliP5yK7sCP31iN9ICWDc
         JQY+8sw9JYZ+OIawy1rEJen4e8CjhmAPbjPBU7iU9XvudPv7tJjcRH7SpizHUjFpF9rd
         lYZ4djvb7STfKD+h7ZHxeZKDMW0Wziwt5Svyqz0Ady4h0MxQPkZ1Dza3wUgw370R+D6B
         i5E6BusYzV0sPprok2qn8UXmY3yO173hkPzL/yFa7MhcH/7SrTn8sLq1vFDnPFNREkXk
         K7l9Uamdlqyd8+Erl0gCMPqZHzg+nP3Z1OrffBqZF1Zgml1/buXaVZgRoK2cT85lYZ+m
         VS6w==
X-Gm-Message-State: AOAM532cRqnd4pf+hsSVCBqgfwWKsxgl1jtGTAHJECM55xopYjR8a4IJ
        o19+9UWhtekgeYrETKdY+a8//ECicQRYNLbbwX0mqKxHVYQ9Hu6UM0IAZcuY2i/SvHAFYTzJA8H
        NfjcfZ8jziltHh0b7gq2C1QX5
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr65656ejk.497.1616424561541;
        Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3OTZYNqLusMjJIntln1ZMQ1gkH4GazIa2cCJ6OLVDvjZ2gcIA2IzzCvXPSaXbODU31M4uvQ==
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr65645ejk.497.1616424561419;
        Mon, 22 Mar 2021 07:49:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH v2 02/18] ecryptfs: stack miscattr ops
Date:   Mon, 22 Mar 2021 15:49:00 +0100
Message-Id: <20210322144916.137245-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stacking for the miscattr operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Tyler Hicks <code@tyhicks.com>
---
 fs/ecryptfs/inode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 18e9285fbb4c..b7d18583c50f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/miscattr.h>
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
@@ -1118,6 +1119,23 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 	return rc;
 }
 
+static int ecryptfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	return vfs_miscattr_get(ecryptfs_dentry_to_lower(dentry), ma);
+}
+
+static int ecryptfs_miscattr_set(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, struct miscattr *ma)
+{
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	int rc;
+
+	rc = vfs_miscattr_set(&init_user_ns, lower_dentry, ma);
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
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1146,6 +1166,8 @@ const struct inode_operations ecryptfs_main_iops = {
 	.setattr = ecryptfs_setattr,
 	.getattr = ecryptfs_getattr,
 	.listxattr = ecryptfs_listxattr,
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.30.2

