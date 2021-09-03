Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C20400569
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbhICTAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350528AbhICTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630695554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynYQb/sRGR4WOPcdYIbB5xWCjxsBkaL75JAU6CwQ/WM=;
        b=NWCOldFBCBK49cIktS5zqIaBq6L8b9C6zrzgH33VnxpbRzfBZcFj1MZz3yV6yJUpDdm0xq
        WXqRAK+L8dFd74a1eA9b+eWAigQKPyqpYb4QW0UNNIVp0v2Hp9u5AkVQ3wGb3YFpe/uzha
        XBbqxnKKS5vW14fRXYMDct6+J2US+g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-zgjSNWfvPeWDf-BjFxb9SQ-1; Fri, 03 Sep 2021 14:59:11 -0400
X-MC-Unique: zgjSNWfvPeWDf-BjFxb9SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5C41100670B;
        Fri,  3 Sep 2021 18:59:10 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05D915C1B4;
        Fri,  3 Sep 2021 18:58:59 +0000 (UTC)
Date:   Fri, 3 Sep 2021 14:58:57 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
Message-ID: <20210903185857.GI490529@madcap2.tricolour.ca>
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 15:48, Christophe Leroy wrote:
> struct node defined in kernel/audit_tree.c conflicts with
> struct node defined in include/linux/node.h

Why?  What changed to start triggering this error?  This code has been
here for 15 years.  I am guessing changing the other one would affect
more code?

The patch itself looks fine to me.

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> 	  CC      kernel/audit_tree.o
> 	kernel/audit_tree.c:33:9: error: redefinition of 'struct node'
> 	   33 |  struct node {
> 	      |         ^~~~
> 	In file included from ./include/linux/cpu.h:17,
>                 	 from ./include/linux/static_call.h:102,
>                 	 from ./arch/powerpc/include/asm/machdep.h:10,
>                 	 from ./arch/powerpc/include/asm/archrandom.h:7,
>                 	 from ./include/linux/random.h:121,
>                 	 from ./include/linux/net.h:18,
>                 	 from ./include/linux/skbuff.h:26,
>                 	 from kernel/audit.h:11,
>                 	 from kernel/audit_tree.c:2:
> 	./include/linux/node.h:84:8: note: originally defined here
> 	   84 | struct node {
> 	      |        ^~~~
> 	make[2]: *** [kernel/audit_tree.o] Error 1
> 
> Rename it audit_node.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/audit_tree.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index b2be4e978ba3..d392cf4ec8e2 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -30,7 +30,7 @@ struct audit_chunk {
>  	int count;
>  	atomic_long_t refs;
>  	struct rcu_head head;
> -	struct node {
> +	struct audit_node {
>  		struct list_head list;
>  		struct audit_tree *owner;
>  		unsigned index;		/* index; upper bit indicates 'will prune' */
> @@ -269,7 +269,7 @@ bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree)
>  
>  /* tagging and untagging inodes with trees */
>  
> -static struct audit_chunk *find_chunk(struct node *p)
> +static struct audit_chunk *find_chunk(struct audit_node *p)
>  {
>  	int index = p->index & ~(1U<<31);
>  	p -= index;
> @@ -322,7 +322,7 @@ static void replace_chunk(struct audit_chunk *new, struct audit_chunk *old)
>  	list_replace_rcu(&old->hash, &new->hash);
>  }
>  
> -static void remove_chunk_node(struct audit_chunk *chunk, struct node *p)
> +static void remove_chunk_node(struct audit_chunk *chunk, struct audit_node *p)
>  {
>  	struct audit_tree *owner = p->owner;
>  
> @@ -459,7 +459,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
>  {
>  	struct fsnotify_mark *mark;
>  	struct audit_chunk *chunk, *old;
> -	struct node *p;
> +	struct audit_node *p;
>  	int n;
>  
>  	mutex_lock(&audit_tree_group->mark_mutex);
> @@ -570,11 +570,11 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
>  {
>  	spin_lock(&hash_lock);
>  	while (!list_empty(&victim->chunks)) {
> -		struct node *p;
> +		struct audit_node *p;
>  		struct audit_chunk *chunk;
>  		struct fsnotify_mark *mark;
>  
> -		p = list_first_entry(&victim->chunks, struct node, list);
> +		p = list_first_entry(&victim->chunks, struct audit_node, list);
>  		/* have we run out of marked? */
>  		if (tagged && !(p->index & (1U<<31)))
>  			break;
> @@ -616,7 +616,7 @@ static void trim_marked(struct audit_tree *tree)
>  	}
>  	/* reorder */
>  	for (p = tree->chunks.next; p != &tree->chunks; p = q) {
> -		struct node *node = list_entry(p, struct node, list);
> +		struct audit_node *node = list_entry(p, struct audit_node, list);
>  		q = p->next;
>  		if (node->index & (1U<<31)) {
>  			list_del_init(p);
> @@ -684,7 +684,7 @@ void audit_trim_trees(void)
>  		struct audit_tree *tree;
>  		struct path path;
>  		struct vfsmount *root_mnt;
> -		struct node *node;
> +		struct audit_node *node;
>  		int err;
>  
>  		tree = container_of(cursor.next, struct audit_tree, list);
> @@ -839,7 +839,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
>  	drop_collected_mounts(mnt);
>  
>  	if (!err) {
> -		struct node *node;
> +		struct audit_node *node;
>  		spin_lock(&hash_lock);
>  		list_for_each_entry(node, &tree->chunks, list)
>  			node->index &= ~(1U<<31);
> @@ -938,7 +938,7 @@ int audit_tag_tree(char *old, char *new)
>  		mutex_unlock(&audit_filter_mutex);
>  
>  		if (!failed) {
> -			struct node *node;
> +			struct audit_node *node;
>  			spin_lock(&hash_lock);
>  			list_for_each_entry(node, &tree->chunks, list)
>  				node->index &= ~(1U<<31);
> -- 
> 2.25.0
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

