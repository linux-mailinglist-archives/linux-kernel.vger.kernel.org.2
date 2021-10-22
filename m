Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E57437F79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJVUu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE04610A1;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sw-000QCb-Hn;
        Fri, 22 Oct 2021 16:48:38 -0400
Message-ID: <20211022204838.389856261@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:47:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/40] tracefs: Have tracefs directories not set OTH permission bits by
 default
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The tracefs file system is by default mounted such that only root user can
access it. But there are legitimate reasons to create a group and allow
those added to the group to have access to tracing. By changing the
permissions of the tracefs mount point to allow access, it will allow
group access to the tracefs directory.

There should not be any real reason to allow all access to the tracefs
directory as it contains sensitive information. Have the default
permission of directories being created not have any OTH (other) bits set,
such that an admin that wants to give permission to a group has to first
disable all OTH bits in the file system.

Link: https://lkml.kernel.org/r/20210818153038.664127804@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1261e8b41edb..925a621b432e 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -432,7 +432,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	/* Do not set bits for OTH */
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
 	inode->i_op = ops;
 	inode->i_fop = &simple_dir_operations;
 
-- 
2.33.0
