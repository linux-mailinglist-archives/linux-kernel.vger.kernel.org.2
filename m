Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAE329447
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhCAVx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:53:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237838AbhCARYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614619438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlRwdOzbL8RLSRzwItUwbMXUiIvnCooahFkWHhdiBtc=;
        b=MWXMF20Pccl/hIQ2lCGRmBq7fMTaMeUrO+KuXsnVcTy+o9hQiUrLkZXo9F8qVhozNAa6m+
        ZSkBPYoRNc2dSidzOllDOiVXOBtk6OpJbbgSStuS7IuDEpfALSHZ1fo7uc29pd4tKWMkBu
        oQAjAHny3QfxG0FhboYVzxSWP5PgsWo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B624B023;
        Mon,  1 Mar 2021 17:23:58 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:23:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
Subject: Re: possible deadlock in sk_clone_lock
Message-ID: <YD0jLTciK0M7P+Hc@dhcp22.suse.cz>
References: <000000000000f1c03b05bc43aadc@google.com>
 <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
 <7b7c4f41-b72e-840f-278a-320b9d97f887@oracle.com>
 <CALvZod5qODDSxqHqQ=_1roYVGVVvEvP3FnYMnAPQZgvUjxotsw@mail.gmail.com>
 <YDzaAWK41K4gD35V@dhcp22.suse.cz>
 <CALvZod4DqOkrJG+7dki=VfzHD1z9jD3XhObpk887zKy=kEk1tA@mail.gmail.com>
 <YD0OzXTmYm8M58Vo@dhcp22.suse.cz>
 <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod789kHFAjWA8W7=r2=YxJ86uc4WhfgW1juN_YEMCApgqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-03-21 08:39:22, Shakeel Butt wrote:
> On Mon, Mar 1, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Then how come this can ever be a problem? in_task() should exclude soft
> > irq context unless I am mistaken.
> >
> 
> If I take the following example of syzbot's deadlock scenario then
> CPU1 is the one freeing the hugetlb pages. It is in the process
> context but has disabled softirqs (see __tcp_close()).
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(hugetlb_lock);
>                                 local_irq_disable();
>                                 lock(slock-AF_INET);
>                                 lock(hugetlb_lock);
>    <Interrupt>
>      lock(slock-AF_INET);
> 
> So, this deadlock scenario is very much possible.

OK, I see the point now. I was focusing on the IRQ context and hugetlb
side too much. We do not need to be freeing from there. All it takes is
to get a dependency chain over a common lock held here. Thanks for
bearing with me.

Let's see whether we can make hugetlb_lock irq safe.

-- 
Michal Hocko
SUSE Labs
