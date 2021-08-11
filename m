Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093EF3E93F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhHKOuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhHKOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:50:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:49:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so2988935plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDnjBmZu+OVbXaG5KDGErJI9ooCYzdcsXQzIphBgiZk=;
        b=gVE+g3XOeDah2oFeHf/FlsGK0oJeQOYoD71xLHyYwv0JmSwmjre5q4PIkBgPQkchhJ
         8fkOjnWv/Eth0g9MTfdndrraXVQEH+JAkLnfONhYv9peGGfc4rAKj6pjc2tzTn7vx2zY
         GugIB9dfyeXmM1UQt2S9jUnl2e0Iv7eynpPKXVVyUcnapGULQoEBgf/kzKRXiF3HzLLT
         CZK5TpvkBGMiS17G1SXgBhz9X501zE6MgLqnd6Ig7YG3++QdNWCLcLKIjL4toGCJelZM
         xFet6NkSUz0aT+cP/zifa5AGNAdeyeDkySmlTWlt7kELp9z2NoYTRvawlFbj4lyJrJQ8
         3lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDnjBmZu+OVbXaG5KDGErJI9ooCYzdcsXQzIphBgiZk=;
        b=RNVLG8DKNDow8yz0F8PE29vvTpPdG30HoqxIj66VMrohksveiaD8bZuHYOglzzJl2h
         fQ5xYcwrt/oVCV1bLYnJe87PXywwlcVqgU7c7yuiMuTRXPQJxds+2akyTFd4CEms655W
         w2ySPTC0iX88r3R+Ghyw6P3+7+Z7r1VF/F5q7Y3wz7pJY5FUJzP5VmvuDWe1wHohDHJy
         BEGTnTDp6g4m/rpIBLoayGuEncNnpt56szJlrLqaeAJNGZXqzx2TfyUP9gleJboSqd5c
         Uh3wtESC0HYEbMsnIroc1n85QzYyUvTEhzXpCzGCtGAvHhLGUdsxZ6qZ5pmhxvRawv8F
         tvNw==
X-Gm-Message-State: AOAM531USP7/QhX3lBzGw0rwRR2wmLHoAubWi4RTJsRtFfykmYWfmG+U
        VKVWuqiRxD67TnxVjFqvNSs8fcwFf7NJ+RdLfwI+1w==
X-Google-Smtp-Source: ABdhPJy8gKbQMEN57ufMIlxMjl9J81GQWv5iNmCH9MH+NbeR1Xf3RLNKdqDomo4rsSovdB5SFoqQYvaHbybkCrYUYSY=
X-Received: by 2002:a63:f804:: with SMTP id n4mr79075pgh.341.1628693382413;
 Wed, 11 Aug 2021 07:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210811111921.85999-1-songmuchun@bytedance.com> <0d6c3e3b-c270-bb7d-c038-64ee3f0257cd@suse.cz>
In-Reply-To: <0d6c3e3b-c270-bb7d-c038-64ee3f0257cd@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 11 Aug 2021 22:49:06 +0800
Message-ID: <CAMZfGtW=TXQQuu=f6ndoNUcaVe7O0SOGRV9J=Zf=Dz+MfMorog@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: remove preemption disabling from put_cpu_partial
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 8:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 8/11/21 1:19 PM, Muchun Song wrote:
> > The commit d6e0b7fa1186 ("slub: make dead caches discard free slabs
> > immediately") introduced those logic to speed up the destruction of
> > per-memcg kmem caches, because kmem caches created for a memory
> > cgroup are only destroyed after the last page charged to the cgroup
> > is freed at that time. But since commit 9855609bde03 ("mm: memcg/slab:
> > use a single set of kmem_caches for all accounted allocations), we
> > do not have per-memcg kmem caches anymore. Are those code pointless?
> > No, the kmem_cache->cpu_partial can be set to zero by 'echo 0 > /sys/
> > kernel/slab/*/cpu_partial'. In this case, the slab page will be put
> > into cpu partial list and then moved to node list (because
> > slub_cpu_partial() returns zero). However, we can skip putting the
> > slab page to cpu partial list and just move it to node list directly.
> > We can adjust the condition of kmem_cache_has_cpu_partial() to
> > slub_cpu_partial() in __slab_free() and remove those code from
> > put_cpu_partial() for simplification.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Please check again current mmotm/next if this still applies, I think it
> shouldn't anymore. Thanks.
>

You are right. I didn't see it before. I guess it was merged
recently. But thanks for your reminder.
