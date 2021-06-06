Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA239D175
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFFUdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:33:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF46C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 13:31:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d16so11523992pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJw8DZU4yi86LnpH4Q8S+TCN5lpChk0DAgboMArge9U=;
        b=WRfP4cqukcmbPDthuW3N3/UKU+5lw1IPToj/yRY3sZmoOYdaAzhiSwskVQMdvbmfFs
         iWiqLIqhCfFBFVm1vj5gINDhgR3z4aB8aLYfA0KGyISwMTHNolDPVjoCUzCGM2AuFXpk
         OOBvD35VvqeimPiuKq+T2S1Crh3d/qt8OJg4rUS0lBpHD5nS71fr39Q54ksXdZ87Db9p
         dAXQrY7lJD0+TnIDmLSv8MUunB64mfvPLvKPGC8ci99ZELTLa3aoedKSSTvI1LR+BkaT
         gKtczoASYqFSCDt7oWLH/Gk4X69Z8XdIn9yz29VZL5Lz9x6kfHzTihlmRp9ZmnNbzch1
         ssiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJw8DZU4yi86LnpH4Q8S+TCN5lpChk0DAgboMArge9U=;
        b=udgF5iW3JQdS8j2u0XLD9QfoZ8Nz19GfYHks4dNLlZXjC2w3Z78h7xPEoKwZZKCD0x
         9OjxMa9Zr0XCBMa0f5wZ4pW/y+Rc0dSDqtjH1fBKnW8H9hZnMoFAYABlVNYTwewJYEF9
         +Fg1uNKTXg9xwrwuv9Kak2iRWwWIN+KdJ/P+xO4EVq/RZgM+J+1wgc3/U7wHKJ3jfs46
         /hIgvo6fCs37k1UA6gnJuB+zPld5TQUSjjfvQLR5F31eeDHCqTOqGN4uq+7jES3ZDnbX
         l5QdYu1D2NewR7p6ca51MZkAZElq2SCA/8SdemBdKJhLerv8Qm4TH8jXXQisr0k2Jqr/
         cZ7Q==
X-Gm-Message-State: AOAM533Q7lvZnJ0+QGR8oPlX0ZqI8WLGLAiK3ZcAJquMMx2WjkxDtWL/
        izlu2GJ5VW1e6BG/sZ3dGl2e+ATV0K5PbEmG/3E=
X-Google-Smtp-Source: ABdhPJzTHcDivLpAKsIXprg7NM6DRuXQpT6zs+lkC1COf1HJRlayDCT+SWTjgYluLWtxFGnPI0/C+iWdXqJGqKrFZsA=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr14908427pgc.203.1623011505684;
 Sun, 06 Jun 2021 13:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
In-Reply-To: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 6 Jun 2021 23:31:29 +0300
Message-ID: <CAHp75VdM0aziN4zHaf6=z6D0Nb=+GTbjV1pdTpRZ=yxGDZRkhw@mail.gmail.com>
Subject: Re: [PATCH v10] mm: slub: move sysfs slab alloc/free interfaces to debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 7:16 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere

limitation

> to "one value per file" rule.
>
> To overcome this issues, move the alloc_calls and free_calls implemeation

implementation

> to debugfs.
>
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.

...

> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +void debugfs_slab_release(struct kmem_cache *);
> +#else

> +static inline void debugfs_slab_release(struct kmem_cache *s)
> +{
> +}

It can be one line.

> +#endif

...


> +               if (l->sum_time != l->min_time) {
> +                       seq_printf(seq, " age=%ld/%ld/%ld",
> +                               l->min_time,

> +                               (long)div_u64(l->sum_time, l->count),

Hmm... Why is the cast needed here?

> +                               l->max_time);
> +               } else
> +                       seq_printf(seq, " age=%ld",
> +                               l->min_time);

...

> +               if (num_online_cpus() > 1 &&
> +                               !cpumask_empty(to_cpumask(l->cpus)))

One line?

...

> +static const struct seq_operations slab_debugfs_sops = {
> +       .start  = slab_debugfs_start,
> +       .next   = slab_debugfs_next,
> +       .stop   = slab_debugfs_stop,

> +       .show   = slab_debugfs_show

Leave a comma here. It might not be the last one in the future.

> +};

+ blank line?

> +static int slab_debug_trace_open(struct inode *inode, struct file *filep)
> +{

...

> +static const struct file_operations slab_debugfs_fops = {
> +       .open    = slab_debug_trace_open,
> +       .read    = seq_read,
> +       .llseek  = seq_lseek,
> +       .release = slab_debug_trace_release,
> +};
> +
> +

One blank line is enough.

...

> +       debugfs_remove_recursive(debugfs_lookup(s->name,
> +                                       slab_debugfs_root));

One line?

-- 
With Best Regards,
Andy Shevchenko
