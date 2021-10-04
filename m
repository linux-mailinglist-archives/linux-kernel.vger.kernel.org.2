Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30E421520
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhJDR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhJDR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:27:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF3C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:25:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so19091969lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKBTIHZkFkwseGAi5II5oGVj0iBXe7h2uvt78kuBKSA=;
        b=bBqGZLltEUDsR1PL9Qc1Y/XRczlTpQxaY5AFRGuodqngidy2xOtDflakPH5qdOqet0
         ny3SMOeBMt2G4zr7THRWei1s9a9znFAqdy7l8EbjWtiqoCkmH5ZY6ewRFn6M+9PmOZh7
         DV3FZ5a8xAC6Y04zmZqcJ48/Js2PEaa/0LC0yJn4nRk0oiYY1nAkGggkRnmPKxPlmVF4
         GErOtqrFb2+A5BIZdLLgIsEZ4qDah8/7VyCTtKaFb4za+Tk32wmnsjxI6tTj1hVG+M3Q
         gwNbLXdk/1YG8nhU32hxUc+vnh5/8TgxuzvkLfzzX5LYxFxLY+ygKfBQ5MSfZKEW90Ew
         SAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKBTIHZkFkwseGAi5II5oGVj0iBXe7h2uvt78kuBKSA=;
        b=pndVqeXjVb5ImYc1igfS8tetnHFRBNm6hgxY2Aw29AKQAuxONoAC5gCY3O2K3uZUWH
         IL7BpXmPCBEsMXA2uhlmfATOqMDUhzm6gD2fqPoRTfjgxqlfCZL1ximjiRnD2BHf82/6
         oHtZOh8zJbXvUr191fUeZuyEIAw4xKwKPTXiIJ6n21rvtJMv2cCZMgnKJF9Bb9GvUArA
         0y+7T6vwHx6gUOwAVxrCTKmpzZzxmnFCs3XQ1d5ODEFWVnmM7hvSXMsO315Upa5URAd3
         9f77XIvDY4AkzGCKy93kRMZYlKAmTHdwczKIGlBEX4EnJkbIc91F5XkLkV6ShpcbPmxr
         dZ9Q==
X-Gm-Message-State: AOAM5333b6kQ+s2HxXY8+n94tniu0S8DwpngSJ+oYS5q/vw5y0fYWxXP
        jwBUo8YAyOF1AMhZlIY5v122e+lxAN0xw6bgEy+SEg==
X-Google-Smtp-Source: ABdhPJzUTQp6h+Sb/2NzFKgUR2uR7Qc2dWO/JFqsIhiNclfxF49MzRER5nTGq/dvtBpWJX0w4hgl9SfOI8qSEhxVitk=
X-Received: by 2002:a2e:a370:: with SMTP id i16mr16470454ljn.35.1633368323563;
 Mon, 04 Oct 2021 10:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210929235936.2859271-1-shakeelb@google.com> <YVszNI97NAAYpHpm@slm.duckdns.org>
In-Reply-To: <YVszNI97NAAYpHpm@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 Oct 2021 10:25:12 -0700
Message-ID: <CALvZod5OKz=7pFpxCt1CONPyJO4wR5t+PH0nzdbFBT1SYpjrsg@mail.gmail.com>
Subject: Re: [PATCH] cgroup: rstat: optimize flush through speculative test
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 10:00 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Shakeel.
>
> On Wed, Sep 29, 2021 at 04:59:36PM -0700, Shakeel Butt wrote:
> > Currently cgroup_rstat_updated() has a speculative already-on-list test
> > to check if the given cgroup is already part of the rstat update tree.
> > This helps in reducing the contention on the rstat cpu lock. This patch
> > adds the similar speculative not-on-list test on the rstat flush
> > codepath.
> >
> > Recently the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
> > stats") added periodic rstat flush. On a large system which is not much
> > busy, most of the per-cpu rstat tree would be empty. So, the speculative
> > not-on-list test helps in eliminating unnecessary work and potentially
> > reducing contention on the rstat cpu lock. Please note this might
> > introduce temporary inaccuracy but with the frequent and periodic flush
> > this would not be an issue.
> >
> > To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
> > a system with swap-on-zram and the file was pushed to swap through
> > memory.force_empty interface. On reading the whole file, the memcg stat
> > flush in the refault code path is triggered. With this patch, we
> > observed 38% reduction in the read time of 8 GiB file.
>
> The patch looks fine to me but that's a lot of reduction in read time. Can
> you elaborate a bit on why this makes such a huge difference? Who's hitting
> on that lock so hard?
>

It was actually due to machine size. I ran a single threaded workload
without any interference on a 112 cpus machine. So, most of the time
the flush was acquiring and releasing the per-cpu rstat lock for empty
trees.

Shakeel
