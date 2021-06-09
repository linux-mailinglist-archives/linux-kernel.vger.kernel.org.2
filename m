Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBC3A1DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFIUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:11:57 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38570 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:11:56 -0400
Received: by mail-lj1-f175.google.com with SMTP id s22so1462725ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH+j2KiVN2G/yHhVjeQt6p3BwbyIHnyM+0CcxE7yrDU=;
        b=AA02DUQuVWJT5MsI3unO8Y7QIOeiM7ojSOf+tqLac1WvD6nIyHkv7Pa0qjcMI+hTcR
         0zNRwRgAg7m2VsUhZD7G21UqsG1aPq/XdzJPGqoO5RrowffR7FXb+T/ICZxJJuMRYvvw
         NdivjzlAyufhdDOwqw5p5T7ogMbkumjfEy93w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH+j2KiVN2G/yHhVjeQt6p3BwbyIHnyM+0CcxE7yrDU=;
        b=A6ZdWQbAafNSd6PWdKdmr3z1zebcTpUUNNo58hKjCPjI587ZuM7bo4WlayWRXE5KqH
         E8vD3Jd/PVLzCmtbQaaeMHxQF4BbRoZq8ZDQb+EH20g+OkY0Age8AbwdgxL8cVk9d9kr
         AlFaNCbcWET+XsIEG/5zXdDzL6d7RHQiHQQKAEhMTQ6W/UqUjG+e0O9tYBUdlDShcID0
         5dPUTFubB9geSQzyPZOUqssj6Pmpkm+TRjER5J9zVJnK6V0oEQJwCRIgzWgcj6WXP65o
         VTwpCFhVZLij3jJeaCS3A7EOIqPOtKxZ8fskZMe7m9ZlK06gr7RzRlVmr2iLtCWnAph3
         on3g==
X-Gm-Message-State: AOAM533SQieog70mXGuvglwhNl2bXlMqcxzF/9gDMpT8K8hkaFchcAQ9
        dTcQC9MDs2JP7yzIU/I8QlhMOcXKiaJ859b+uD0=
X-Google-Smtp-Source: ABdhPJx4I1nOt3/mkO6mc8/5sNLUevfpGSUTbn/VwyJm9egHHbb5oXpPhYz4+0sVuX3JHLZzrRiftg==
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr1168291ljp.201.1623269331551;
        Wed, 09 Jun 2021 13:08:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a7sm80574lfj.42.2021.06.09.13.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:08:50 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w33so40007234lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:08:50 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr684978lfc.201.1623269330357;
 Wed, 09 Jun 2021 13:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210607125734.1770447-1-liangyan.peng@linux.alibaba.com> <71fa2e69-a60b-0795-5fef-31658f89591a@linux.alibaba.com>
In-Reply-To: <71fa2e69-a60b-0795-5fef-31658f89591a@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 13:08:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com>
Message-ID: <CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Correct the length check which causes memory corruption
To:     James Wang <jnwang@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Liangyan <liangyan.peng@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        yinbinbin@alibabacloud.com, wetp <wetp.zy@linux.alibaba.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven?

On Mon, Jun 7, 2021 at 6:46 AM James Wang <jnwang@linux.alibaba.com> wrote:
>
> >
> > James Wang has reproduced it stably on the latest 4.19 LTS.
> > After some debugging, we finally proved that it's due to ftrace
> > buffer out-of-bound access using a debug tool as follows:
[..]

Looks about right:

> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index a21ef9cd2aae..9299057feb56 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -2736,7 +2736,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
> >           (entry = this_cpu_read(trace_buffered_event))) {
> >               /* Try to use the per cpu buffer first */
> >               val = this_cpu_inc_return(trace_buffered_event_cnt);
> > -             if ((len < (PAGE_SIZE - sizeof(*entry))) && val == 1) {
> > +             if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
> >                       trace_event_setup(entry, type, trace_ctx);
> >                       entry->array[0] = len;
> >                       return entry;

I have to say that I don't love that code. Not before, and not with the fix.

That "sizeof(*entry)" is clearly wrong, because it doesn't take the
unsized array into account.

But adding the sizeof() for a single array entry doesn't make that
already unreadable and buggy code much more readable.

It would probably be better to use "struct_size(entry, buffer, 1)"
instead, and I think it would be good to just split things up a bit to
be more legibe:

        unsigned long max_len = PAGE_SIZE - struct_size(entry, array, 1);

        if (val == 1 && len < max_len && val == 1) {
                trace_event_setup(entry, type, trace_ctx);
                ..

instead.

However, I have a few questions:

 - why "len < max_offset" rather than "<="?

 - why don't we check the length before we even try to reserve that
percpu buffer with the expensive atomic this_cpu_inc_return()?

 - is the size of that array guaranteed to always be 1? If so, why is
it unsized? Why is it an array at all?

 - clearly the array{} size must not be guaranteed to be 1, but why a
size of 1 then always sufficient here? Clearly a size of 1 is the
minimum required since we do that

        entry->array[0] = len;

   and thus use one entry, but what is it that makes it ok that it
really is just one entry?

Steven, please excuse the above stupid questions of mine, but that
code looks really odd.

               Linus
