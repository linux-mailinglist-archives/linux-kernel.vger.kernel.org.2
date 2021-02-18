Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81F31EE69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBRSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhBRQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:11:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE0C061794
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:10:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so1580909pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/RqDGUNhoNYq3IBZ52eaMQt2gjuVi91yB+Zi9HnIoY=;
        b=I7rUmNQljY9Jk3djbiDNOojkc4eoNilxIHJ9KUKZjvQsEC0jDer5M0cwdhn8w24b5m
         09ZQ0M6lt/GZj1TS8gbFpixow3S6hEMrr2fOrhpD8huHouISOOzDP3WdkMpWDD1BsagS
         sH/A10O8Ge9LOuuAgJoB28xuhnU8rhUy/sMIiB4IarNb1naKc++OA/Ul8naCmFlyoYhI
         wSv1QW6MLe8opogR82YsgCwa7q97jbryIxqP8a/xO1ZpWtx9A/xTuwY92ogpU8OKpYNV
         x3+8WcNebObNrO4Sp9QeQOI7z1bqUQmI2fT1xpwHVV56N+lXwSAp9mR5vPU0otMPc5xj
         AtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=k/RqDGUNhoNYq3IBZ52eaMQt2gjuVi91yB+Zi9HnIoY=;
        b=M3Vh2KE0Du0keepJL8wzsBIwcUzYiztadTlyHYova/NJfqUyWe3B8+yBPmGMmDMz/N
         x8tHoN5X0fn1PVW5+T7/ftOuA6lnuWwnSkzFEtKL35oxjlsrrp3vVKnggQskAzqOZcEf
         rzz5kM20W6nrG7uVkRlnEOf+mKamt9C4xGVISSC8yhD7mPnsSLVk9BzGMHhJnYhY+fqm
         A3y+m4DMSQlOdAj9XzIAmoOFG94DDyl4wWnFAG5GqSJCem+4kW27bwjmeFz2YD3UVDpg
         4AYPPrIOeqCxitbhKy3m61qzUEkwDwOh0OXPJzZKWojLGYWbvZ7Ft78pbZ+KnSJRvKI7
         GUdw==
X-Gm-Message-State: AOAM531nVPMlY0i1XtITh6AsDxWgGfojpamQFIKUjPxawwdGFT+WwH7+
        i1hAskvJayHYiQOeKmM95V4=
X-Google-Smtp-Source: ABdhPJxzK3s1aFvwRizRfxBz5x8pjjKoHWjP2ahug80JQzM2nsD4pay2JZfUjYxQB7yKwELPepy1Kw==
X-Received: by 2002:a65:458e:: with SMTP id o14mr4517255pgq.444.1613664633349;
        Thu, 18 Feb 2021 08:10:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id g62sm6876628pgc.32.2021.02.18.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:10:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 18 Feb 2021 08:10:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, david@redhat.com,
        joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC6RdvhiEDf0tZnB@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:56:18AM +0100, Michal Hocko wrote:
> On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > alloc_contig_range is usually used on cma area or movable zone.
> > It's critical if the page migration fails on those areas so
> > dump more debugging message like memory_hotplug unless user
> > specifiy __GFP_NOWARN.
> 
> I agree with David that this has a potential to generate a lot of output
> and it is not really clear whether it is worth it. Page isolation code
> already has REPORT_FAILURE mode which currently used only for the memory
> hotplug because this was just too noisy from the CMA path - d381c54760dc
> ("mm: only report isolation failures when offlining memory").
> 
> Maybe migration failures are less likely to fail but still. Doesn't CMA
> allocator provide some useful error reporting on its own?

Unfortunately, it's very useless. :(

```
in cma.c
                pr_debug("%s(): memory range at %p is busy, retrying\n",
                         __func__, pfn_to_page(pfn));

```
even, the pfn is not failed page. 
Originally, I thought to deal with it from cma.c to minimize changes
but it was tough because cma area couldn't get the failed page list.
