Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1C387F42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351463AbhERSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346898AbhERSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:09:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:08:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so12611345ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E7Z7TDc06/eMEz9G837ZKMVJn1ufiTnEi/jaPd1NvY=;
        b=wOsUI1tgO5GyceYANUg7bhK+kgPr8bEKnGXv/CrfjPyGFSLphMKWdlZbBEhK7JawBf
         VD4c2QD/2KMR0E1qrzCd8QMtksaO27A+uv8JW3OhfX3sgIO7YNQSvG7SBMKQu5+L4oyT
         e+jYaEtihbIO72lE8SQhtw1Kqu81Hhb60lIgHixmIpFlXHvyFghJ4FSyT2qOSKhkPN2B
         Ru9nHknSVzUt8GKlVm1bXVCs9/yj6iUBDkUShcRkSXiSUKjjyG1Ji+9RF32Qqd0FkesP
         mxQH2WbtbiAguRwQ3nYFu4iEy7nxrOU7RLTANf7M9dgJbX9r+B2cdYFpSwE9QrIPOOje
         EuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E7Z7TDc06/eMEz9G837ZKMVJn1ufiTnEi/jaPd1NvY=;
        b=ShUzpE85//K1qb4vVhrJsm19QLIQYByTjn0Sdib+MYGK/1tPdwPkDpfUd8YuH+n0Uw
         D2D+K1AvV56zaskvG0YzvfEJiWiHzr1gt6XeKaGD/3pcF550xfQqaP9vYsRKivI0dHRr
         HY7IUskqH9Oq5/nrB2VcHmVWMfLpnC8lnfR6qeoiOQEBCmlCbrIlJUtMusofjECD04oU
         2Kul/vWp26Ewllh8cYgCznBdjjL7RxfzoTgWwyHx8lvHgFQ/8VgLkqRERWNz958+KRKo
         vNwOuxEZY6SmdC/faDnbskzYrp+I7u2ElDu5TaRyEMIZP8Ut9wOJbCrJBN8OIhgZAPA5
         klGw==
X-Gm-Message-State: AOAM531CMqQu/lLF20et0E2yvkiaQBysG3/1MEejdHK32mRm7CdR1C3+
        VTP0mUdit3AN9Sjf/rDRS+pYzpHb96vj1QtmZlybZA==
X-Google-Smtp-Source: ABdhPJyLLwcAeGX5sDd57fzmMT0ecsaNhxJsRNedKf9DMhNB1jsVArj8Os8vAkYsZdR+La9q6npu0K2+JNJ4YUxhMWY=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr5225520ljr.0.1621361298314;
 Tue, 18 May 2021 11:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210518020200.1790058-1-surenb@google.com>
In-Reply-To: <20210518020200.1790058-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 18 May 2021 11:08:06 -0700
Message-ID: <CALvZod7VBQMyftOffc8maCKtDwybLWGQNkk+R0M2SJPy2BuEjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, bristot@redhat.com,
        paulmck@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        viresh.kumar@linaro.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 7:02 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> PSI accounts stalls for each cgroup separately and aggregates it at each
> level of the hierarchy. This causes additional overhead with psi_avgs_work
> being called for each cgroup in the hierarchy. psi_avgs_work has been
> highly optimized, however on systems with large number of cgroups the
> overhead becomes noticeable.
> Systems which use PSI only at the system level could avoid this overhead
> if PSI can be configured to skip per-cgroup stall accounting.
> Add "cgroup_disable=pressure" kernel command-line option to allow
> requesting system-wide only pressure stall accounting. When set, it
> keeps system-wide accounting under /proc/pressure/ but skips accounting
> for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I am assuming that this is for Android and at the moment Android is
only interested in system level pressure. I am wondering if there is
any plan for Android to have cgroup hierarchies with explicit limits
in future?

If yes, then I think we should follow up (this patch is fine
independently) with making this feature more general by explicitly
enabling psi for each cgroup level similar to how we enable
controllers through cgroup.subtree_control.

Something like:

$ echo "+psi" > cgroup.subtree_control

This definitely would be helpful for server use cases where jobs do
sub-containers but might not be interested in psi but the admin is
interested in the top level job's psi.
