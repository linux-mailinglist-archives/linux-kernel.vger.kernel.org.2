Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142231D8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBQL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:57:36 -0500
Received: from foss.arm.com ([217.140.110.172]:57126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232183AbhBQLvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:51:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1BB31B;
        Wed, 17 Feb 2021 03:51:06 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736BB3F694;
        Wed, 17 Feb 2021 03:51:04 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 6/7 v3] sched/fair: trigger the update of blocked load on newly idle cpu
In-Reply-To: <CAKfTPtDpTEUdRcgJ3dwvD6Fz3D02E46xNtv9BpfFmkjCV1shyA@mail.gmail.com>
References: <20210212141744.24284-1-vincent.guittot@linaro.org> <20210212141744.24284-7-vincent.guittot@linaro.org> <jhj5z2xt7oy.mognet@arm.com> <CAKfTPtDpTEUdRcgJ3dwvD6Fz3D02E46xNtv9BpfFmkjCV1shyA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 17 Feb 2021 11:51:02 +0000
Message-ID: <jhjmtw2syjd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/21 16:02, Vincent Guittot wrote:
> On Fri, 12 Feb 2021 at 20:19, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> I don't think there is anything inherently wrong with it - the
>> nohz_idle_balance() call resulting from the kick_ilb() IPI will just bail
>> out due to the flags being cleared here. This wasn't immediately clear to
>> me however.
>
> In fact, I forgot to replace the WARN_ON in nohz_csd_func() by a
> simple return as reported by kernel test robot / oliver.sang@intel.com
>

Can't that actually be a problem? kick_ilb() says:

         * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
         * the first flag owns it; cleared by nohz_csd_func().

So if you have:

  kick_ilb() -> kicks CPU42

And then said CPU42 goes through, before nohz_csd_func(),:

  do_idle() -> nohz_run_idle_balance()

you could have yet another CPU do:

  kick_ilb() -> kicks CPU42

which would break rq->nohz_csd serialization.

>>
>> > +}
>> > +
