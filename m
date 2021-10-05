Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAD4232DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhJEVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbhJEVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:32:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D1C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:31:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v195so926607ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zFd2aEpAbN0UaxYqSieP1eT57btxJ5r4/ig5AwZ56hU=;
        b=A6cMmH6kIYNw3BTgbMB7RjNRiWzfr4Rx+YvMM2U6bgd5BP75qsOkQ6RxR6rUGfz+vB
         rfjOyFzG3JmZ01R24GvvhBKUBeF8C9WDST11Re/o14/bDrTbnLwSx3TU8/IfuS0OJVCx
         JhkIvBFZUFQdKcFvScBgAjAjd1//rDxbW0JYsEyatBB36ofJDPAwd1syR0+pPemucCzv
         dA3hDlf0O2JOHdYfJ0fccJlwurmUscamj4c6tlh87z41jjaba51DOA7GXPYJKHXrTXdM
         +UOty4XjTFa3eyRZg8LEgrxJb2GOqgQw/UedY2Bnb+zW7nu3QBeUWf/h2tvMUUEuY6OI
         pQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zFd2aEpAbN0UaxYqSieP1eT57btxJ5r4/ig5AwZ56hU=;
        b=Lwi+vxbcM3WdfCpwyd1niM4oVARfm0xhb1a5pXterceUle+31FnBm7tZa3Zk4sxrrq
         8MrTpA4forbkWY3cbwR2FRNBdX6wkRmbwEUwr4wthHCYnTeaXcRgE+bk4qZ/zFBL9Aby
         mIYzSUafiRosxEJIgZwM7pjnNQMM074PLr5cw5tw41us+NGFNmnkcMWgDtgq83/bFCeM
         yQnh9Ok/soQO18O6OdCSwo/Dov9e812fja1KmgHMIquJprNBltAoUt/MkpBGkSr7Zl5h
         aPam+VdV0ncdRH/4p/4c+/tbcp/wo3GEPPKn9p0MtQBufLD0896GcKtkbB4GzULS4m9A
         6iug==
X-Gm-Message-State: AOAM533rfn2mcbq65/2xzw3nDl3m5eCBYXRSu/CbLmtbEukA6VWprF8t
        lLSiMrqKSKPEfoNFKM2UvWsk8UCln/sZZ0M0Fzzp/w==
X-Google-Smtp-Source: ABdhPJxIZnTZN87HdH/jKt8pzHjywbGdk+rQNE5ijTKlFRuji90ahdhfsDtTCVCgO9/p/VxoanNZP2pPH0+zMb7LRGQ=
X-Received: by 2002:a25:3:: with SMTP id 3mr24887463yba.418.1633469459834;
 Tue, 05 Oct 2021 14:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <5358242.RVGM2oBbkg@devpool47>
 <CAJuCfpF57Wppc_Si98wEo5cASBgEdS7J=Lt9Ont9+TsVr=KM_w@mail.gmail.com> <20211005210003.v3zgqhefn5j65gig@revolver>
In-Reply-To: <20211005210003.v3zgqhefn5j65gig@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 5 Oct 2021 14:30:48 -0700
Message-ID: <CAJuCfpGaxhpePj8KN3S=Q7jMUjaeWZfoBTAHqjodhoH5MV-9yQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "krisman@collabora.com" <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        "legion@kernel.org" <legion@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "cxfcosmos@gmail.com" <cxfcosmos@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 2:00 PM Liam Howlett <liam.howlett@oracle.com> wrote=
:
>
> * Suren Baghdasaryan <surenb@google.com> [211004 12:18]:
> > On Mon, Oct 4, 2021 at 12:03 AM Rolf Eike Beer <eb@emlix.com> wrote:
> > >
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior=
)
> > > >  }
> > > >
> > > >  /*
> > > > - * We can potentially split a vm area into separate
> > > > - * areas, each area with its own behavior.
> > > > + * Update the vm_flags on regiion of a vma, splitting it or mergin=
g it as
> > >                                 ^^
> >
> > Thanks! Will fix in the next version.
>
> Since you'll be respinning for this comment, can you please point out
> that the split will keep the VMA as [vma->vm_start, new_end)?  That is,
> __split_vma() is passed 0 for new_below.  It might prove useful since
> the code is being reused.

Hmm. There are two cases here:

        if (start !=3D vma->vm_start) {
                ...
                error =3D __split_vma(mm, vma, start, 1);
        }

and

        if (end !=3D vma->vm_end) {
                ...
                error =3D __split_vma(mm, vma, end, 0);
        }

so, I don't think such a comment would be completely correct, no?

>
> Thanks,
> Liam
>
> >
> > >
> > > Eike
> > > --
> > > Rolf Eike Beer, emlix GmbH, http://www.emlix.com
> > > Fon +49 551 30664-0, Fax +49 551 30664-11
> > > Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
> > > Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR =
B 3160
> > > Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Us=
t-IdNr.: DE 205 198 055
> > >
> > > emlix - smart embedded open source
> > >
> > > --
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to kernel-team+unsubscribe@android.com.
> >
