Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0C409B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbhIMSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344671AbhIMSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:00:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C4C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:58:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id p2so15204301oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYhC7SL+4as2ND/qPy+Y7r2GKb7SvMEFyVMfGu0ciwc=;
        b=lk5a4NHgzAda8Jp5cOipSeD/mJiI4TGViEw34RypmHjDcyqeAi7CV9o72mRAEqUFU9
         C4NTOoZgnkF/s0hUzUJtaTwQtygl1TIey49qXPQx1RkL/vIYwjOuSa53n+Ia3kLB77cT
         2+1tPi93FIl67SCsOihJjNHFRafmVdl07ZmshwykesytkL1dI8M3VBDfjFWqAwAjuOuX
         4oYXxyAx6nGE+tjLd3AeagRQzBIC1Y7Fz4423pMD02xtAdajKvZY+vFwOjk61++p6O4y
         1Z0412rOB9HjQ/KBQ2uzt4xs5PYfThWvvJB/ZtQzgBswPOXxK1VtRvfMjhTmc7JLv07/
         CD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYhC7SL+4as2ND/qPy+Y7r2GKb7SvMEFyVMfGu0ciwc=;
        b=qs13zkK4MnMdJeJ4dI1T48QO+FZ1MDXVU/rtXK8tAZOwZ4fOimj6fqircnkTZveVEu
         EFN4aPRRno/+kZ46sqZYkHRM3L/cpshJSFEgS5CXB3LFi2FEqGZoIEytel31jG4UxDIH
         mAb9hxKy3EropmqxOGbfkJZsPObWTSBmHfONaixave9lEs0EnSdzKx2l/vSZ3juPEd14
         +Zo6pHCwVppMy4CXWp1sbNgjfjJk2HqhbvHypP2fWP1qW3LKJom72UeDlYAZkGnwYKOe
         J4zmSpcjpDotrUQwtIBflc9GT6gJLFF38P7bfROv5CGhsBCz7tsJZPospjh5Ism8Yo62
         jw/Q==
X-Gm-Message-State: AOAM532SaimUOLajn6LnLmGFTgkuW41hJACl5pq0NYmUFdtdJstKhs1S
        e7Rbhbr8EpbVjFNdClHnYeXK2uc/Zfvle9PdnJem/Q==
X-Google-Smtp-Source: ABdhPJx1GF0fnNkLpruEj+Lqzz7FmMV1FL51iB1zp2oNxAaujdVlXBEy3MMDpYSYrrm5oGw0MReNlDfpcJb8JE1LLOo=
X-Received: by 2002:aca:4344:: with SMTP id q65mr8845158oia.70.1631555931531;
 Mon, 13 Sep 2021 10:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com> <20210913112609.2651084-7-elver@google.com>
 <YT+EStsWldSp76HX@slm.duckdns.org>
In-Reply-To: <YT+EStsWldSp76HX@slm.duckdns.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Sep 2021 19:58:39 +0200
Message-ID: <CANpmjNPA9qW8i=gHvrdMRag0kOrOJR-zCZe6tpucOB4XN8dfWQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] workqueue, kasan: avoid alloc_pages() when
 recording stack
To:     Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sept 2021 at 19:03, Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Sep 13, 2021 at 01:26:09PM +0200, Marco Elver wrote:
> > While there is an increased risk of failing to insert the stack trace,
> > this is typically unlikely, especially if the same insertion had already
> > succeeded previously (stack depot hit). For frequent calls from the same
> > location, it therefore becomes extremely unlikely that
> > kasan_record_aux_stack_noalloc() fails.
> >
> > Link: https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
> > Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> > Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

> Please feel free to route with the rest of series or if you want me to take
> these through the wq tree, please let me know.

Usually KASAN & stackdepot patches go via the -mm tree. I hope the
1-line change to workqueue won't conflict with other changes pending
in the wq tree. Unless you or Andrew tells us otherwise, I assume
these will at some point appear in -mm.

Thanks,
-- Marco

> Thanks.
>
> --
> tejun
