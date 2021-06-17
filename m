Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F663AA8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFQCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFQCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 22:16:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 19:14:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p7so7586637lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qk9UhbPNb71mmstojp2VdBuW5jCCYxJrZt8qmUVCklI=;
        b=Atvr0kaHIcTPZv9zNgMHQHH8D7j5TpxSwKRQl1UPL1qkcp3aGtMBBI6p5u4X1X+VC+
         gNG8sX6xpGB34DgPhNdsbBonJ31LQiIzOAcDwtOUz0GTtn6762mArmefAe/2zzXQDu+4
         adofol6sr4JvqGfIsghdYWTbDJXVnMIo75ZYYEM5bYK6OPQi/b4P3foSIF64wwhSi/ZU
         JKjQmzkBMEubwTUdP0AHlTtraCRwdfLkOaph8gSuTg0aLDBoW45+0Pgg8+NbCigTM54P
         F6FIcPxY0LH3QyRDCZBjy2xjtZYEFa62+0mzTIwB1IY3VCNDo3RuL35Q0JlE8IT52bQH
         ADfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qk9UhbPNb71mmstojp2VdBuW5jCCYxJrZt8qmUVCklI=;
        b=KcjmfRM3v5mNkwhpiQH3/eadu5VmhTVsquJuirF3GEildOGxse9EWOjc6c6LDrmI9+
         z4AultcM53C8NJdHJ3W3uVvFG4d3nEfWZ4bQyXMnsZ5SrWue6EoC9mOgB6YVoQOs9A+G
         oks/cEW/rzn5N4VT8tPlm6aODmyWAEjYvPWqM+3IPKpjnlJTUz11TSLMk0Djl5sn01Ce
         x7c3WLr6Ps9tEiEvKTgtj5tkLCfZ0OcRQyFS/B/4oKqMkP7EijIHFeiALUW3bF0L9oT+
         HRyP8JYde+HFzHuljgN/7rfzE2H9XOPyzajrXFlDSVvQq2bLwBiH/mZ8eSo2QMcKON59
         50gw==
X-Gm-Message-State: AOAM533E/grhSh1yHAv8wpvQCQCE78aLTd+qlvnbCWiD0tCSQLlszbTt
        vzPu4izzBUnbPl5J/YWj8JQJlS+OGuUdkx6+9SU=
X-Google-Smtp-Source: ABdhPJzA3Jroh1WyWIF1gM6dex6xAtCOyeVnlwMiW+mWtz0cr5xon9oAeQShEWlahNwqZXgOcshc67ewaPzR/kXqNWI=
X-Received: by 2002:ac2:42d1:: with SMTP id n17mr2012372lfl.650.1623896078246;
 Wed, 16 Jun 2021 19:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210616144210.278662-1-sxwjean@me.com> <a341e1f1-39a5-dca3-9454-8eabe085928b@redhat.com>
 <BF7CB29B-0B34-4462-B793-732C1EF9DC40@me.com> <9c60a4a9-c241-73de-57b5-c5fc45720677@redhat.com>
In-Reply-To: <9c60a4a9-c241-73de-57b5-c5fc45720677@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Thu, 17 Jun 2021 10:14:11 +0800
Message-ID: <CAEVVKH_nN65D6AnJbOceSAh1ttbH+eQpb9ycGxPoYYGGnM_LwA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: unlikely bfs error check
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:11 PM Waiman Long <llong@redhat.com> wrote:
>
> On 6/16/21 10:59 AM, Xiongwei Song wrote:
> >
> >> On Jun 16, 2021, at 10:48 PM, Waiman Long <llong@redhat.com> wrote:
> >>
> >> On 6/16/21 10:42 AM, Xiongwei Song wrote:
> >>> From: Xiongwei Song <sxwjean@gmail.com>
> >>>
> >>> The error from graph walk is small probability event, so unlikely
> >>> bfs_error can improve performance a little bit.
> >>>
> >>> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> >>> ---
> >>>   kernel/locking/lockdep.c | 12 ++++++------
> >>>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> >>> index 074fd6418c20..af8c9203cd3e 100644
> >>> --- a/kernel/locking/lockdep.c
> >>> +++ b/kernel/locking/lockdep.c
> >>> @@ -2646,7 +2646,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
> >>>     bfs_init_rootb(&this, prev);
> >>>             ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
> >>> -   if (bfs_error(ret)) {
> >>> +   if (unlikely(bfs_error(ret))) {
> >>>             print_bfs_bug(ret);
> >>>             return 0;
> >>>     }
> >>> @@ -2664,7 +2664,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
> >>>     bfs_init_root(&that, next);
> >>>             ret = find_usage_forwards(&that, forward_mask, &target_entry1);
> >>> -   if (bfs_error(ret)) {
> >>> +   if (unlikely(bfs_error(ret))) {
> >>>             print_bfs_bug(ret);
> >>>             return 0;
> >>>     }
> >>> @@ -2679,7 +2679,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
> >>>     backward_mask = original_mask(target_entry1->class->usage_mask);
> >>>             ret = find_usage_backwards(&this, backward_mask, &target_entry);
> >>> -   if (bfs_error(ret)) {
> >>> +   if (unlikely(bfs_error(ret))) {
> >>>             print_bfs_bug(ret);
> >>>             return 0;
> >>>     }
> >>> @@ -2998,7 +2998,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
> >>>      * Is the <prev> -> <next> link redundant?
> >>>      */
> >>>     ret = check_redundant(prev, next);
> >>> -   if (bfs_error(ret))
> >>> +   if (unlikely(bfs_error(ret)))
> >>>             return 0;
> >>>     else if (ret == BFS_RMATCH)
> >>>             return 2;
> >>> @@ -3911,7 +3911,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
> >>>             bfs_init_root(&root, this);
> >>>     ret = find_usage_forwards(&root, usage_mask, &target_entry);
> >>> -   if (bfs_error(ret)) {
> >>> +   if (unlikely(bfs_error(ret))) {
> >>>             print_bfs_bug(ret);
> >>>             return 0;
> >>>     }
> >>> @@ -3946,7 +3946,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
> >>>             bfs_init_rootb(&root, this);
> >>>     ret = find_usage_backwards(&root, usage_mask, &target_entry);
> >>> -   if (bfs_error(ret)) {
> >>> +   if (unlikely(bfs_error(ret))) {
> >>>             print_bfs_bug(ret);
> >>>             return 0;
> >>>     }
> >> I think it is better to put the unlikely() directly into the bfs_error() inline function instead of sprinkling it all over the place.
> > Sounds good. Thank you for the suggestion. I will update the patch.
>
> Another nit. It is a bit odd that sent out two patches separately though
> they do seem to have a bit of dependency. I think you should post them
> as a 2-patch series.

Ok. Let me do it. Thank you again.

Regards,
Xiongwei

> Cheers,
> Longman
>
