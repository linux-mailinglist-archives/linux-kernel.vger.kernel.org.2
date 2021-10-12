Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7480429BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhJLDCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhJLDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:02:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6605C061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:00:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id y10so1577969qkp.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B100TNfxux8MkM53tT5+mvaB4zQgc5l0a51qWAB7oeY=;
        b=QcUrE/rGjmVLgGRtI564GAlFVUpY0c99OGdEyNr1y0rX8/wuU4xUpFvLhvh7ge20YA
         VjENDJ9PEOv9K8PKAAOKpo8KrEOXAdyFcqMMJ0ochkvA6vqnmy/gcKqb2ZQnKRvvPQvJ
         T4hoYsaapC11TwiL++jziZS8g9wXYA3tSvryZI0Yve32gs00DWtQ4tEruIL/csN1VEfs
         /woymrea9zjZQm9NvjuthLP1v82wrZY/WbjveZw6bTW9llxYFVJDV5v5KRP4cZekrk33
         o03hHS31unp49DwnOwHbjQ2dIYZx3iK2UDKV3x+lDJwiPpwGdi46I4t78jM4JVKyRVwj
         Msmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B100TNfxux8MkM53tT5+mvaB4zQgc5l0a51qWAB7oeY=;
        b=Y+mTROheIvNUxhf60fKelzKh+mOca90oBFIh3OUbn83YCvMiApdTRTcwF9ddB8xLJw
         OUfxPPi4DJ+w2bsd6P7J0OLJTH+On//dSd96FwXOy9q2+nXSsfWnzCy1j9vPJHVrIsbe
         CktMpeb0opfKym0qRYWihn14OmCHCdvIyWxP2t5SOK8WNkflziNBDJ/ioNoUMI+sb8ls
         nHQhcQHDX2c7OdbwyOQdFB4lYL0j4jxt0TLNg+iHx3aQuPCPpXKM7pLAQHAe9J8dnNh3
         JNTKd2VhNikb7A+WUWy8EEsF3chK8Yzjfgp6OLsvKKZBHyl9Lx1iDSEIvWrI5SSRwAwE
         6Org==
X-Gm-Message-State: AOAM532mXIV2Ys5CJliQaqe61cskTOrnNHhhhC00/3WTiU36vfUkKG6i
        ja1tEPF+6m/3Ocrbuw8PPtInXQ==
X-Google-Smtp-Source: ABdhPJyA16KHuJMlpHIfDt8HoA0n9/NzYG93r2bEkIaMUlRRltkLlZ5fuYvSCm7pvSgA1xkD8SVDtQ==
X-Received: by 2002:a37:a748:: with SMTP id q69mr17559785qke.178.1634007616296;
        Mon, 11 Oct 2021 20:00:16 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 9sm5174953qkn.84.2021.10.11.20.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:00:15 -0700 (PDT)
Date:   Mon, 11 Oct 2021 23:00:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <YWT6Ptp/Uo4QGeP4@cmpxchg.org>
References: <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook>
 <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 06:20:25PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > - Strings for "anon" specifically have no required format (this is good)
> > > >   it's informational like the task_struct::comm and can (roughly)
> > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > >   is one needed here? That seems like a completely unreasonable
> > > >   requirement.
> > >
> > > I might be misreading the justification for the feature. Patch 2 is
> > > talking about tools that need to understand memeory usage to make
> > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > argument against.
> > >
> > > So can we get a clear example how is this being used actually? If this
> > > is just to be used to debug by humans than I can see an argument for
> > > human readable form. If this is, however, meant to be used by tools to
> > > make some actions then the argument for strings is much weaker.
> >
> > The simplest usecase is when we notice that a process consumes more
> > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > check which area is contributing to this growth. The names we assign
> > to anonymous areas are descriptive enough for a developer to get an
> > idea where the increased consumption is coming from and how to proceed
> > with their investigation.
> > There are of course cases when tools are involved, but the end-user is
> > always a human and the final report should contain easily
> > understandable data.
> >
> > IIUC, the main argument here is whether the userspace can provide
> > tools to perform the translations between ids and names, with the
> > kernel accepting and reporting ids instead of strings. Technically
> > it's possible, but to be practical that conversion should be fast
> > because we will need to make name->id conversion potentially for each
> > mmap. On the consumer side the performance is not as critical, but the
> > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > file, do id->name conversion and replace all [anon:id] with
> > [anon:name] would be an issue when we do that in bulk, for example
> > when collecting system-wide data for a bugreport.

Is that something you need to do client-side? Or could the bug tool
upload the userspace-maintained name:ids database alongside the
/proc/pid/maps dump for external processing?
