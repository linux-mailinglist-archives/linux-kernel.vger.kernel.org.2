Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF3F31C105
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBORvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhBORts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:49:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54EC061786
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t26so4633844pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0raigWBsW5BmlJVVshcrNYwzQYWZPvQmzq/5zwebTXY=;
        b=fl6FixGKWjTID3qTSaKuX0EgetRR8QBn7aRcT3Xl+UP8cqOr6p3G+iD1eTTf0hu3ak
         +liuII/Gu+qlMZYn4CTSKBRild3fq4iiKeEGL+8b/HMEyTkfR0lxpp1aIyP5MOkOnLHu
         n7mDgFs4eE/SMAqzxJNbxWCbSUC+xHlWEWLG3qrIScMk/bjvOR57kk7nFY7rVn/9UiH9
         g2pOpALQHu/15aB71vd8qzQeiPvr76pUiiibWLdgNXzIRdH3e7uN2WCmTp8lGk/ksYR7
         ZIRk0VV4pwRJE21aYuWDbkXc3kOpnbN0CK8+C727b5npEWm2JsCj1LaBgWNXZrMEv6//
         4r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0raigWBsW5BmlJVVshcrNYwzQYWZPvQmzq/5zwebTXY=;
        b=MPo/EzZcWXN9JSYhNukuIQSsO1KK09DOZxFmUCz5kvd5NP2qEOnrj8V38aMNu+daHz
         VyvlOVb6O6S40ubkVzukwoC8CrbGzwu0wCvGxNg9JJpmLK88NsjsBU19EDZ68Y+QHLTl
         X5ZNaebQPfwCl/NvlPMotC0GLjaY+33h+aLsaJbqPctC1qtLsXKC/8ds6jI0EvrMj6xc
         lsOCmV8bn1F3OCD45eImGnfRKfg+ncSuRrxSMtpQuhnSxL/HCvpgjiijAHDELfDfWzL+
         sQ/ilarLOJzg0CTu4qXcYCeieEQf30NtfyO7WBhow4skDKEwAisKij2E+MicaXZV3kyJ
         0oFw==
X-Gm-Message-State: AOAM530IKU6/aFM6OvddjoYKBMaBRH8INZVU8Bu9A1H380JeNgQ8/zYY
        VAb3XnaU5wBmzFozdOaNCjolcPIozn0AIl6bRkoQDQ==
X-Google-Smtp-Source: ABdhPJz4LqZsDGklbkN4FqRjRy8OxHw8u+JlsWDcM1+xjYoqctmuuXLbOUqvMlpcK78wa9N3DIsalYaZRJP0O/OTh7o=
X-Received: by 2002:a63:480f:: with SMTP id v15mr15739656pga.341.1613411345880;
 Mon, 15 Feb 2021 09:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-5-songmuchun@bytedance.com>
 <YCafit5ruRJ+SL8I@dhcp22.suse.cz> <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz> <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
In-Reply-To: <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Feb 2021 01:48:29 +0800
Message-ID: <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
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

On Tue, Feb 16, 2021 at 12:28 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-02-21 23:36:49, Muchun Song wrote:
> [...]
> > > There shouldn't be any real reason why the memory allocation for
> > > vmemmaps, or handling vmemmap in general, has to be done from within the
> > > hugetlb lock and therefore requiring a non-sleeping semantic. All that
> > > can be deferred to a more relaxed context. If you want to make a
> >
> > Yeah, you are right. We can put the freeing hugetlb routine to a
> > workqueue. Just like I do in the previous version (before v13) patch.
> > I will pick up these patches.
>
> I haven't seen your v13 and I will unlikely have time to revisit that
> version. I just wanted to point out that the actual allocation doesn't
> have to happen from under the spinlock. There are multiple ways to go
> around that. Dropping the lock would be one of them. Preallocation
> before the spin lock is taken is another. WQ is certainly an option but
> I would take it as the last resort when other paths are not feasible.
>

"Dropping the lock" and "Preallocation before the spin lock" can limit
the context of put_page to non-atomic context. I am not sure if there
is a page puted somewhere under an atomic context. e.g. compaction.
I am not an expert on this.

> --
> Michal Hocko
> SUSE Labs
