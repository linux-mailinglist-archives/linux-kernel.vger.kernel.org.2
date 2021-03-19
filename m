Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85411341EED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCSOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:00:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C80C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:00:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u4so12105152ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCZAHZFhptxcyqdqzzX/b+llWDB9Z2cdnFChdhi5Vwg=;
        b=hbuafUMuXP312PXrZHnMp/92FBrmirq42lyx06C8Agvn87xHEoPo7OQu6gl2wSVWMO
         I6doAnkI5UZ0G0OdBgSgw7TdfurM6EjLVZBa0M+Y5aZUPhfzckmx9H30C15CVZeAxFZe
         4uxJHzgd5zNB2Shl7VKLfHcAFXrQwXeJ22Nl9RzXfrTV9PaT8nCUomECivrsQ5FaaqiI
         T/ltkh0E+Md2wAJzG94MHdJ1IKPJKBvqP5Tsd9Cnyp/TB1utqQwprQzjEXCNltXpJ/xP
         zC8uwR6rKEg5aBhOXxJ5CgMIva1CslYrhntNPzlA5wX9c0C5QrxEKEd066vPiNwcTJER
         pPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCZAHZFhptxcyqdqzzX/b+llWDB9Z2cdnFChdhi5Vwg=;
        b=O/gYnouEdTG6enjv6ThxkWYEjAxaZe0GVjRregzvVXBB40ll1CpsHomqJDKcsF7B4C
         gJsEvMTr1hp1yUGOsuKMvLxO+qusZqW7P7yp5pGi6bxc+TmtdEFAwrGW+NxTwiUCaHaw
         vBhTicV0O6h2lrjfTTvCuSpuV5wkG3pdJch7BTT6XQ0/XANF3RhvVxnGmjTivxr2wnu+
         65WycW3Rahv0hu7o1RBYQPth/Xq0m32LI76JTk98PqscKGvFM3PjazfIo/rJzV/opiyW
         4+l0jEFUm5/j2/ZzsdOGLD3Ih6gy4V/k+H/xHn2r0x8gn0aEQW93Kz8NYVsMa7NyedRu
         ipVA==
X-Gm-Message-State: AOAM5311SN0JWdVq5JpMDh6CUgcT9zqPeTeTwJKlIDAkpl7Qb3edAnxD
        JrTNYCwoH2qp342FhtRvTrzvKm1C2qqxMX0mNc6Sfg==
X-Google-Smtp-Source: ABdhPJxvPa7ArMKA/Y/ImVmLoe1V8HmhdxX1uYodeH2iLbpXGcJj1hwf/NcUqerMm2CiXXwFFjQoGZ39+VdiMPpwnX8=
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr1035148ljo.279.1616162436265;
 Fri, 19 Mar 2021 07:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210319054944.50048-1-hannes@cmpxchg.org>
In-Reply-To: <20210319054944.50048-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 07:00:24 -0700
Message-ID: <CALvZod4RD6ALiQHrFBMWMytYW0Lg+RFZapKKSWJbK+-ue9BG2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memcontrol: don't allocate cgroup swap arrays
 when memcg is disabled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:49 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Since commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> integral part of memory control"), the cgroup swap arrays are used to
> track memory ownership at the time of swap readahead and swapoff, even
> if swap space *accounting* has been turned off by the user via
> swapaccount=0 (which sets cgroup_memory_noswap).
>
> However, the patch was overzealous: by simply dropping the
> cgroup_memory_noswap conditionals in the swapon, swapoff and uncharge
> path, it caused the cgroup arrays being allocated even when the memory
> controller as a whole is disabled. This is a waste of that memory.
>
> Restore mem_cgroup_disabled() checks, implied previously by
> cgroup_memory_noswap, in the swapon, swapoff, and swap_entry_free
> callbacks.
>
> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
