Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08A23117B6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBFARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhBEM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:57:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A33C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:56:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c132so4493850pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=at3tlE+CnMfJFYgoRalXte0nrDzDhLkLsR1wIcNPMOM=;
        b=rh+E2c1RBqi2Afh5NbYKEM3yLFpRTWi9kUBJWQ4+8iWFvtpIMOf9ASTnRxKKD+dKrA
         MJshQOYgCKe27lDY4QZkClKdDAUu9qWUjxOpvFSQTCDOBfkPF82Hynzf0IG1wPGdIzb3
         IU5bD6qlsNnrrjF+g3m382MXpUkDMR3Oar4JbCr0JG9Fjh6x+19tfj4EeRFbc/8rQOqk
         a2gbS5rTBo0mgUTFtn4PFjuvqG5Dg2lg8Qu8xk0/+bqRB77gJgMpLq7CVYlWkf4XImVG
         3ZBxBIpcfVcdKow7puYuDSj2Xw70IytFjMpGZ9aV5vKroCNt2CXgHJRdwIoPtBISS2fx
         ZFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=at3tlE+CnMfJFYgoRalXte0nrDzDhLkLsR1wIcNPMOM=;
        b=QGHmtMefPMf2HzF4YVCYN+tEmO048arvLSKZhVfvFvP3fxG6c0Y6X2jmCLEXB0PcLH
         ViV+58JV93UbxheHtJENE/8+I1SqSWDnRnqzZQqioiGAYiG+BSFJBURe0TanGya+9/5Y
         FsOid9CocWOSiHL9QXutrwgo6t4mDYGEU3X4/DxTKxUThc/KLmW10agJt8vDaZ0hOP92
         xC3the7Ft3XhpiSRgiw/4XTh0apQ+6FU3VEPWwcxw739/9RxktkzBL0tbL8XStRcqfd6
         2GjHoDLOfoGU53Kc7L5r7/kPxaED/+9NrFLRHthiC1Ru37XJCLnaUghhIUNkuUNfjK5f
         Kz9g==
X-Gm-Message-State: AOAM533ltK+dP5n6NIV3fKsX0QU6UYUefQ31GdW2xVxTn0yGIgS8MtKU
        2/pfk++71ganxXOij9N7HFuzMSBwtl6k+ofIGF6wtiVFGto42rjR
X-Google-Smtp-Source: ABdhPJx7IVvcP3TolhwSH4GVR+OrlDlebGRWy4KWLjsLAojzAJd6dr0eZYbUN/dx4eNIpblAX6dyx5radVmw/AVBzmQ=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr4371823pgf.31.1612529805660;
 Fri, 05 Feb 2021 04:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz> <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
In-Reply-To: <YB0euLiMU+T/9bMK@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 20:56:07 +0800
Message-ID: <CAMZfGtW3fjnPt140OqaQqSyaPAiB9AKSVgop4pXdZb15qVmSPw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:32 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 05-02-21 17:14:30, Muchun Song wrote:
> > On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > > > The get_mem_cgroup_from_page() is called under page lock, so the page
> > > > memcg cannot be changed under us.
> > >
> > > Where is the page lock enforced?
> >
> > Because it is called from alloc_page_buffers(). This path is under
> > page lock.
>
> I do not see any page lock enforecement there. There is not even a
> comment requiring that. Can we grow more users where this is not the
> case? There is no actual relation between alloc_page_buffers and
> get_mem_cgroup_from_page except that the former is the only _current_
> existing user. I would be careful to dictate locking based solely on
> that.

Yeah, there is no comment requiring that. I have seen all the callers
of the alloc_page_buffers. I found that it is under page lock.
But it seems it is not the key point here. I should delete those
comments from the commit log.

>
> > > > Also, css_get is enough because page
> > > > has a reference to the memcg.
> > >
> > > tryget used to be there to guard against offlined memcg but we have
> > > concluded this is impossible in this path. tryget stayed there to catch
> > > some unexpected cases IIRC.
> >
> > Yeah, it can catch some unexpected cases. But why is this path
> > special so that we need a tryget?
>
> I do not remember details and the changelog of that change is not
> explicit but I suspect it was just because this one could trigger as
> there are external callers to memcg. Is this protection needed? I am not
> sure, this is for you to justify if you want to remove it.

I am sure it is not needed.

>
> > > > If we really want to make the get_mem_cgroup_from_page() suitable for
> > > > arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
> > > > and call it after rcu_read_lock().
> > >
> > > What is the primary motivation to change this code? is the overhead of
> > > tryget/RCU something that needs optimizing?
> >
> > Actually, the rcu_read_lock() is not necessary here. So it is better to
> > remove it (indeed reduce some code).
>
> Please state your reasoning in the changelog including benefits we get
> from it.

OK.

> --
> Michal Hocko
> SUSE Labs
