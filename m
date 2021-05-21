Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75EE38D071
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhEUWDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhEUWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:03:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF76C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:01:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z13so31768782lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDRzh2skEezJB6tv1yJRGOr/uzGzkIEh8BoTRD9XtfQ=;
        b=njEm0YHjEkDY3e5Z9iKNNLGw1N5nZmsovWPzWhSA0ptWG7O96Nmq7/fCaevTZevbM8
         dW/XV6EJfZ7IFcCYgUvwOsdsY6wiOoO+5QuknxvXSqFpFgl4kSzATgP8jd0WAW7HByJZ
         /9Xj+CcKDBlRs/3JdWnUpF6fq8bYYxyizlPmh6aicRPJVPn5ItB1dYiViFF3ZC9NpGtR
         nQlotkAAupdI2i6GTeM0STEG5XoWGcrDmspSDY9ryrBp5eLLcoadsoSncp2dP6i0NDOq
         D3z1K0QVOhtqioHPk3Usm65vgwPUecPXWcu9lKEhe9coRDvHuL9qwZuKwSXyRRV8GBDZ
         4F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDRzh2skEezJB6tv1yJRGOr/uzGzkIEh8BoTRD9XtfQ=;
        b=oG5+ynu4Dr1a/64cfJXUxcWdJtPUKymq3fwKJv6+7U78dXlDapdSGQ7VBLXUPupmSn
         WqM/dxEc7nNEnWUP6H+LKvcV+o6DO/OzzexE7SQD1yOXLK/Kfieh/IZ1/w+WizuEms76
         6XuacSH1ka+8O4qEWGvNi6cQx0rXJo1rh5rEKu3DCW9Ee2bJb5giNDybbLg0VyJ/MI0R
         LIB++mMCYpg3Z/1WiKWhzuDSSKiLePz0oL3gFgDXFWJTm9mlbrrz3LU81DHRy4yIacnO
         YOI1oCzHoeRoFM2IWpNt9X6KCsK5cRJpqff5Ic4MV+SlnJFM3czUKcdHb+wdID5ZhqKC
         Wglg==
X-Gm-Message-State: AOAM531h2dG734C0W84lsEScDpHY/wTnEIUrizJ514DICg75dul1gu5j
        Ny5PoWC8YNKzYxDihvrNwTMpHwQVOeoqxg/JuRGAuQ==
X-Google-Smtp-Source: ABdhPJyR6ywlBKYouVLHwWJrlpr6+XJOhEYSGLkUcHGwnCqNN+FpE/iTjLRteYwFzMI3BV57vibtfcqiad+wEsgbCQ4=
X-Received: by 2002:a05:6512:3a4:: with SMTP id v4mr3472319lfp.473.1621634496124;
 Fri, 21 May 2021 15:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210520183614.1227046-5-posk@google.com>
 <CALCETrXo=5r+i6f3qvSp4mEHcR93U3F0S0kFr8d5JGU6WetSqw@mail.gmail.com>
In-Reply-To: <CALCETrXo=5r+i6f3qvSp4mEHcR93U3F0S0kFr8d5JGU6WetSqw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 21 May 2021 15:01:24 -0700
Message-ID: <CAPNVh5foSzWj3XHoONjvzmLLXOi9u3ojNmdfegohpufx1YYXgg@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:32 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, May 20, 2021 at 11:36 AM Peter Oskolkov <posk@google.com> wrote:
> >
> > Implement version 1 of core UMCG API (wait/wake/swap).
> >
> > As has been outlined in
> > https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/,
> > efficient and synchronous on-CPU context switching is key
> > to enabling two broad use cases: in-process M:N userspace scheduling
> > and fast X-process RPCs for security wrappers.
> >
> > High-level design considerations/approaches used:
> > - wait & wake can race with each other;
> > - offload as much work as possible to libumcg in tools/lib/umcg,
> >   specifically:
> >   - most state changes, e.g. RUNNABLE <=> RUNNING, are done in
> >     the userspace (libumcg);
> >   - retries are offloaded to the userspace.
>
> Do you have some perf numbers as to how long a UMCG context switch
> takes compared to a normal one?

I'm not sure what is a "normal context switch" in this context. Futex
wakeup on a remote idle CPU takes 5-10usec; an on-CPU UMCG context
switch takes less than 1usec; futex wake + futex wait on the same CPU
(taskset ***) takes about 1-1.5usec in my benchmarks.

>
> --Andy
