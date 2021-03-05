Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBB32F361
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCETA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCETAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:00:55 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CDCC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:00:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n16so5388837lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBJywJ/55SdNNzhqEcBb4hZL99EvDvjWTnWLT8JPIUw=;
        b=RoBRx/Ju+scxCBTVd/KvQrJIbS48I+xnjFvh4bTmMOSNIxQ5JM+JiCXo3NaDckbE9M
         DCZOWmAjHLYlX+7BObWmlV2P6zUj25fU/3weEb+3W5YxaOZgDWeus+AMMuY/jCLgLbH/
         Vpi+6D4B/nRB2tiuuyiNPmfxiMVKU5PB6VhT09Ls9yc41FsKwAwBlS1xHhpAjVwHtXkZ
         NH7VYMRF+Qpbw7xrXRbxVz1JGegIJ1ZstGik6Q8xIWI91LWicEzNIhUkJhwBRiL/9BXU
         lTjrxy8IvulF0o22LYBTRU4oz2GuDEKwqyQgwfFPXW20DoV+1kPFGXVXJT24zB1F4txg
         3J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBJywJ/55SdNNzhqEcBb4hZL99EvDvjWTnWLT8JPIUw=;
        b=L3CnuPnEaXRkPxYHJoYZdQ9Li52ggXSloejR8GJG2qDvKub59szF3e/HRTiSShKSB0
         WEwvK95zwjTIe36NDVRyWPFv/JR1v/b95wT/upcTvfYs92e2ypiAyqMsdpk7F2TVxRZx
         qrZd5YPSTAkQGspi1LfwcqTpaMMcdK64rL5D4l6HAAqO7ordmh5ujTMHvEnnbso7mFDf
         JFUyUut1ud0ZDwsjXOBz3ubWWO/VMtXrlt6vDnGAfhBTR31Zt3ksW2YC92p2V8XyyhO1
         vQIWv3jswZusVpg53MUzEJTBUHmj23rffjanGNeXw7ZDDxah5WqjJS1LDBbNwe20AN8G
         DNzA==
X-Gm-Message-State: AOAM531CR2G80bphQR19khdT3ugxHbR+31toOUsBPrS/UghuQkAAMsLQ
        M6l6727BeW3QHok3xJ3w48Dofz76UcCwMyNktF8fHw==
X-Google-Smtp-Source: ABdhPJzcyA4Nh6MPfMONYL+w0cPJ8mMcfZGWjB1dLulIsm91W7L4R/sQAqp324Jf9O1MEs4981U9YCjiZarO5kbHO8g=
X-Received: by 2002:ac2:4144:: with SMTP id c4mr6344311lfi.549.1614970852892;
 Fri, 05 Mar 2021 11:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20210304014229.521351-1-shakeelb@google.com> <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
 <YEJbZi+tpSATjsT/@cmpxchg.org>
In-Reply-To: <YEJbZi+tpSATjsT/@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Mar 2021 11:00:40 -0800
Message-ID: <CALvZod5Q+jo_FezxZz0XRfMDZ73SSMdHkt_TkB-ab-TY2+XYVA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Mar 05, 2021 at 12:06:31AM -0800, Hugh Dickins wrote:
> > On Wed, 3 Mar 2021, Shakeel Butt wrote:
> >
> > > Currently the kernel adds the page, allocated for swapin, to the
> > > swapcache before charging the page. This is fine but now we want a
> > > per-memcg swapcache stat which is essential for folks who wants to
> > > transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> > > swap counters. In addition charging a page before exposing it to other
> > > parts of the kernel is a step in the right direction.
> > >
> > > To correctly maintain the per-memcg swapcache stat, this patch has
> > > adopted to charge the page before adding it to swapcache. One
> > > challenge in this option is the failure case of add_to_swap_cache() on
> > > which we need to undo the mem_cgroup_charge(). Specifically undoing
> > > mem_cgroup_uncharge_swap() is not simple.
> > >
> > > To resolve the issue, this patch introduces transaction like interface
> > > to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> > > initiates the charging of the page and mem_cgroup_finish_swapin_page()
> > > completes the charging process. So, the kernel starts the charging
> > > process of the page for swapin with mem_cgroup_charge_swapin_page(),
> > > adds the page to the swapcache and on success completes the charging
> > > process with mem_cgroup_finish_swapin_page().
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > Quite apart from helping with the stat you want, what you've ended
> > up with here is a nice cleanup in several different ways (and I'm
> > glad Johannes talked you out of __GFP_NOFAIL: much better like this).
> > I'll say
> >
> > Acked-by: Hugh Dickins <hughd@google.com>
> >
> > but I am quite unhappy with the name mem_cgroup_finish_swapin_page():
> > it doesn't finish the swapin, it doesn't finish the page, and I'm
> > not persuaded by your paragraph above that there's any "transaction"
> > here (if there were, I'd suggest "commit" instead of "finish"'; and
> > I'd get worried by the css_put before it's called - but no, that's
> > fine, it's independent).
> >
> > How about complementing mem_cgroup_charge_swapin_page() with
> > mem_cgroup_uncharge_swapin_swap()?  I think that describes well
> > what it does, at least in the do_memsw_account() case, and I hope
> > we can overlook that it does nothing at all in the other case.
>
> Yes, that's better. The sequence is still somewhat mysterious for
> people not overly familiar with memcg swap internals, but it's much
> clearer for people who are.
>
> I mildly prefer swapping the swapin bit:
>
> mem_cgroup_swapin_charge_page()
> mem_cgroup_swapin_uncharge_swap()
>
> But either way works for me.
>

I will do a coin toss to select one.

> > And it really doesn't need a page argument: both places it's called
> > have just allocated an order-0 page, there's no chance of a THP here;
> > but you might have some idea of future expansion, or matching
> > put_swap_page() - I won't object if you prefer to pass in the page.
>
> Agreed.

Will remove the page parameter.

BTW I will keep mem_cgroup_disabled() check in the uncharge swap
function as I am thinking of removing "swapaccount=0" functionality.
