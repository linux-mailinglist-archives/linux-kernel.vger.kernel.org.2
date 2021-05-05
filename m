Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9170373F69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhEEQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhEEQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:18:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC349C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:17:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v6so3223192ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LojNw03jpaoud1mN08MPpxuRhcuj9lI3TX5RGXeehmg=;
        b=wTlp9K2Q2Xv96007PiwKY/jru+Ohb3ch0S/6t2XIXDw2ODe5lvi2gLwnlyZ1rNwbMF
         LcFb4/KZU7VRn9Lse/8MH+ZjWdIAuiaUzAy1mYYrRKi5qtTPami9sMXMeFkwYp8YCiL8
         eKhMPDV97PAo+Hrk9y7J2aEKPWjWDdPP33k/wP65eQZHotMsX4y+hr3TYYZROJqaIrTW
         e/Iu6vKI5XqcRhhmQAY74O7PoKpxQvoan3HZC3UQVblxTIVo0k1s9tLuRFiM02Wcxb3A
         8Iy1pcbvqIBUNV59LRcj8hhHEuWGjsM3va3L+E1duQ4dIRQfoiJY/Ap2Qtid4cRc+fK5
         ozqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LojNw03jpaoud1mN08MPpxuRhcuj9lI3TX5RGXeehmg=;
        b=PjF5TLg7sjprIs9stPeNtfKtuqeQP3PwI1IA8szzvvCU+vYs6/Cxn/1kweMnl6xbnI
         I3HSxpEfLP+hMDljy9XCMu61zSMwpav/2TKza+SQtQzw0fMMj75NXHAwpJibm6irsxhl
         cp3JcuIDaorwA0hMZChqRPp6v3weZmjK/vdYsTErks2WV29a5JBLeG697pavpaQWxVIU
         gW0tridqrucDV7ttEsku5AyCZTTXPqyQZ73GJFBeon+xkH9+L2jBBSl2+kUhL1SIjG0c
         hk/ZGaETkvjkCtC8ZyXHvnNfEtb+kb/P7ZiSfsSLYnovykdf19gNtKgFZtZYZW4S3E4J
         KmmQ==
X-Gm-Message-State: AOAM531DO9TIJUNfQoUfl2jk4JBYbLMYGx62s2ratXiKPiZza43IrJ2B
        6c9VRLJbk7GHpipGTvGJ5buEUEafjtVq9LGuceH4jw==
X-Google-Smtp-Source: ABdhPJzt0jB5rpAfTkUGxSG0noTVNMqIGE9U9VfWYa56x36a9dRYqTexkv3u2OLCm0zFG50xfKlKC4uRRYgkx01kxIo=
X-Received: by 2002:a2e:a607:: with SMTP id v7mr22447523ljp.81.1620231470970;
 Wed, 05 May 2021 09:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210505154613.17214-1-longman@redhat.com> <20210505154613.17214-3-longman@redhat.com>
In-Reply-To: <20210505154613.17214-3-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:17:40 -0700
Message-ID: <CALvZod7TzBVdwdCMChFNEZqYHxQUWBVfvWwtuAH-4rh_b4XRKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n> caches
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 8:47 AM Waiman Long <longman@redhat.com> wrote:
>
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
>
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
>
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
>
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for non-accounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and non-accounted
> objects.
>
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> have mixed accounted and unaccounted objects, this will slightly reduce
> the number of objcg pointer arrays that need to be allocated and save
> a bit of memory.
>
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>

One nit below and after incorporating Vlastimil's suggestions:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/slab.h | 42 ++++++++++++++++++++++++++++++++++--------
>  mm/slab_common.c     | 23 +++++++++++++++--------
>  2 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..f2d9ebc34f5c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -305,9 +305,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>  /*
>   * Whenever changing this, take care of that kmalloc_type() and
>   * create_kmalloc_caches() still work as intended.
> + *
> + * KMALLOC_NORMAL is for non-accounted objects only whereas KMALLOC_CGROUP
> + * is for accounted objects only.

I think you can say "KMALLOC_CGROUP is for accounted and unreclaimable
objects only".
