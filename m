Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C609F402DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbhIGRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbhIGRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:53:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853BC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:52:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r7so15069521edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoHEUb0DCP2OkvPMgQlxjC1z05NpkoQ2FGZEXVyLfxo=;
        b=KibYMWptm8FxE70xjZLMkks5z4mhxTgXord3n8HVvc8ssE6F8+icP4COZI/erePcgP
         bJntP5M5tJ/uCnjEH0q16uqCFwfzdL+1EJ+dcLwKxZB+bEFI9CcDlhw+cqs+2p7/M5Q6
         weCOiUsN1wEGcjrIOIiorDSVQb9ThEOoSeVn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoHEUb0DCP2OkvPMgQlxjC1z05NpkoQ2FGZEXVyLfxo=;
        b=Iqfs7V2lOHN0OXcaH6EtaLzi047iYOZJ4CnzhYP19mF3IGlBLCwyUkrZpCv8cMhCHs
         0TOCL3qOdojIbPW2BF6kGOsOT1ezBZ3z40QptO+HthVqJD92WakSty+nMDHl3VMitVV8
         6uP2tztGwGb7ErfthggOnum0PeZv8BKcOgbRL5q9TIXlICQPxG0MlbnYYmT76YkG1Yg4
         ki+svYecFx5xJPJ4st+mYIoGy3hynF4kyL5B+IQ4an3GZ21SwbwCJsMXe+hhWDHXB7LJ
         T5yiBLDKJO4wTzl7YCPaacMGmlbxO408PHlPe6y4WWZDlSxKX0M/WGuWBW2cRlKm2ut8
         1DNQ==
X-Gm-Message-State: AOAM531f/woLzBzCETUfaTxLMkIxtOnn1GQpx8y30beNuGngIeVu0iAy
        9rsl7mabt7yOX2MYJ9GdNIza3D1YCLMsxhgJeCQ=
X-Google-Smtp-Source: ABdhPJyd/V4+Tmm4lKUeMuCGYjlwaoSStgfVn8HHvvVwVXd/qlNxNs94ZjGejFPy0FG8g3E6XALPCw==
X-Received: by 2002:a05:6402:4314:: with SMTP id m20mr758923edc.6.1631037165953;
        Tue, 07 Sep 2021 10:52:45 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id v13sm5802890ejx.72.2021.09.07.10.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:52:45 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id h9so21303879ejs.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:52:44 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr13298472lfg.402.1631037153599;
 Tue, 07 Sep 2021 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com> <CALvZod5Q_K=xLpBWTLgg38X_w23HVSyqW2_Jnz7p=JR+kDD_-w@mail.gmail.com>
In-Reply-To: <CALvZod5Q_K=xLpBWTLgg38X_w23HVSyqW2_Jnz7p=JR+kDD_-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 10:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
Message-ID: <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
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
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
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

On Tue, Sep 7, 2021 at 9:49 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Sep 7, 2021 at 9:40 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We are worried about them. I'm considering reverting several of them
> > because I think the problems are
> >
> >  (a) big
> >
> >  (b) nontrivial
> >
> > and the patches clearly weren't ready and people weren't aware of this issue.
>
> Sounds good to me. Please let me know which patches you are planning
> to revert. I will work on the followup to make those acceptable.

The one that looks clear-cut is the one in this thread:

    0f12156dff28 memcg: enable accounting for file lock caches

which seems to result in regressions on multiple machines and just be
very bad for anything that uses file locking. I'm not entirely sure
how much that would show up in real life, but I can most definitely
imagine it being a problem on a real load.

There's a few other regression reports I've seen, like

    5387c90490f7 mm/memcg: improve refill_obj_stock() performance

but that one had mixed reports (it improved another benchmark), and it
looks like Minchan has a fix for the regression already.

And

    aa48e47e3906 memcg: infrastructure to flush memcg stats
    b65584344415 memcg: enable accounting for pollfd and select bits arrays

were reported as a regression in -mm, but not in mainline yet.

I assume (but didn't check) that aa48e47e3906 is a bigger deal to revert.

So _right_now_ my plan is to revert the two obvious cases:

    0f12156dff28 memcg: enable accounting for file lock caches
    b65584344415 memcg: enable accounting for pollfd and select bits arrays

on the assumption that the memcg accounting code needs some work to
make it less of a performance hog.

Does anybody have other commits they want to highlight (or other
comments) about this?

              Linus
