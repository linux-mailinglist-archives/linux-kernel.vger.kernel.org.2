Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4B44F0DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 03:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhKMCsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 21:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhKMCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 21:48:11 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177DC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 18:45:20 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e136so28564400ybc.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 18:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWWGJ2bSIzx6ZQI/hIj2QOWLmreuvhZZr/DXZdLo9fM=;
        b=DRNlPSbPYnBu1vVs+yuGRo1MofzLumdbIreZL7hwabCMT428dc2HlfwS1A+nmfQb42
         5JUiNBia2k6ZDjfSi5rWefIr+NMz8BwT9rRiZFLXrIu6s1LLPXL67I3cH+MtaQ4W7NTj
         V5SHXL+5o6u1WKyBgPVs/eHc7YFQkKl7eZlWe9Ub7ahcqDEwFDsWmuROyll3+bSwjgpU
         CRuGI/wrPwTLW8JxPutgfjis8eu33zN0VWUg7lMO4scWZcO96djZ4wgA6liUHM9vfupb
         LPMeQDxcEKn2GRI1LQr7NLUpPY0Pn3jfIMC8hcM1wuaBCMXqMDVoYDsi8dZfedpGsMhf
         WR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWWGJ2bSIzx6ZQI/hIj2QOWLmreuvhZZr/DXZdLo9fM=;
        b=cP0moXyunf7bDtV2y4jvjJdF5eesBM0vBDOwTXwee+y/b+PvOJJo9BOwM6I4krLxik
         bXq/qpxTR0052HzdAPePGJ79faxQofyq7uedTki1Fk3JukpIUasglEOHMZvLQlmv/DZs
         fp9Oox7W8fJc8RuXN9E9atQ48dbEhvxF/6Ou2t+VRmZgviBw+XmsBjIV/27WsF+le0XN
         h08C5Z4lBh5ybqfyEf3AY4vPhC9cj64u/mrH+Cue50SN8P91nJdwV3vq+/Rbh++qjqst
         zFVA7JoTkkyz2REnergmnCY58RR+2zwjFvs8YoVz2oap22q2Igu+KpKq/+ZwhzGynOX2
         Yblw==
X-Gm-Message-State: AOAM5318h2zvn1LtWGhBZZKT1QwydIuPuRsrgjql8fW3fhxcu+adn/jm
        g3yRSFCYbSbEPtqxushW7EZiFzInNT86XYJm8XLU5w==
X-Google-Smtp-Source: ABdhPJxov/ZfVmDPDIOb0pU3NO/b9DAw7w8pfg1RuWVaj1GRMDMcmVDRaBWxYwdwmQUxPi35zIdUZf731YgQxJGZ0Mg=
X-Received: by 2002:a05:6902:68a:: with SMTP id i10mr19994226ybt.340.1636771519444;
 Fri, 12 Nov 2021 18:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com> <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com>
In-Reply-To: <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 13 Nov 2021 10:44:41 +0800
Message-ID: <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Mina Almasry <almasrymina@google.com>,
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
>
> To:        Muchun Song <songmuchun@bytedance.com>, Mina Almasry <almasrym=
ina@google.com>
>
> Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@k=
ernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@su=
se.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com=
>, Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>, Yang Yao=
 <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews <cann=
onmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.org>, =
LKML <linux-kernel@vger.kernel.org>
>
> Bcc:
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-
>
> On 11/10/21 6:36 PM, Muchun Song wrote:
>
> > On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.com> w=
rote:
>
> >>
>
> >> +struct hugetlb_cgroup_per_node {
>
> >> +       /* hugetlb usage in pages over all hstates. */
>
> >> +       atomic_long_t usage[HUGE_MAX_HSTATE];
>
> >
>
> > Why do you use atomic? IIUC, 'usage' is always
>
> > increased/decreased under hugetlb_lock except
>
> > hugetlb_cgroup_read_numa_stat() which is always
>
> > reading it. So I think WRITE_ONCE/READ_ONCE
>
> > is enough.
>
>
>
> Thanks for continuing to work this, I was traveling and unable to
>
> comment.

Have a good time.

>
>
>
> Unless I am missing something, I do not see a reason for WRITE_ONCE/READ_=
ONCE

Because __hugetlb_cgroup_commit_charge and
hugetlb_cgroup_read_numa_stat can run parallely,
which meets the definition of data race. I believe
KCSAN could report this race. I'm not strongly
suggest using WRITE/READ_ONCE() here. But
in theory it should be like this. Right?

Thanks.

>
> and would suggest going back to the way this code was in v5.
>
> --
>
> Mike Kravetz
>
