Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24666373F42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhEEQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhEEQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:10:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28876C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:09:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h4so3401939lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKsuEFeD+gJYSLJ7ekg4hfVqsnbJkGKmSnFbVOc/YJ0=;
        b=pGurct48b4cD8PojrnEnwDogn490UJ9vqixvhsKhgQxNctHN1tmUuM3UD9+ybdnCIY
         UxaEbOhE28qlVJbcYa48VZQspRkpa6R+BdyW29LwM/CJLY+97Y+uD6Cp5fdO4dnPj2rX
         A0mfjYE/DSuuRi1bqPpZG1hrFxCO7tuqYHZDpNQeXKfe+E+ImMxuIh9hdW3twa5HeDV6
         G2NJHXEeRLfd4fcv1JDhs3H8kWGJrtpuq9tLRg6pUf6vAquDmBcDLuBANRZ1u8FO36ON
         PDLNDLz8lbu0hary8tnz00mf3UhHAdg/2teGSWUTWOyMpHy/jr1tEsiXr/46vVNPzP75
         9Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKsuEFeD+gJYSLJ7ekg4hfVqsnbJkGKmSnFbVOc/YJ0=;
        b=sGeULVt2ZdLRE5Uwjw+iCejihmMyJ/HQWykayOWa+u6DBHYvVEYaPJkcp6cMzIz/yT
         aDMhpVHGDE/Bq0a8PXN4FUMsVcLVjD2pou1NqcXoujuaQBV01WL/b2xOo+zndWaqpNLn
         YlPZNL+qmT7ugCCChLouPj0Sl5jdgncio+7rt9bKvcH7YuNzPk/h+7pZ8h5Xz8upkMsT
         GEhwZ5/En90JN0Eb9sVneWAiux9MtnkOlIn/QysjaqrWeG2TwUR2/UnuN/k0eNkw/H8t
         PTFw2Ftai0YARKL8gPqSb0SG9esnboJ0iZw39a7KszoN7Z9943d99krwOrpkI5mC1+S1
         oCqA==
X-Gm-Message-State: AOAM530KamBN7CCHUFyC/2keRgCifzHNtEpo76pGAQ82mR7bYtfqWMa2
        c3HsRAhHcBWM45JJ/bDjlRHWze6WxkQ7pb4vjT1J6Q==
X-Google-Smtp-Source: ABdhPJxwJ64DO2bcAnK++U2Uq7VZ5qveX0vCIByuvshyxCHklvLxOYW/x/1x+Z2L38EpLEypgc6eYhFyefEOpbx9m1A=
X-Received: by 2002:a05:6512:92e:: with SMTP id f14mr20767256lft.347.1620230965352;
 Wed, 05 May 2021 09:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210505154613.17214-1-longman@redhat.com> <20210505154613.17214-2-longman@redhat.com>
In-Reply-To: <20210505154613.17214-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 09:09:14 -0700
Message-ID: <CALvZod6AfOiKC3tmnJzgAJEUKwXwS__n8on59qbmHyHG2XAc4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
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
> Since the merging of the new slab memory controller in v5.9, the page
> structure may store a pointer to obj_cgroup pointer array for slab pages.
> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> is not readily reclaimable and doesn't need to come from the DMA buffer.
> So those GFP bits should be masked off as well.
>
> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> that it is consistently applied no matter where it is called.
>
> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
