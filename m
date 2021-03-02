Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80132AE03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360356AbhCBWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381439AbhCBU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:56:40 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81FC061356
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 12:55:19 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id s17so6059385qvr.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQfXllwKN5G8JGXptjBrQYjr7HBI6bLZ8JEcl84qd2Q=;
        b=fCQLxGXewrDDQXo/cYSGKTR+uA+HfeC9xfDoFNHv0vnbdbprQea443sCI6U0NKpTv3
         p4iADjmCJWrOGiFFZOxAA3C5mU7wNkcWRaThgI0p92BxKTo8ZY/uuBq2gf22DCACVoa2
         YdeU+qrchMMKT06xG46FkN+PelpWnENCBf9wMXal7me9nSyoiqROsdxf8Tr+7VbCyZ4+
         JTxsLYX7Ek5sVOUHWkTBIaOZVr6yarV15jPdfXsgeIf3LLrkMUnCzsvzdhtHr38o4xHx
         kaljloJBXwugJNFdA6nEZojSGR82YDmCT4MRtYsTQarndl5sCNtSiPNG8zsMvi40t73y
         TqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQfXllwKN5G8JGXptjBrQYjr7HBI6bLZ8JEcl84qd2Q=;
        b=D3IJJt+XmLgLKlpN8gniOYEFxVMRlq8cNc6ysxT5PQ6NBqmaXfBvq+tg6r+CaJ5dWj
         73ZKDYBegBQ/JZ+k3PCv0nT67MlOx2Lq18hlf3nA9pmX7JJSjZRnU1xCkT8K+ajhOR72
         muii/qAzo6WfObe/vzsXA+a1ixXdWBeY1LAMMj704g/HMLRDmXlxo33G9JxF0jYMmz8j
         uXACkCD7mJJ6aj5JMzuR7PNus/etUwPmitioLFiszhF9VGWWUayDgkKrjvOnbCa0wUOd
         YtDPkKtMLDbS7k2Fttr0RC1d+00wfE5nzAX+l9mHbWghdheB8azld2JtAUJP62JEjjdV
         G4/w==
X-Gm-Message-State: AOAM531AZ1fdlVsdpelGhsODhxi4xG9xmuJ4qdmqHpkknjItbxxx+f9F
        EmpuOJtWyW6Vujzc3XSEwVeiQNTNjKKETZPTiw9Zpg==
X-Google-Smtp-Source: ABdhPJwbAXiGK1+Fj7XuxAJz6vjM8zKfrdGarrWy9mjUr+ILs8EHbDcvMWpVU6M8PiLbhAgbzQDlIE4BhCIoGJVYLtM=
X-Received: by 2002:a0c:b912:: with SMTP id u18mr21543184qvf.2.1614718518335;
 Tue, 02 Mar 2021 12:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20210226195239.3905966-1-joshdon@google.com> <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
In-Reply-To: <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 2 Mar 2021 12:55:07 -0800
Message-ID: <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 1:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 26, 2021 at 11:52:39AM -0800, Josh Don wrote:
> > From: Clement Courbet <courbet@google.com>
> >
> > A significant portion of __calc_delta time is spent in the loop
> > shifting a u64 by 32 bits. Use a __builtin_clz instead of iterating.
> >
> > This is ~7x faster on benchmarks.
>
> Have you tried on hardware without such fancy instructions?

Was not able to find any on hand unfortunately. Clement did rework the
patch to use fls() instead, and has benchmarks for the generic and asm
variations. All of which are faster than the loop. In my next reply,
I'll include the updated patch inline.
