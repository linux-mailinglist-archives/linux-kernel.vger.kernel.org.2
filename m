Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106032BF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577329AbhCCRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbhCCOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:53:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA41C06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:42:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u4so37492659lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJyFsTiCe9XNG8TmQw4FTErWPKkRCrfm1UpjfacnCRk=;
        b=TTTSuCmDYQAQDBRD4EKHRAK1Jd/bFDLZfJoRLYmjth5/oqd2f1BLLm/a1BthSC7wZN
         L7nUY9xFGKH2u4iFMHMLCu1bB1zy2C/BIhGsLIlvsWX1Z2bKNlChUy1EtdqTINFc1IXe
         7J/Yc1MGbaBDwUiWj4WYa+c8E+D75k6FHy+RGqPIrN3iUm2LRKyaSsr+K82CAT0/oKMY
         iuCQe4GNkqOAVOKidqaiLcNSFPr+k+TCrqyBOSovDARkfFYe8iJyO1gpLy2gZH8dHJPl
         R3LfIpycj6qZnIqU8tINI41bUp/uu7NT9YlK1D5N8frx8Z3XvCbIGq4zuk/aPAUEIJUT
         hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJyFsTiCe9XNG8TmQw4FTErWPKkRCrfm1UpjfacnCRk=;
        b=VtLx7sIfwY/hr3DZiQOJ+4L4bqblT4qtkStQ2wHCYirV8A3fWIoCxDJK2VzAyIU3wM
         wUbSz+Q4HaeVOPkWNSfZZ7/hNkjn4EvGAEGtSuOczyyVIjbUJ8ZBdyExsunYfQHbwXzB
         DewfKPQDy6j7zEYWgR4MRqBQwPEYlOxaufSWFqaLhh4cNRJO60ES65oXzNV6S15K1GfF
         SsJ1MF1EQsG5TaoQV4V6UuwykrJv+94aREk4bRtlJ7czjCGIKP4pCgLPciXINTiMYGjy
         4g+N4KbJKxUEswp7w7mi8wTF/qriYLF6qGaMUnn4WZfH4hd1QJ3a4SmCIxJizjX8X0s7
         0mVA==
X-Gm-Message-State: AOAM5328JlDMyEFIInbcyjZUngrnp+FfjBfv5IZdSyiaodg9ulceBh8c
        mUt2cgEY3O0JGOfSYGTBUqO85lyV0BpUX3h9Wi/2Bw==
X-Google-Smtp-Source: ABdhPJzvKP5lgHp/eRliXv3scmLxOVHbfjwzKOI4TpEoH0afRBOD8JAccayavUGKnE30nEG4RNc9dL19sFT2ScAagy0=
X-Received: by 2002:a05:6512:942:: with SMTP id u2mr15752552lft.117.1614782544239;
 Wed, 03 Mar 2021 06:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20210303093956.72318-1-songmuchun@bytedance.com>
 <YD9kCLlckn9evWuw@dhcp22.suse.cz> <CAMZfGtVdU9KWD8U_0CbctMpYo5SbzJEW2pSa1Qdr9tFcwaWcoQ@mail.gmail.com>
 <YD+XB6LVUhwL6qm+@dhcp22.suse.cz>
In-Reply-To: <YD+XB6LVUhwL6qm+@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 3 Mar 2021 06:42:11 -0800
Message-ID: <CALvZod7LLP02bw0t0eJFz1CF6dannFDNEGY2dNWOdqzqmJ_jEg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: fix kernel stack account
To:     Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 6:02 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > > > +             BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> > >
> > > I do not think we need this BUG_ON. What kind of purpose does it serve?
> >
> > vm->nr_pages should be always equal to THREAD_SIZE / PAGE_SIZE
> > if the system is not corrupted.
>
> BUG_ON is not an annotation for "this shouldn't happen". Even if the
> system was corrupted and nr_pages wouldn't match then this is not a
> reason to crash the kernel right away.
>
> In general there should be a very _strong_ reason to add a BUG_ON.
>

I agree with Michal. We should remove this BUG_ON or at least convert
it into VM_BUG_ON.
