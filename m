Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09F932FFAF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 09:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCGIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 03:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhCGIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:39:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6EC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 00:39:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i14so1435059pjz.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+ZIdAEa9OwEkxgFcDiKNp4vM+KvSh13doJNbkRyCBk=;
        b=xhjBKjSuF4exEfCWDp7cl5chAnIppGTTfOErwDX9TjXEDszpoQHxnheS0lDw/Px0GD
         auYjkp6xPVobYtnb3S5RJvK1McAT4Kx8vX4xO0J6pWGev71nx7MLrRcp9ZqpAlqWMnk8
         41yZTr35QJIAv3pOKBlvutH6ZCYXbZ15BFgpzWEx2GQ9Uan85hsZnr/bHfrhoWR3tJma
         m/nPKyAxWAJDS1igXcKnuHQqeOB5PMan3Ob/2UMVY0BpFi3ftw1E3U45qkzFTRrU9FYD
         +ykdzS8Ay9pxLZL1cZRHxyvyJaE+C2SsxklsIxZOcXdbIZMFb3GflqrqWxIcpuSctdqQ
         3/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+ZIdAEa9OwEkxgFcDiKNp4vM+KvSh13doJNbkRyCBk=;
        b=LqQblhAXkcDZj/FDJcA9/Fn2esmjy52y4RcaUdGnA80/MTbW/5BEyjCzLW1KCYfxCv
         rq/gYmQafnbvKb8cD2c74as8z2A8l3cZVMhVrApWWAkz1K7R/cGE8ReYGSDqgMVZB0b3
         +WSYi34f86S+LmvCetV/AYzwgzpywl2krDfXjZxfNJHrIeVWExYjKmPnaUGiQl2VIy1c
         Led6V3y0NsThzfoeuLCfbz2qnlAqD09vHrtB8F1NBtYVRoIH3lN+tJnRyjANuD2uy7IA
         X0okKoPDrPQEXc4+UElg+vnG6xxkMkKL4UogrRJwl4tJDw44Ch8mSr7yW9FM0W0iGACX
         QPEA==
X-Gm-Message-State: AOAM532d7Wr0pBmsdUAtjzp+FNXxA3rHHmS64zUv0CA2Fz0eBXXJg08i
        k4BRKvXOjDOYspCkhLRCX6q4PeMFIBe7SZPn3egI1Q==
X-Google-Smtp-Source: ABdhPJzYu4GAe2KZbj6JGQ3TjLW4bhjtDiKLF8LYik5ilaN940EpS0CUXvYX1AmTwVvRaeE70SCqKvP8wVhLrFQc8B8=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr18672246pjk.229.1615106383749;
 Sun, 07 Mar 2021 00:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-6-songmuchun@bytedance.com> <20210307081857.GE1223287@balbir-desktop>
In-Reply-To: <20210307081857.GE1223287@balbir-desktop>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 7 Mar 2021 16:39:07 +0800
Message-ID: <CAMZfGtUjDj8e9tW2dum+JSMo-BQ5YwPo+Am4ixndkMKaCuG4gQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 5/9] mm: hugetlb: set the PageHWPoison
 to the raw error page
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 4:19 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 09:21:26PM +0800, Muchun Song wrote:
> > Because we reuse the first tail vmemmap page frame and remap it
> > with read-only, we cannot set the PageHWPosion on some tail pages.
> > So we can use the head[4].private (There are at least 128 struct
> > page structures associated with the optimized HugeTLB page, so
> > using head[4].private is safe) to record the real error page index
> > and set the raw error page PageHWPoison later.
> >
>
> Does the hardcoding of 4 come from HUGETLB_CGROUP_MIN_ORDER, if so

Yes.

> do we need to hardcode 4? Also, I am not sure about the comment
> on safety and 128 struct pages

We can set head[4].private only if free_vmemmap_pages_per_hpage(h)
returns true. In this case, there are 128 struct page structures (we reserve
2 pages as vmemmap pages, so 2 * 4KB / sizeof(struct page) == 128) that
can be used. Instead of hardcode, I introduce another patch to make the
code more readable. Please refer to patch #8 in this series.

Thanks.

>
> Balbir
>
