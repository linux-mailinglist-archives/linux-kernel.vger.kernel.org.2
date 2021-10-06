Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DD423774
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJFFWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 01:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJFFWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 01:22:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04FC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 22:20:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t9so5347393lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciDVGqsYOH35J7AcMoo3IqFXoCRGKtna/4nNh2oAa8I=;
        b=PX0XPkQdsK6VcV1+qe5E+Ws3MuZHQRH5zK2EJhibfZ1p+ae4ZLUqE2uyBANAjRuZCx
         GeXpFV/AWrWBo/t32n6nw7eG4uGD/5B7/23okivlIH+KKES5dAZfgyXnQ8zz89hrnhPM
         liKp70d2Hxfq9gkAMHIEsKT5+fjZa7TZwmjSBJXjsXXQEkrxQdL0FD32ljWrdxHAMCbX
         WnJASMLr+YbRvIAuQ2AVgfQQBurUUPQzn36gJAv4Bo6RUWXkC5/e0yQ0j6zENpg0Y1xI
         6hc+6ZYVIm6sWazuZZAzbzbGlbefkJHxqehgLmcH6zD4QcLJtCvSBX/YGszd1nb/k+W0
         vdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciDVGqsYOH35J7AcMoo3IqFXoCRGKtna/4nNh2oAa8I=;
        b=X36I6zCYMMF97tirT9F4nzH/fp1aaG5Ck4fZBdBEhJbESJdBZrT/k1mpwkoKudW9Hn
         xhwh/nvkgKTWCYLudORgjRgAxtKYfw7QKSkyuPJRdGlzn4d42w2lImFEPdDq6yCYmVBN
         zmRKPVRGIwKmWlKPCCjEP7oDDJdVXgtM8SSuOLe5DFDnp6UmYe9TUftt1dSIhnOGI0ws
         nXjkIOUwIRLqR0udhjaDQZrJRHPR1XcZftDUHdbTwRCE0m82TN2Gtz3tRXerz8aLIz8N
         vBe/oD1qJ61ekwS9ax5jAaEyiNzf5r/6zgFJMxhtbu1R/HOs+L56v3vBT1ciJXCjgplv
         UyXA==
X-Gm-Message-State: AOAM533fA1oRoQb8o8rLtmBcUMT23MfdrH+EVuwotbbSGf7a+Sf2Qgda
        yOO4hiPHE++0xSwvN7JogA3EmDIR3spDaGnJOLWUvQ==
X-Google-Smtp-Source: ABdhPJwOOgy1WotQnWFPm8n0pGDBcluDmJgc+49p7hGhcTZ2QvP2pF5lVEYlLy0mnXHpJxuod/wIwBgpVBsKuG446WM=
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr7906462lfv.8.1633497656441;
 Tue, 05 Oct 2021 22:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211005202450.11775-1-longman@redhat.com>
In-Reply-To: <20211005202450.11775-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Oct 2021 22:20:45 -0700
Message-ID: <CALvZod4Rhv8vSVRGnqHwRuuBHQ=E-YZk7JGjRWHftM4+9cSQ5A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 1:25 PM Waiman Long <longman@redhat.com> wrote:
>
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online which can happen when
> online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
> is confusing and it is more clear and straight forward to call
> memcg_offline_kmem() directly from mem_cgroup_css_free().
>
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
