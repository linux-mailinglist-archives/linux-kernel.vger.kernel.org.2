Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B88446B15
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKEXGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhKEXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:06:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C75C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:04:13 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bm28so10127147qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNyg2uSqsWWOkhRlD7q+NCFVj7IbVMltP2NKSoIKgM8=;
        b=c45fjMeVz7SB02yT63a42t9+4q69zWkm8R93gB6TGNUKTkgiXYK2q5HvJNUqBKdadB
         Z1ebspcysUjRrUVV9LpXTgX4FPpT4ygkWeKMti34a6eDgqV802J00bcjjUjZoS5uL5xM
         8oSXg0O8akBiMu5IJzz+t79UEpT/aV5qiV0B2cMpXEdGkM/L0L8WfU+5qT7YsTComahh
         3jmcxkQv/klq0VgwMpYNXhPBDesIhRp2ybBdVbDoKrO/FLXEZgtsaHjEGoDqaD6iII3A
         N5HJc1EMUqF+soDkRVQfrwUqImRgdgNdycvE1NbXZWj9sipCHZwX+cz6CWY6qQZUNLiM
         clBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNyg2uSqsWWOkhRlD7q+NCFVj7IbVMltP2NKSoIKgM8=;
        b=iJ70laQQEHEggH6YLE5CpWnlvR3UtMCy2k7biOSYpgXilXWxUIEWj8gIJrYbhc5QCd
         W2NTfe/obLq4DgYPI7urVtBm85G/sEXtqai37VBuv4rf9U6ps7BcRokQgVfcoqLfN+r4
         DWpNFmcwmrXMNJNktfy3chMg/tzrp5A8sDv1gcgsndcMWwluCVLqFhexaDU8QL+pTBo1
         WeMh9S8Hp9r0yXgxQa5pyd2CuqXk/OI1YXY70lAneTltIohXyMjeA7kt7uzCw9Hx2o8q
         8emcQz4W0cssOS4IBSHDp0Dg7DPbAOdzbmi6LXfPxFTub7JAiRD6iI2uhNTwKm55J/rs
         nf8w==
X-Gm-Message-State: AOAM530h7W7CiXZ9hxMi5nDMUNo6Y7P77c717Zx/vmg8OyueK97YnndV
        vi+DkHADZBKN964S27B8hgef//MA00uVvPd5FFizMA==
X-Google-Smtp-Source: ABdhPJwiy1h9s4PfZMw2wdZ9rq92tXcpjFnh1fQfK32KIfxYMVYqRYjldv/dUbOTm1EoogM7S1fPLbnTqalvPob+JHg=
X-Received: by 2002:a37:2716:: with SMTP id n22mr16030083qkn.492.1636153452199;
 Fri, 05 Nov 2021 16:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
In-Reply-To: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 5 Nov 2021 19:04:00 -0400
Message-ID: <CAJWu+orNotdFUe0Bc9ooP+1nzajd=7A9WiSWXwtrsLkWi8gFAg@mail.gmail.com>
Subject: Re: RT_GROUP_SCHED throttling blocks unthrottled RT tasks?
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 1:44 PM Doug Anderson <dianders@chromium.org> wrote:
[..]
>
>
> I tried gathering some tracing. One bit that might (?) be relevant:
>
>  cros_ec_spi_hig-179     [000] d.h5  1495.305919: sched_waking:
> comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
>  cros_ec_spi_hig-179     [000] d.h6  1495.305926: sched_wakeup:
> comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
>           <idle>-0       [001] d.H5  1495.309113: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H6  1495.309119: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h5  1495.309336: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h6  1495.309341: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H5  1495.312137: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H6  1495.312142: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h5  1495.312859: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h6  1495.312870: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>
> My best guess is that there's some bug in the scheduler where it just
> loops constantly picking an unthrottled RT task but then incorrectly
> decides that it's throttled and thus doesn't run it.

Thanks for posting this. Tricky bit indeed. I was wondering if the
issue is here:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/rt.c#L1031

Basically, if something is actively getting RT-throttled on a CPU,
then if something else unthrottled but RT is ready to run, the
scheduler does resched_curr(rq) anyway. This probably happens when
update_curr_rt() is called on the unthrottled RT task via
task_tick_rt().    That seems a limitation of the current RT scheduler
I think? Thoughts?
