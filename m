Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD3D8DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhG1MYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhG1MYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:24:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5208E60C3E;
        Wed, 28 Jul 2021 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475091;
        bh=jlrPzEuJm9foO+7KNRHzPI4mF50awFwPR4lclougBGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8RFZbgyPBX1w+my5BAr68m6Nr4g2HjcKFMrKBmJWOApLyn1qYBnskqFbTG0Jq6w7
         EbLet8kbXNCQNYxoiocmnlinuiioqvUOHe6wY0H1KbAHw5wH0Csy41fimRSQblWsPz
         QYdMn7g5N+cQNFDPqq3C4Cpr/bVS42pH0KrX1Fal2G5oPg1AF0i7Dt4GcNnQ7RuAN0
         dk0em/3RS99wV9E/xwik2bkjOYnl6MPw0Qsja53RB+A7YiVhbtJpJL8kjmzlBgkGUO
         tjfOst8LfA32m53rPf82tiuAX2loRRkdHPAj8U4wVtVXfMrv5BmwBB5wyPPuES5fiL
         naRfq9A9nV9Wg==
Date:   Wed, 28 Jul 2021 14:24:48 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com,
        syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com,
        syzbot+6cd79f45bb8fa1c9eeae@syzkaller.appspotmail.com,
        syzbot+b6e65bd125a05f803d6b@syzkaller.appspotmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v1] ucounts: Fix race condition between alloc_ucounts and
 put_ucounts
Message-ID: <20210728122448.lh2e3nr4txhsmcwt@example.org>
References: <000000000000efe97f05c74bb995@google.com>
 <20210728025837.1641-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728025837.1641-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:58:37AM +0800, Hillf Danton wrote:
> On Tue, 27 Jul 2021 17:24:18 +0200 Alexey Gladkov wrote:
> > +++ b/kernel/ucount.c
> > @@ -160,6 +160,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
> >  {
> >  	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
> >  	struct ucounts *ucounts, *new;
> > +	long overflow;
> >  
> >  	spin_lock_irq(&ucounts_lock);
> >  	ucounts = find_ucounts(ns, uid, hashent);
> > @@ -184,8 +185,12 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
> >  			return new;
> >  		}
> >  	}
> > +	overflow = atomic_add_negative(1, &ucounts->count);
> >  	spin_unlock_irq(&ucounts_lock);
> > -	ucounts = get_ucounts(ucounts);
> > +	if (overflow) {
> > +		put_ucounts(ucounts);
> 
> Given 		  if (atomic_add_unless(atomic, -1, 1))
> 			return 0;
> 
> put can not help roll back overflow.

In case of overflow, we don't try to rollback overflow. We return an
error.

> BTW can you specify a bit on the real workloads with the risk of count overflow?

For example, one user has too many processes in one namespace.

It is necessary to check and handle the possibility of counter overflow
in this case. Linus described it here:

https://lore.kernel.org/lkml/CAHk-%3dwjYOCgM%2bmKzwTZwkDDg12DdYjFFkmoFKYLim7NFmR9HBg@mail.gmail.com/

> > +		return NULL;
> > +	}
> >  	return ucounts;
> >  }
> >  
> > @@ -193,8 +198,7 @@ void put_ucounts(struct ucounts *ucounts)
> >  {
> >  	unsigned long flags;
> >  
> > -	if (atomic_dec_and_test(&ucounts->count)) {
> > -		spin_lock_irqsave(&ucounts_lock, flags);
> > +	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
> >  		hlist_del_init(&ucounts->node);
> >  		spin_unlock_irqrestore(&ucounts_lock, flags);
> >  		kfree(ucounts);
> > -- 
> > 2.29.3
> 

-- 
Rgrds, legion

