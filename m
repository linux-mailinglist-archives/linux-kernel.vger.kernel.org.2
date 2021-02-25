Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED632551D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhBYSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBYSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:02:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:01:58 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d2so8022770edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6fnMFz33qplfRqMB+HqqUvPdR34RqJh36nDC5TsifM=;
        b=GFIFnYEHkDWCJeUWtVcHjzxrKHzPSC845ICu8hcYMqCsuUHUMYhmhM6A8qllmj2wvF
         TeD+nXiix4KfoCrm2ttxL6EfZmKtzW+4tjcpl0pa/DNpOjMdlXHpNVfbq1N7k4QYkskP
         rPYDh0IFTsvGod5noex2WbDs0vYWj0YFRCsRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6fnMFz33qplfRqMB+HqqUvPdR34RqJh36nDC5TsifM=;
        b=ddagNHuytpLmHVe3bBnuA3JUrFqNRpVVMOXZOl+FPWjAfNIF3qTedeslShpLG5PZ5k
         2Mmp7wN+enUjFSCX8bzdnhaSDhgCi48QtuNi+/bAxyY0agRK4umVY8tbuBbgy5RFxyVv
         JTU4CCswXgR1lM+ID4rsN/8qzqyqgwmJ41E/W9thpTOtiy2EGm2+ovuQUYFo2CjZpWrH
         PzsZ+Clg2wIl789HhNKSeeVkYrr48LhfSaSs0KKuYmgoNYhrwTzu2DjQXdCD8DLJ+8fv
         0X6z40F5A10hEIpEHprNuvFmGwO0qtpO7AVZATnH/MxqDigqw0QPFF9b+np2+9iWuBJq
         ZNkQ==
X-Gm-Message-State: AOAM5339C9fKrcU52/D/F6+0vVJgtZmB9YUtSqjLALfwC/1b8QLR3oQg
        qObHfCcuaYgdXGryNe4VY7XxopmrtFF8/g==
X-Google-Smtp-Source: ABdhPJw4InWBlzQx2FZrMvRvfUDMzEJXKr4k6p2KJQ7KJwb9iJHkfanJxfSO8qaUtASCRiSgOf4nLg==
X-Received: by 2002:a05:6402:203:: with SMTP id t3mr879403edv.306.1614276117343;
        Thu, 25 Feb 2021 10:01:57 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g3sm3280495ejz.91.2021.02.25.10.01.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 10:01:57 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id c23so1601672edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:01:57 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr2392819lfu.41.1614275689864;
 Thu, 25 Feb 2021 09:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20210224153950.20789-1-rppt@kernel.org> <20210224153950.20789-2-rppt@kernel.org>
 <515b4abf-ff07-a43a-ac2e-132c33681886@redhat.com> <20210225170629.GE1854360@linux.ibm.com>
In-Reply-To: <20210225170629.GE1854360@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Feb 2021 09:54:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-0TeNTNhn+r8c9n76uy8ZiYw03AnXz3hyDZ_rQu35Uw@mail.gmail.com>
Message-ID: <CAHk-=wj-0TeNTNhn+r8c9n76uy8ZiYw03AnXz3hyDZ_rQu35Uw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] mm/page_alloc.c: refactor initialization of struct
 page for holes in memory layout
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Qian Cai <cai@lca.pw>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 9:07 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> >
> > We might still double-initialize PFNs when two zones overlap within a
> > section, correct?
>
> You mean that a section crosses zones boundary?
> I don't think it's that important.

What if there was a memory allocation in between that could allocate
the once-initialized page?

Maybe it can't happen, or is not an issue for some other reason, but
this code has been fragile and had a ton of subtle issues, so maybe
worth documenting (or explaining here why it's just not relevant)

          Linus
