Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE778451DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbhKPAcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbhKOT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:42 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD4C0AFD71
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:55:53 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k1so17755593ilo.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tSucHjGcT6rkKlRqoilO8gpQKCTFkj/1xgEEhZp5eAs=;
        b=shPjg8V/5u2dqDLkaXzmMZAZMsCcQsR6PFojLDP+XysioiAsZ4MWDBMH6lj/nqs6gK
         gng1bRyO6QvcnTO5lOmQ6W+fJmAbMq4U84LN21NdUpOJ2TZB5iUf/WOZOMIeN3CqxYkr
         IHjlp6d6zLWOSnmsbK5LHmMacY5TAnn2yOu9iGU4BUJdGHzhHKyMsjsOc1lEugx33ZlJ
         MMDWKgTqqpjDhcSTU/d5FYsk3P3mMUlTtDK0R2zHrkggCNZie+YAQPwf4MNanrevjkqc
         uXoPpauDl8mPczO61WBkh+P/51kTrT4iziFFSqwAX75MuRSaSUNqvyAax4bMnnKdg4vZ
         xekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tSucHjGcT6rkKlRqoilO8gpQKCTFkj/1xgEEhZp5eAs=;
        b=IN5PK6ZHDJozFAEeehmIVHrxbakG8kwBucMsatBy5Kob9gXNgOM7+luGHzJrmXK/D/
         OMiH/vO7N1AMdOFDb5yKnrk633MgYE4EMpcCTE6vZhIoL6RuRDgW5XAC50Lp+QnGgofZ
         TbyOZP3Y0NDkxmkNp5GZdr6zsHLqtAmxREsHvZdPsHfIx0HJQHLavE7lGd1BI3Oj5XcY
         2xkDs+ASqdzN3Rj0h+Qf/yY3A2k/E2heMmqJFEM7ru1MPUV8QLjDkJJvCOh+tQ5knjsH
         LxyspqmUI4gCrgsC8LGuAqBemSP5gm8E99QMSIY1yTE/URo96TTD/DrCra90uzkSEq9R
         uVfQ==
X-Gm-Message-State: AOAM530/dWrXw+UjpHFu0lin0GHyWpND/G+HLTLRlZKrwRueQA2JZkjs
        VvsOxH39EuBhUbwlEqgrQNW9eSrRIYBrx7PhZnxPIQ==
X-Google-Smtp-Source: ABdhPJzz/r513GfRNjO6TK5we9g+gjG84Zhlrk5AIOCmQVGEOVogXCQfWGjXf4QWkxK7t8FkTXXsFpZUnaWHoUz7zgY=
X-Received: by 2002:a92:c569:: with SMTP id b9mr714347ilj.39.1637002552537;
 Mon, 15 Nov 2021 10:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com> <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com>
In-Reply-To: <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 15 Nov 2021 10:55:41 -0800
Message-ID: <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:22 AM Mike Kravetz <mike.kravetz@oracle.com> wro=
te:
>
> Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
>
> To:        Muchun Song <songmuchun@bytedance.com>, Shakeel Butt <shakeelb=
@google.com>, Mina Almasry <almasrymina@google.com>
>
> Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@k=
ernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@su=
se.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com=
>, Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>, Joanna Li <joan=
nali@google.com>, Cannon Matthews <cannonmatthews@google.com>, Linux Memory=
 Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
>
> Bcc:
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-
>
> On 11/14/21 5:43 AM, Muchun Song wrote:
>
> > On Sun, Nov 14, 2021 at 3:15 AM Shakeel Butt <shakeelb@google.com> wrot=
e:
>
> >> On Sat, Nov 13, 2021 at 6:48 AM Mina Almasry <almasrymina@google.com> =
wrote:
>
> >>> On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.com=
> wrote:
>
> >>>> On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> >> We have following options:
>
> >>
>
> >> 1) Use atomic type for usage.
>
> >> 2) Use "unsigned long" for usage along with WRITE_ONCE/READ_ONCE.
>
> >> 3) Use hugetlb_lock for hugetlb_cgroup_read_numa_stat as well.
>
> >>
>
> >> All options are valid but we would like to avoid (3).
>
> >>
>
> >> What if we use "unsigned long" type but without READ_ONCE/WRITE_ONCE.
>
> >> The potential issues with that are KCSAN will report this as race and
>
> >> possible garbage value on archs which do not support atomic writes to
>
> >> unsigned long.
>
> >
>
> > At least I totally agree with you. Thanks for your detailed explanation=
.
>
> >
>
>
>
> Thanks everyone.  This makes sense.
>
>
>
> However, I should note that this same situation (updates to unsigned
>
> long variables under lock and reads of the the same variable without
>
> lock or READ/WRITE_ONCE) exists in hugetlb sysfs files today.  Not
>
> suggesting that this makes it OK to ignore the potential issue.  Just
>
> wanted to point this out.
>

Sorry I'm still a bit confused. READ_ONCE/WRITE_ONCE isn't documented
to provide atomicity to the write or read, just prevents the compiler
from re-ordering them. Is there something I'm missing, or is the
suggestion to add READ_ONCE/WRITE_ONCE simply to supress the KCSAN
warnings?

> --
>
> Mike Kravetz
>
