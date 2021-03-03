Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D332C3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354523AbhCDAJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCCWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:11:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAADC0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 13:59:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j3so3168262qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQvMooYXTqFSXvQJbwHhwZB/VRpYE9wlYhCe9YGfbL8=;
        b=Dt0X3mUQd/DUkNeuvAMV/W3X95HyHC/aM6ZOqeylnVIOQ2d/HZgPp07QkFrKNMFmZI
         I+May3xRHjkE8CvywD5YUBeiAgtaxogu4JyKD9wbdaAWYbzMI6Hd5ai9mgieMsLX9En1
         nQWo7cUP33IFgH9TKlIyFS5eBILD2HDrz+YX9Vpt8Nwah1e447SW96G1gg5yptJwmbBv
         eDqvY9hijk5zPfBUYwZ1qQsJ8wJ1RHwpS0scc1LGpdCoM1ctja0dq1DCjQsT2Nhw2veO
         9cj8v7LD6DUqDULb+runiba0Wx28zMY+tN8y2d1RPuCAOe6nycPkp/R7KNsM/qiA+4Kk
         QxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQvMooYXTqFSXvQJbwHhwZB/VRpYE9wlYhCe9YGfbL8=;
        b=ZA0MzP5r2wZkbKqSDzvy2KzDmBbH7Zt/8ameV9+fO6XVddEkVYoAt7+rn5oHvojyOZ
         hHn++yHRa1vfE5nz7LV0xgiAXY47VbLzfCfcYsH7ddanQ/mQoYfinF4I5GJGsBDYL95E
         HcGtNjmbE5KG/kDwYnQziAs69NfNDwZ4+Alzlu5LyAUNwjPnrbUGw1zOO9gWAid6IiyA
         f0P/eiSmZZsuZwwzeKsSHDWDvuGNAZIzgXXlfySmgQzNu/1Qr1R88up+1VwQ/bxMkR8L
         RA/YjKZHg3j/nkfINez6kzSqr6mdwqtUS8M61IAObUhG3rJfv6Urj/WCh+1Wv5GLC7J2
         pLVA==
X-Gm-Message-State: AOAM5311coDwRbGxHPRkZpwfRtv1xFAW0dEVMX74r9kAZ1XKBnGw5+ye
        hf5tfkfRTdMG9GDXVjMZjuVdJOmymDyLGApURhLS5Q==
X-Google-Smtp-Source: ABdhPJy5zBIdRBS64nEYKgi3rKCV9ZVp7hRddaxFdADyhwwmq7aPJyFzXiyQW1Czf8MMt97PfXj9OBbs0xz/EVP0xus=
X-Received: by 2002:ac8:4e8f:: with SMTP id 15mr1299223qtp.317.1614808753179;
 Wed, 03 Mar 2021 13:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20210226195239.3905966-1-joshdon@google.com> <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
 <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com> <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
In-Reply-To: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 3 Mar 2021 13:59:02 -0800
Message-ID: <CABk29NtgjoKb0-hH71XtUfQ8H=58VJh2aAY4Vs6ZaJfOpJGMrA@mail.gmail.com>
Subject: Re: [PATCH] sched: Optimize __calc_delta.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> you made fact_hi u32, why can't we unconditionally use fls() ?

Thanks for clarifying with ILP32; will remove this macro and simplify
to just fls().
