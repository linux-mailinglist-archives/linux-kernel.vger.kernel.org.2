Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063045FD01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 07:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351826AbhK0GIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 01:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbhK0GGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 01:06:45 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:03:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v138so25642697ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adY8mfuFzwIDbnC96OKG32RgLOCWTKObyT/Jlr8SbTk=;
        b=CqVEMGglKcCPOL/ugP2AAvv+Sj9+in22zmiG2AR3MCI8FmsYzlnLKzQMAjha+InILW
         gOHJ9UmMkte8xWgW4Ov7xEPOL2+U1H1QLABkKHTN3sDzKCl9qLkzzoPxvtl8KktAJqZU
         YjFE+4XpNxiPz9uOi8r6NphSpj0L5RVII9KWOsRZ+8r070iXpkCtTXKwOzL/zhLc4Fam
         OdvuhUvHLUMSyKypaKsGcfLM+KHw8mn04yMY2/5KKo+YkB5+iSQPFXQtMYFbpsg/jSN5
         OrHfQL569f+QUtiLulTQkQEmNSw/aCSy5FLVHz8ZvX1BftcfIRUAAa1l3x8CUjIBH/xt
         Ky3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adY8mfuFzwIDbnC96OKG32RgLOCWTKObyT/Jlr8SbTk=;
        b=OWSAEif1KOFAYkUb6QArSp6uOHrk+Pn2HU4GEIu4q/ka88GtubfaYP+mZGhH6hgai4
         IVbLDZrrE1kzLiJb7EQ5R/9G7iGsfnhkbEmZ2NrLddQJb+km77U6yg2541LT7wnp/E5a
         N38F7hQU9poaysscmZo1w6cX7psDKsGJL+9Zge473vtP7EOTAivGXXTQtF1Go22fuwGa
         JHktyh5MZMx2cVoodlJ8R6PdWj5r+7J6e1mZ/o+ySpDi/26fKN09RhoCPG23r0SSU737
         n+gi4HjUuAFdMGB2L6UERv3mX35J5lhtqnV8yInroFZEIWBbyWIt0UqolwamogU0/ukW
         wIzQ==
X-Gm-Message-State: AOAM531MGnwMEypNcfYHlrFwsADRKpNnbsTcVWjKVPi+HYNf7LmHnRsl
        pKbu7sZ84BPfI0WjMUcbtE68UK9DDLPvc2lSLPjBCQ==
X-Google-Smtp-Source: ABdhPJz4by1puZpUjUzOgbQ7Wk9Q0sOMxJXGLTE1dBUH/hW9/7Pak4HLMS2oFK1Pj6w4eg7ZS2I4SQPHTK8jd7Zj0Hg=
X-Received: by 2002:a25:2fd1:: with SMTP id v200mr21300942ybv.78.1637993010232;
 Fri, 26 Nov 2021 22:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com> <20211127042540.96249-1-goldstein.w.n@gmail.com>
In-Reply-To: <20211127042540.96249-1-goldstein.w.n@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 22:03:17 -0800
Message-ID: <CANn89iKaTyrNZHCg7i46-db_zudXs0V-BvmwM-5fYLZT2yQr4Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexanderduyck@fb.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 8:25 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> Modify the 8x loop to that it uses two independent
> accumulators. Despite adding more instructions the latency and
> throughput of the loop is improved because the `adc` chains can now
> take advantage of multiple execution units.
>
> Make the memory clobbers more precise. 'buff' is read only and we know
> the exact usage range. There is no reason to write-clobber all memory.
>
> Relative performance changes on Tigerlake:
>
> Time Unit: Ref Cycles
> Size Unit: Bytes
>
> size, lat old, lat new,    tput old,    tput new
>    0,   4.961,   4.901,       4.887,       4.951
>    8,   5.590,   5.620,       4.227,       4.252
>   16,   6.182,   6.202,       4.233,       4.278
>   24,   7.392,   7.380,       4.256,       4.279
>   32,   7.371,   7.390,       4.550,       4.537
>   40,   8.621,   8.601,       4.862,       4.836
>   48,   9.406,   9.374,       5.206,       5.234
>   56,  10.535,  10.522,       5.416,       5.447
>   64,  10.000,   7.590,       6.946,       6.989
>  100,  14.218,  12.476,       9.429,       9.441
>  200,  22.115,  16.937,      13.088,      12.852
>  300,  31.826,  24.640,      19.383,      18.230
>  400,  39.016,  28.133,      23.223,      21.304
>  500,  48.815,  36.186,      30.331,      27.104
>  600,  56.732,  40.120,      35.899,      30.363
>  700,  66.623,  48.178,      43.044,      36.400
>  800,  73.259,  51.171,      48.564,      39.173
>  900,  82.821,  56.635,      58.592,      45.162
> 1000,  90.780,  63.703,      65.658,      48.718
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
>
> tmp

SGTM (not sure what this 'tmp' string means here :) )

Reviewed-by: Eric Dumazet <edumazet@google.com>
