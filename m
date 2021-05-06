Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881237586C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhEFQ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhEFQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:27:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:26:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i9so2077810lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHrtdCMpJ6hTGURWAOvHXQBYIp09wPfHcz/BgTusvDM=;
        b=YcHASyyGjOsvRsAICnwedOYDgqo99c6xqPpr7ONmgJval9FdT1JKTMNjr+ttBlmuX5
         O9G6kxkAdR03YCgYcwQfwppEYuuJ2zUXhOLQFk3IDcuZwcBMwysip7HIWJb7otnMk6Xs
         JntofGvputZEgbhuUDJJvJkIU+sNp9zRECOqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHrtdCMpJ6hTGURWAOvHXQBYIp09wPfHcz/BgTusvDM=;
        b=Aauo33mBtBVpTQEUU7jJtIOLQudowYSPdUy6+gu2dlqtBWnrV8tn988cr1k0PbBxow
         YL5PRvUZhFEetwjvKmStmA/c1CLK9XmQBDsR7QFzT/mx7eFeywrj+TDnvQa4RomY6vEo
         7bU4lpMXG22m/o4yycRWrFAIyLRMp7mzPnZYxw2GKeaaRH6HG2CcoCthC3aMNxGPUSr1
         uN6pJhwAsejbZuLMgl25WJGxF6WRwYiyGRzUY/FhjfmSRnjdcsqqx3XqV+CDkrunGPGv
         YFoDCZ22OIyWor9Oo95+5vMh3ErhzcdLjLllDINr4EapOie2qZFV71MnXRXVcwKYMaap
         Aa7g==
X-Gm-Message-State: AOAM531s/dH+cZJPm+aj57UNlqnTBOnBLo8tg1YossA6ArPO8JQFpFiV
        q9oMI9BjsM3g61MiZnD7hbc+BMNUvMKVTNRjeIg=
X-Google-Smtp-Source: ABdhPJxVbIM5u8LD6vnhOjK67/JUdRxuWCaV4l94vcV8QVqsL7ZJI1GZ0ms+SUhf7X9kRwKqVB6NIg==
X-Received: by 2002:ac2:4a8d:: with SMTP id l13mr3525028lfp.493.1620318383971;
        Thu, 06 May 2021 09:26:23 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id u12sm1040164ljo.82.2021.05.06.09.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:26:23 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2so8663068lft.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:26:23 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr3443217lfe.41.1620318383001;
 Thu, 06 May 2021 09:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
In-Reply-To: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 09:26:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXY78yyGE4VEqiUix9NU0tZTBDO=DqEeSyJgBwVZ+Q=g@mail.gmail.com>
Message-ID: <CAHk-=wjXY78yyGE4VEqiUix9NU0tZTBDO=DqEeSyJgBwVZ+Q=g@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.13 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 10:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> Here are my conflict resolutions, if that helps:

I think you've unnecessarily done that "+1" twice:

>  +      /* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
>  +      num_resources = memblock.memory.cnt + memblock.reserved.cnt + 1;
>  +      res_idx = num_resources - 1;
>
> -       mem_res_sz = num_resources * sizeof(*mem_res);
> +       /* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
> +       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
>         mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
>         if (!mem_res)
>                 panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);

and I kept that as just the first one.

               Linus
