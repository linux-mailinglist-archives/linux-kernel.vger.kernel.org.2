Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59426459A28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhKWCki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhKWCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:40:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C631C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:37:28 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x32so19208660ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nTPvXtzHv6HZ++mcRaXSOv1XKXnEa9rG+SSlC7lYWhE=;
        b=bHQq0Hd9I+/x8g1ZiZ0Z02M8FM3ZseM/4YkRg0DgwRAubOxI1F66GBSSnLposQ8q4Y
         ZM0VPxfaLVAhZuZw4o9hBxpIt8KQSF3bp39N5GJlruPuG9tmzZGTUvjFK39kInRaraMF
         7rwRsQKa4eu8zoZeZpq+NT+Wc6ZCWPxsHKnsf7Etw+JKv0aHa6BQ4gR3yjYGPvqRyD0r
         lsTm+CQQZ6wOPt5sNrS35Niz2aKBkxQ82ky0RbYVnCYKTNTMVM0rLM40UaLtTSNSxU1n
         VnqNWPUsrC9P9yN1kZh8AnqaIvybNdmzYY6Wm9B0BU9lYhN5bDHT5XVpKPD84TjCOUjU
         HrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nTPvXtzHv6HZ++mcRaXSOv1XKXnEa9rG+SSlC7lYWhE=;
        b=BOv3DoSi8ZRKp8p7Olhd8ZaqMxilgP0fwl8ZhXM/QE8hDWBW2JJR36gvCDnJKMbZUy
         ARwmZtQzH9QlT+WmR9DfrDv0UALBcZRprTzNphSnsLNG5bU4TrliWX+4zRMDyuBVSUE3
         TAlkRiQNFaqRhTHAZDuxhR++8y3JnO1pucX38N7WamgeDfsYCYM3bxxAS4JiQbeWb7l8
         v5JuKOTYpDfKKsyJnuAZM/bbdY+fm0Ov5pQre9p5PCzmv9Z3bGXUAfE2wKk3jmNDCCSi
         WrjdwUt/3Qq63kAoj7i5NQMpbW6B9F+5NktR6er0cRjILOzqtBFlhgy7w/9/HOxW5HOO
         MghQ==
X-Gm-Message-State: AOAM530IJSDAKyl+djlonGnxD4bL19Sldf3DxmRcJ9anU/+cB57vGw8r
        ZpoCJjl5ZNew8x3cmTaZV5nNZ0oCN6dcb4rQfLJrHg==
X-Google-Smtp-Source: ABdhPJyQuU6bla0tWR3Wxzlsd9NTbOuv/DnOYWhHE+zyUPIdWOhzHxoMxpfXFikXiLUYEMuzoAGwd/Vz1Gd5l2N773s=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr2434493ybu.404.1637635047527;
 Mon, 22 Nov 2021 18:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20211123001020.4083653-1-almasrymina@google.com>
In-Reply-To: <20211123001020.4083653-1-almasrymina@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 23 Nov 2021 10:36:48 +0800
Message-ID: <CAMZfGtVe9oeqz-E2kquodD6JPvt=2qkpU4E0T6OgSu4_3PXQhA@mail.gmail.com>
Subject: Re: [PATCH v8] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:10 AM Mina Almasry <almasrymina@google.com> wrote=
:
>
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
>
> Currently this technically can be queried from /proc/self/numa_maps, but
> there are significant issues with that. Namely:
> 1. Memory can be mapped or unmapped.
> 2. numa_maps are per process and need to be aggregated across all
>    processes in the cgroup. For shared memory this is more involved as
>    the userspace needs to make sure it doesn't double count shared
>    mappings.
> 3. I believe querying numa_maps needs to hold the mmap_lock which adds
>    to the contention on this lock.
>
> For these reasons I propose simply adding hugetlb.*.numa_stat file,
> which shows the numa information of the cgroup similarly to
> memory.numa_stat.
>
> On cgroup-v2:
>    cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
>    total=3D2097152 N0=3D2097152 N1=3D0
>
> On cgroup-v1:
>    cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
>    total=3D2097152 N0=3D2097152 N1=3D0
>    hierarichal_total=3D2097152 N0=3D2097152 N1=3D0
>
> This patch was tested manually by allocating hugetlb memory and querying
> the hugetlb.*.numa_stat file of the cgroup and its parents.
> =EF=BF=BC
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Jue Wang <juew@google.com>
> Cc: Yang Yao <ygyao@google.com>
> Cc: Joanna Li <joannali@google.com>
> Cc: Cannon Matthews <cannonmatthews@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
