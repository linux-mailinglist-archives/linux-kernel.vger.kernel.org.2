Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCB4003D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbhICRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhICRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:07:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3683C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:06:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc21so13374942ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1t6osnp17UN4qyfOO+wWdTwfcFIn3mD+387A+UK4UA=;
        b=YW4g3QTqU3FmfK5f4YwQyqKkuY94DNRNVe8kM4bERcqVFOR3qUNuPgoasy2RfRUBwk
         4b+3rAmQklYwqKiIaFpgj315aFyKcNiDGoqiAzQRo1p3iaP1R/Li9URT8ZE09Wlei5Vh
         o1CqebiYKijcyxl5VedUGZup5uUXlnVAVB6dI5HqZmc4NUOoOzdWgL2Yilf+7zJNXB0f
         UasTeHHJExXcWBSCpfFTUi4vUKPWwR/huzX6qmnTCh5wmIjiAr/f5OG349YKVEI9gJ2D
         0A6w2IQiq8FBONI8N1qeJ/cmfRpomqhyjRGOqL00p2Gei6OD558qkAYDB72B8O7D1XkH
         2e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1t6osnp17UN4qyfOO+wWdTwfcFIn3mD+387A+UK4UA=;
        b=pVqPl3GDMu7eY6Cy0i3clwpK2IErzEvMLut0+YZRc5mlKGkf6sqZwWlNcceT7DXlj5
         qh7lpIqTZugyDaVrqj9q1Zvrgf7vpb2PIXYG3t3s5x4o/ijh6cfO7+oJjxIU8nrNUriq
         LntdKGUkocPMpEqpo9y2ifJyYAZj+ep7W9a1HhvnLBRtPjUtbRvMAobLDGe1o0DZ5G2L
         +vGAGTmVI66SOoY9bakP8eGyeGnbIidU6rsvXJKdnsXoRAkdDkWPz6KfPc0EA0/1rKwC
         stOyuGdB/IlLO/VEi9qAkhsoJGjoIg6TxdMZgv7NvEbvhVFv41Z8ZtkEE4RLxolSpDnh
         V+nw==
X-Gm-Message-State: AOAM530l5RcCZ1sK0zV/+GeuF9zjRnge45bk9c4nt6KNQiyvChYwFP5N
        ciHE2EYG9MLRnCe5AsWUWqBsihiEVIKEnPRb2Jrc
X-Google-Smtp-Source: ABdhPJydRFuTdE2vS9SzeYVtj/7m1goAej+xNOyNd/xF9NhKLQFJN9GHTdU2sNTa2pn9ZxH11nzMHG90U2xTWvdWieA=
X-Received: by 2002:a17:906:abcd:: with SMTP id kq13mr5326863ejb.195.1630688800206;
 Fri, 03 Sep 2021 10:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Sep 2021 13:06:29 -0400
Message-ID: <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com>
Subject: Re: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 11:48 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> struct node defined in kernel/audit_tree.c conflicts with
> struct node defined in include/linux/node.h
>
>           CC      kernel/audit_tree.o
>         kernel/audit_tree.c:33:9: error: redefinition of 'struct node'
>            33 |  struct node {
>               |         ^~~~
>         In file included from ./include/linux/cpu.h:17,
>                          from ./include/linux/static_call.h:102,
>                          from ./arch/powerpc/include/asm/machdep.h:10,
>                          from ./arch/powerpc/include/asm/archrandom.h:7,
>                          from ./include/linux/random.h:121,
>                          from ./include/linux/net.h:18,
>                          from ./include/linux/skbuff.h:26,
>                          from kernel/audit.h:11,
>                          from kernel/audit_tree.c:2:
>         ./include/linux/node.h:84:8: note: originally defined here
>            84 | struct node {
>               |        ^~~~
>         make[2]: *** [kernel/audit_tree.o] Error 1
>
> Rename it audit_node.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/audit_tree.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

That's interesting, I wonder why we didn't see this prior?  Also as an
aside, there are evidently a good handful of symbols named "node".  In
fact I don't see this now in the audit/stable-5.15 or Linus' tree as
of a right now, both using an allyesconfig:

% git show-ref HEAD
a9c9a6f741cdaa2fa9ba24a790db8d07295761e3 refs/remotes/linus/HEAD
% touch kernel/audit_tree.c
% make C=1 kernel/
 CALL    scripts/checksyscalls.sh
 CALL    scripts/atomic/check-atomics.sh
 DESCEND objtool
 CHK     kernel/kheaders_data.tar.xz
 CC      kernel/audit_tree.o
 CHECK   kernel/audit_tree.c
 AR      kernel/built-in.a

What tree and config are you using where you see this error?  Looking
at your error, I'm guessing this is limited to ppc builds, and if I
look at the arch/powerpc/include/asm/machdep.h file in Linus tree I
don't see a static_call.h include so I'm guessing this is a -next tree
for ppc?  Something else?

Without knowing the context, is adding the static_call.h include in
arch/powerpc/include/asm/machdep.h intentional or simply a bit of
include file creep?

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index b2be4e978ba3..d392cf4ec8e2 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -30,7 +30,7 @@ struct audit_chunk {
>         int count;
>         atomic_long_t refs;
>         struct rcu_head head;
> -       struct node {
> +       struct audit_node {
>                 struct list_head list;
>                 struct audit_tree *owner;
>                 unsigned index;         /* index; upper bit indicates 'will prune' */
> @@ -269,7 +269,7 @@ bool audit_tree_match(struct audit_chunk *chunk, struct audit_tree *tree)
>
>  /* tagging and untagging inodes with trees */
>
> -static struct audit_chunk *find_chunk(struct node *p)
> +static struct audit_chunk *find_chunk(struct audit_node *p)
>  {
>         int index = p->index & ~(1U<<31);
>         p -= index;
> @@ -322,7 +322,7 @@ static void replace_chunk(struct audit_chunk *new, struct audit_chunk *old)
>         list_replace_rcu(&old->hash, &new->hash);
>  }
>
> -static void remove_chunk_node(struct audit_chunk *chunk, struct node *p)
> +static void remove_chunk_node(struct audit_chunk *chunk, struct audit_node *p)
>  {
>         struct audit_tree *owner = p->owner;
>
> @@ -459,7 +459,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
>  {
>         struct fsnotify_mark *mark;
>         struct audit_chunk *chunk, *old;
> -       struct node *p;
> +       struct audit_node *p;
>         int n;
>
>         mutex_lock(&audit_tree_group->mark_mutex);
> @@ -570,11 +570,11 @@ static void prune_tree_chunks(struct audit_tree *victim, bool tagged)
>  {
>         spin_lock(&hash_lock);
>         while (!list_empty(&victim->chunks)) {
> -               struct node *p;
> +               struct audit_node *p;
>                 struct audit_chunk *chunk;
>                 struct fsnotify_mark *mark;
>
> -               p = list_first_entry(&victim->chunks, struct node, list);
> +               p = list_first_entry(&victim->chunks, struct audit_node, list);
>                 /* have we run out of marked? */
>                 if (tagged && !(p->index & (1U<<31)))
>                         break;
> @@ -616,7 +616,7 @@ static void trim_marked(struct audit_tree *tree)
>         }
>         /* reorder */
>         for (p = tree->chunks.next; p != &tree->chunks; p = q) {
> -               struct node *node = list_entry(p, struct node, list);
> +               struct audit_node *node = list_entry(p, struct audit_node, list);
>                 q = p->next;
>                 if (node->index & (1U<<31)) {
>                         list_del_init(p);
> @@ -684,7 +684,7 @@ void audit_trim_trees(void)
>                 struct audit_tree *tree;
>                 struct path path;
>                 struct vfsmount *root_mnt;
> -               struct node *node;
> +               struct audit_node *node;
>                 int err;
>
>                 tree = container_of(cursor.next, struct audit_tree, list);
> @@ -839,7 +839,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
>         drop_collected_mounts(mnt);
>
>         if (!err) {
> -               struct node *node;
> +               struct audit_node *node;
>                 spin_lock(&hash_lock);
>                 list_for_each_entry(node, &tree->chunks, list)
>                         node->index &= ~(1U<<31);
> @@ -938,7 +938,7 @@ int audit_tag_tree(char *old, char *new)
>                 mutex_unlock(&audit_filter_mutex);
>
>                 if (!failed) {
> -                       struct node *node;
> +                       struct audit_node *node;
>                         spin_lock(&hash_lock);
>                         list_for_each_entry(node, &tree->chunks, list)
>                                 node->index &= ~(1U<<31);
> --
> 2.25.0
>


-- 
paul moore
www.paul-moore.com
