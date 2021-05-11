Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ADD37B096
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhEKVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhEKVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:14:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6899C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:12:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i7so12093032ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH/xveNEXn3ClqzPZQs0YZcLB87CWmrdPlrNo8WmPew=;
        b=mMX5w7ST3LQW0ywAFuAUuqkCFVRfnqAZhl10XTJFMtqWPNF7Z8bgq9KURO1yuhHNii
         qQkbrMoLii4DlJdF/+a9/rmkCZyZ5kDcntf1YeJS3L360Ran1Qz8PWzFvK/oze14z/uj
         SOCCJ7zLmlVVYNDjKwbue6ROTn3GZCg3NmW2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH/xveNEXn3ClqzPZQs0YZcLB87CWmrdPlrNo8WmPew=;
        b=EXQSP10LAocoBVZkNQMCi9FpeW4/5nRoODdRIXOXhEfHNMQrMyXtrTzUHt5IxPSnhT
         r92VxtopJiXX5ZYJfpPXFrbJtkXeg1jK1UjLQCzWaFe3oJ3XrR6ULlPJb8Otrdrk0cx/
         /VrcPUDpoLcXjuMpDKNWvyxnsW9mOub+AZLAfHqH7q7rKkYatXMAq97BrJ379lfLm5MR
         bUgHqOSzEe8g6BfdoCJwOS/fKbCrQ/FfWV2y1vC5VS7zlk2LIL16VN81fGmWZ6Wc6yvy
         aDgt4adLJ+rae3RaOSdtBx8LqzXEmViYyU9GTZtT9XctOdUzAGMypN5jL7yI+49h2w+F
         EyJA==
X-Gm-Message-State: AOAM531bxnQRL/RQ08u7Zx5ukEwpM4nGpN4fB/GS2iPU8SBQx22QovcL
        Y2v2Z488j39xqplZbgyGP04ByYMmUebYTrW/E9HsOw==
X-Google-Smtp-Source: ABdhPJx+1o7FayAGMwEtTvoHhSkLMZCZGw0mBOexriNXRBWzUFROrm0/cLyz4Xkgs/dqWVG/wRICQWJ7f7TSfemgRjs=
X-Received: by 2002:a02:a918:: with SMTP id n24mr28849104jam.125.1620767577194;
 Tue, 11 May 2021 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210511081054.2125874-1-revest@chromium.org> <CAADnVQKq+b7uJb0J32swWEZmoDfdrUfx=f8ndSM4vicTCtYebA@mail.gmail.com>
In-Reply-To: <CAADnVQKq+b7uJb0J32swWEZmoDfdrUfx=f8ndSM4vicTCtYebA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 11 May 2021 23:12:46 +0200
Message-ID: <CABRcYmK-AjsUTWASd2mqDmeS1NpzuV+YcFyb7NYA01=OQz0wKg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix nested bpf_bprintf_prepare with more
 per-cpu buffers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:07 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 1:12 AM Florent Revest <revest@chromium.org> wrote:
> >
> > The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> > per-cpu buffer that they use to store temporary data (arguments to
> > bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> > by the end of their scope with bpf_bprintf_cleanup.
> >
> > If one of these helpers gets called within the scope of one of these
> > helpers, for example: a first bpf program gets called, uses
> > bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
> > another bpf program that calls bpf_snprintf, then the second "get"
> > fails. Essentially, these helpers are not re-entrant. They would return
> > -EBUSY and print a warning message once.
> >
> > This patch triples the number of bprintf buffers to allow three levels
> > of nesting. This is very similar to what was done for tracepoints in
> > "9594dc3c7e7 bpf: fix nested bpf tracepoints with per-cpu data"
> >
> > Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> > Reported-by: syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  kernel/bpf/helpers.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 544773970dbc..ef658a9ea5c9 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -696,34 +696,35 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
> >   */
> >  #define MAX_PRINTF_BUF_LEN     512
> >
> > -struct bpf_printf_buf {
> > -       char tmp_buf[MAX_PRINTF_BUF_LEN];
> > +/* Support executing three nested bprintf helper calls on a given CPU */
> > +struct bpf_bprintf_buffers {
> > +       char tmp_bufs[3][MAX_PRINTF_BUF_LEN];
> >  };
> > -static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
> > -static DEFINE_PER_CPU(int, bpf_printf_buf_used);
> > +static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
> > +static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
> >
> >  static int try_get_fmt_tmp_buf(char **tmp_buf)
> >  {
> > -       struct bpf_printf_buf *bufs;
> > -       int used;
> > +       struct bpf_bprintf_buffers *bufs;
> > +       int nest_level;
> >
> >         preempt_disable();
> > -       used = this_cpu_inc_return(bpf_printf_buf_used);
> > -       if (WARN_ON_ONCE(used > 1)) {
> > -               this_cpu_dec(bpf_printf_buf_used);
> > +       nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
> > +       if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
> > +               this_cpu_dec(bpf_bprintf_nest_level);
>
> Applied to bpf tree.

Thanks Alexei!

> I think at the end the fix is simple enough and much better than an
> on-stack buffer.

Agree. :) I was skeptical at first but this turned out quite well in
the end, thank you for convincing me Daniel & Andrii. ;)
