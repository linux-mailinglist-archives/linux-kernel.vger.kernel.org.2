Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15834B3FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhC0DUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0DUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:20:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFBC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:20:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q3so7312974qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLsrfQt0PWiR75Gy7KXrnQsaYDkPpsvvqGBNulGOz3Q=;
        b=fRwjFQO1P1Wm0RMsCY9rwYkWWlAEywwpOjTSDUzWwL8RT/nEstn0Esqp/ym8OdUuEe
         kqmsTYRf0cVLcX52i854irPn/v9taI5PZeATW8AgSMoX4a9CkKD+akRYpwuJKqdIzoS5
         bEp0I4OJoP5wlMOIExqfsg+EmKkNAjo4h2FhBq+Kywvr4oSPuG9nY95POZD4emkJxsOx
         DpP74Vow2OVYIGYRR/pzET5K5xz3Y/GvZo/1bvxA/+R8q3/KdyrP1OkocGMQjaG0Jm81
         0NS57UpCieaALAkw2Aa5iOsNklGNRH0s3WoW5GX1hpg9K+4wtpeP9v4Iq2s111uapt4R
         I0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLsrfQt0PWiR75Gy7KXrnQsaYDkPpsvvqGBNulGOz3Q=;
        b=mzfAcLJ/xJq6LWaNyhUCQ1H9hvaGmhl6HWwq5NpF+izwbbEbklub2BCZe/jlnaMqQ4
         PWDjDn92XTzoZ0Usexzh/RvcKO317NgT7r9T8/HpCoYf/cH33cDkHef5DS1AFb9VNDXh
         ZnL0i4slELmhIlXxGIWyW0n2NM8quWCgkDU4XBN2yHkLfzfXOdeWF37whZeVrFVAKlmS
         2YSrFeFliR83g+L/OJdBrDHIZdko9Yqs/pRbj/nDuk3QcJ940l5L0q39mTXTdajrvCto
         9Ma6kLdokKD2oySdaBldNvM+g5DEYyojj91jRmDTlggqLukcyS3wrgt2nWpqOUHYFJnn
         BO7A==
X-Gm-Message-State: AOAM533sYsEtSjHbtZt5ACl8KzIKLL24IHvsvqGCRZJqTc1AjKVVhZMw
        n+K5b7PQDxztmAgvQUuPDq6T92BQ6vlv+eKIVp4WIw==
X-Google-Smtp-Source: ABdhPJyfyATp9CDrIi79MmawF1G20H+EhieEveu/Q690s9ZCO57AWiJvd6NmgwBNFhjF+ghbS6RECElChR3TQ8nlPLE=
X-Received: by 2002:a37:a643:: with SMTP id p64mr15409808qke.276.1616815208716;
 Fri, 26 Mar 2021 20:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org> <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
In-Reply-To: <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 26 Mar 2021 20:19:57 -0700
Message-ID: <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com>
Subject: Re: [PATCH resend 2/8] sched: core scheduling tagging infrastructure
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
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Mar 26, 2021 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 24, 2021 at 05:40:14PM -0400, Joel Fernandes (Google) wrote:
> > From: Josh Don <joshdon@google.com>
> >
> > A single unsigned long is insufficient as a cookie value for core
> > scheduling. We will minimally have cookie values for a per-task and a
> > per-group interface, which must be combined into an overall cookie.
> >
> > This patch adds the infrastructure necessary for setting task and group
> > cookie. Namely, it reworks the core_cookie into a struct, and provides
> > interfaces for setting task and group cookie, as well as other
> > operations (i.e. compare()). Subsequent patches will use these hooks to
> > provide an API for setting these cookies.
> >
>
> *urgh*... so I specifically wanted the task interface first to avoid /
> get-rid of all this madness. And then you keep it :-(

Sorry, I misunderstood the ask here :/ I had separated out the cgroup
interface parts of the patch, leaving (mostly) the parts which
introduced a compound cookie structure. I see now that you just wanted
the plain task interface to start, with no notion of group cookie.

> I've spend the past few hours rewriting patches #2 and #3, and adapting
> #4. The thing was working before I added SHARE_FROM back and introduced
> GET, but now I'm seeing a few FAILs from the selftest.
>
> I'm too tired to make sense of anything much, or even focus my eyes
> consistently, so I'll have to prod at it some more next week, but I've
> pushed out the lot to my queue.git:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core-sched

Thanks, I'll take a look next week.

> Also, we really need a better name than coretag.c.

Yea, we don't really otherwise use the phrase "tagging". core_sched.c
is probably too confusing given we have sched/core.c.
