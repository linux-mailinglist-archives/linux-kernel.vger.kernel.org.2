Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC42E4531EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhKPMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhKPMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:15:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E9C0611A6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:04:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso1741160wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9Y9KcPa2lBrD3VwSGoo5xYPKSJ2jtX2bGgZ++EHy0Q=;
        b=mgCBiXpImkz7mM4cJq4UY8PMvRzsm6lwKouZ+dcvq8QSVa3J7JFej5uyngBzBs3VG9
         apP2Z2KnDB5lDZlgAnWWdBCIMaRp/9enlykRrPIMXnoMvjLqtHt0WpZc0g2YyHjeLydk
         /lQLwnitOv0S5e4LE3MrkKlJFQHSt8KKuyp7xrGkfwqrpHa/ibB3ODZXOTCs18KS7fiG
         5Ktnv8UE7n7sDzHh65sX5ke0VLwyVYv435sLeKkgWupMowYh6aN856ah7UXctP7gcCwI
         626yN4/2SbwvBKPhStTlohtmgVVNCNpPhrOtB0SuY5XbRiHjBNYUGhGuHafg7zP1SIJh
         N2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9Y9KcPa2lBrD3VwSGoo5xYPKSJ2jtX2bGgZ++EHy0Q=;
        b=pYBIuiOLR/7kcPsP/hZyOFWSs5hmkeSp1nt67Zx77uuC+Wrtbl+qmPMzB224kNDi9H
         RAOGwP85R0FBpHSPfZYQfVnUD5Risk7f6QI9TPa9OyNyuCcmhUB1ysOTxOQPSVjxf9Qv
         f5SSVt29cc6hwNFwPKOcVIOog0C5r00mQiexuch2jq2ahREXeW3kQWnnwhClrnEEPanD
         yCex9/vqDfNc8wpnLml2W6iUD2KUA4VGKWaqmBPFk+ENRKiFYVl5jHGcDwULyScd0MPC
         RRnbCUBP1vPlbod9MAE0oJHYGbqi81Mj8NYG0xm5nz4/KwyTbJNgLmYdYVJGdxA0Y7fj
         85+g==
X-Gm-Message-State: AOAM533KRAhRiIoXHJb4IbvmaLASmzc6Zn/sNkkgZ5W0yjuK6aq4MXaq
        9uBSHnuEMGp6zE4Lg4C8EQ9wEg==
X-Google-Smtp-Source: ABdhPJwUc+UlWH9Tc9SEHhXGVwFTVxffKLubOuzcgHdKK5Ik5pUTSDWywCEFBioj4I/hmRhY4Wxy8Q==
X-Received: by 2002:a1c:80c5:: with SMTP id b188mr7359307wmd.57.1637064278455;
        Tue, 16 Nov 2021 04:04:38 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:ee27:74df:199e:beab])
        by smtp.gmail.com with ESMTPSA id f7sm3226528wmg.6.2021.11.16.04.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:04:37 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:04:32 +0100
From:   Marco Elver <elver@google.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mina Almasry <almasrymina@google.com>, paulmck@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
Message-ID: <YZOeUAk8jqO7uiLd@elver.google.com>
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com>
 <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
 <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com>
 <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
 <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:59AM -0800, Shakeel Butt wrote:
> On Mon, Nov 15, 2021 at 10:55 AM Mina Almasry <almasrymina@google.com> wrote:
[...]
> > Sorry I'm still a bit confused. READ_ONCE/WRITE_ONCE isn't documented
> > to provide atomicity to the write or read, just prevents the compiler
> > from re-ordering them. Is there something I'm missing, or is the
> > suggestion to add READ_ONCE/WRITE_ONCE simply to supress the KCSAN
> > warnings?

It's actually the opposite: READ_ONCE/WRITE_ONCE provide very little
ordering (modulo dependencies) guarantees, which includes ordering by
compiler, but are supposed to provide atomicity (when used with properly
aligned types up to word size [1]; see __READ_ONCE for non-atomic
variant).

Some more background...

The warnings that KCSAN tells you about are "data races", which occur
when you have conflicting concurrent accesses, one of which is "plain"
and at least one write. I think [2] provides a reasonable summary of
data races and why we should care.

For Linux, our own memory model (LKMM) documents this [3], and says that
as long as concurrent operations are marked (non-plain; e.g. *ONCE),
there won't be any data races.

There are multiple reasons why data races are undesirable, one of which
is to avoid bad compiler transformations [4], because compilers are
oblivious to concurrency otherwise.

Why do marked operations avoid data races and prevent miscompiles?
Among other things, because they should be executed atomically. If they
weren't a lot of code would be buggy (there had been cases where the old
READ_ONCE could be used on data larger than word size, which certainly
weren't atomic, but this is no longer possible).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/rwonce.h#n35
[2] https://lwn.net/Articles/816850/#Why%20should%20we%20care%20about%20data%20races?
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1920
[4] https://lwn.net/Articles/793253/

Some rules of thumb when to use which marking:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

In an ideal world, we'd have all intentionally concurrent accesses
marked. As-is, KCSAN will find:

A. Data race, where failure due to current compilers is unlikely
   (supposedly "benign"); merely marking the accesses appropriately is
   sufficient. Finding a crash for these will require a miscompilation,
   but otherwise look "benign" at the C-language level.

B. Race-condition bugs where the bug manifests as a data race, too --
   simply marking things doesn't fix the problem. These are the types of
   bugs where a data race would point out a more severe issue.

Right now we have way too much of type (A), which means looking for (B)
requires patience.

> +Paul & Marco
> 
> Let's ask the experts.
> 
> We have a "unsigned long usage" variable that is updated within a lock
> (hugetlb_lock) but is read without the lock.
>
> Q1) I think KCSAN will complain about it and READ_ONCE() in the
> unlocked read path should be good enough to silent KCSAN. So, the
> question is should we still use WRITE_ONCE() as well for usage within
> hugetlb_lock?

KCSAN's default config will forgive the lack of WRITE_ONCE().
Technically it's still a data race (which KCSAN can find with a config
change), but can be forgiven because compilers are less likely to cause
trouble for writes (background: https://lwn.net/Articles/816854/ bit
about "Unmarked writes (aligned and up to word size)...").

I would mark both if feasible, as it clearly documents the fact the
write can be read concurrently.

> Q2) Second question is more about 64 bit archs breaking a 64 bit write
> into two 32 bit writes. Is this a real issue? If yes, then the
> combination of READ_ONCE()/WRITE_ONCE() are good enough for the given
> use-case?

Per above, probably unlikely, but allowed. WRITE_ONCE should prevent it,
and at least relieve you to not worry about it (and shift the burden to
WRITE_ONCE's implementation).

Thanks,
-- Marco
