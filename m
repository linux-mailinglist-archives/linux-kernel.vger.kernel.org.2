Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA94007F0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhICWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhICWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:37:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC3C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 15:36:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c6so511774pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4n4t1I0ds31rTOivM3zh0FqEEapcJtxXsNS36ICN76o=;
        b=QKjVkjAqZbrZL+HEfDDzK9eMl0sGZ/u4nVq3zK3+h1u4V/mSFYef1CY/V+aEvTl09U
         EOaZW4VhviL6B6Ctz/7RqzfWRiLUvphzT9lcClHeDoPka+RyM4x90D+rHMxVSnOZyVVX
         Nt4K7MfeZHZZ4YnmwPkCu5cTUa+KBYINtY83hbjBlL2AvnN9rSB3W4dnRuqyMpeCSkzB
         g+fXVEhkSP3GHe+ZV7dEPm2uQgpIUIvfhzSA4Lmt9ZbB8bLJjO7d6jgBEIvoTDoBEFK0
         X9JD5Mw5WQ388AGBKSASMf+5LIzBuAwIqB4cXhtS92wwfYhjexmaMtsFH6teOzLj2KnA
         p/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4n4t1I0ds31rTOivM3zh0FqEEapcJtxXsNS36ICN76o=;
        b=eRnq81ROkjitirl6Ul5auUxRPhYf72Z5YSwhflcmevo7i+g8sTEKVRAJJU6cSkFD5/
         dXah9Qyxvt5fpypZ8g6k8yYYVZTQ197hLWNNUjGqrVt5CukSXEJwXvlAT9F9Y3NoPCnF
         QsBadgVeCmH8+Nayf0dB2azn0yS2Ex7yO7SA/Au8ih159tFiUePHE/fnTBJD4/XlixLd
         0OrxjPM9EUbBDOZyf11Kjlp7asgAal1PkDy2DWyvRb0aGacOEamPIbnEKooEl+mkO5Tx
         sJ/8IhuKSWG04nk6SCASfCdDX16Yc+5bXQ7qLWRmKLp84P6jz6fFWvAfWvw/s8b/BKuX
         baMA==
X-Gm-Message-State: AOAM533kGXtaTO0c8cTHODgVWtUL6ICyXgbocrRqEIZZddu/Cus3gPJ4
        nMztPLatlkIEA/I02KRc/zOuVLqM1ly5CCXa9WGOOA==
X-Google-Smtp-Source: ABdhPJx4mWEGu0kI+CxWBNOJxmkOXwSce1nqbnnzMXG0QeUk/OHJxSKmm5RtHs9p47GBQ3xMnPy2CNSyt0D6+Q49tYs=
X-Received: by 2002:a17:90b:3608:: with SMTP id ml8mr1123767pjb.124.1630708574150;
 Fri, 03 Sep 2021 15:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210831170233.1409537-1-kaleshsingh@google.com> <20210903163047.20e4f286@gandalf.local.home>
In-Reply-To: <20210903163047.20e4f286@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 3 Sep 2021 15:36:03 -0700
Message-ID: <CAC_TJvdv+BSQh0vqWmA220op+b5=8=ZYrhXcmDRE-Fppo0zE0w@mail.gmail.com>
Subject: Re: [RESEND v2] tracing/gpu: Add imported size to gpu_mem_imported tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Reitan <john.reitan@arm.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Underwood <mark.underwood@arm.com>,
        Gary Sweet <gary.sweet@broadcom.com>,
        Stephen Mansfield <stephen.mansfield@imgtec.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 31 Aug 2021 17:02:29 +0000
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > The existing gpu_mem_total tracepoint provides GPU drivers a uniform way
> > to report the per-process and system-wide GPU memory usage. This
> > tracepoint reports a single total of the GPU private allocations and the
> > imported memory. [1]
> >
> > To allow distinguishing GPU private vs imported memory, add an
> > imported_size field to the gpu_mem_total tracepoint. GPU drivers can use
> > this new field to report the per-process and global GPU-imported memory
> > in a uniform way.
> >
> > User space tools can detect and handle the old vs new gpu_mem_total
> > format via the gpu_mem/gpu_mem_total/format file.
> >
> > [1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/trace/events/gpu_mem.h | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
>
> This is that trace event that doesn't have any in tree callers, right? I
> thought there was going to be some soon.

The trace event is currently used by the Android GPU drivers, and
there is some work ongoing to add this in drm core upstream but it's
not yet ready.

>
> For the updates to the tracing side (besides not having any users), it
> looks trivial to me.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> But this needs to be pulled in by one of the GPU maintainers.

Thanks for the review Steve. I'll resend adding the GPU maintainers.

>
> -- Steve
