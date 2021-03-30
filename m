Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFD734F2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhC3VUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhC3VT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:19:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:19:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 7so17358911qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQRA3OjCeCU841Ne1zNo7gEHznsl3l8S5CKTW7wrnlQ=;
        b=oFfebUUAIYgPPhIXxzYrx8IceuWps3eVS1RcVu8Q3nFE+cTjEu4sCWKlIENNQ3twZd
         Deoor11jZHPDtc/lWgiEuQ/ZyBKGUuF4hhzjKAxcBmukBaRbLT+k4J6h1hgUHhLcHHL9
         NYUDvujo1S1QEYB4cANRi8yO2BGBd1teJiM196nbSTghuAi7Kwhz1EJJoTmyAAaGlHxs
         gp+hlnG00QtXBiF1INozUk2Z86x2n6c0AU5J2OWn4rSE24HeffQKo8eCE8sELxFDygAu
         bH+xjHbcdrqXYe13cotmSjQpRAGzbdkK/EdlNdVAepzLi+n6ux7n9gJvm5Ax77cUoawk
         vlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQRA3OjCeCU841Ne1zNo7gEHznsl3l8S5CKTW7wrnlQ=;
        b=JtUQ61iVH9Z/6ltoFWL39GqGjNMu8inj6+4Rkqmr6s2de7UHRhJcZyt3H9DPAzZYBz
         vSsgZJct73g497aG9lZZgb3zMqG1+N0jSUygS8VpoYXnQd0mtqpQXKxaIcy2xBx2pkXh
         hK4SD5rzsb6In47HhGO5dK3drE8J/uDHaP7WxO6NjOYRwj1LljrE276tj5fwVnKIrVeH
         ef4TCWN7WeMyzYvi2PMNjgn93ExHqGFlooTZJfyE8UD73sEFpdtjAZbWySG1JTrWdgvn
         pOOuoTJ6OSxuGONi5OQCkoPdj7BFt2Ta5JtIqjgdo/QZxj6642Hp8UosZyGVPTFrZ47J
         O0xw==
X-Gm-Message-State: AOAM530X7lAR1fq0+xyMClpLITAvnErMDOWPIkj8Qs91oWa47e1PJmrX
        fzDQk9IQjbqRjqpYyA61k0qaJvYchEewtqZeHd6O2A==
X-Google-Smtp-Source: ABdhPJxP4k7qdQxxlHSdJsSSWAF7hq1jXq0XZsjeK15KU2tDbiuy0y+he7kiN8sJg3m3LBTwGgDqnN4ALjXXaNLZEo0=
X-Received: by 2002:a37:a647:: with SMTP id p68mr215962qke.189.1617139198498;
 Tue, 30 Mar 2021 14:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-6-joel@joelfernandes.org> <YGLt/ltwa92lfCDK@hirez.programming.kicks-ass.net>
 <YGLu1swpZPq4nhJk@hirez.programming.kicks-ass.net>
In-Reply-To: <YGLu1swpZPq4nhJk@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 30 Mar 2021 14:19:47 -0700
Message-ID: <CABk29NsLwENwygzuNSuW6=R--P7Q38LL_wKXJJdH4N4+ysZ_cQ@mail.gmail.com>
Subject: Re: [PATCH resend 5/8] sched: cgroup cookie API for core scheduling
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        dhiatt@digitalocean.com, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 2:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Mar 24, 2021 at 05:40:17PM -0400, Joel Fernandes (Google) wrote:
> > > +
> > > +   if (!tg->core_tagged && val) {
> > > +           /* Tag is being set. Check ancestors and descendants. */
> > > +           if (cpu_core_get_group_cookie(tg) ||
> > > +               cpu_core_check_descendants(tg, true /* tag */)) {
> > > +                   ret = -EBUSY;
> > > +                   goto out_unlock;
> > > +           }
> >
> > So the desired semantics is to only allow a single tag on any upwards
> > path? Isn't that in conflict with the cgroup requirements?
> >
> > TJ?

I carried this requirement over from the previous iteration, but I
don't see a reason why we can't just dump this and have each task use
the group cookie of its closest tagged ancestor. Joel, is there any
context here I'm missing?

FWIW I also just realized that cpu_core_check_descendants() is busted
as it recurses only on one child.

> > > +   } else if (tg->core_tagged && !val) {
> > > +           /* Tag is being reset. Check descendants. */
> > > +           if (cpu_core_check_descendants(tg, true /* tag */)) {
> >
> > I'm struggling to understand this. If, per the above, you cannot set
> > when either a parent is already set or a child is set, then how can a
> > child be set to refuse clearing?

Yes this is superfluous with the above semantics.
