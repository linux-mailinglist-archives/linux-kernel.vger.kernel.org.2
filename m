Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9443136D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhJRJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:27:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89F0C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:25:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id z15so9848986qvj.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6G1gDX0KodcT+B+IPaHcSNxCrI3CJV8Wo022zcTGwY=;
        b=Ra8WWSozEac0AuCeiOFrRWfgnppu7WS7DGNDykXOGxBpKM1P9lpzj0zeBRV+r8AAXB
         VGFTxH9IKRhNmKZgsKGUGsI4txUCjgu86skcnWNDN64otXTKjqx4Ta1sQLN/1RkeCTzc
         Tppdw1eP+rBA3NZd+OXQvPCaij5XrGSslvH+uETiD3fOUgfVgaSuYFvs2Pi++HKuQW+q
         wKmrS0UQqrxBPXfs6z3YrRDkdwuSVYUDsvwMIO/lhJJpvU0/zng4eenKIGRd8gxd111B
         Wv1HcmygVlSROQEImkNou0WL06hWkltfwj7XsuvTIKxCI+Nk6APl0idJq/Dc2y/I5W9D
         YfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6G1gDX0KodcT+B+IPaHcSNxCrI3CJV8Wo022zcTGwY=;
        b=QohUyBJ1mkhYLAvQ3BRXxppfXUFxQJ9ots4wXFK9CHLdgN/PpKszyLIcsW+6mQNa6V
         xmqUl52IQ11t/jaqS2z83RcrC6a+y76EbV2BH6gKjpwnfcpEiKDunOW7SWneZTqCVzVm
         wEjKLDeB+sVDEhtW/1BcnrwYJ76QUkPo8OGqjaT//s9ffC5iNSFPruiShzZLF/IS5Ymj
         rQdVw+d2q7gYrzKF8Tb/+hukFF/6Ovjlkg7IbGbDokEMfkgaV+sZRbh4Q2+DMyS6bPy8
         KafRDHjcst4IOie+IjBBgPgxEBXFzkutYzjjN1j7QkgGEsNC38GyVHT7yL4DCebql2g7
         f5gA==
X-Gm-Message-State: AOAM533xqvr97KCM/sgxb1rXXPASAZ8GOGaZeUBF6VVwHfEXcuGexmJZ
        EZol/u/llKH4t2nyDxEAIvYnTQYkoiy//FAwnfY=
X-Google-Smtp-Source: ABdhPJxh7KWyCF/ta4V76CsvEyYDOdY1etMkJj+9Gv3xB9MkugEQQMgU5eo75x/AYAiXImlr0O7LXcyJi9mdnDKuOZU=
X-Received: by 2002:ad4:5621:: with SMTP id cb1mr24448220qvb.6.1634549145111;
 Mon, 18 Oct 2021 02:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com> <YW0u67o8wl3CGikP@dhcp22.suse.cz>
In-Reply-To: <YW0u67o8wl3CGikP@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 18 Oct 2021 17:25:23 +0800
Message-ID: <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 4:23 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 15-10-21 14:15:29, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Sibling thread of the same process could refault the reclaimed pages
> > in the same time, which would be typical in None global reclaim and
> > introduce thrashing.
>
> It is hard to understand what kind of problem you see (ideally along
> with some numbers) and how the proposed patch addresses that problem
>
> Also you are missing Signed-off-by tag (please have a look at
> Documentation/process/submitting-patches.rst which is much more
> comprehensive about the process).
sorry for that, I will fix it.
>
> > ---
> >  mm/vmscan.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 5199b96..ebbdc37 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2841,6 +2841,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >                               sc->memcg_low_skipped = 1;
> >                               continue;
> >                       }
> > +                     /*
> > +                      * Don't bother current when its memcg is below low
> > +                      */
> > +                     if (get_mem_cgroup_from_mm(current->mm) == memcg)
> > +                             continue;
>
> This code is executed when none of memcg in the reclaimed hierarchy
> could be reclaimed. Low limit is then ignored and this change is
> tweaking that behavior without any description of the effect. A very
> vague note about trashing would indicate that you have something like
> the following
>
>         A (hiting hard limit)
>        / \
>       B   C
>
> Both B and C low limit protected and current task associated with B. As
> none of the two could be reclaimed due to soft protection yuu prefer to
> reclaim from C as you do not want to reclaim from the current process as
> that could reclaim current's working set. Correct?
>
> I would be really curious about more specifics of the used hierarchy.
What I am facing is a typical scenario on Android, that is a big
memory consuming APP(camera etc) launched while background filled by
other processes. The hierarchy is like what you describe above where B
represents the APP and memory.low is set to help warm restart. Both of
kswapd and direct reclaim work together to reclaim pages under this
scenario, which can cause 20MB file page delete from LRU in several
second. This change could help to have current process's page escape
from being reclaimed and cause page thrashing. We observed the result
via systrace which shows that the Uninterruptible sleep(block on page
bit) and iowait get smaller than usual.
>
> Thanks!
>
> >                       memcg_memory_event(memcg, MEMCG_LOW);
> >               }
> >
> > --
> > 1.9.1
>
> --
> Michal Hocko
> SUSE Labs
