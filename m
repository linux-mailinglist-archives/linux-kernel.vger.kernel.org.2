Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A592305017
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhA0Dot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbhAZW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:28:30 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02044C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:27:50 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d81so37007164iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJhhmvWns3GKOFhUzS0tKCy1L5S8kNGu09jKiG35J4g=;
        b=M4Adf9g3xuqbQL0ROgpyHsWneeiSZ8EF8P6XH1vOdJI6ZW3m3a2UMJnadLfRIAme+0
         QD2WDAzEdgXf3TVKluiBW+7S6NYvRmeM6IIHEoCeMOj4qx2ju7p5RmYPdDqfo0DLbnvx
         uvNr9Yr13B2TRzEpMDM6w7fh0kbsTVoEvjl6jGdRcyh43NIL8VkhM0JLRYL10U6K7yNZ
         rJ16vwU0wiGNXQLp7WFuOHCwtP6LxLoLHGR4BcfaI21jQBI+wKS7qmkVv1LVG4B4AWrN
         ERv3FAmgJebxITGFci8qZ/tXLLrc+Ox1Ye4gdl64HTqJhyT2oCwiAIqQ5N9r5wRbnmiE
         hTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJhhmvWns3GKOFhUzS0tKCy1L5S8kNGu09jKiG35J4g=;
        b=dh7aqspC8GGbvNbRmuCFcHRX04hbvmJNtzOgoPV7aij1QDgvjUJjVWVtw+bcRpgXHD
         J8jiUBEjllHAApVh0w0ZvJ1ARVIPIC0B84Dfv2xQxWFIuvYIJo4gdL0VdOk1t8jiQHPn
         bWvgNa7MIKl6Xpq/BXAHcjgbsWYT0B62vUTm4QPjtuQ1KfLXOr+DFuUm3uZ6Fxhq7aeX
         6NwWC0woIL13iUplkPXYEZLcjT7kX7Mx1VzGCjEXVdBSHlkcahKPfx52AE4M722gtM7y
         mtbWRx9ZJLllM22XuxAqBfFKE3m/FfbSLftgNXc5q0uT7WHODCuDb5XaQ4ifu+DN9UzD
         ToOA==
X-Gm-Message-State: AOAM530EDWNwigywi/oen9HnSE5LC1ly8hwDbNXZzRphENrWFHF+dkZr
        sjbsGYHieNhyLS/8CNX+qRss2V/XmG+56aJb0/A=
X-Google-Smtp-Source: ABdhPJyNE/M0BY6vDCo+19dl0fXp37s/Sf6yFyK4vlD53cXCm58wMdX7VIkJcwGb/2rdyUIPEXFArKnTgoNo5LPHnRc=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr5660847ioh.92.1611700069265;
 Tue, 26 Jan 2021 14:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
In-Reply-To: <20210126171141.122639-1-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 26 Jan 2021 14:27:38 -0800
Message-ID: <CAAH8bW-6GQkx67=iiwozKwG=4b4rJ8sqNB3UrMeS5eregNvkzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] support for bitmap (and hence CPU) list "N" abbreviation
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lizefan@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, josh@joshtriplett.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, fweisbec@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:12 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> The basic objective here was to add support for "nohz_full=8-N" and/or
> "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> to the last core, evaluated at boot for anything using a CPU list.
>
> The thinking behind this, is that people carve off a few early CPUs to
> support housekeeping tasks, and perhaps dedicate one to a busy I/O
> peripheral, and then the remaining pool of CPUs out to the end are a
> part of a commonly configured pool used for the real work the user
> cares about.
>
> Extend that logic out to a fleet of machines - some new, and some
> nearing EOL, and you've probably got a wide range of core counts to
> contend with - even though the early number of cores dedicated to the
> system overhead probably doesn't vary.
>
> This change would enable sysadmins to have a common bootarg across all
> such systems, and would also avoid any off-by-one fencepost errors that
> happen for users who might briefly forget that core counts start at zero.
>
> Originally I did this at the CPU subsys level, but Yury suggested it
> be moved down further to bitmap level itself, which made the core
> implementation [6/8] smaller and less complex, but the series longer.
>
> New self tests are added to better exercise what bitmap range/region
> currently supports, and new tests are added for the new "N" support.
>
> Also tested boot arg and the post-boot cgroup use case as per below:
>
>    root@hackbox:~# cat /proc/cmdline
>    BOOT_IMAGE=/boot/bzImage root=/dev/sda1 rcu_nocbs=2,3,8-N:1/2
>    root@hackbox:~# dmesg|grep Offl
>    rcu:     Offload RCU callbacks from CPUs: 2-3,8,10,12,14.
>
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    10-15
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N:N/N > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    15
>
> This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.
>
> Note that "N" is a dynamic quantity, and can change scope if the bitmap
> is changed in size.  So at the risk of stating the obvious, don't use it
> for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.

I think it's worth moving this sentence to the Documentation. Another
caveat with
N is that users' config may surprisingly become invalid, like if user
says 32-N, and
on some machine with a smaller bitmap this config fails to boot.

It doesn't mean of course that I'm against 'N'. I think it's very
useful especially in
such common cases like "N", "0-N", "1-N".

Would it make sense to treat the mask "32-N" when N < 32 as N-N,
and bark something in dmesg?

> Paul.
> ---
>
> [v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/
>
> [v2: push code down from cpu subsys to core bitmap code as per
>  Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
>  https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/
>
> [v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
>  just being allowed at end of range like "0-N".  Add new self-tests.  Drop
>  "all" and "none" aliases as redundant and not worth the extra complication. ]
>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ---
>
> Paul Gortmaker (8):
>   lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
>   lib: test_bitmap: add more start-end:offset/len tests
>   lib: bitmap: fold nbits into region struct
>   lib: bitmap: move ERANGE check from set_region to check_region
>   lib: bitmap_getnum: separate arg into region and field
>   lib: bitmap: support "N" as an alias for size of bitmap
>   lib: test_bitmap: add tests for "N" alias
>   rcu: deprecate "all" option to rcu_nocbs=
>
>  .../admin-guide/kernel-parameters.rst         |  2 +
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  kernel/rcu/tree_plugin.h                      |  6 +--
>  lib/bitmap.c                                  | 46 ++++++++++--------
>  lib/test_bitmap.c                             | 48 ++++++++++++++++---
>  5 files changed, 72 insertions(+), 34 deletions(-)
>
> --
> 2.17.1
>
