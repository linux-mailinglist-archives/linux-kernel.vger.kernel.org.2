Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1F3769C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhEGSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhEGSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 14:03:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A7C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:02:18 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e14so8364281ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiFf1NwwUvud1mnDtuQmtDxIGqR5e/nfJ7NM5Is87sw=;
        b=oYfD4vzTCc927EwqeTaZUZiVyk6EYM8Vnm//QRL1AumSWt6cAtSBlStkF+BcohKFM3
         +tKacLNbJX9Z+qo+ajJsgGRlRm7ZxV9lO6bAAfyg37DxOD/qpn4p/JgkCkQ863/V2aPa
         BbTv/2NoY8ZFFBzKNxjTu5e7HAVcd42icZW18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiFf1NwwUvud1mnDtuQmtDxIGqR5e/nfJ7NM5Is87sw=;
        b=VXNOx0ypuF9bcNgGRhciBYB69xihOa2k09KchH5MChmaNtzAR1I6HK1Uxgx31ihtre
         1778eQVzTzy7OuFZKNF6HpgMH4bIkg1rxDZb+zwdbPLPfSUUSg2fBo2AvpHrtk1foDpj
         a0ExsMWIhsSae7TY7OqjpKT4YNkhPmTKopVBdFjwmDAgIHp0qOz+aQ6b+GZLjBiV1oLE
         j4zTFQI+22Mkq5HTlfO01+jMUVwGUtPJ2kGGraPg/J3dIkfr+QoijJ2CYbId27/LhjkN
         2l0Lsw9u4fr5rugghPlGlpCAhBKR6zPWJvGh+P09raLTQ8xRTZgze9ZDx6kALO5sJ7Qo
         i+Qw==
X-Gm-Message-State: AOAM531gi9l741XfLaSo2NdFshdIDxPaESuFv7IPNI6ST7nR2I/eDd5p
        qPzncEX7ZpbmBh53x8qqqIuTYa3FLT1daFrfydav+A==
X-Google-Smtp-Source: ABdhPJzN5HWpa8Abi1V1uTyBqqXUgx1GSkjd39fpUWTlxDTnlmS25VaHCKz9+XKlEVlcRVRQ4oFIfNWsE+JI0TGAP3I=
X-Received: by 2002:a05:6e02:5d1:: with SMTP id l17mr9847706ils.78.1620410537552;
 Fri, 07 May 2021 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org>
In-Reply-To: <20210422120459.447350175@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 May 2021 14:02:06 -0400
Message-ID: <CAEXW_YT5AoRwS7XZreX-_2OAzoQNVUeaOH3nJFvV65T0zDaP5g@mail.gmail.com>
Subject: Re: [PATCH 00/19] sched: Core Scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 8:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hai,
>
> This is an agressive fold of all the core-scheduling work so far. I've stripped
> a whole bunch of tags along the way (hopefully not too many, please yell if you
> feel I made a mistake), including tested-by. Please retest.
>
> Changes since the last partial post is dropping all the cgroup stuff and
> PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> the cgroup issue.
>
> Since we're really rather late for the coming merge window, my plan was to
> merge the lot right after the merge window.
>
> Again, please test.

Thanks Peter, I uploaded this set to our ChromeOS 5.10 kernel tree
with minor changes to make it apply, to:
https://chromium-review.googlesource.com/q/topic:cs510
Let me know if anything looks weird, but it does build. I will be
testing it further in the coming days.

Of course product kernels slightly lag upstream but such is life <:-)

 - Joel

>
> These patches should shortly be available in my queue.git.
>
> ---
>  b/kernel/sched/core_sched.c                     |  229 ++++++
>  b/tools/testing/selftests/sched/.gitignore      |    1
>  b/tools/testing/selftests/sched/Makefile        |   14
>  b/tools/testing/selftests/sched/config          |    1
>  b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
>  include/linux/sched.h                           |   19
>  include/uapi/linux/prctl.h                      |    8
>  kernel/Kconfig.preempt                          |    6
>  kernel/fork.c                                   |    4
>  kernel/sched/Makefile                           |    1
>  kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
>  kernel/sched/cpuacct.c                          |   12
>  kernel/sched/deadline.c                         |   38 -
>  kernel/sched/debug.c                            |    4
>  kernel/sched/fair.c                             |  276 +++++--
>  kernel/sched/idle.c                             |   13
>  kernel/sched/pelt.h                             |    2
>  kernel/sched/rt.c                               |   31
>  kernel/sched/sched.h                            |  393 ++++++++--
>  kernel/sched/stop_task.c                        |   14
>  kernel/sched/topology.c                         |    4
>  kernel/sys.c                                    |    5
>  tools/include/uapi/linux/prctl.h                |    8
>  23 files changed, 2057 insertions(+), 222 deletions(-)
>
