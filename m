Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5132C3D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbhCDAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390142AbhCCWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:02:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663DC0613DA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 14:00:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r24so18850294qtt.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 14:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkGapjMnJn9HZY59dhus3KP4cZ8f65QJ9j79aM4Jbvg=;
        b=swP7TwMIX7+JawIKmb+GSOmqXSNSsa9kIQqihGYUHx4wMX1+vuKoztjFO8Egya9QPQ
         YRIs6y42qpsWYF/sUNphbRATc8U0xzP/d4Qu82zjYTVhrHkWorZp2p756RC+wCpRdJIF
         0dPCPKyLFxQiJf4k7dNz1/OaLUpGVy+VKgBp6FXaZJIbSoTrMTjRTNye77OjfuXE4JL8
         vofLfVRlD5pcw2DesGixAW3trZVYNL28YzeH9BJ0o7a0/LQxNNkU3i41/xmZVE+8QNsg
         IxvwDFAO6+gu13OE1AfJiBN2ag0rRnGgryHJoGhs5PQDcxzROhltvnfdLg6rHaFfjaa+
         idmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkGapjMnJn9HZY59dhus3KP4cZ8f65QJ9j79aM4Jbvg=;
        b=Z37LpXLWVh1EfSNdoDoZMcR/LsuDbK8wX/jbq2NU71LLrtjHWzWxjm1M1EgRSY4br+
         3zXWx3/G+1bVgoROgDjFjRlN5YEnhOdreezgxalTKsRaYMjR9+9TeFC9UiBcyJsbgOSS
         rmnRZBvSCz+XYHH/NIcFppyZ0M5YLg7WK8HbVt8VOHaX50nhvLtpTD3JDa8ijnsML9TP
         GbLUhMS0sHvbP3juRtaGI3UQAOY7FsZVgVS9Rey5M5lvkzUZQircYwnuIP1LFueVpKeI
         f18gbTHU+SPjKWWzGO1wP2E8OZ42g2ZkjXWLGN5LmZKjhKe/npI0b0HQxP/xEaAe8s5t
         s5oQ==
X-Gm-Message-State: AOAM532vUq+sk+OVJ3MAOIrS6eRvjuoy9eQoXDIJE1tI7QKjNvw5+xWh
        +90JOz9evmee0gcC3qoTrCqINiOVU9DdYzN0G9oq2g==
X-Google-Smtp-Source: ABdhPJz9TeHg4tlJkK1s7ah1hGG6snT5ywQQksuAcrsFRBgc8I7bOEzbKqv/sp4qqmS7z0ezGjU4nn4KTOqf+6wLEc8=
X-Received: by 2002:ac8:44ca:: with SMTP id b10mr1311799qto.293.1614808828935;
 Wed, 03 Mar 2021 14:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20210226195239.3905966-1-joshdon@google.com> <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
 <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com> <YD9etVMPW5A22jxo@hirez.programming.kicks-ass.net>
In-Reply-To: <YD9etVMPW5A22jxo@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 3 Mar 2021 14:00:18 -0800
Message-ID: <CABk29Nu67D8Wf-xEyaxZ39FsqPB9tpw8cGHPFmZrTqfM-JgYjQ@mail.gmail.com>
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
        Oleg Rombakh <olegrom@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 02, 2021 at 12:57:37PM -0800, Josh Don wrote:
> > On gcc, the asm versions of `fls` are about the same speed as the
> > builtin. On clang, the versions that use fls (fls,fls64) are more than
> > twice as slow as the builtin. This is because the way the `fls` function
> > is written, clang puts the value in memory:
> > https://godbolt.org/z/EfMbYe. This can be fixed in a separate patch.
>
> Is this because clang gets the asm constraints wrong? ISTR that
> happening before, surely the right thing is to fix clang?

https://bugs.llvm.org/show_bug.cgi?id=49406 filed
