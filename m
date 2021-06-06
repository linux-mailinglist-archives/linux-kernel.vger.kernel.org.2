Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870139D0F8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:23:57 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35466 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:23:55 -0400
Received: by mail-lj1-f170.google.com with SMTP id n17so1850507ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0240J0KF/Aped80vMa9sT0XstaDEWC4hgYqZlxbHwnE=;
        b=dIgJrqsLAPSKrgToOlNA9v2coxfEAjWretSNpIuF3J1GplSE7g0xWej8Nb/7o6uMWf
         /bKsw3cPBSIky+cnh73qRWj126Dase0EBYZjn9kgX+1V4UIC0gnbMQb3G8zgAxV3XLyh
         3WRs8ypWn8bONXlU+rH+WIzOoq+XydEhjmj8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0240J0KF/Aped80vMa9sT0XstaDEWC4hgYqZlxbHwnE=;
        b=DKWxnZ+TcAPkoCiyUYWKwTn3a3JqqpbxYOFZArvtPttNzOGv6S/QC6prcsJYv0JG8f
         AWQC+2oIXysqEDvXTst0vM42uY75A9dyg4oILoZEXBemZhZRgnIfIgRPzTbAME3Ow2LX
         LnN/xfeUeU5WE7qapR1s5IChPnFt7yOne9van8+Q4+b5LWtOCghgnUdN5cSlNzGHJGO1
         tOspSbXihDUcagHo137e4uDjzn0H0zMUzYEcRTOaoBnTzqCDaQ4iuD6SJTV08MbCtS5o
         2rWqTGEPZUef5uyr8UUApa6JA5a0joi4Dpeh1u6gOYFF5r4U6Zy6buLhtH+z3HaaQ+T2
         Qu0Q==
X-Gm-Message-State: AOAM533toWVVpQB4GEhzvQ8AGyiH5LqTNZHpOoM/BvtwoarnRwGmO7io
        Tjiqwzkgpwgg+YsSmaAAsNkfWmy+uht1GK9eafw=
X-Google-Smtp-Source: ABdhPJwp16SNd5Ty7beQuRmGiX+ThU7l7J7YoDL2TUI5bANQWEAY4/1sNprrOchP2Q1L5RuVDtlJnA==
X-Received: by 2002:a2e:9395:: with SMTP id g21mr12132188ljh.211.1623007263910;
        Sun, 06 Jun 2021 12:21:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m19sm1231015lfb.121.2021.06.06.12.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 12:21:02 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id p17so21637906lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:21:02 -0700 (PDT)
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr9435491lft.41.1623007262311;
 Sun, 06 Jun 2021 12:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210525031636.GB7744@xsang-OptiPlex-9020> <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com> <20210604075220.GA40621@shbuild999.sh.intel.com>
 <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com> <20210606101623.GA48020@shbuild999.sh.intel.com>
In-Reply-To: <20210606101623.GA48020@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 12:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com>
Message-ID: <CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com>
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2% regression
To:     Feng Tang <feng.tang@intel.com>, Waiman Long <longman@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Waiman Long to the participants, because this seems to be a
very specific cacheline alignment behavior of rwsems, maybe Waiman has
some comments ]

On Sun, Jun 6, 2021 at 3:16 AM Feng Tang <feng.tang@intel.com> wrote:
>
> * perf-c2c: The hotspots(HITM) for 2 kernels are different due to the
>   data structure change
>
>   - old kernel
>
>     - first cacheline
>         mmap_lock->count (75%)
>         mm->mapcount (14%)
>
>     - second cacheline
>         mmap_lock->owner (97%)
>
>   - new kernel
>
>     mainly in the cacheline of 'mmap_lock'
>
>     mmap_lock->count (~2%)
>     mmap_lock->owner (95%)

Oooh.

It looks like pretty much all the contention is on mmap_lock, and the
difference is that the old kernel just _happened_ to split the
mmap_lock rwsem at *exactly* the right place.

The rw_semaphore structure looks like this:

        struct rw_semaphore {
                atomic_long_t count;
                atomic_long_t owner;
                struct optimistic_spin_queue osq; /* spinner MCS lock */
                ...

and before the addition of the 'write_protect_seq' field, the mmap_sem
was at offset 120 in 'struct mm_struct'.

Which meant that count and owner were in two different cachelines, and
then when you have contention and spend time in
rwsem_down_write_slowpath(), this is probably *exactly* the kind of
layout you want.

Because first the rwsem_write_trylock() will do a cmpxchg on the first
cacheline (for the optimistic fast-path), and then in the case of
contention, rwsem_down_write_slowpath() will just access the second
cacheline.

Which is probably just optimal for a load that spends a lot of time
contended - new waiters touch that first cacheline, and then they
queue themselves up on the second cacheline. Waiman, does that sound
believable?

Anyway, I'm certainly ok with the patch that just moves
'write_protect_seq' down, it might be worth commenting about how this
is about some very special cache layout of the mmap_sem part of the
structure.

That said, this means that it all is very subtle dependent on a lot of
kernel config options, and I'm not sure how relevant the exact kernel
options are that the test robot has been using. But even if this is
just a "kernel test robot reports", I think it's an interesting case
and worth a comment for when this happens next time...

                Linus
