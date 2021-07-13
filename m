Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E263C7017
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhGMMGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:06:43 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:47088 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhGMMGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:06:42 -0400
Received: by mail-vs1-f48.google.com with SMTP id e9so10608942vsk.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ/XATmEw2FOvWYcKuc48jTHeHh5xPl/7xffQRs+CgY=;
        b=HFp3djgKOtqg6+QwjeSqXSUzCWX3ljs+otnqiIIVb1SskOhVUBFdD0opGC+Q7ECT51
         svIvT7fSQdeoFjy+Bk5xOtWAxVeEoScSknwLH//TAM314BO++1iKHy5n2NbzgDINidXf
         QpOfVFoIkngvmbyWi2I4XgHZPcOw4BCzWzH1aKzmDBvjk8OJF1blV7NzJP32ppWXlJkQ
         7MxDp5sOStIaFrWv4wgrbL2K1mcaFahSpSExgOlji7Or1veBcSSBu6oCsD+e1zqg1SrW
         p3XvX1dU9fpkIR3l/t9n48mqIXo20Bqt0hfvjkUZF73Qc4l6eki2lb/zxxuSSa+OADaF
         J9iw==
X-Gm-Message-State: AOAM531qcJ+Vf3zSKm1p5hcLO1/C/dYQMTdJv4He4awA3va1fFbdk5Cj
        g1E6ET1Itum3E+aM2rugIqva1Tpyv8YB8W+MdNE=
X-Google-Smtp-Source: ABdhPJz/wYxiMEghMEpeCH26yZOIcHTipXqFk2MKx3dtSnvRcQq5ZNTfblEiJ56qKYYPOx6Lu73/EnheHrxuPN8B8CY=
X-Received: by 2002:a67:8702:: with SMTP id j2mr5598475vsd.3.1626177831098;
 Tue, 13 Jul 2021 05:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210414163434.4376-1-glittao@gmail.com>
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jul 2021 14:03:39 +0200
Message-ID: <CAMuHMdW=eoVzM1Re5FVoEN87nKfiLmM2+Ah7eNu2KXEhCvbZyA@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
To:     glittao@gmail.com, Yogesh Lal <ylal@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver, Yogesh,

On Wed, Apr 14, 2021 at 8:08 PM <glittao@gmail.com> wrote:
> From: Oliver Glitta <glittao@gmail.com>
>
> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
>
> Replace field addrs in struct track with depot_stack_handle_t handle.
> Use stackdepot to save stack trace.
>
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the future using the stackdepot handle
> instead of matching stacks manually.
>
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Thanks for your patch, which is now commit 788691464c294553 ("mm/slub:
use stackdepot to save stack trace in objects") in v5.14-rc1.

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1891,6 +1891,7 @@ config SLUB_DEBUG
>         default y
>         bool "Enable SLUB debugging support" if EXPERT
>         depends on SLUB && SYSFS
> +       select STACKDEPOT if STACKTRACE_SUPPORT
>         help
>           SLUB has extensive debug support features. Disabling these can
>           result in significant savings in code size. This also disables

This change increases memory consumption by 4 MiB (or more, see below).

Looking at lib/Kconfig:

|   config STACK_HASH_ORDER
|           int "stack depot hash size (12 => 4KB, 20 => 1024KB)"

The sizes reported here are not correct, as the actual memory consumption
is not STACK_HAS_ORDER bytes, but STACK_HAS_ORDER pointers.
Hence they're off by a factor of 4 or 8.

|           range 12 20
|           default 20

Does this really have to default to the maximum value?

|           depends on STACKDEPOT
|           help
|            Select the hash size as a power of 2 for the stackdepot hash table.
|            Choose a lower value to reduce the memory impact.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
