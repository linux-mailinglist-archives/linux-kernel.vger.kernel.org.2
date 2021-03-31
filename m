Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6203505B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhCaRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCaRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:45:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:45:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f16so24900998ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kmsw/hwl+PwZA/OoUPhEgtT+HF47fJNAsesqJoIn3Xg=;
        b=gviUTNYKc6PYqiFUOPiDVlgtPspFAYs2YumAmdXaWBuFMVUadGB09cD2WoeMMZpdha
         TJkAwhgad5rmuisPMXVmmTwV2gLFyM+EBqjox0HzfP7RY/N3BRafCYChfmjCnZLexspX
         /VnjqF4/drG8jiZOCyTirNvgdTJjUMyIefq2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kmsw/hwl+PwZA/OoUPhEgtT+HF47fJNAsesqJoIn3Xg=;
        b=mnxR61MgTQZqzRi1Vl5Bu5cTZjsF+3rGEl36NESAhYrpX9lVtl2RuOLZ/cG8QK/QTf
         3UGsmNyIlKWofuCcwkLv18rkzMjbfjhbgrDjiIPo963JHDip6pOL2PjxjiP3j1eLMxgx
         zlLzzhutpXLR+1JiOEArvXAz5uZJ2Tr32TWsHYCZRcX59uDspDdJXB/4W+bGSHzWoDtw
         qkH6k3rnpJUaH0u1mUG5Pmx1zSfreKvsFinKQrhHud56kjZn59jei+FCqWUb+GAZPDBv
         iL7Bdjjdo3+YlhfxOiCeWSjXyNBNpkyMQ4nfpG0Vz0Vq3wnGygyF+k3W8ZoZ3Hzn0Tp2
         59WQ==
X-Gm-Message-State: AOAM530hqpWV/Seb+yC6jD78SpNcq4RP2jxUaDAacjyU66s7JgD2XKfa
        Jhy1GpPBHLGIosOlzWIyA+X/K1AAm8IKTupe
X-Google-Smtp-Source: ABdhPJx9jbF7TpQwImIJKD7Voh6jXJY6OYdWwiXpMaYYDLwmN4/2Fgn6CS+/S41/xxWHgv8B8chWQA==
X-Received: by 2002:a2e:90c1:: with SMTP id o1mr2815890ljg.510.1617212722975;
        Wed, 31 Mar 2021 10:45:22 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f15sm291392lfr.51.2021.03.31.10.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 10:45:22 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id n138so30366712lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 10:45:22 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr2730138lfo.201.1617212717642;
 Wed, 31 Mar 2021 10:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210331092711.2b23fcff@gandalf.local.home>
In-Reply-To: <20210331092711.2b23fcff@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Mar 2021 10:45:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
Message-ID: <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling free_pages()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 6:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>                 order = get_count_order(pg->size / ENTRIES_PER_PAGE);
> -               free_pages((unsigned long)pg->records, order);
> +               if (order >= 0)
> +                       free_pages((unsigned long)pg->records, order);

Honestly, looking at that code, every single use of
"get_count_order()" seems really really confusing.

And really confused.

The comments are garbage, the code is odd, it's just all very very strange.

See here in ftrace_allocate_records():

        pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
        order = get_count_order(pages);

        /*
         * We want to fill as much as possible. No more than a page
         * may be empty.
         */
        if (!is_power_of_2(pages))
                order--;

can you actually explain what the logic is here?

The 'get_count_order()' function will return the smallest order that
the value fits in. But then if the value wasn't a power of two, you
subtract 1. If I understand the code correctly, that's just the same
as "what is the highest bit set", isn't it?

So afaik, what you *actually* want is just

        pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
        order = fls(pages)-1;

isn't it?

Did I misunderstand what the code wants to do? The "No more than a
page may be empty" seems wrong - you really mean "no empty pages".

I dunno. Maybe I'm wrong, but that code is really confusing (which is
why I may be wrong). It doesn't seem to make any sense at all to use
"get_count_order()" and then modify the end result.

             Linus
