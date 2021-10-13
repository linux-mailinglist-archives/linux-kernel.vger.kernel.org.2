Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9A42C677
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhJMQf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237567AbhJMQfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:35:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 444B8611BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634142799;
        bh=ATA/VolDIWnXKFAjt4i41Bs/bP1bjPllEPRn2zHVlKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nZbYdZ+TmRgayW9FwVgGm8DDu5R77elFAQ3WMwZcuIl71KwBiM2S+tBRo47oKEuIh
         YMga+JIqSnENtPD+0HzE1LUoNv34lkPkB03r80WaFtoy30LzpzQTCXjn9fO043JC2M
         HkNqEGvoy2VFU4rOWHKfaxlWRCl5yHFtBAkryNsfKsrZQehLNBCvmBcGrmhzsI4elI
         G6YwD1KS6s6hYKcceK62TIXJ7JcgIij7dsleB0ojHtHlvljxigGylb3wdMaYLwNbN9
         wvK7n5gVUMt2BL+HdNRKuMeCMIcWM/e4teUCpykj+9/9nsVeFBOnFRgPdqwSlsgPB8
         UsBCl5jIAMFcg==
Received: by mail-ed1-f45.google.com with SMTP id d3so12526111edp.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:33:19 -0700 (PDT)
X-Gm-Message-State: AOAM532/C2ZpK4dZA9AScAwFhpS/gXm7azPhHiOwsN4CZOrCaij9VJvZ
        JOHg7bbjdPH2NaHpqwY8Lz6KNv+heiM13zrQXeXgRw==
X-Google-Smtp-Source: ABdhPJx9XxGMkLOCefGOFoiNm9Z9yL/49UPzM+9bne8ju+YUe9f7659vAfHr8FWun4KOjSrtVUuOxUigyyadomyKMvs=
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr562911ede.186.1634142796733;
 Wed, 13 Oct 2021 09:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211006210732.2826289-1-songliubraving@fb.com>
 <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net> <A2707216-E8F3-4D91-87AF-6F09CA63415C@fb.com>
In-Reply-To: <A2707216-E8F3-4D91-87AF-6F09CA63415C@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 13 Oct 2021 18:33:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5AVFFnD9fQmjFNrkgxN2qR_k1TshoxhNkku4N9hta1wg@mail.gmail.com>
Message-ID: <CACYkzJ5AVFFnD9fQmjFNrkgxN2qR_k1TshoxhNkku4N9hta1wg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in kernel/event/core.c
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:47 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Oct 12, 2021, at 5:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 06, 2021 at 02:07:32PM -0700, Song Liu wrote:
> >> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> >> them by removing $(CC_FLAGS_FTRACE) from Makefile.
> >>
> >> ---
> >> We had some discussions about this last year [1]. Seems that enabling
> >> ftrace in kernel/events won't really cause fatal recursion in the tests.
> >> Shall we give it another try?
> >
> > I suppose we can give it a go..
>
> Yes, please. :-) Shall we ship it with 5.16?

This would be super useful for us, perf_event_* functions are very nicely placed
for tracing events like mmap.

>
> Thanks,
> Song
>
>
