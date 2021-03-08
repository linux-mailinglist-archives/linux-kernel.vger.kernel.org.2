Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756983313FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:01:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1609C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:01:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4234680pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ru9F9a1RhouEc909fqeCnbgCPw/G1uUji7fWjGwbaOg=;
        b=KKzp7+2SxHvXKPm1hyNkSAS7wxCgpnIjs1BUg20f0lPhBFp1IwyvcGE9m1bS56w7pk
         UOjdqzl9K9fIHu/lWBWufp7mPBkQL5/ZPaNhkgX0mnrNbbNwsr0mYEscwDYCxRLT3pCL
         UU03On7NfppXE3EzohKRuSxc6kX8F6v+nwYrrmnhSjPDTF3rAfBk3ks50GkR3mkBFzmB
         CHhl8v2QyvstKFf7hBguIfVwJo5soU/Kxszgf6qVx0lOUBN792/5QGQafjrbxg3W7WlZ
         82jem2xrjSmHToTgIkT4PNW+7XsduwkpKileEg8U9OtO8Mktf2mepoCjyKGENpI7N3ha
         Rq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ru9F9a1RhouEc909fqeCnbgCPw/G1uUji7fWjGwbaOg=;
        b=n723w3aQwz12Rk1Md+f1QURYgIMnQNeHXvEpuqhr1NB5BWfKh3Z0mN1qVFg1niLN92
         syYRJ9gAkLVaafeTQDbU3D2H7o/khFvrxdobz9vQ3t98w8ukUG5lCg8ao89sTD1UHuuh
         NP71MRILok5gqVbnugj33aPOojBl2dJgS5p9qp706Cec4o6+eUbFpZFeMumrXZj7SKW+
         2TL48inCAZWcp9z5RKmFtzXjkQbZuUONXM4qADWQeJRB/MMpYp4z9E9dFAgNTJfC9e78
         wR+sdIpErLTSOTgv+S43wGxc/S0YsRcZKWQW428QepzuftYCSX2FJCqhSMIiKLH8dU19
         XAbw==
X-Gm-Message-State: AOAM5312LVbqjCnz3Y1/Fxzz923moooMf9IjQ7pf3/0T0iqy1N29NBKY
        JeD9JAwitzWcVrNHeggs9Zk=
X-Google-Smtp-Source: ABdhPJzEHivhZGe0/lB4cl+Z6AdcbpAosHSCSJInwdwzqUhIxbU10GipAmvszvlmpOIPX/dWtTH4Rg==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr3800865pjp.166.1615222874153;
        Mon, 08 Mar 2021 09:01:14 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id y9sm4956495pfl.201.2021.03.08.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:01:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 09:01:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEZYVkWV+qygPkT3@google.com>
References: <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
 <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
 <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
 <YEZJk8YpUypT7q/j@google.com>
 <YEZPG+9ql2j8O9QS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZPG+9ql2j8O9QS@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:21:47PM +0100, Michal Hocko wrote:
> On Mon 08-03-21 07:58:11, Minchan Kim wrote:
> [...]
> > It's the dynamic debugging facility
> > to enable only when admin want to use it. Otherwise, it's nop
> > unless is't not enabled. Furthermore, it doesn't need to invent
> > custom dump_page implementation(including dump_page_owner) by
> > chaning pr_debug.
> > Could you clarify your requirement?
> > 
> > https://lore.kernel.org/linux-mm/YEEUq8ZRn4WyYWVx@google.com/
> 
> I am not really sure this is the right way to enable dynamic logging.
> Maybe it is. I thought we can go with something as simple as pr_debug.
> You are right that we do not have dump_page with the kernel log level.
> This is rather annoying but a) do we need a full dump_page functionality

Most parts I take care of are

        pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
                        page, page_ref_count(head), mapcount, mapping,
                        page_to_pgoff(page), page_to_pfn(page));

        pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
                page_cma ? " CMA" : "");


And dump_page_owner which was super helpful to find GUP places.

Looks like most of dump_pages.

> and b) can we make it log level aware with the dynamic debug
> infrastructure preserved? If not then then an explicit handling is

If we could make aware of loglevel, we need to enable each by each IOW.
IOW, what we want to enable is mm/page_alloc.c #1492 line, for example.

However, we should enable 
  mm/debug.c # 88 line
  mm/debug.c # 102 line
  mm/debug.c # 121 line
mm/page_owner.c # 448 line
mm/page_owner.c # 450 line
kernel/stacktrace.c #32 line

And so on. Furthermore, user should be aware of that how the kernel code
is changed for those all sites and reconfigure and follow new added
code.

So, I choosed explict handling.

> probably the only way and this should be reviewed by people who are more
> familiar with that framework than me.

> -- 
> Michal Hocko
> SUSE Labs
