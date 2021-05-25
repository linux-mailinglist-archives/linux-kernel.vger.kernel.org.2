Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4A390611
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhEYQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhEYQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:02:21 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:00:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id w15so38817162ljo.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlGDwi+fKb5zDo0UgCxQb6+0ejL9MD7uZrEbLSa4Oto=;
        b=F8IoZ31vbu3JuKyp9XnxNMl6YxtNA2oECxMIbLi9v7US/TCuDrFIPmY876ESiknlBc
         cAKK1IAGOHcTMDm51QNr9q62Lx/yjQC4eiavpb6wfgGZnDi8R1R24k+pZ5+7OWIBjSnt
         f9C0aKQJlR8IR67wEbnAeeJWeez+R+6+5yuntCPH5gVMbHonthRDAgW1/EI5npLjF1vh
         hZx92RzdJKVaAhRzMmxq2psslRuA4eZJGhEzyNUOh/fFOHmlGJGhJ56xXtI4VCj4fZJv
         giLk1Ue6Dnsmns3bHjtEQwj0Oz8LWpgllGSbx2TmVO8qpVtEearWBhhmTpzH3st0oC99
         Pf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlGDwi+fKb5zDo0UgCxQb6+0ejL9MD7uZrEbLSa4Oto=;
        b=Dam86gKqLfIsMPYG9c++J7UGYeskhOUcNy+Nc7R/fJE+9VIuzgoXZ6NiZYsvHhTOk5
         HxvzfNfNNVnFRQ6CJwsC2qXA2xyD3d9iGVAmq76zGmxeiEBpNLs/I+cNA8LuvUky6D67
         8dr5C+y+eAUF/e75yBuy8rfDTcXiK8j16HmI04GFEcrOTO8a2HMGjPdiN/dyoog7p/c6
         JCi3bFB8Sdsme3KSBRtoqP9VWJXr39dzL0eCq/XKw0+CA3LYEcIrDZpMSgqvjhB2WOO4
         WbAB/ZkO9UCvwmZ8RGOohs0iTgsZGFQPVcQ9+0YgOFnNKbYRgczC6dGU4cHpcraryVnS
         mvtg==
X-Gm-Message-State: AOAM533YW2WsTtigKDxWY1Vs7PvvZmNeZdPYFwqpS2Zhh3zNFLQB3cHp
        fQdCAsvRTDH2f63eiFbazLVglXpNDHfB9KXCGz8CAA==
X-Google-Smtp-Source: ABdhPJx9xYr2Q9z8EeDwQEaSd0fE2W8VGVS1cMT3ZD+4m9iso3u01S1B4hRaNGxuBydJN6h2WIrDsTxaLTS5pE2QPtU=
X-Received: by 2002:a2e:b4ed:: with SMTP id s13mr21295934ljm.86.1621958449402;
 Tue, 25 May 2021 09:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-12-vbabka@suse.cz>
In-Reply-To: <20210524233946.20352-12-vbabka@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 25 May 2021 18:00:23 +0200
Message-ID: <CAG48ez0mXxqLdSse6OpAMLNxSMc7nNor8PXk=kagPppGAXAXgA@mail.gmail.com>
Subject: Re: [RFC 11/26] mm, slub: move disabling irqs closer to get_partial()
 in ___slab_alloc()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 1:40 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> Continue reducing the irq disabled scope. Check for per-cpu partial slabs with
> first with irqs enabled and then recheck with irqs disabled before grabbing
> the slab page. Mostly preparatory for the following patches.
[...]
> diff --git a/mm/slub.c b/mm/slub.c
[...]
>         if (slub_percpu_partial(c)) {
> +               local_irq_save(flags);
> +               if (unlikely(c->page)) {
> +                       local_irq_restore(flags);
> +                       goto reread_page;
> +               }
> +               if (unlikely(!slub_percpu_partial(c))) /* stolen by IRQ? */
> +                       goto new_objects;

nit: I think this comment is wrong by the end of the patch series,
since at that point, in RT configurations, it could also be stolen by
another task, if I understand correctly what migrate_disable() means?

Similarly the comment above ___slab_alloc() still talks about
disabling preemption for bulk allocation.
