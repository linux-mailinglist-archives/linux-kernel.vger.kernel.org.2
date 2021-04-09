Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BCB3590D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhDIAQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 20:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhDIAQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:16:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 17:16:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j7so2950365qtx.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IOoA2kTvDfBupyHsDf/FJrcWIjGCFOzoozTsFc0jX64=;
        b=EzJOThwErCKAdYEvCj69esN/Ho9fIlqOoqGL+HWjZpa6d8Z+qsgO/hgXHInUWXdsOl
         D4AxvsITQIbiXY5HhvF1u1ZtzSoGPg5tk0McnoRR78lxwF3cr4YXM1eyLX/5KcXhO4ye
         UZ8jtS4/Tix3mB6exex93/tHbfSaRTEfTvWGCPHn3NqbhS0pFHVD8ZYmxsKHxfDDABDy
         tynxb9lykL02iSeHUzGYlw8GMNGcnO9NLbAwj4zWVHsEl7vKcD+7L/201e6oTXcDeLKW
         8QytXgtwdBrWi0AvMrigcu/DzNbD/6ljVB8+opHmAZ0Abvqk0deh0ielnmReYn4Vw3NS
         Op1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IOoA2kTvDfBupyHsDf/FJrcWIjGCFOzoozTsFc0jX64=;
        b=RFT8H2oMUgG194e5FVhwuekv2tC6BRrcTn4KHOG4apLsmnhTYcF2I8k4ZnxSdbqCLe
         qwLW0aCqQjGNHMM7F1+z/SjCSdWEfCZg9v4dJ+PqtIlUTKfXBgjqU9d9IatDedlpftGa
         Ehpex0QNpMAvzq7YNtqrRU/6/Uv7BKpi8j6aG9zfhtPOKy3G7UAKAitQaIwtzSZDgHPa
         Qm2QwZoLeKUID/cGBmgGLJktP3cOI3BawpMIezDwq18auFhwayCe+Scdw14iHF+jIGKz
         qgtrLoVsHsnuPybHMLpyEIxhddvGqR//EaJ/Fj1jj07SShntbhvLhLg+FtTzIyFLlsms
         U2JQ==
X-Gm-Message-State: AOAM531unSu4+5YEUbRDDR7zBqj9pyFsADan9+kwkhzLq2QzZxHeC0Lq
        MMwY3H7n97Uir1sBuyLbQ3JJXzwGPw+UF6q3irFf6Q==
X-Google-Smtp-Source: ABdhPJxMzrnn6hVzO+UG5pgOiNLt8J/Dn/x0DXsnOaROy6xCC3gMi8RwMnkOsR9dVg81j0uSJ27m/CBLz7qdd/NpoWQ=
X-Received: by 2002:ac8:5b86:: with SMTP id a6mr9836409qta.293.1617927384311;
 Thu, 08 Apr 2021 17:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <YG3i2JF2vBY4CseK@blackbook> <YG37MBLBIXIPVv7u@hirez.programming.kicks-ass.net>
 <YG8EYKgcwLCfIZAV@blackbook> <YG8a/LbO4PXFLEix@hirez.programming.kicks-ass.net>
In-Reply-To: <YG8a/LbO4PXFLEix@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 8 Apr 2021 17:16:13 -0700
Message-ID: <CABk29NtTScu2HO7V9Di+Fh2gv8zu5xiC5iNRwPFCLhpD+DKP0A@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 9:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 08, 2021 at 03:25:52PM +0200, Michal Koutn=C3=BD wrote:
>
> > I'm curious whether the cgroup API actually simplifies things that are
> > possible with the clone/prctl API or allows anything that wouldn't be
> > otherwise possible.
>
> With the cgroup API it is impossible for a task to escape the cgroup
> constraint. It can never share a core with anything not in the subtree.
>
> This is not possible with just the task interface.
>
> If this is actually needed I've no clue, IMO all of cgroups is not
> needed :-) Clearly other people feel differently about that.

The cgroup interface seems very nice from a management perspective;
moving arbitrary tasks around in the cgroup hierarchy will handle the
necessary cookie adjustments to ensure that nothing shares with an
unexpected task. It also makes auditing the core scheduling groups
very straightforward; anything in a cookie'd cgroup's tasks file will
be guaranteed isolated from the rest of the system, period.

Further, if a system management thread wants two arbitrary tasks A and
B to share a cookie, this seems more painful with the PRCTL interface.
The management thread would need to something like
- PR_SCHED_CORE_CREATE
- PR_SCHED_CORE_SHARE_TO A
- PR_SCHED_CORE_SHARE_TO B
- PR_SCHED_CORE_CLEAR
