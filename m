Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC63618B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhDPET4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 00:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhDPETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 00:19:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 21:19:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so40085304ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYPjZinW4Vog3I9TnLyI0GoInS9aoZ8KHr6MlIE/U9Y=;
        b=JV97mdetnzQPwWYULXzQjwsDFwoXrfrVaelXO+XvlFqj7bz4KYuzZKmPuao7s+MaUK
         4Bdx2aPtqgH2NwImTLgv0agvRRC8e3CjWz6v99oxuUgfCaFuXqJbQNO8kbtgrZZNSxN9
         F2gE5PpzvsAj5vkcViGixiDc5dGMp7wcJd0JzucJf/X44Zzm6T/8D8TBh2u67RPxbfRO
         z2fmcWX3BDU2+NB75rYo683lljBvPaJV4CdNY9JlA3F6SRh/29U7DUIl+8RKiTnTqiyi
         8HySzAT3iqDNgJ+qIwg9U/9CJg/3qGDxgGoXlAUJ1FVrOdlfxchghfPIx/9bLOhfgtkW
         SS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYPjZinW4Vog3I9TnLyI0GoInS9aoZ8KHr6MlIE/U9Y=;
        b=R/sbymcj1pZt+az6GqA2NhtRXGdKUOIlvihqgKyH7U6mkE6FThZpbQa57Mq9mHmC3/
         m7URaOyzAEigcouUVN64rhtoUfYQsHUY9o3dzqSGlbgHJKmv54W30vIipPWB+SWeI8Fk
         3XSpWPnULOMpJjZ7QXdRLJwOS+H6m7n4/nPHF88Eia+eXZn2ryoRBZlvrFoCsG3DWIvx
         T+WN/JT+JJwgkJmzm3cY0lYXEbvLVrbrPBW8UEB9kT+wEQvMUi6dPcq6NZ7jkCHQquCi
         WzC2aFn/t4HYm5BvhcZwm1l1gCI9E2eI5tV/tnu4d5RZORXCd9MMNLDcLmDPCfU//L5z
         Mnzw==
X-Gm-Message-State: AOAM532ES3yz/gzI/hPG2ucHHm6aM53sH7MLExMcUfRIaVeQNhh1BzxY
        1Ag5svMHGPc96BNSIiRvhxc90+VPfrwtPC/Ijdd+7Q==
X-Google-Smtp-Source: ABdhPJxD9dfxeOsgGmfqe+w1gIEwZ7QHRp/Y/l6TVaR6etOgU4eBcst1e8X7wND65V5EZEqALyErpFcU6soADVBAuMQ=
X-Received: by 2002:a17:907:20e9:: with SMTP id rh9mr6672157ejb.523.1618546769476;
 Thu, 15 Apr 2021 21:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210416025745.8698-1-apopple@nvidia.com>
In-Reply-To: <20210416025745.8698-1-apopple@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 21:19:18 -0700
Message-ID: <CAPcyv4grDqR09QWv68sJY=AXMDom5MSj40nOHaE+nKP9d9qc+g@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/resource: Fix locking in request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Muchun Song <smuchun@gmail.com>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 7:58 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free.
>
> region_intersects() obtains a read lock before walking the resource tree
> to protect against concurrent changes. However it drops the lock prior
> to returning. This means by the time request_mem_region() is called in
> request_free_mem_region() another thread may have already reserved the
> requested region resulting in unexpected failures and a message in the
> kernel log from hitting this condition:
>
>         /*
>          * mm/hmm.c reserves physical addresses which then
>          * become unavailable to other users.  Conflicts are
>          * not expected.  Warn to aid debugging if encountered.
>          */
>         if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>                 pr_warn("Unaddressable device %s %pR conflicts with %pR",
>                         conflict->name, conflict, res);
>
> To fix this create versions of region_intersects() and
> request_mem_region() that allow the caller to take the appropriate lock
> such that it may be held over the required calls.
>
> Instead of creating another version of devm_request_mem_region() that
> doesn't take the lock open-code it to allow the caller to pre-allocate
> the required memory prior to taking the lock.
>
> On some architectures and kernel configurations revoke_iomem() also
> calls resource code so cannot be called with the resource lock held.
> Therefore call it only after dropping the lock.

The patch is difficult to read because too many things are being
changed at once, and the changelog seems to confirm that. Can you try
breaking this down into a set of incremental changes? Not only will
this ease review it will distribute any regressions over multiple
bisection targets.

Something like:

* Refactor region_intersects() to allow external locking
* Refactor __request_region() to allow external locking
* Push revoke_iomem() down into...
* Fix resource_lock usage in [devm_]request_free_mem_region()

The revoke_iomem() change seems like something that should be moved
into a leaf helper and not called by __request_free_mem_region()
directly.
