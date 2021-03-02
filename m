Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5849032A3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbhCBKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382323AbhCBJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:51:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234CCC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:50:17 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id j12so13451706pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtndLsEaN7tzdKD5K+JvWGojXPONwlybi1fJYBg5XAo=;
        b=rnvConHGygj2YhM2noKk4i8f9KE2eVEJk8eUsStiUtGPjRlsxwwNAk5uBxwRdha7ex
         BIItuCJDjifrVzkoDGaBpx6O0ycunRZSESsDup7TGLsL/tvOJs2KY7CGLQLmSolxYong
         wfc0GmfKrRDdW5oh1Zcd4BirHBdVHXij3GmRm+dWUjP+VdZiZJyD3+Rkj+AuVAkxNg4c
         7MhsKnYV7NG8cYvePLZJ9g5woJcV1Jqz8AiyzDYxvfbKfniMEKtZol3bLPgenTdzwJry
         CKXmmLNQDgo6ntiJtDQDUlc8J4GKLU5paTbVDj2V8HTT8W0EUVwGODGvUHVbssLoD0DV
         E7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtndLsEaN7tzdKD5K+JvWGojXPONwlybi1fJYBg5XAo=;
        b=mjXLF92IO07/TIg+qiE8nMNpU38I0YXKXmcIChnz0HPIAqXnLIysEmD7DbMtJL2LGB
         JH6hGeEgZ2Jk2upSaGWyyQt+eDo0eHYLVU7si19dupjz9iJ6drnAreE07PH2q75y8h2g
         fvG/aBI1b/r66O8ZilWp6JOM/aGhhk3W/RuvXqA+ffP9Qz982txx0KWYYBuJH1URBTby
         8gmN5mcjh1EYGknql6NMPZvGvwaoO/U4VOKrqD5TQvb4rvPWdVLCV2YV1qsF9Ol3UV2m
         sH2abF5VWhIItL68TPZewU92a2zzF9gFEJ38IYGxCXaKF/gJFRg/d73PrtpSAwfyVLyX
         uMTg==
X-Gm-Message-State: AOAM530EbdNT7ZC9lQFG6HJggIA3dk/pmgANPkW2yZ3kHZ4av3WFuKSm
        7u+hMSdk3/URDm3iBb6L1ddjoqwlVdmwFGCczFR3Jwr3Ku6cm2Xx
X-Google-Smtp-Source: ABdhPJyBL4+o7TN0CcugFT0hUMqIrP+PY3j9837YOq+x3Hw/7QAYa8H9G+jv5QvX/cjzNIkRQwaQQXcgTHFBxeGxdIY=
X-Received: by 2002:a65:6645:: with SMTP id z5mr17097527pgv.273.1614678616654;
 Tue, 02 Mar 2021 01:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20210302073733.8928-1-songmuchun@bytedance.com>
 <YD36+i1PZX/CH1jf@dhcp22.suse.cz> <CAMZfGtX=EmE8iOLfO3duCyMWOmu-OYra9Rk4mKsknds+5MueMg@mail.gmail.com>
 <YD4GkRnTN6RK5CyG@dhcp22.suse.cz>
In-Reply-To: <YD4GkRnTN6RK5CyG@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 2 Mar 2021 17:49:39 +0800
Message-ID: <CAMZfGtW1prn96mq-J4dA+_nERkq4YLi7EaL+bACMDPZNJVe0BA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix kernel stack account
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 5:34 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 02-03-21 17:23:42, Muchun Song wrote:
> > On Tue, Mar 2, 2021 at 4:44 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 02-03-21 15:37:33, Muchun Song wrote:
> > > > The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> > > > are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> > > > __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> > > > mod_lruvec_page_state() for each page one by one.
> > >
> > > What is the actual problem you are trying to address by this patch?
> > > 991e7673859e has deliberately dropped the per page accounting. Can you
> > > explain why that was incorrect? There surely is some imprecision
> > > involved but does it matter and is it even observable?
> >
> > When I read the code of account_kernel_stack(), I see a comment that
> > says "All stack pages are in the same node". I am confused about this.
> > IIUC, there is no guarantee about this. Right?
>
> Yes there is no guarantee indeed. Please always make sure to describe
> the underlying reasoning for the patch. Subject of this patch refers to
> a fix without explaining the actual problem. If a change is motivated by
> code reading then make it explicit. Also if you are refering to a
> different commit by Fixes: tag then it would be really helpful to
> explicitly mention why that commit is incorrect or cause a visible
> problems.

Got it. Thanks for your teaching.

>
> > Yeah, imprecision may
> > not be a problem. But if this is what we did deliberately, I think that
> > it is better to add a comment there. Thanks.
>
> Yes the comment is quite confusing. I suspect it meant to say
>         /* All stack pages are accounted to the same node */
>
> --
> Michal Hocko
> SUSE Labs
