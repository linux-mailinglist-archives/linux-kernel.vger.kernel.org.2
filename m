Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6640D61D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhIPJ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbhIPJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:26:05 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3739C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:24:45 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x141so5567110oix.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJJaNclf3wzSnd6KFncvUtNJPgnZ1G90tgAnEdwOG7Q=;
        b=SbSTnF6YB4bss2Kwu3Ep7iIEb7Q6CmnnRp4hjIFt/9Pbhj0Q711D/tuvfqU5zB2Kjc
         AjQSqIobj2DUtSFPEaZpc0U/vym4bSYEkapUidoU/gnKfC0w4vjWy521Fpw8HdYST4D3
         IQEYySJdphMWR8Qt2gOgqw395pigN34xQhmSc8LV2lP/9U7QLfqfE8GvbVcvZTd7JrBC
         7LrcCviFVgp0ib51iXroH0631blxOqX8+UwkNtj+2SLuWsDo0c5Ogh++or4k/ig36Oz+
         WKGkSIqvhC6lRVAvZQsC4fXhokL4iWJEsKMYmBKlDDbyyeoMnBIbigJwQLE3zxDBKCf8
         JZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJJaNclf3wzSnd6KFncvUtNJPgnZ1G90tgAnEdwOG7Q=;
        b=sVZovaJASCXKCB1dli0eRR11u+7VzUhFUCRc6OExc4Nn6WxZeLkADN1iJGJl86WxPM
         dDnq0IPwsr3NsZ4oTriZeisiWFmjJh5FLW8B8svjGg95jVcSRBsW2abozGr/Yovv09+J
         7HELn9joZ7uxJGmPULdSHgxjH9chANjet+DJs/qpldw1jNuFLjtVY9F5Bvwz2BNWbAkL
         mKBzk/WX2b7g5861qDfVRrfvh/k6FgxUJzSSiBPUeN5cRUjGCEx+UXdL/rxewqH6g7yc
         iW30XCvltuR6To1KUyOlAH6IT9b2CS2nKwdkj0KHc2+yWM7C7FdKxQ4rLvUDlmft1f9F
         zTaw==
X-Gm-Message-State: AOAM532cHAoVvsKnKQ8J0/iNvClcJdWWkC9ygcQNagLFnvBlZUELsS7V
        vsEOQMZqpC0/Iw5MBwPy3QbqykE7dMCGUHQIRPzCuvU+paEyNg==
X-Google-Smtp-Source: ABdhPJxi7CXHXatKk6Ent0JGeDYXpkYxaElSOp3Gne6NRfOXLMwCR+A/DisuphBRfpRFcm02SiUwwPboPjwflF/uMLw=
X-Received: by 2002:aca:f189:: with SMTP id p131mr8669427oih.128.1631784285005;
 Thu, 16 Sep 2021 02:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eaacf005ca975d1a@google.com> <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
 <87mtoeb4hb.ffs@tglx> <CACT4Y+avKp8LCS8vBdaFLXFNcNiCq3vF-8K59o7c1oy86v-ADA@mail.gmail.com>
 <87k0jib2wd.ffs@tglx>
In-Reply-To: <87k0jib2wd.ffs@tglx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 11:24:33 +0200
Message-ID: <CACT4Y+ZCRiwobf0rGUoMiUEi=6Eoxvvgxxv-c+AhH=7U6M3LXQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 11:32, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Sep 15 2021 at 11:14, Dmitry Vyukov wrote:
> > On Wed, 15 Sept 2021 at 10:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> That made me actually look at that mac80211_hwsim callback again.
> >>
> >>         hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
> >>                         ns_to_ktime(bcn_int * NSEC_PER_USEC));
> >>
> >> So what this does is really wrong because it tries to schedule the timer
> >> on the theoretical periodic timeline. Which goes really south once the
> >> timer is late or the callback execution took longer than the
> >> period. Hypervisors scheduling out a VCPU at the wrong place will do
> >> that for you nicely.
> >
> > Nice!
> >
> > You mentioned that hrtimer_run_queues() may not return. Does it mean
> > that it can just loop executing the same re-armed callback again and
> > again? Maybe then the debug check condition should be that
> > hrtimer_run_queues() runs the same callback more than N times w/o
> > returning?
>
> Something like that.

I've filed https://bugzilla.kernel.org/show_bug.cgi?id=214429 so that
it's not lost. Thanks.
