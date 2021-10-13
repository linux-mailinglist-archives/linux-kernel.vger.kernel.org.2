Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99242C7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbhJMRcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJMRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:32:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6465C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:30:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z11so14326337lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQOoabUNu0R7IbgTfWQ9QRtHLdgX6BHbDT/1BhoTe9M=;
        b=btRQMBymcZokHMewh1RWraDTkJdKm+n2ddZG7Lw2znxC/GSJbWy87egZvb6rXSdldy
         IDXCUqPWaFPmQafIM46OPWdnNjB9VuaJcU33bm66NfS7PNnHNh1b+TblPKadHz2CoEMD
         OePatUFeM/gA764CLWpwIycRbUOXojpKlgVbJwF8yAqXJsZil9DrYE602MkiWjzKEAiV
         JxApHT16J9oA9iZW5O/MGbMxz40m7i6boNVwWnxXxV4GLBMC9wMEpT1pvXcbwFxSBbU1
         Vg8PN+eyytYs/gund8DNu5b4r0AxEaZ153lRDvRPVV4ruMrlDJeTr+sbnEsxtXA9oiOC
         gwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQOoabUNu0R7IbgTfWQ9QRtHLdgX6BHbDT/1BhoTe9M=;
        b=Dp9ayOiexDlpF/wCOOSKiRIt8XcghANJFE/468hojaawIA1E8bkt+6Y57EnrPYz/wa
         Sw5EreS1R2JR+0QC6gOGaJ9sIjvCtyDWzbX4QokYV9DiCP9wLD+k21Nb146hCFSPL9Sf
         frqjmwKY/nT9f3rWVd6ITAZl7jyp4OLN324ZgQhgxrYrfy19Z85cYyved3ooX/k4E1dm
         6oyjZFVRps9h+dfcNK5yMX6zBxG/mHEd0GRLQR5SaWzhOTbj6CLBG9FZsrzfJz362TOc
         Do7yTQIYzfk4GJu+ozqZP3sSrDduqdvBFzIU5vYKEmX+5Q23JEX35gCK41IR/xrOg/9w
         JZ/g==
X-Gm-Message-State: AOAM530UFtO00Cz8KWtzAfnoPn7zNWcGbdJC3UpMaXDmAusxi+HyQNru
        yZwOXXzVFx3Wtn/USTMdhXilChwfKieuCCh5zlxjRA==
X-Google-Smtp-Source: ABdhPJwBVo0irDBA2p+/ESUMoecZY8cZKZzIBcJI3jBVFqJ0bJoi/XVS3EPY/CfSxfGkwfEteH52y76Fxi9rAACnhkU=
X-Received: by 2002:a05:6512:2204:: with SMTP id h4mr315095lfu.494.1634146216834;
 Wed, 13 Oct 2021 10:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com> <YWWrai/ChIgycgCo@dhcp22.suse.cz>
 <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com>
 <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz> <CALvZod6K6UXxDrkHp=mVDV7O-fAtmRkgMDngPazBhcyDUNxy_Q@mail.gmail.com>
 <YWcUbXfBsbNzYIad@dhcp22.suse.cz>
In-Reply-To: <YWcUbXfBsbNzYIad@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 10:30:05 -0700
Message-ID: <CALvZod5V_NK_mVFY7ik6wSWPxqSqRrhzJkdtuyQjzMB-0yjHGw@mail.gmail.com>
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > > If this is really that complicated (I haven't tried) then it would be
> > > much more simple to completely skip the bulk allocator for __GFP_ACCOUNT
> > > rather than add a tricky code. The bulk allocator is meant to be used
> > > for ultra hot paths and memcg charging along with the reclaim doesn't
> > > really fit into that model anyway. Or are there any actual users who
> > > really need bulk allocator optimization and also need memcg accounting?
> >
> > Bulk allocator is being used for vmalloc and we have several
> > kvmalloc() with __GFP_ACCOUNT allocations.
>
> Do we really need to use bulk allocator for these allocations?
> Bulk allocator is an bypass of the page allocator for performance reason
> and I can see why that can be useful but considering that the charging
> path can imply some heavy lifting is all the code churn to make bulk
> allocator memcg aware really worth it? Why cannot we simply skip over
> bulk allocator for __GFP_ACCOUNT. That would be a trivial fix.
> --

Actually that might be the simplest solution and I agree to skip bulk
allocator for __GFP_ACCOUNT allocations.
