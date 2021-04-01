Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6335242E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhDAXr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236295AbhDAXr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617320846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVpc0rUTxDYUGUYBGrEzWNw2vv+lb7XY8N2qOdklVV0=;
        b=FlH/vI0HGjraIze0WRHtVRdp9oQGQ2BnHX2F34SHw0+FnRhdEfiD0NDUwOSnuF/spuEBxh
        Fn1ajDO+3lLEd5r65w66e9BB03vhmHMI8kXOnx+Xc238E5pmfloapNnOSj1GxBjefw4Ydu
        Ma7J3oxKsn7RWXzUlZomMVOJKAbREHU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-mRrn-P46P9ytOmptn0_Wdw-1; Thu, 01 Apr 2021 19:47:22 -0400
X-MC-Unique: mRrn-P46P9ytOmptn0_Wdw-1
Received: by mail-qv1-f69.google.com with SMTP id p18so48358qvn.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVpc0rUTxDYUGUYBGrEzWNw2vv+lb7XY8N2qOdklVV0=;
        b=WhikByakbhDvxTKMzzS2Z+vkaSwed1R1Q5MYb6ed+OmPtt5MR/f1vsnQKE4ETrGPGO
         Q0f3r4x7F0OX7v2TQ3SXoOoE78GyQ20NTO9ifRaHaA84OTwJa4Fpb7ShUtzbyEN1Fdua
         H1iLsLEtsN11h+fX8U8yTtQp8TFtFFAvc7hFU3eB33b0D3UulvEqITwBpbxHVy5rZvBq
         XPXE6aIu0Fyqqxza6l4keaI6jbtyEGjyu8OVpZ5vJpcBJs03RllEtTC90gEPZk2b/9T5
         XxNSG493fhCV1DhRtQjcAj3hENlPYbez9tX7OhPL20So3ziDa/r87YnIjnW8VzmHkB04
         r33w==
X-Gm-Message-State: AOAM531wJO983+/wLIq4c60IQKLnjV18PP6ntqaTOfOxD6lsHMAvlXJa
        Vjcw79NZ3WMpXweE32Px7Wp1ksABvw2qFQoD5IjBM/agn81+1ZG5YjhYmBruWglMG9QzpIRtk1v
        9xraCqeRMYqSvUpLvl5j5eLC/
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr9650662qti.329.1617320842483;
        Thu, 01 Apr 2021 16:47:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxImG7qpo37qw37G+WISCdBMKNa6HQGppU3YSusHUWwxfGEF8pBIidclFCLT7Qtsk+GX+13Cw==
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr9650651qti.329.1617320842231;
        Thu, 01 Apr 2021 16:47:22 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id 73sm5398788qkk.131.2021.04.01.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 16:47:21 -0700 (PDT)
Date:   Thu, 1 Apr 2021 19:47:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Shaohua Li <shli@fb.com>,
        Nadav Amit <namit@vmware.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
Message-ID: <20210401234720.GB628002@xz-x1>
References: <20210401181741.168763-1-surenb@google.com>
 <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
 <CAJuCfpE48zkcM_2GABBpXssjmivKLt+r8+CEeXafqK3VNMMjDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpE48zkcM_2GABBpXssjmivKLt+r8+CEeXafqK3VNMMjDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Suren,

On Thu, Apr 01, 2021 at 12:43:51PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 1, 2021 at 11:59 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Apr 1, 2021 at 11:17 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > We received a report that the copy-on-write issue repored by Jann Horn in
> > > https://bugs.chromium.org/p/project-zero/issues/detail?id=2045 is still
> > > reproducible on 4.14 and 4.19 kernels (the first issue with the reproducer
> > > coded in vmsplice.c).
> >
> > Gaah.
> >
> > > I confirmed this and also that the issue was not
> > > reproducible with 5.10 kernel. I tracked the fix to the following patch
> > > introduced in 5.9 which changes the do_wp_page() logic:
> > >
> > > 09854ba94c6a 'mm: do_wp_page() simplification'
> >
> > The problem here is that there's a _lot_ more patches than the few you
> > found that fixed various other cases (THP etc).
> >
> > > I backported this patch (#2 in the series) along with 2 prerequisite patches
> > > (#1 and #4) that keep the backports clean and two followup fixes to the main
> > > patch (#3 and #5). I had to skip the following fix:
> > >
> > > feb889fb40fa 'mm: don't put pinned pages into the swap cache'
> > >
> > > because it uses page_maybe_dma_pinned() which does not exists in earlier
> > > kernels. Because pin_user_pages() does not exist there as well, I *think*
> > > we can safely skip this fix on older kernels, but I would appreciate if
> > > someone could confirm that claim.
> >
> > Hmm. I think this means that swap activity can now break the
> > connection to a GUP page (the whole pre-pinning model), but it
> > probably isn't a new problem for 4.9/4.19.
> >
> > I suspect the test there should be something like
> >
> >         /* Single mapper, more references than us and the map? */
> >         if (page_mapcount(page) == 1 && page_count(page) > 2)
> >                 goto keep_locked;
> >
> > in the pre-pinning days.
> >
> > But I really think that there are a number of other commits you're
> > missing too, because we had a whole series for THP fixes for the same
> > exact issue.
> >
> > Added Peter Xu to the cc, because he probably tracked those issues
> > better than I did.
> >
> > So NAK on this for now, I think this limited patch-set likely
> > introduces more problems than it fixes.
> 
> Thanks for confirming my worries. I'll be happy to add additional
> backports if Peter can point me to them.

If for a full-alignment with current upstream, I can at least think of below
series:

Early cow for general pages:
https://lore.kernel.org/lkml/20200925222600.6832-1-peterx@redhat.com/

A race fix for copy_page and gup-fast:
https://lore.kernel.org/linux-mm/0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com/

Early cow for hugetlbfs (which is very recently):
https://lore.kernel.org/lkml/20210217233547.93892-1-peterx@redhat.com/

But I believe they'll bring a number of dependencies too like the page pinned
work; so seems not easy.

Btw, AFAICT you don't need patch 4/5 in this series for 4.14/4.19, since
those're only for uffd-wp and it doesn't exist until 5.7.

Thanks,

-- 
Peter Xu

