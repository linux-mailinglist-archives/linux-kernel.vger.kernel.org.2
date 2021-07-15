Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AE3C9651
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhGODS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:18:58 -0400
Received: from foss.arm.com ([217.140.110.172]:45952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhGODS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:18:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BADCD6E;
        Wed, 14 Jul 2021 20:16:04 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C44733F7D8;
        Wed, 14 Jul 2021 20:16:01 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH RFC 02/13] afs: Remove the number postfix of '%pD' in format string
Date:   Thu, 15 Jul 2021 11:15:22 +0800
Message-Id: <20210715031533.9553-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the previous number postfix of '%p' is pointless.

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/afs/mntpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index bbb2c210d139..e55233bde20f 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -61,7 +61,7 @@ static struct dentry *afs_mntpt_lookup(struct inode *dir,
  */
 static int afs_mntpt_open(struct inode *inode, struct file *file)
 {
-	_enter("%p,%p{%pD2}", inode, file, file);
+	_enter("%p,%p{%pD}", inode, file, file);
 	return -EREMOTE;
 }
 
-- 
2.17.1

