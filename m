Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7E3141FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhBHVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhBHUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:54:57 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FABC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:54:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id l27so15874179qki.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcpftL0I3Yn/sC6LOBOo9QXXxpF9jls61Dh3UGgrMhQ=;
        b=XGEs+1RNC81c2udolSMD/41WbwHBvqroEIblFLM6gl9MVclTdONeCq1jP0jJVv3DW7
         dqvBGlfkyGoSaJOFPO4C+/KygXrMmF6GgeZV38oFelwD8bYgQ4Y9FaDxTNylaeEkxhxN
         9/wMWF5GLFfZLkCkBzWMoFr2YsBTvzztvlTODSSdkywa0ZqSPz7MMES7R4ORrBwmRXAa
         inRSRsCQhcz07fMpBpDsQUbvvWjmpmN/ObDNeouvOi73LV0BXKKTABmritwmYEUUmzuj
         N6MX+1gkgsjC7cBc8+SIZf6tPoSoD/WIgebrPDZfgKnsLOKOtM1fzFUShy4hNgpDqfjO
         8aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcpftL0I3Yn/sC6LOBOo9QXXxpF9jls61Dh3UGgrMhQ=;
        b=ICJgZOTb+Y9gh/hGuTpvOG5xdmAq40Woi1H/R6vZJinnbXWOYFhZEt5b+JolxjCRGn
         PFGfKfgWW2pwcTF4tg7bEdkYq7ILoG6bt7en5cMx4He84uBDyhaRw+rYKHMgbcVy81ad
         0oebpV/8zI250YO5myuEeknKgWGX7tuOr/f8y6RhNDepJeysIMaLZ33H73mFh88z72Y5
         Okw7jV55kYUq5b+mvogGA25FHKwEt7L5ofVEdTRqun/kQQFfa2KCv33wkQWj4i0SI4N6
         rB/k9EPGYHCnxdYrvCbOz0nK25Z4QDVlGX+m0mLSqvrGOZ+f9KhVgF5a9DBIM4jiXwZW
         K46A==
X-Gm-Message-State: AOAM533FKHk7UVp1yo0WuIt6+THPeL2EOMuBCcZWi9QNP/4Jna0CWF4L
        QIKeCob127lvMVsmh7NNiHoGrQ==
X-Google-Smtp-Source: ABdhPJyVK62aBHf/AAc/vz/JS5ITM85XcG83LzKNHbywrxm4x9GiInjP9DCODQJEYHOwcUsfBKrnmA==
X-Received: by 2002:a37:4a91:: with SMTP id x139mr2049044qka.102.1612817655489;
        Mon, 08 Feb 2021 12:54:15 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 15sm14904060qty.65.2021.02.08.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:54:14 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:54:14 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YCGk9ksAU8+tBv5y@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
 <20210205182806.17220-8-hannes@cmpxchg.org>
 <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 06:28:37PM -0800, Shakeel Butt wrote:
> On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > There are two functions to flush the per-cpu data of an lruvec into
> > the rest of the cgroup tree: when the cgroup is being freed, and when
> > a CPU disappears during hotplug. The difference is whether all CPUs or
> > just one is being collected, but the rest of the flushing code is the
> > same. Merge them into one function and share the common code.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

> BTW what about the lruvec stats? Why not convert them to rstat as well?

Great question.

I actually started this series with the lruvec stats included, but I'm
worried about the readers being too hot to use rstat (in its current
shape, at least). For example, the refault code accesses the lruvec
stats for every page that is refaulting - at the root level, in case
of global reclaim. With an active workload, that would result in a
very high rate of whole-tree flushes.

We probably do need a better solution for the lruvecs as well, but in
this case it just started holding up fixing the memory.stat issue for
no reason and so I tabled it for another patch series.
