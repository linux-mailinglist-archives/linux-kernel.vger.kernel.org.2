Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDD3D1879
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhGUUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGUUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:19:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:59:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y38so2248698ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zev5RkUDntkX6kWICmg9oLGVZwQDp/V6CB2SFJXvlbM=;
        b=MbUup/f2IQ4e5MYXEyQSpJT9BA/5+K1mBDGxRAU/j8XHmKaNWC16053kMEmyaCPWU0
         6X5d7gRKAa/dn9sXGMMonqNVZSQYg+FgMrgm/oDLmrFHHR6ryPTk24OjWuqiUkf9JhlW
         PLjjQ9c7rg4CcEE7sbk2wPUqHfE4u7dcmZIHR68kECpIWmNrF1e+HavOLMMowGahLl1N
         kGlsYJAhDLNMrqMEj2DACIl6eethtxavpitbs31H1qNkaE1Gra0Ryy7rqC6tnXd9j2JL
         7GKz6SzksiLzhiITrFIqLM+x66LPrPtZYXLKfOTn1rDr0ivJKphsFhfY2vy2DTZWrCSf
         Kz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zev5RkUDntkX6kWICmg9oLGVZwQDp/V6CB2SFJXvlbM=;
        b=jR4vt+3+XRcQvd7fIa/icsLdGf5f0YoglHO3PXzSeUwWa1SvpXlBrfQIMbxGl2QiSs
         1ubS90G5YwrY7DeFb1AeTyVo4ZyLdQQgrYEVIr/YuMTHa7ARHcKydJdJv/d5XcduEMda
         QRYoXLNcGGW1tgTtx4mX8IgUMCMrG7hCAz/57pJOU7hV2AYMSx0rewrBW9BUeSq0uGj5
         HiQ5O/u5oCBoBevQTHA89meTLUVgUA8lfE/evzW2alNDUFzDESpu9o/EFVh1E72aGmRZ
         o9y4LtgFFPX3RAIHo1ZfLzNLKMFlDLuIGaj0meNPXv9lkwuSZDeURC3Za/tn/iX4KGur
         nJlQ==
X-Gm-Message-State: AOAM531poJpB7UgfCEjpGIinBhbSeSDbRSx1/iz/ZkMGrPUV+mIb4LRK
        qVH2bHwWRhjp4km/qQnNBJF9Stdc5HdPnJEncn6byA==
X-Google-Smtp-Source: ABdhPJxPA+1Lvr6r0Ah+Ih16Hp1gDj0q96HTIeJShNuvXV8XbMIS4BZvdwqDvpclVoKXHc0q16IfDXSgqc30JARLqDQ=
X-Received: by 2002:a25:d912:: with SMTP id q18mr44064581ybg.294.1626901195909;
 Wed, 21 Jul 2021 13:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
 <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com> <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
 <0ee6775b-589c-3243-1c01-aafad5eecb73@redhat.com> <CAJuCfpHtRzCNH6Cspu8ngjw+WLvZTMsVbmBu_F-z8YY_n=RbvA@mail.gmail.com>
 <20210721135056.84d12dd49c07adff7b0beffb@linux-foundation.org>
In-Reply-To: <20210721135056.84d12dd49c07adff7b0beffb@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jul 2021 13:59:44 -0700
Message-ID: <CAJuCfpGsSFccjV9Qd86PCdLHjRG9gdP7snfy-856pzmfxdGO1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Jul 2021 13:19:35 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > This would not require moving other functions.
> > > > Would that be better than the current approach or the forward declaration?
> > >
> > > IMHO that could be an easy, possible alternative.
> >
> > Andrew, others? Should I follow this path instead?
>
> Whatever you prefer ;)

I understand David's concern too well to ignore it, so I prefer to
follow this middle-ground approach if you don't mind :)
