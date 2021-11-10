Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAE44C467
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhKJPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhKJPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:33:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E810C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:30:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so4680067wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCb0S2WxUVc3oDuQ2l00TOmUlUDbZwafwSfJTHltYXo=;
        b=SGqhDEvpHSn9EYRs2LaROmPvVBOp22K+qSnUjFtQKBdbAGzc5znWs1mpD8ACQM2OGf
         qmLM2u1lfCHts0LfDa2gU46L56GXmHVZYcGtovLwf4S7CECNS9IjoU7WIIB6KuZ8DfYh
         FYjW95QQFI6NSILJhBVb5KpTu5BRUM+U980XV6NKkIWFJABoQiCZmJXsVN8vso6sNJza
         QecPrndGL1DBKPy46UBI23azoi6LgRHkadgHjX3H1vyltTdtMbI7lXZosuMotl+tZ5+E
         mX3MsQxVj+EWvMYdL9T0a6ojBEXSUkPFQaZjS7GDznmiuvZft2EdxEjcc0nLZ5iO4c/E
         2Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCb0S2WxUVc3oDuQ2l00TOmUlUDbZwafwSfJTHltYXo=;
        b=2CUq3j9jdleNYaiWwFClwK/ylccDpCt+AXOGyORvopiwxBhPeUlDBbXT9YdYBOUe1V
         l/joFbVlykoQUml0eW3Q03w+AfGzSx8WDZhI/IywLwxWezuM5tIOFB+/jNh5j3NQwS/7
         +1M5PMPRuREwYM/6BJOV1wYloe2BFuaF2UgzkvrfkpXiNpCNxjRTHn6IRAuh1ES+xqwj
         g/h+LWH/iaR6/shGNmeGLwBkwvVcWGkk0EWEDfzE6WlBuJ5B8V+I2sMV1By17P0VhI2U
         2Wra55pBbt9WNM7ol+fQoLFbfWIWMic2MXa2MnhJ91Yux21S1gILAwIYfx/4B3FLZ2am
         Bhag==
X-Gm-Message-State: AOAM532dB6TeNCYagt2YKgAyBocwkXLhD3V0cREJHqueNhXNi64h6Hy6
        ki0eByFejTgrV7CxW2E6CZtuHxZ5xP3HXsmgHOTnq5Ctrha1HK2n
X-Google-Smtp-Source: ABdhPJxveFAFiP/qO2lpF+u9s3slOtTzNiDBXe/neh9dvlTCsODhDasNx1b5xQtasEQOO1Vf8Dh5MtTnXWbuKdELQLc=
X-Received: by 2002:adf:f40b:: with SMTP id g11mr718793wro.296.1636558235470;
 Wed, 10 Nov 2021 07:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
In-Reply-To: <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Nov 2021 07:30:22 -0800
Message-ID: <CANn89iLSvNzgDc4s5rv65eELx2fGVzb6Nj=8D7T3Up8Wgsm_SA@mail.gmail.com>
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, jpoimboe@redhat.com,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> > used for the control path.
> >
> > Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> > Otherwise we place them out of the way to increase data locality.
> >
> > This patch adds __static_key to centralize this new policy.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  arch/x86/kvm/lapic.c       |  4 ++--
> >  arch/x86/kvm/x86.c         |  2 +-
> >  include/linux/jump_label.h | 25 +++++++++++++++++--------
> >  kernel/events/core.c       |  2 +-
> >  kernel/sched/fair.c        |  2 +-
> >  net/core/dev.c             |  8 ++++----
> >  net/netfilter/core.c       |  2 +-
> >  net/netfilter/x_tables.c   |  2 +-
> >  8 files changed, 28 insertions(+), 19 deletions(-)
> >
>
> Hurmph, it's a bit cumbersome to always have to add this __static_key
> attribute to every definition, and in fact you seem to have missed some.

Sure, I can make sure to include all cases. I was hoping
DEFINE_STATIC_KEY_TRUE()/DEFINE_STATIC_KEY_FALSE()
would catch the majority of uses.

We also can add a new DEFINE_STATIC_KEY() macro to ease these cases.



>
> Would something like:
>
>         typedef struct static_key __static_key static_key_t;
>
> work? I forever seem to forget the exact things you can make a typedef
> do :/

I tried, but a typedef was not working. A macro would work.
