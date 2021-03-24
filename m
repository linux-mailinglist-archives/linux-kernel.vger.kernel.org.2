Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29BF3473F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhCXIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhCXIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:51:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:51:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u19so14160763pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9t8jH7fiBRNuIpJOprUlwIjQmokxDINeAIuoJ7WsEI=;
        b=j4H4/cvDRqgHQCNnDg0HwFrPYKAgXoJpgGRMWG8HjKYfH926TB4MRWEiuxCaU1K2Kb
         woUMNc9qO1qA7/XZH3VEEe2c0RMiYPNrvko7Fy0wKNFcuJtHHw5JAqTXmxcvV+XfEQar
         vsNs/mdSoKBRN1/3Hxt1zsDwWQ44SvkYxnWpwvtVAsZnah/xDjpzyZQ5helZfwWF4Kqc
         9vy+GYvo8+FqDq42I6jsxh68pObJO2xf2nt1x1VDJJ7ZDAlEZqzeqjNKTtK1Ie5duYhi
         Zvn9aPcU1ftOGBOsWNbBp/H3V/eXbrRQDOoBSb9j83hxucYZUvdgkV9pWB7cgYwlW4jb
         zqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9t8jH7fiBRNuIpJOprUlwIjQmokxDINeAIuoJ7WsEI=;
        b=kM5c7dL8pIP0lXMCJ9/i/8OYTUo1CaJDw7CT6cHrZBP9bguSgXoIpEv3x/dcADWYFO
         N+xjrqWUeGzZ7PfyelrPkaccKyuN3SBz4LPpt7nN/aXbat9aQjxIVYvqOXYfqxBGyuYK
         Vbi0cAQKaaW74PlhsonLPAH16XPph48nLcTmoyaDpaKsgg34zLd2/UVZs9S9TQi5HfwH
         xboz9uB87wZGCxKqEtUtBNoMC+z/pj4Wmbfk4DKT3cgqtjQlC4hIYW9SUl1r/Uhnlh3r
         UQArv+MevL7X3HmexFju1hlBJhs0rBJCxRyEQOZsyasmLRgzU6cp3WrUpyIIpyhLR0Jf
         YD9Q==
X-Gm-Message-State: AOAM530FSKjJXdyhr0tkcKIM445XMNTH3KXfHf4jl02K4lNh6e1RHV1o
        Q76Z8HITa/FTlZ+Dk6vzxPG5XEo4LZ0dxPACVUIdlg==
X-Google-Smtp-Source: ABdhPJwX6oaoOONDaii/WKm7gZdPV1gXoOejYkts/sZ0DJFoA4ZGka5pHxdEPlnr77OXIP71hN4AHiGETMo69iqt5h4=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr2195394pfq.59.1616575878821; Wed, 24
 Mar 2021 01:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210323145653.25684-1-songmuchun@bytedance.com>
 <CAMZfGtWT8XXDtg0Jcv=1qJpdLD6foJWE=kB_i1ZyHjvrku=vrw@mail.gmail.com> <YFr5SrJ2iNGYwVNA@dhcp22.suse.cz>
In-Reply-To: <YFr5SrJ2iNGYwVNA@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Mar 2021 16:50:41 +0800
Message-ID: <CAMZfGtVe6seRLA7Wo4TST0ApkaHdkDmv6sL5GZytK_4hvMbkXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix memsw uncharge for root_mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-03-21 12:11:35, Muchun Song wrote:
> > On Tue, Mar 23, 2021 at 11:04 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The pages aren't accounted at the root level, so we cannot uncharge the
> > > page to the memsw counter for the root memcg. Fix this.
> > >
> > > Fixes: 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > I am very sorry. I should repent. I suddenly realise the fix is totally
> > wrong. Because the @memcg cannot be root memcg when
> > @memcg != @swap_memcg.
>
> I am probably blind but I do not see why this would be the case.
> We have memcg != swap_memcg in this branch but we do not know the
> neither of the two is root_mem_cgroup, no? If we did knot that we
> wouldn't have to check for swap_memcg != root_mem_cgroup. Or do I miss
> something?

I look at the mem_cgroup_id_get_online() closely. If memcg is root, this
function always returns root memcg. So memcg will equal swap_memcg.
I apologize for not carefully reviewing the code myself.

Thanks.

> --
> Michal Hocko
> SUSE Labs
