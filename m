Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA57C3454CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCWBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhCWBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:15:34 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA75C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:15:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v70so12791535qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scplLgXPqqZKrtnIxgrt8tEocTmcj46ftQf4U6i2iYA=;
        b=nChjpddhcwjSCu3obF68BMXJY1m7YhqYrE9QDshrL1zxJwh0t9zHT3e82XFwk4t2Ar
         qVdTuKvAKNHw6QQcw/JnzStDKlhRHMoYXTj2zgbdt5e0H2Zo5E1GFc45NX55kQv1yxXh
         OgYUwCVqfMywOGcD5o7OpWp4u9/dak1QJNjAvL8DF9xqDz4LkwNFXIwxm2JtwxSxhox4
         jq/wY7H/MHwkIf+kagLPOaii9x6tVzxc4p0EV/739TWZhTzT7q1gnC5FKE+wfYIJ8M55
         vg2iFh8GcgDWw/t9RzZau3mAXgXE9Z/T7ZP/meWmseigZpUlu/leKot8ZuM99l1kqnps
         TNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scplLgXPqqZKrtnIxgrt8tEocTmcj46ftQf4U6i2iYA=;
        b=pTpmWzLUsM5nBYtrDXQi65EstcsNEtH0fl/s7pH6C6XBcN+Avey097JSj2VuopODMY
         Gm24h2xu2TaYMDlJGnGDcNJ3XRLnas1ZmqBrD4Wu0qNvhCYFFLhv4Bi+pJa6feNtB7Tb
         uxI3N62yspUtrD/VPbmTRibU/lT7wEuF6n5Dttsw6Q+y1hPj9kqaXm8xS6iAPCdHujtb
         eL6hEuA6zRcI2xbCJVXEkTGBAxfFABoNqUeYRn/Gxcu8EQQUrFFJ5OlulLBqwwcKj+o6
         cht61cp5YDCdgkspZj8dg7/QQot6qRIqT/ncns8tNvcmTQxuegZIdpEHvlg5kinH/4E6
         Ihkg==
X-Gm-Message-State: AOAM530Fda1AJJk0sJ7vDqERhn3eiqadEO12ZryiPjRn0QEzgYjrfcW/
        0JFzJQRo9B6Dj8kn8KmkqEzHxApt4N3McehTuAvYqw==
X-Google-Smtp-Source: ABdhPJzOpro7C1aQUTouUHfe7+0TwOaB6WkuLAry5pJTYJSt3nwE5fu2jXm5nj0XKPds1iiJecOf9/hZgeBYOrvEpJM=
X-Received: by 2002:a37:a647:: with SMTP id p68mr3035984qke.189.1616462131596;
 Mon, 22 Mar 2021 18:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-3-joel@joelfernandes.org> <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
In-Reply-To: <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 22 Mar 2021 18:15:20 -0700
Message-ID: <CABk29Nvp92i3_qsr4519XEa9=_XjKYemDpj2Ptk45wx90bYgFw@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched: tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Steven Rostedt <rostedt@goodmis.org>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static unsigned long sched_core_alloc_task_cookie(void)
> > +{
> > +     struct sched_core_task_cookie *ck =
> > +             kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
>
>         struct sched_core_task_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
>
> Also, those type names are unfortunately long..
>
> > +static void sched_core_get_task_cookie(unsigned long cookie)
> > +{
> > +     struct sched_core_task_cookie *ptr =
> > +             (struct sched_core_task_cookie *)cookie;
>
>         struct sched_core_task_cookie *ptr = (void *)cookie;
>
> Know your language and use it to avoid typing excessively long names :-)

Good point, done. Keeping sched_core_task_cookie for now unless you'd
prefer a replacement, since it is only used internally by coretag.c.
