Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6D44CF75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhKKCIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhKKCH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:07:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52767C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:05:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 13so8917329ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LMNluGg1oD1xxzKztNLmkE+a3kVEZIQ80t9yoqV5XOU=;
        b=K9B9z96JYSZNOVrwDI6C3rzyp1zxt5naT65hnzTktky4X2rUX/4C//Z9RX1wwiloYD
         yTu+RreHY3WWZ/ezTbbOKzlnG9NgfjNlGdjqVe5QFsz/IyPqqi/UDcrBaIH7+lPoNdwQ
         JlqDBpDGBq0SlH7y1GUoBOXpFh4s2qaJ1SLJTEJD9mYhrd074DAbAGNPkDcUQSp/sTHd
         hfHi4ba/20bg5XT4s1iIa+9fUF4HCcRUUK9buvmDMa97OxmyLVTzBWsDlh1KiH0LfT4N
         aH41S1MkfxsvtgfWi0haZMpErOxQivwzPsPV+3j3GFGkRTILGlUmUpsD5lYv0rvU95jp
         3wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LMNluGg1oD1xxzKztNLmkE+a3kVEZIQ80t9yoqV5XOU=;
        b=ttQL95mh/Tdc2RIZPsB9ZrqS16OleliV41+klg/Vm4WNTVp0ImJDLE5uo6sp458zoz
         BshrsX0wSxC2uvkHXkzR6OJtztBF5W+L5PDcMPL9qiRTYhl5Gt74Z5b+3LskW3+ooE+V
         6XuuoaGBX52YS0CBnEaNoiloH/7jqV36MH0QvQJan8dQYbAu0v+uH1+Ds3CLe7qaaIdn
         71mgDgQMWd3gHCOnkWlytsiGC8bOfmSAeNf0nlPDZ6DsiGuKiZ/xfVZow1FoWZSG68qG
         GD/oeIq5//LGi+6MpNOWtIvGXLIJ6OWyznC0fj5DOxeJBYD6IOUYDKFe6v0NBxqhDgfn
         pH8w==
X-Gm-Message-State: AOAM531sscOTCoa6VGQ0NMq2Vr0CxGDtUruv8WjiK5IpZedKMnthTUrz
        6lan7DM/PI3XfAtCdIoMhC+94/4do0ZqbDOzizzE9A==
X-Google-Smtp-Source: ABdhPJzC4Jp+umhzEA3lXMzej2zzbUmTLlT9e9wINZ3YQk5aDo16CUqE2DEpesPxsSM8/hXW01nfIjCtiq+kgOHc+Z4=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr3475095ljp.202.1636596308510;
 Wed, 10 Nov 2021 18:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
In-Reply-To: <20211111015037.4092956-1-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Nov 2021 18:04:57 -0800
Message-ID: <CALvZod4=kf=1oqisM9KxBHNvYbHohZE1ZnTVzq_ub4pLBp0ryw@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 5:50 PM Mina Almasry <almasrymina@google.com> wrote=
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


Reviewed-by: Shakeel Butt <shakeelb@google.com>
