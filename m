Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9740028D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhICPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:49:27 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60267 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235573AbhICPtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:49:25 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1Mdg4G7hz9sSf;
        Fri,  3 Sep 2021 17:48:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ujhQdbycgG0X; Fri,  3 Sep 2021 17:48:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1Mdg30wHz9sSb;
        Fri,  3 Sep 2021 17:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 398418B917;
        Fri,  3 Sep 2021 17:48:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qsHaNTvIM31N; Fri,  3 Sep 2021 17:48:23 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C53C28B915;
        Fri,  3 Sep 2021 17:48:22 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 237E068A07; Fri,  3 Sep 2021 15:48:22 +0000 (UTC)
Message-Id: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] audit: Fix build failure by renaming struct node to struct
 audit_node
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com
Date:   Fri,  3 Sep 2021 15:48:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct node defined in kernel/audit_tree.c conflicts with
struct node defined in include/linux/node.h

	  CC      kernel/audit_tree.o
	kernel/audit_tree.c:33:9: error: redefinition of 'struct node'
	   33 |  struct node {
	      |         ^~~~
	In file included from ./include/linux/cpu.h:17,
                	 from ./include/linux/static_call.h:102,
                	 from ./arch/powerpc/include/asm/machdep.h:10,
                	 from ./arch/powerpc/include/asm/archrandom.h:7,
                	 from ./include/linux/random.h:121,
                	 from ./include/linux/net.h:18,
                	 from ./include/linux/skbuff.h:26,
                	 from kernel/audit.h:11,
                	 from kernel/audit_tree.c:2:
	./include/linux/node.h:84:8: note: originally defined here
	   84 | struct node {
	      |        ^~~~
	make[2]: *** [kernel/audit_tree.o] Error 1

Rename it audit_node.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/audit_tree.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b2be4e978ba3..d392cf4ec8e2 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -30,7 +30,7 @@ struct audit_chunk {
 	int count;
 	atomic_long_t refs;
 	struct rcu_head head;
-	struct node {
+	struct audit_node {
 		struct list_head list;
 		struct audit_tree *owner;
 		unsigned index;		/* index; upper bit indicates 'will prune' */
@@ -269,7 +269,7 @@ bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree)
 
 /* tagging and untagging inodes with trees */
 
-static struct audit_chunk *find_chunk(struct node *p)
+static struct audit_chunk *find_chunk(struct audit_node *p)
 {
 	int index = p->index & ~(1U<<31);
 	p -= index;
@@ -322,7 +322,7 @@ static void replace_chunk(struct audit_chunk *new, struct audit_chunk *old)
 	list_replace_rcu(&old->hash, &new->hash);
 }
 
-static void remove_chunk_node(struct audit_chunk *chunk, struct node *p)
+static void remove_chunk_node(struct audit_chunk *chunk, struct audit_node *p)
 {
 	struct audit_tree *owner = p->owner;
 
@@ -459,7 +459,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 {
 	struct fsnotify_mark *mark;
 	struct audit_chunk *chunk, *old;
-	struct node *p;
+	struct audit_node *p;
 	int n;
 
 	mutex_lock(&audit_tree_group->mark_mutex);
@@ -570,11 +570,11 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
 {
 	spin_lock(&hash_lock);
 	while (!list_empty(&victim->chunks)) {
-		struct node *p;
+		struct audit_node *p;
 		struct audit_chunk *chunk;
 		struct fsnotify_mark *mark;
 
-		p = list_first_entry(&victim->chunks, struct node, list);
+		p = list_first_entry(&victim->chunks, struct audit_node, list);
 		/* have we run out of marked? */
 		if (tagged && !(p->index & (1U<<31)))
 			break;
@@ -616,7 +616,7 @@ static void trim_marked(struct audit_tree *tree)
 	}
 	/* reorder */
 	for (p = tree->chunks.next; p != &tree->chunks; p = q) {
-		struct node *node = list_entry(p, struct node, list);
+		struct audit_node *node = list_entry(p, struct audit_node, list);
 		q = p->next;
 		if (node->index & (1U<<31)) {
 			list_del_init(p);
@@ -684,7 +684,7 @@ void audit_trim_trees(void)
 		struct audit_tree *tree;
 		struct path path;
 		struct vfsmount *root_mnt;
-		struct node *node;
+		struct audit_node *node;
 		int err;
 
 		tree = container_of(cursor.next, struct audit_tree, list);
@@ -839,7 +839,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
 	drop_collected_mounts(mnt);
 
 	if (!err) {
-		struct node *node;
+		struct audit_node *node;
 		spin_lock(&hash_lock);
 		list_for_each_entry(node, &tree->chunks, list)
 			node->index &= ~(1U<<31);
@@ -938,7 +938,7 @@ int audit_tag_tree(char *old, char *new)
 		mutex_unlock(&audit_filter_mutex);
 
 		if (!failed) {
-			struct node *node;
+			struct audit_node *node;
 			spin_lock(&hash_lock);
 			list_for_each_entry(node, &tree->chunks, list)
 				node->index &= ~(1U<<31);
-- 
2.25.0

