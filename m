Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45C33CE03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhCPGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhCPGgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:36:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:36:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t4so34250381qkp.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bx0hFpYvINElZV6pJjvCi8FeimInpCTokGRu0R++mJs=;
        b=ACpKI45IO0ptXLAu5jnUXBtj2vEFvA9g11dP+8NOwgL3NIfAcdN7YdfWQ8xFs0I5Fq
         4/aqozxJ7itvg60WEekThvneDzKn5jpGgyCAOyWsaYdR8vcgZA5lIZ0aDh8yWK1X/XFQ
         IrSq0zOZVf54uMUjzRqyU4LDm8/zrYKUym8Icvo42EMU/np4WdzLCd8qVPDBkEwnhV0P
         99mb24tvX/3f8rJfKnqb5Hs/6v+YQUKHcS2qMRlkA+z5QEN7LCuccjr4x6mo0SCsO36P
         8X4u02/rvqhYzieN9vJCzFJ2y9ve7ayxy8jstSxE0JGR84p1ehmq0ZInHwCtuCxO0QZK
         qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bx0hFpYvINElZV6pJjvCi8FeimInpCTokGRu0R++mJs=;
        b=WCidxudUynHr9bzNgZVpWClAgVFybidbWVERvl96xtflygftGfCKEXkWT7walGDu20
         wxDKFyBCJ1qnJ88HutwBNWymQ6MtlphmypOlaruzOb8N234eNck5F+3crBM1MLm9ukHf
         6h/0NZoEOKrn0sbEmrrx4iIIvgi5U2SVOKLLF57Z0lCr8X4rqvkBK7loULUOuEREE2UC
         p7rV9Eik6VQzpBpzc6cs+P90GOKEH/53VtTCj+e6cPV8O3uShDB9rLDrOw+HgXmmcTqY
         A1rr91LpoRzEnqU8XGIrPnaJimBp+L8JHKxIgPrAsgdtCYQDTXWQf5bLOcjZrrSRbvmX
         ozgQ==
X-Gm-Message-State: AOAM531aWEfpv4owpj5hOU6T+GHwhM4lrWTRbbMauUDR6Ck+t5YC5f/O
        fIkZd0ynqIX6q1IbiRB18vtqhJpG9rHVHlfidllCVA==
X-Google-Smtp-Source: ABdhPJz+s7oNuRvrrT9LgDuXzmHMGqPqbVTMruzlcfdggKZOm/k4xbcIpuA8X5HCM0N7rEGN0sAlpgTKJ4AHIOBEgZ0=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr30363503qkd.231.1615876583744;
 Mon, 15 Mar 2021 23:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210211080716.80982-1-info@alexander-lochmann.de>
 <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
 <01a9177f-bfd5-251a-758f-d3c68bafd0cf@alexander-lochmann.de>
 <CACT4Y+ZPX43ihuL0TCiCY-ZNa4RmfwuieLb1XUDJEa4tELsUsQ@mail.gmail.com> <8841773d-c7d2-73aa-6fa6-fe496952f2ba@alexander-lochmann.de>
In-Reply-To: <8841773d-c7d2-73aa-6fa6-fe496952f2ba@alexander-lochmann.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 07:36:09 +0100
Message-ID: <CACT4Y+bV1rCZrtbJtPaKeY=2q8MW8bLsB95rdAeRyUDR3fMsDQ@mail.gmail.com>
Subject: Re: [PATCH] KCOV: Introduced tracing unique covered PCs
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:43 PM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
> On 15.03.21 09:02, Dmitry Vyukov wrote:
> >>>>  static notrace unsigned long canonicalize_ip(unsigned long ip)
> >>>> @@ -191,18 +192,26 @@ void notrace __sanitizer_cov_trace_pc(void)
> >>>>         struct task_struct *t;
> >>>>         unsigned long *area;
> >>>>         unsigned long ip = canonicalize_ip(_RET_IP_);
> >>>> -       unsigned long pos;
> >>>> +       unsigned long pos, idx;
> >>>>
> >>>>         t = current;
> >>>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> >>>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t))
> >>>>                 return;
> >>>>
> >>>>         area = t->kcov_area;
> >>>> -       /* The first 64-bit word is the number of subsequent PCs. */
> >>>> -       pos = READ_ONCE(area[0]) + 1;
> >>>> -       if (likely(pos < t->kcov_size)) {
> >>>> -               area[pos] = ip;
> >>>> -               WRITE_ONCE(area[0], pos);
> >>>> +       if (likely(t->kcov_mode == KCOV_MODE_TRACE_PC)) {
> >>>
> >>> Does this introduce an additional real of t->kcov_mode?
> >>> If yes, please reuse the value read in check_kcov_mode.
> >> Okay. How do I get that value from check_kcov_mode() to the caller?
> >> Shall I add an additional parameter to check_kcov_mode()?
> >
> > Yes, I would try to add an additional pointer parameter for mode. I
> > think after inlining the compiler should be able to regestrize it.
> >
> Should kcov->mode be written directly to that ptr?
> Otherwise, it must be written to the already present variable mode, and
> than copied to the ptr (if not NULL).

I would expect that after inlining it won't make difference in
generated code. Is so, both options are fine. Whatever leads to a
cleaner code.
