Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80D39BF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFDR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:59:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23688C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:58:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m3so12601687lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32oaR0c8kPrg68WaYMsIVFX1pFixmYc8jBXuPce7aqw=;
        b=Arq+6pHAhA+6mDmLufvN71tK/S4tPFoZ7Uq/geleo6of264AXrSe1tM+jluIf6B3zD
         AZs04X7ognuE3D2i6F0z9Mn1WqV2++xQDUMwY+aX2S+LMCtP/R376LwUOogcVxNXEcYc
         GOz9C5WIEQi6729yXjMf3BW/0QywFdq2zH07k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32oaR0c8kPrg68WaYMsIVFX1pFixmYc8jBXuPce7aqw=;
        b=ecHVQ5VOymBj8mt/tFZq8puOt+TGs+VljBX39/3an675XAfThjPwFmftzVGMJwotJ3
         CSFol3zWOv/7Osws8UVjGCtxpDWpUvhydOB07jVy82Y7jtqBxED7DBnPTbaNTTIv6hUF
         3H4hEcUR8Qs66005RCDkE28a726Nt8VrUs6AlCdES4R1RaBbpqSz5L5YpG9SLoI5UqnP
         oLpXsIY1jQTf5NEJXBDDKdQHrb5spu2BNtQjFdpR0zR9rtIh2vLT40G9vtaBX1WfxNS5
         g/xJsKddANyhRYN9xz6TlpYq5uM45fZ2tZES+d+s0g7X3U5LlXGkd5CYPWWS5upXp5vu
         G+YA==
X-Gm-Message-State: AOAM532QWShgOTdQxrnvyFV5YJOzXVDb632w40G5Xogq/BBrAvyQqXQy
        hy1ZXtuBByruVil/TI7AFR2dHY+i7EZ5a+SMBfE=
X-Google-Smtp-Source: ABdhPJyn3XpvUap6w8rrn75SZTTUxodevEVXHaYT/ZC3mBuNTBJSbiGZfNQ+qvS6JBgp6Ny7quLCVA==
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr3707408ljl.325.1622829482305;
        Fri, 04 Jun 2021 10:58:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id z13sm774894lji.115.2021.06.04.10.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:58:00 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a4so12661129ljd.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:58:00 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr4336857ljh.507.1622829479784;
 Fri, 04 Jun 2021 10:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210525031636.GB7744@xsang-OptiPlex-9020> <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com> <20210604075220.GA40621@shbuild999.sh.intel.com>
In-Reply-To: <20210604075220.GA40621@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 10:57:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
Message-ID: <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2% regression
To:     Feng Tang <feng.tang@intel.com>
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

On Fri, Jun 4, 2021 at 12:52 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Fri, Jun 04, 2021 at 03:04:11PM +0800, Feng Tang wrote:
> > >
> > > The perf data doesn't even mention any of the GUP paths, and on the
> > > pure fork path the biggest impact would be:
> > >
> > >  (a) maybe "struct mm_struct" changed in size or had a different cache layout
> >
> > Yes, this seems to be the cause of the regression.
> >
> > The test case is many thread are doing map/unmap at the same time,
> > so the process's rw_semaphore 'mmap_lock' is highly contended.
> >
> > Before the patch (with 0day's kconfig), the mmap_lock is separated
> > into 2 cachelines, the 'count' is in one line, and the other members
> > sit in the next line, so it luckily avoid some cache bouncing. After
> > the patch, the 'mmap_lock' is pushed into one cacheline, which may
> > cause the regression.

Ok, thanks for following up on this.

> We've tried some patch, which can restore the regerssion. As the
> newly added member 'write_protect_seq' is 4 bytes long, and putting
> it into an existing 4 bytes long hole can restore the regeression,
> while not affecting most of other member's alignment. Please review
> the following patch, thanks!

The patch looks fine to me.

At the same time, I do wonder if maybe it would be worth exploring if
it's a good idea to perhaps move the 'mmap_sem' thing instead.

Or at least add a big comment. It's not clear to me exactly _which_
other fields are the ones that are so hot that the contention on
mmap_sem then causes even more cacheline bouncing.

For example, is it either

 (a) we *want* the mmap_sem to be in the first 128-byte region,
because then when we get the mmap_sem, the other fields in that same
cacheline are hot

OR

 (b) we do *not* want mmap_sem to be in the *second* 128-byte region,
because there is something *else* in that region that is touched
independently of mmap_sem that is very very hot and now you get even
more bouncing?

but I can't tell which one it is.

It would be great to have a comment in the code - and in the commit
message - about exactly which fields are the criticial ones. Because I
doubt it is 'write_protect_seq' itself that matters at all.

If it's "mmap_sem should be close to other commonly used fields",
maybe we should just move mmap_sem upwards in the structure?

              Linus
