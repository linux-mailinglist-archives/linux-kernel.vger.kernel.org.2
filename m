Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8639ECA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFHDEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:04:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3094 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFHDEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:04:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZfk2JFHzWtL4;
        Tue,  8 Jun 2021 10:57:50 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:02:40 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 11:02:39 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        "Eric Paris" <eparis@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <linux-audit@redhat.com>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] audit: Use list_move instead of list_del/list_add
Date:   Tue, 8 Jun 2021 11:11:50 +0800
Message-ID: <20210608031150.2821712-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move() instead of list_del() + list_add().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/audit_tree.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 6c91902f4f45..b2be4e978ba3 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -689,8 +689,7 @@ void audit_trim_trees(void)
 
 		tree = container_of(cursor.next, struct audit_tree, list);
 		get_tree(tree);
-		list_del(&cursor);
-		list_add(&cursor, &tree->list);
+		list_move(&cursor, &tree->list);
 		mutex_unlock(&audit_filter_mutex);
 
 		err = kern_path(tree->pathname, 0, &path);
@@ -899,8 +898,7 @@ int audit_tag_tree(char *old, char *new)
 
 		tree = container_of(cursor.next, struct audit_tree, list);
 		get_tree(tree);
-		list_del(&cursor);
-		list_add(&cursor, &tree->list);
+		list_move(&cursor, &tree->list);
 		mutex_unlock(&audit_filter_mutex);
 
 		err = kern_path(tree->pathname, 0, &path2);
@@ -925,8 +923,7 @@ int audit_tag_tree(char *old, char *new)
 		mutex_lock(&audit_filter_mutex);
 		spin_lock(&hash_lock);
 		if (!tree->goner) {
-			list_del(&tree->list);
-			list_add(&tree->list, &tree_list);
+			list_move(&tree->list, &tree_list);
 		}
 		spin_unlock(&hash_lock);
 		put_tree(tree);
@@ -937,8 +934,7 @@ int audit_tag_tree(char *old, char *new)
 
 		tree = container_of(barrier.prev, struct audit_tree, list);
 		get_tree(tree);
-		list_del(&tree->list);
-		list_add(&tree->list, &barrier);
+		list_move(&tree->list, &barrier);
 		mutex_unlock(&audit_filter_mutex);
 
 		if (!failed) {

