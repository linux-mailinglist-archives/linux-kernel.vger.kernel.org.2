Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D25360661
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhDOKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhDOKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:02:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:02:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so11760896plh.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zm6WOLpoBupP5HjBPdb3l9pYDvQOSku0pOkw8t2295U=;
        b=j4Iyb3iIzlUmiMrepUSmxPvgLsBjtBUY9oW1JFiiGooOW/MM7tJyI686cDprjLhKhG
         0RxNwyJ6DSqcxWRpM+qG96okUZ00v72RSqY9S38fwz3Y6bQczIUSvLx4H72t5hqWNBo9
         DyhISgnfnVl2NYzMRRsjwRyR/FavV8c3pGIydbSVC8Qb7TLnOEFmZ9qv8iMKxH9Fqzyr
         GIhXpaXZ+tXYz/N7a+fhIWjtR+FCjUNL58PUn7yHtrodKkmvhHxYa5+08EjEGRO9XiV+
         RW+oTqd1p+ecNFZDRpo+NpNk1Okp1hnmYKO+q85wyrTk3COEVbqsYzi/pfFxCcAuNXUu
         zWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zm6WOLpoBupP5HjBPdb3l9pYDvQOSku0pOkw8t2295U=;
        b=mNOYsc8yPvXG4PjCbfdWFV9v/MpYBg5lUZEaqIz44N7RU9wCZ5+yN9PL3Ki2KDYJBN
         vnxx5WT/1lOsWm7pZG3Hm1veIuaRO4e7ZJYxXyJjNlZyabXUqhFg5EQeuGPMtbkkc4fy
         Gl/4iWT1vlK//pyofO7KVEk1L6CPxPhWE4BqUV8cyOlJ+2uQIkHa9aOp6zlcRyXQo6x8
         JH9sBZ5UTXU/AaWruqIhBrNPIEErdyz/e3wD3vp9ZyAuwlfveYM+vCjdgv0XEjrL8XVV
         r2Of9n98D5t0/nWx56W1OOCJPlo/FbWyZwLN464ydADFQv5Jq4zcXqd1iA352mUz0yX8
         brBQ==
X-Gm-Message-State: AOAM531nfG55sDhb9fHhQalL8ClPbTNZ4H1en2O727GjIXJVo+b7BqJi
        CDy05f5YQQixV1Pa7Po/amxHyhzMOSLm9Bfx27fEPA==
X-Google-Smtp-Source: ABdhPJzIqo/dJxuaB4eMFPaHL4ZYJTOustyDLlI9/weAm8+moE/xsKoxTvOPspHWx9D3rPi459BckDQzTdfnDVLt/eI=
X-Received: by 2002:a17:902:ea93:b029:eb:65ee:ddd3 with SMTP id
 x19-20020a170902ea93b02900eb65eeddd3mr3020294plb.24.1618480936088; Thu, 15
 Apr 2021 03:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com> <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
 <CAMZfGtXBqxxgNaB5dcNGvtoH7Gn-1+Ara1YOGS-OahNXaExhsQ@mail.gmail.com> <YHcrRMsmrXd5n3oQ@cmpxchg.org>
In-Reply-To: <YHcrRMsmrXd5n3oQ@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 15 Apr 2021 18:01:38 +0800
Message-ID: <CAMZfGtV8eKE4JP3wqzy2YhQ2McxE-36jJm=8yi1geGbT6ps=rw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 1:49 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 14, 2021 at 06:00:42PM +0800, Muchun Song wrote:
> > On Wed, Apr 14, 2021 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 13-04-21 14:51:50, Muchun Song wrote:
> > > > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > > > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > > > lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> > > > page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> > > > of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> > > > to simplify the code. We can have a single definition for this function
> > > > that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> > > > CONFIG_MEMCG.
> > >
> > > Neat. While you are at it wouldn't it make sesne to rename the function
> > > as well. I do not want to bikeshed but this is really a misnomer. it
> > > doesn't check anything about locking. page_belongs_lruvec?
> >
> > Right. lruvec_holds_page_lru_lock is used to check whether
> > the page belongs to the lruvec. page_belongs_lruvec
> > obviously more clearer. I can rename it to
> > page_belongs_lruvec the next version.
>
> This sounds strange to me, I think 'belongs' needs a 'to' to be
> correct, so page_belongs_to_lruvec(). Still kind of a mouthful.
>
> page_matches_lruvec()?
>

I prefer this name. If you also agree, I will use this name.

Thanks.

> page_from_lruvec()?
