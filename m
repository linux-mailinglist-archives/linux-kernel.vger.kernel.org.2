Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFE44C491
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhKJPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhKJPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:44:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD097C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:41:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so4796475wrh.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5ip8+WF10up78UWLF1pGKUjApOcu0vg6ZMhf84Dwo4=;
        b=KR8INsl/WEQgnQoPf5irY+IeY98nazKbcca7XzB9sHhnzAoLjIOhrYP9wMynzham6e
         HIh1mf87JytOM3AsraHTbNBV2f60pEXtVdmGGKnA75LtJFnWxzV4GaW6sLmVhxCHKHul
         gnUbkstRgGTCdvpiF1u4WooF/Ez0BUZMwNoN1jz/ql5Rz7dEWDyPH1epswNz6g9PRSUu
         hPilxowN7Daxy62r2rQDDK4s9rzvDWtv18HEwk7+FgRkDXtKp1TTu+TcsGL/YsxwL/V4
         moKH8Z2NodockxCtuXefZdHxJfAUoEh2KgDN7PbD1upbWGa+ldXS2qtbGLX/9PXi2Dqm
         8qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5ip8+WF10up78UWLF1pGKUjApOcu0vg6ZMhf84Dwo4=;
        b=fiCjXU5uacMmVzpv+fcgKfzEaSVEcnyquOWznUQYM7jsaHLCvszvVOuz4/y3gpS618
         ZpM/j22EgDkmBZnsinnpcbwZgupShYjeF1vXbFXClZx/ST5YLruetMiz2miYHP2zIqLe
         3P9GBveZwC8XJE+eopYUTVbAVufFrDMMmvLYPBtMFc1af/LACgHfodhMDrGsjfbZYIxo
         78rG8O6xcEfQJrwC7q8LskSMhBgEVGEM5pWxkq5nXyO6DYAWJV42lemVOA4kq0i0Im20
         Tgrq50ewnjS3/YBG5bCU88uE+Kyd29efx3CqldIph4JVM0rluMW1bc/RNxCeK8WsyVtn
         e32w==
X-Gm-Message-State: AOAM532ep+vY00f2ty+4TGsI4B9EbNOggEcvjxhBMeFO1ICVGtUKDN4R
        tAuQ+no1KhnxzuxVsTsqEBf2rQgvsmsbiRU5F6g8rQ==
X-Google-Smtp-Source: ABdhPJzCq4Z683Ulo4wIYMGGzPs1ohL0Apd1AAyNRzfU3JTMW0QOW8GGLRclzPsJgAH6Fy4ZLguICzkAkFw6jw3Ol/s=
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr770486wrq.221.1636558894874;
 Wed, 10 Nov 2021 07:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
 <CANn89iLSvNzgDc4s5rv65eELx2fGVzb6Nj=8D7T3Up8Wgsm_SA@mail.gmail.com>
In-Reply-To: <CANn89iLSvNzgDc4s5rv65eELx2fGVzb6Nj=8D7T3Up8Wgsm_SA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Nov 2021 07:41:22 -0800
Message-ID: <CANn89iLZr6Dg0ON=RcZsH=Yd=+qdKNEuAgzOj6hu=f-y=7ngfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jpoimboe@redhat.com,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 7:30 AM Eric Dumazet <edumazet@google.com> wrote:
>

>
> Sure, I can make sure to include all cases. I was hoping
> DEFINE_STATIC_KEY_TRUE()/DEFINE_STATIC_KEY_FALSE()
> would catch the majority of uses.
>
> We also can add a new DEFINE_STATIC_KEY() macro to ease these cases.

Although use of 'struct static_key' is marked deprecated.

I guess that we can leave legacy uses be converted by maintainers if they care.
(They do not have to, __static_key section is only a hint, not a requirement)

For instance these ones had no __read_mostly and nobody cared.

arch/x86/kernel/paravirt.c:124:struct static_key paravirt_steal_enabled;
arch/x86/kernel/paravirt.c:125:struct static_key paravirt_steal_rq_enabled;


>
>
>
> >
> > Would something like:
> >
> >         typedef struct static_key __static_key static_key_t;
> >
> > work? I forever seem to forget the exact things you can make a typedef
> > do :/
>
> I tried, but a typedef was not working. A macro would work.
