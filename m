Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AC32D86E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhCDRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhCDRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:13:50 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40115C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:13:10 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r25so33290214ljk.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFk60/R93j/Ir+3OsIDPm87BVki6b+umgOzaexWfu9Y=;
        b=ipdNXv2W0+m0TzGiGZv/k4LwVFCEWWmyFxoH/AYPwJo5e7snO6Lo6WhFIf4StYPudv
         GF9t8QFsvY8w/m8QsKaAe0JtnyI0ZJu5wRBt06IVJepz0mdCB+sbU1pTGeIhTSV3Uo3t
         vhbPl5N0Dsl+fvA8jy4KGdhnFFRyfHlAlW2C1NycxnBBiNxtGh0trXgrjheABWbzzsof
         3fXEIY1DSd9tR61ancM308v6eKm7y1ZzOTwT5dxGaUcNRgiJ+JsA96KnOafSct7wzL/n
         C5xuzppV407zHw2hxKpg8PpdWFTC+RdKXnxOam+nmXN1eVa6X7ttbeaX6q8YdcGBMNos
         aotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFk60/R93j/Ir+3OsIDPm87BVki6b+umgOzaexWfu9Y=;
        b=iPivquDBK5YBH9Sh8iWCd8SDjDrMfVOXTjg9OngLfzSWOXPY7L5MCAJM2iRPqiUFT5
         PcZojDJKKvvkjwCBNXv8YYkaV4Qjoa0l5XPVL3nVqrO/DoUCiZELMboaiF0HdzXwP+X+
         hIc/tEQANI6Zb7MIoA8gGnlRZT+eJiUak/Xd7doAWrKHdPKhVLjbKAD8nJgYmBkK4VOV
         dI7+eTY3GEqyPJfTnCTrVFqpaCWVzpmsW/KoYsMvCL9UzqdnkcqBu4tOgwJCqwY8MNmT
         rH1DFzGiXT+I3hOJa1KsrvvGBSrBo6Wyi2pddlsYgfRKRJgW2/qaQ7j6j/PvCxiKkF7W
         jyWA==
X-Gm-Message-State: AOAM531Fs6gHWjYddUNQQKbhdIJwI3OAYfWi15LN3sx8GpzD5mg69aX2
        g92ye5B1NnzSETbpnvi38Oe6fCOZwVNh6lR25My0/Q==
X-Google-Smtp-Source: ABdhPJwd/9rGKR+1GgvpMgGk8rXue/ZLv08tWsIm+I/pEInOeNK57UG4fTTeUXVNpCEnlOZUqQgjLqVDgQntILSRdBk=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr2891774ljj.34.1614877988461;
 Thu, 04 Mar 2021 09:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20210304014229.521351-1-shakeelb@google.com> <YEEBTm/NIugjQWG5@cmpxchg.org>
In-Reply-To: <YEEBTm/NIugjQWG5@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Mar 2021 09:12:57 -0800
Message-ID: <CALvZod5TjuOjLN6FWvMvwFHC2BaGg=3+yuaCdnp-DfabUioQVg@mail.gmail.com>
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

On Thu, Mar 4, 2021 at 7:48 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Mar 03, 2021 at 05:42:29PM -0800, Shakeel Butt wrote:
> > Currently the kernel adds the page, allocated for swapin, to the
> > swapcache before charging the page. This is fine but now we want a
> > per-memcg swapcache stat which is essential for folks who wants to
> > transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> > swap counters. In addition charging a page before exposing it to other
> > parts of the kernel is a step in the right direction.
> >
> > To correctly maintain the per-memcg swapcache stat, this patch has
> > adopted to charge the page before adding it to swapcache. One
> > challenge in this option is the failure case of add_to_swap_cache() on
> > which we need to undo the mem_cgroup_charge(). Specifically undoing
> > mem_cgroup_uncharge_swap() is not simple.
> >
> > To resolve the issue, this patch introduces transaction like interface
> > to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> > initiates the charging of the page and mem_cgroup_finish_swapin_page()
> > completes the charging process. So, the kernel starts the charging
> > process of the page for swapin with mem_cgroup_charge_swapin_page(),
> > adds the page to the swapcache and on success completes the charging
> > process with mem_cgroup_finish_swapin_page().
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> The patch looks good to me, I have just a minor documentation nit
> below. But with that addressed, please add:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks.

>
[...]
>
> It's possible somebody later needs to change things around in the
> swapin path and it's not immediately obvious when exactly these two
> functions need to be called in the swapin sequence.
>
> Maybe add here and above that charge_swapin_page needs to be called
> before we try adding the page to the swapcache, and finish_swapin_page
> needs to be called when swapcache insertion has been successful?

I will update the comments and send v4 after a day or so to see if
someone else has any comments.
