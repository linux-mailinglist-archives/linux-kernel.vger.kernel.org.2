Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7340E402DF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhIGRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbhIGRt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:49:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7FC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:48:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f18so21004670lfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IXPyGiAA/X4aMsCwW53dWoNc2nCHqMqBLBp35K+EP8=;
        b=MyUI5QIPyPTdsUeaVxiSSonFsrWRV3WdSqFz6OS19+YnAoHxDe6cPZueAwSYrCqC0p
         LYULOFq+gIpvibOvB54t/l5LaZtTsx0rl1mA08rG/SvsmSBMkI0ODTn9G0lpT9qqI+Yx
         nRgcShBPaR+CHJjn1MFI1//O1xtg+OLp5ifmLP3CkiJCx+CWfL9njgSR8QR4rgogDvm4
         jjSy0JYPtj6aP3/fuo9x8hgrxT9cuOWsd8f2OpG/Z2KHDJwfF7tiurnWv1E7C3wwkBGz
         ATMnhjy9K1lQgp9Tav6pB2W8yGQ2XHk6efUR2qOKTky/oJDYc2BKI/M/jhcoT8IaRKHl
         UGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IXPyGiAA/X4aMsCwW53dWoNc2nCHqMqBLBp35K+EP8=;
        b=iWzQgjTLMxxelLs4sEoZyICUjBHHCZBjUc/4TKLO8SL4Au9wSg8UJ13Tqs3gVhRuep
         f1VwFPTgJ7EXJPeas/dyOA/ZuxBlX3b4V/O5dwE5Tr64zwW+v5Iw4UGkZLAp1VrDS3T7
         QKh1tu1e+trdengOvaxv/Y/JMa7/qY/EFDC9H+RtYvh4RZSmf2vy+1mcGWEWJJ/fFZFw
         kx+DwwezRMI2OJKH86fPavYg66hUDydsVrkYZeE4emis0gM5Z7riIqxb3gAzBpTzf84T
         P4ck6rm1JNt6bp91lZCVjaAGuHJshZCwvGjbyvVnMwJl4OpeQiG6A8fLEBIDlCI3+bcj
         yQQA==
X-Gm-Message-State: AOAM533v2dMAio0cXgbFQd4X1mIt+MeRS8uaPAQY9jlr9E7Cd+0wYuNW
        yByFD6xe5a8khIsBv5QCAAes5SOvDpajr+9BDcH0hQ==
X-Google-Smtp-Source: ABdhPJz2Q1lij0tZFVN3Ens6kYU1DLa7KFrKALzC87PJ9JlmLO7swbCVjFG77yOSpadwbW6EnGDuhZsq49xvbfzhE0g=
X-Received: by 2002:ac2:4e0c:: with SMTP id e12mr13873258lfr.264.1631036898182;
 Tue, 07 Sep 2021 10:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk> <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
 <YTeeBf64yUwj01Sf@slm.duckdns.org> <YTeh1WkseQtyboM9@carbon.dhcp.thefacebook.com>
In-Reply-To: <YTeh1WkseQtyboM9@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Sep 2021 10:48:06 -0700
Message-ID: <CALvZod4=uY=5Zp_GCzjjMzCbs16856dR85SBWv-dpNc4kBrO+Q@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 10:31 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Sep 07, 2021 at 07:14:45AM -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
> > > There are two polar cases:
> > > 1) a big number of relatively short-living allocations, which lifetime is well
> > >    bounded (e.g. by a lifetime of a task),
> > > 2) a relatively small number of long-living allocations, which lifetime
> > >    is potentially indefinite (e.g. struct mount).
> > >
> > > We can't use the same approach for both cases, otherwise we'll run into either
> > > performance or garbage collection problems (which also lead to performance
> > > problems, but delayed).
> >
> > Wouldn't a front cache which expires after some seconds catch both cases?
>
> I'm not sure. For the second case we need to pack allocations from different
> tasks/cgroups into a small number of shared pages. It means the front cache
> should be really small/non-existing. For the first case we likely need a
> substantial cache. Maybe we can do something really smart with scattering
> the cache over multiple pages, but I really doubt.

I think we need to prototype this to sensibly evaluate. Let me know if
you want to take a stab at this otherwise I can try.
