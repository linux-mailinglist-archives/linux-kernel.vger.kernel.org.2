Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CC30DA00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBCMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhBCMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWk1RSGz/Jz1PF065AWjCmG/GJbgGhKZIRIwvxP81a4=;
        b=C8Ncg3mJTxX6yIF6NUZSXUH8Zb04S6dM6KBLz2Jo7UzGsMKFSf+fZVoJw3Du++sp/xfLYG
        6EIz9I1ZLm7/ABYbMH3y/MbLLRmw4E6FY+doRVJhOSFjylFxQYm93EidPrvHKX/VTfdoqU
        eaptpPN4Ts6gx32Gh0vUYp8JaXTzjgg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-CX33e9K4N2OTfwQv4ZRUnw-1; Wed, 03 Feb 2021 07:41:36 -0500
X-MC-Unique: CX33e9K4N2OTfwQv4ZRUnw-1
Received: by mail-ed1-f70.google.com with SMTP id j12so11368479edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWk1RSGz/Jz1PF065AWjCmG/GJbgGhKZIRIwvxP81a4=;
        b=Y0QVTm0ze/04/DMNfb/XFEbJ+Gs7yRtCsjcdcVTBRkikHqS/G4aCiWGCxHrtIPURv2
         7/of34onGHfy5w7TzO+QMfaN0sIh+5+qNH7MSb2vYJb5OoDHFGIgdhHz6uSREBPRI3Bf
         xcPwId8UH653Prn0nKlhypAmj9r7W7h4xAxGeJKxchkcqfBgealqsBLG7stivNpFbnCZ
         Q143ZKxgsMOD6nIsveXIcFYJiAlkCHe5mXo+3FLLQGFxGakWlN/qiWxio1ipSVyw/ocO
         V1KHBTeGAO3r2WS+gA54D2aLcrgSP4aItB/dq3wwZb9Oao3fTBIicrLcaq5AQ//ukR55
         rpNQ==
X-Gm-Message-State: AOAM530Bmab4LPH1iiZEGj0JnJWnkqtERUREtS8Vmo78fcibx6jhsQW8
        3dqIuCD23D97RngB69tMtZipJlTst1u2f2TJmjouNpTTWyilx2Mbjjis83CmQXaTyWe98ZcuPTa
        faIusDZOPac+ryBxA7405aJC3
X-Received: by 2002:a05:6402:19bd:: with SMTP id o29mr1173248edz.161.1612356095380;
        Wed, 03 Feb 2021 04:41:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0ZqqxVNF/MjgsNMqM5xSpWLx6WXKdNxXfxnE8UaVmVCbfajooXPLjbg1McUTjkz0/wBZ1IQ==
X-Received: by 2002:a05:6402:19bd:: with SMTP id o29mr1173241edz.161.1612356095271;
        Wed, 03 Feb 2021 04:41:35 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:34 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 02/18] ecryptfs: stack miscattr ops
Date:   Wed,  3 Feb 2021 13:40:56 +0100
Message-Id: <20210203124112.1182614-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stacking for the miscattr operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Tyler Hicks <code@tyhicks.com>
---
 fs/ecryptfs/inode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 58d0f7187997..6ed24fc0e5f3 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/miscattr.h>
 #include <asm/unaligned.h>
 #include "ecryptfs_kernel.h"
 
@@ -1097,6 +1098,22 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 	return rc;
 }
 
+static int ecryptfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	return vfs_miscattr_get(ecryptfs_dentry_to_lower(dentry), ma);
+}
+
+static int ecryptfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	int rc;
+
+	rc = vfs_miscattr_set(lower_dentry, ma);
+	fsstack_copy_attr_all(d_inode(dentry), d_inode(lower_dentry));
+
+	return rc;
+}
+
 const struct inode_operations ecryptfs_symlink_iops = {
 	.get_link = ecryptfs_get_link,
 	.permission = ecryptfs_permission,
@@ -1118,6 +1135,8 @@ const struct inode_operations ecryptfs_dir_iops = {
 	.permission = ecryptfs_permission,
 	.setattr = ecryptfs_setattr,
 	.listxattr = ecryptfs_listxattr,
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 const struct inode_operations ecryptfs_main_iops = {
@@ -1125,6 +1144,8 @@ const struct inode_operations ecryptfs_main_iops = {
 	.setattr = ecryptfs_setattr,
 	.getattr = ecryptfs_getattr,
 	.listxattr = ecryptfs_listxattr,
+	.miscattr_get = ecryptfs_miscattr_get,
+	.miscattr_set = ecryptfs_miscattr_set,
 };
 
 static int ecryptfs_xattr_get(const struct xattr_handler *handler,
-- 
2.26.2

