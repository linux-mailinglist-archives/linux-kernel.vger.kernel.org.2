Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623453AC0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFRB5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:57:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 18:55:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m21so13674567lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5i265Dlxku7LS7cdoB+aE9Pgv2Etk1tGVQ6RT312v8=;
        b=g1rr3d/OMdqTsZsWIZ9JbUl1qgzRPBwLfABUe7p5nQ8PBNZkxKmt+GfvAuwSY6IWAc
         xhPKj6tRNNLMNUOY3kO1gXjoanK/9Xe03wT7YnqdBdheUqXRcbC0D6kN+uwJ59mPKiln
         OKtR3/xub0ZLy8iDyTs2UUgMCFH5lSGzu0YrmDLyxE/abS1MW2hNNdXRrsfQhC/wHJAn
         0F+w4q5FawNUzIAPD2a3/ohn4idaVk1rA7eF0DGGln84QzbtyBF3h3vsqCjNZVjNpDjJ
         VHTC1VixnxGcQt8TBqbslZwU8iq21LjEv4M42prmCk1Ihj2MCjbFxiCmzKD4ubDZJWXC
         YzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5i265Dlxku7LS7cdoB+aE9Pgv2Etk1tGVQ6RT312v8=;
        b=rwMnzmgue3fKU3JgVBq7PItYYsIVxOQbXX3nKP3cUerrB1XCJzyNr2POLgycbt14DI
         66u9/We2fs+UMhupEdpY+Ds10mT7UM9NKiJtPvcUp0Gf+rYUCa1W5abz4cUkv05h4T5J
         PBhyNPD5Ncle6Ddu6xmwloxDUzhPHE3sn948V4E/8XIIRgjEtqC2ssF0aDiptypemf2p
         RyB9pwF9Weh93svD1hYmhXIwT8Ce86lF1VMdiGSVVAWOuuPvD43v1fGrBE7csi5c/8l5
         qidtUXoU9apGawBgNuwq/rqSJ4YGGCyAhWemp/VIPpFevpSoVnRcZ5tt5L6LBAL/OoJb
         moiw==
X-Gm-Message-State: AOAM530djiMy3T4zYKtfPY7y6KLDlXYa4Qnw4KDRgAiBmUQEFkC7OQFG
        MqYI8suxDgAqGQqCJwWqPVYJmgdKEG3a9CnekXw=
X-Google-Smtp-Source: ABdhPJy3vkr7BI6anDuxlu4H4B08E/nVAyuy9myGCasQwPP1tOWV5HxHT/QatJ4BngMTJ18LuK9OUVfoAjkma89+ulc=
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr1036235lfo.587.1623981326032;
 Thu, 17 Jun 2021 18:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210617142828.346111-1-sxwjean@me.com> <20210617142828.346111-4-sxwjean@me.com>
 <YMtmbjw5EGdXRdD8@boqun-archlinux>
In-Reply-To: <YMtmbjw5EGdXRdD8@boqun-archlinux>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 18 Jun 2021 09:54:59 +0800
Message-ID: <CAEVVKH8TYoQjZSJr7DjecgEq-EAZEqWqC=EC_pFPzti3VLh6_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] locking/lockdep: print possible warning after
 counting deps
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:13 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi,
>
> On Thu, Jun 17, 2021 at 10:28:28PM +0800, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The graph walk might hit error when counting dependencies. Once the
> > return value is negative, print a warning to reminder users.
> >
>
> Thanks for the improvement, but please see below:
>
> > Suggested-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index cb94097014d8..cfe0f4374594 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -2028,8 +2028,12 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
> >  {
> >       unsigned long  count = 0;
> >       struct lock_list *target_entry;
> > +     enum bfs_result ret;
> > +
> > +     ret = __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> >
> > -     __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> > +     if (bfs_error(ret))
> > +             print_bfs_bug(ret);
>
> Here print_bfs_bug() will eventually call debug_locks_off_graph_unlock()
> to release the graph lock, and the caller (lockdep_count_fowards_deps())
> will also call graph_unlock() afterwards, and that means we unlock
> *twice* if a BFS error happens... although in that case, lockdep should
> stop working so messing up with the graph lock may not hurt anything,
> but still, I don't think we want to do that.
>
> So probably you can open-code __lockdep_count_forward_deps() into
> lockdep_count_forwards_deps(), and call print_bfs_bug() or
> graph_unlock() accordingly. The body of __lockdep_count_forward_deps()
> is really small, so I think it's OK to open-code it into its caller.

Thank you so much for the detailed comments. Let me improve and update
the patch.

Regards,
Xiongwei

>
> Regards,
> Boqun
>
> >
> >       return count;
> >  }
> > @@ -2053,8 +2057,12 @@ static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
> >  {
> >       unsigned long  count = 0;
> >       struct lock_list *target_entry;
> > +     enum bfs_result ret;
> > +
> > +     ret = __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> >
> > -     __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> > +     if (bfs_error(ret))
> > +             print_bfs_bug(ret);
> >
> >       return count;
> >  }
> > --
> > 2.30.2
> >
