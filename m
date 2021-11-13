Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6744F3C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhKMOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKMOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:51:41 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E33C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 06:48:49 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l19so11926361ilk.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 06:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mT2wqWAbGXye/oOAJu7JszLtZ2k9E4RwfAiqc/hqR6s=;
        b=bKzsmtg8WGNurTIyAuveG62Gvo6HVFivXIQTq6AvIcD9voJK5p0+nHRx/2HS1sY9EN
         PCJR4whf6loIXngAWLEVCfYaeBxdZvQ2jMblyOnkITsjzjvJ3cRyDlvo4nGbdn/8L6Mt
         TGQ+aW0Ss9cDpJk80JURiWkK4MGgrpzQwkpPihtU6EpeCsgcqS6wPAs05a8Bhq6tYaHp
         AUX8xJNNAEZpEd9Bl2F/skHCwo1ZVt+qmtbTIxxiN6uKpRBKUHAjBedsjujxbFF/PHTJ
         ijjaOV6KzQ/0FOtmDbu3CxVd44LQewg1ADvdNuwglpuZi21rhMwD1EqG4kVujZOy2bLV
         C8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mT2wqWAbGXye/oOAJu7JszLtZ2k9E4RwfAiqc/hqR6s=;
        b=A/osgni25styz3WFpLeF1S87zwo8Z2pTTfFG9qH92Trg0azoEQxNWnI7eNL24+kM1P
         I65pkGo5N/7+/vllGhl/ySmwHBtAWlyWOIDJ9XNveysJyzaLML3kSU3afFfGRDHQie74
         tFWFaxnJhbnb/RRorcKUIzIpRDGwWjPFmfoKjz6AnR9TJ1K8RePb1/HjkjArTHYajN9Q
         VTe6Z4whL9KtQKdoBh+Rg0jSmvotKiGui7eUJiTFY0tbTlyIQe3O04rDoC0uir2FrmYP
         aZ36crxqrg8ahkrZBivYObq5xPZ3xv5juyrgOVDl0WjBXte0ycoKOFO4/JO9nm5fhFlC
         btbg==
X-Gm-Message-State: AOAM530D+WFW8HQe0IGV5k+g60CHqDpGMVAijNGtdO9m6qxiI44UJyCE
        +gXl4kwRfxy4hQM5X3v2QcKVwCX5i75Nw4f8PO4/aw==
X-Google-Smtp-Source: ABdhPJxMgSs399iXe+1qXlJc43lDzixP1TRp4F/RUxvdwOET1jBQYUIjsUjent6vHHJLGucIW7LQ1VFRsjHX10geASo=
X-Received: by 2002:a92:c5a1:: with SMTP id r1mr13480189ilt.228.1636814928145;
 Sat, 13 Nov 2021 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
In-Reply-To: <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sat, 13 Nov 2021 06:48:37 -0800
Message-ID: <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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

On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.com> wr=
ote:
> >
> > Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
> >
> > To:        Muchun Song <songmuchun@bytedance.com>, Mina Almasry <almasr=
ymina@google.com>
> >
> > Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah=
@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@=
suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.c=
om>, Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>, Yang Y=
ao <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews <ca=
nnonmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.org>=
, LKML <linux-kernel@vger.kernel.org>
> >
> > Bcc:
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> > On 11/10/21 6:36 PM, Muchun Song wrote:
> >
> > > On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.com>=
 wrote:
> >
> > >>
> >
> > >> +struct hugetlb_cgroup_per_node {
> >
> > >> +       /* hugetlb usage in pages over all hstates. */
> >
> > >> +       atomic_long_t usage[HUGE_MAX_HSTATE];
> >
> > >
> >
> > > Why do you use atomic? IIUC, 'usage' is always
> >
> > > increased/decreased under hugetlb_lock except
> >
> > > hugetlb_cgroup_read_numa_stat() which is always
> >
> > > reading it. So I think WRITE_ONCE/READ_ONCE
> >
> > > is enough.
> >
> >
> >
> > Thanks for continuing to work this, I was traveling and unable to
> >
> > comment.
>
> Have a good time.
>
> >
> >
> >
> > Unless I am missing something, I do not see a reason for WRITE_ONCE/REA=
D_ONCE
>
> Because __hugetlb_cgroup_commit_charge and
> hugetlb_cgroup_read_numa_stat can run parallely,
> which meets the definition of data race. I believe
> KCSAN could report this race. I'm not strongly
> suggest using WRITE/READ_ONCE() here. But
> in theory it should be like this. Right?
>

My understanding is that the (only) potential problem here is
read_numa_stat() reading an intermediate garbage value while
commit_charge() is happening concurrently. This will only happen on
archs where the writes to an unsigned long aren't atomic. On archs
where writes to an unsigned long are atomic, there is no race, because
read_numa_stat() will only ever read the value before the concurrent
write or after the concurrent write, both of which are valid. To cater
to archs where the writes to unsigned long aren't atomic, we need to
use an atomic data type.

I'm not too familiar but my understanding from reading the
documentation is that WRITE_ONCE/READ_ONCE don't contribute anything
meaningful here:

/*
* Prevent the compiler from merging or refetching reads or writes. The
* compiler is also forbidden from reordering successive instances of
* READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
* particular ordering. One way to make the compiler aware of ordering is to
* put the two invocations of READ_ONCE or WRITE_ONCE in different C
* statements.
...

I can't see a reason why we care about the compiler merging or
refetching reads or writes here. As far as I can tell the problem is
atomicy of the write.

> Thanks.
>
> >
> > and would suggest going back to the way this code was in v5.
> >
> > --
> >
> > Mike Kravetz
> >
