Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35F33103EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhBED4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhBED4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:56:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB0C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:55:24 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id l27so5677449qki.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAaRJACWW51J5vlqCTX3yVGM03oPhbUpsF+ymE+oVAM=;
        b=qVaZKJI5PUUQL3kPtrZv9MP7rbEn2UOxoEk1D/qucv3hsjP9Rzl6XZEOSkM89Gcz8n
         Th2e8DYWq3VGFXrleupHZl6pcF56VM2YV8DOtGyGzVYKbqKpWhtpBud63WA7FItli+2z
         60A7Qv4R8o5iM2CSGXU3lm+LlRhwAUlS4HSAz9ekA65tWg5Y99zakqBz5yo/NxsDfMGe
         yf2qpAeLBHnIUqGmqryBTwH11mItoUMFqNLk5JW1ujFkFRLZRYR+xF+aKrNYATFKF5yr
         TSn7hLacsQ/mA9ogRiLIZp8vz0j44fNl/yamA4u5t2DWmEqpBaQXJH8WaFGabokpw5Mn
         CcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAaRJACWW51J5vlqCTX3yVGM03oPhbUpsF+ymE+oVAM=;
        b=p2tJGXXfIrEcojZIVegt66sezs2cyS2FRUOCDxg4yOx0YpQZnaqaQ7r+uN1CSpAR5R
         SuEN7cCIRP9/JVWP1gkuOLyzqC3qfdILS6TVTmo86TuICNbSjo8pi7SnirusKMxWfqMH
         ycotlzkSTvhi6tZZp0w0Ps38mPHdiRWz8fKEvm+kAwYia0BoaA4pZ8r8n/4K3nxMXy6M
         Jyw2m24l2ECOc75rBdWfGTaj6xPkkOSBJAL3797xwg1RFzCyvzO73W7rulcPWfPn6FNN
         cp4zDpSaTLlTiQixh7lKRIOfR7tvMRD75m+kIj3E5XNWk1AzSjZPWR4XK7+vZffAmWTu
         tIyA==
X-Gm-Message-State: AOAM533T8jRuClUbTY/RqW8AIjrVmNcMSOa/yuS4FOqRkBnaRT6Wueq5
        3DzN1LGk+CZxo95EDqm5vjuHIilBEuzhKbj6GfYNMQ==
X-Google-Smtp-Source: ABdhPJyU0IV0FvLC+IraA0ATfPuhjgKtCVwOPkgOv7QG8VWPfHhXBGVe9EhHQ/EOwYF8Fhpi8vzer4IxIjmCnqrAt1E=
X-Received: by 2002:ae9:e647:: with SMTP id x7mr2481056qkl.276.1612497323405;
 Thu, 04 Feb 2021 19:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <YBv+Ps8F2eho77qh@hirez.programming.kicks-ass.net>
In-Reply-To: <YBv+Ps8F2eho77qh@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 4 Feb 2021 19:55:12 -0800
Message-ID: <CABk29NsmV=6fstw3qEPpEb5Zw9K6hpQSASE5yS68Zjj9_HDkcg@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 6:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
>
> > +#ifdef CONFIG_SCHED_DEBUG
> > +     /* Read the group cookie. */
> > +     {
> > +             .name = "core_group_cookie",
> > +             .flags = CFTYPE_NOT_ON_ROOT,
> > +             .read_u64 = cpu_core_group_cookie_read_u64,
> > +     },
> > +#endif
>
> > +#ifdef CONFIG_SCHED_DEBUG
> > +     /* Read the group cookie. */
> > +     {
> > +             .name = "core_group_cookie",
> > +             .flags = CFTYPE_NOT_ON_ROOT,
> > +             .read_u64 = cpu_core_group_cookie_read_u64,
> > +     },
> > +#endif
>
> AFAICT this leaks kernel pointers. IIRC that was a bad thing.

For that matter, we're also exposing the cookie pointer in
/proc/$pid/sched. Currently these are used by the selftests to
validate that two tasks are/aren't sharing.  If this poses a risk, we
can rework to avoid exposing the actual pointers.
