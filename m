Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06F3236A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 06:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhBXFQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 00:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhBXFQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 00:16:52 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:16:11 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x124so1148949qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUvWJYrXAuGzpS9fS9+tPQGfdm51KBNj7fCxiqur/W4=;
        b=Ulx78aW7pwQUhvRUIGQwRIKK7P8C4yFz0OBXNfJ9ue4wan0M9Vl2xKLi4S1AHfd4I0
         DQs5O2iRjk3g1hcJ8loFdyjeCSrYzND5ypqxx09lqK/bvbVit6uggOtkg/rkwDMTH+rx
         4MHqH5fuYGUmYNn3YsQjlL147kFD0YHZpW0aEYr8NKGJXrdx5jiJSQE1KHZMwTSILXtG
         gUjqKuD/KJcY5CKR09jKUTKVWhcgM7ODATAyHMkLa11UyK+ltzvVnXbAQI5z2ygk1Iw6
         JXZW+KYZSWLAKdjPSWBfEuryFwNMi6X6O7C9c3nxBDfs1LMP/cuZiV2e0d7KOHtrF1Zy
         5V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUvWJYrXAuGzpS9fS9+tPQGfdm51KBNj7fCxiqur/W4=;
        b=NF6KJBMTob4+9VgNT2Ng6mRY/sYGrqlo7E7NxfDCpronnvVyCoxLO8gZ2qmc1npcrL
         d1LEyxqCBa2xVJyDphms9rwZP6JPj+t2mz7JwVyIAVjZPUpwgFgn3xUE5/yQWMTKk50g
         IpDxiEIr1NLbVwLvdFCou1xpWBlYiqgH9t6t4fYlGyQxrV0+tHwRyHA4S4Yk4n3RGTAl
         3dpCRchcKkRIMKnvkiaigY6ER9trjNma/VY2f5s90FQyU5LE4rddWLTCN2SVQpYVq8Ss
         ttvwBq/++6ly1eOAjJg+1+GTaaRl4ivB2gFqIiHuoy6CMgMRRTzh3OKO85hh6YH++jHG
         /JNw==
X-Gm-Message-State: AOAM532R+ou2wA11gVrHXHxKOg+1Rw1DveeU4UyEKtIL/fYyUgO+M3iq
        9d1w539daGEA8yBhL5cXWhMmrALCdyZ8qDMW/Xg8EA==
X-Google-Smtp-Source: ABdhPJwVtVcsosketbfwboWYRQdvwwJa4H45fNyNHqmFQzIwsHv9E0PUfv7jf1y8BWP8Hv41J8gsqJlYPtgBve0SLMA=
X-Received: by 2002:a37:27c8:: with SMTP id n191mr29004102qkn.146.1614143770799;
 Tue, 23 Feb 2021 21:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net> <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
In-Reply-To: <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 23 Feb 2021 21:15:59 -0800
Message-ID: <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:26 AM Chris Hyser <chris.hyser@oracle.com> wrote:
>
> On 2/23/21 4:05 AM, Peter Zijlstra wrote:
> > On Mon, Feb 22, 2021 at 11:00:37PM -0500, Chris Hyser wrote:
> >> On 1/22/21 8:17 PM, Joel Fernandes (Google) wrote:
> >> While trying to test the new prctl() code I'm working on, I ran into a bug I
> >> chased back into this v10 code. Under a fair amount of stress, when the
> >> function __sched_core_update_cookie() is ultimately called from
> >> sched_core_fork(), the system deadlocks or otherwise non-visibly crashes.
> >> I've not had much success figuring out why/what. I'm running with LOCKDEP on
> >> and seeing no complaints. Duplicating it only requires setting a cookie on a
> >> task and forking a bunch of threads ... all of which then want to update
> >> their cookie.
> >
> > Can you share the code and reproducer?
>
> Attached is a tarball with c code (source) and scripts. Just run ./setup_bug which will compile the source and start a
> bash with a cs cookie. Then run ./show_bug which dumps the cookie and then fires off some processes and threads. Note
> the cs_clone command is not doing any core sched prctls for this test (not needed and currently coded for a diff prctl
> interface). It just creates processes and threads. I see this hang almost instantly.
>
> Josh, I did verify that this occurs on Joel's coresched tree both with and w/o the kprot patch and that should exactly
> correspond to these patches.
>
> -chrish
>

I think I've gotten to the root of this. In the fork code, our cases
for inheriting task_cookie are inverted for CLONE_THREAD vs
!CLONE_THREAD. As a result, we are creating a new cookie per-thread,
rather than inheriting from the parent. Now this is actually ok; I'm
not observing a scalability problem with creating this many cookies.
However, it means that overall throughput of your binary is cut in
~half, since none of the threads can share a core. Note that I never
saw an indefinite deadlock, just ~2x runtime for your binary vs the
control. I've verified that both a) manually hardcoding all threads to
be able to share regardless of cookie, and b) using a machine with 6
cores instead of 2, both allow your binary to complete in the same
amount of time as without the new API.
