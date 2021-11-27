Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3B45FD1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347024AbhK0GoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 01:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhK0GmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 01:42:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11669C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:39:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z6so10959486pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrNphKelcE824PrzMZCiCnCbbnyo/PzJZlqphLlfwjw=;
        b=H7s3m1arjAymfkT6oXYSsfcF5yvJE5kPbMVo/OGyTqvPbQX7k3VMvp71X9OM/izJ0s
         5zAsqn1RZHeb0pyYdHk5xq40tqE4GpkNnzQBnCHj16a2b5VQzakIkdiVKFQfE3VLYero
         Himo4kFQ+9hqF0mIiGwTZ6is3nqpZsGKyFZhQrLT2vDOODKn/Kxpf7uWXj4S1ScR1cpv
         ZH9JjsAJWzceCgnK5oQxX4xXloCRyibHsB7MAYvIMr2QT+fOx5fTrbw8DSEUK4/lMIMb
         1tu/a6n/Br/16JcKD+aeaWGN/2ipJFQ7GJ8CY6gbhd0Gi7kgI+tj3X/wc2V5F990rFBw
         wh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrNphKelcE824PrzMZCiCnCbbnyo/PzJZlqphLlfwjw=;
        b=lWbzBgYp0mp7BcIqxWZjh6KE/a5b/FYfJikOOalbFvAY9DqFCAlON+ELDjdax/YdSb
         2IjFkqXE7ckC21YOEDTTJZZdkn+Z/sPZgxYdHQExjy3sXjgmknnxRAdCN2E8kR6CHXI0
         negebzhTS0udynLG5HH6BMeUPUwwoALgxeesI6UHfymqCDGCQJ4hvINh4I0mgGFNO07C
         J9GCbtHjMB6ht/kZACsTYPFNe/Y8ZPwnY2vmZPIkrJpOK93ykRkyBGpRFJiU8OPQs4JH
         jq9h250BQ3YurwFmx4z7bL2PmOQwYYwBmdV/VKlZf29xcWaXuBmGKxrpWPbdSODydFvX
         eBXg==
X-Gm-Message-State: AOAM53094ask2OFKK4mgAj44POIHh1TNkTYgfYmmfCF9Km6K6A7tqqYk
        4dR9Lj5qdBJIwk07LwNx1RYYjLS3u7v8x4M5IAc=
X-Google-Smtp-Source: ABdhPJzM897f61Es3uszzMcgXdiTLyNTXiZEfQshFb3jA4WRjOD5yRnLCAniccavSmkQxONdmGNzJS/tcIxoJ+B5TDY=
X-Received: by 2002:a05:6a00:1a8d:b0:49f:de63:d9c0 with SMTP id
 e13-20020a056a001a8d00b0049fde63d9c0mr24824374pfv.79.1637995149466; Fri, 26
 Nov 2021 22:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <20211127042540.96249-1-goldstein.w.n@gmail.com> <CANn89iKaTyrNZHCg7i46-db_zudXs0V-BvmwM-5fYLZT2yQr4Q@mail.gmail.com>
In-Reply-To: <CANn89iKaTyrNZHCg7i46-db_zudXs0V-BvmwM-5fYLZT2yQr4Q@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Sat, 27 Nov 2021 00:38:58 -0600
Message-ID: <CAFUsyfJVM_RO5Fy2PyerxiQipz+Nw4oXc0-gm9rR59AHpmqw8Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 12:03 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 8:25 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > Modify the 8x loop to that it uses two independent
> > accumulators. Despite adding more instructions the latency and
> > throughput of the loop is improved because the `adc` chains can now
> > take advantage of multiple execution units.
> >
> > Make the memory clobbers more precise. 'buff' is read only and we know
> > the exact usage range. There is no reason to write-clobber all memory.
> >
> > Relative performance changes on Tigerlake:
> >
> > Time Unit: Ref Cycles
> > Size Unit: Bytes
> >
> > size, lat old, lat new,    tput old,    tput new
> >    0,   4.961,   4.901,       4.887,       4.951
> >    8,   5.590,   5.620,       4.227,       4.252
> >   16,   6.182,   6.202,       4.233,       4.278
> >   24,   7.392,   7.380,       4.256,       4.279
> >   32,   7.371,   7.390,       4.550,       4.537
> >   40,   8.621,   8.601,       4.862,       4.836
> >   48,   9.406,   9.374,       5.206,       5.234
> >   56,  10.535,  10.522,       5.416,       5.447
> >   64,  10.000,   7.590,       6.946,       6.989
> >  100,  14.218,  12.476,       9.429,       9.441
> >  200,  22.115,  16.937,      13.088,      12.852
> >  300,  31.826,  24.640,      19.383,      18.230
> >  400,  39.016,  28.133,      23.223,      21.304
> >  500,  48.815,  36.186,      30.331,      27.104
> >  600,  56.732,  40.120,      35.899,      30.363
> >  700,  66.623,  48.178,      43.044,      36.400
> >  800,  73.259,  51.171,      48.564,      39.173
> >  900,  82.821,  56.635,      58.592,      45.162
> > 1000,  90.780,  63.703,      65.658,      48.718
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> >
> > tmp
>
> SGTM (not sure what this 'tmp' string means here :) )
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Poor rebasing practices :/

Fixed in V3 (only change).
