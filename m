Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BB3EDD81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhHPTDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:03:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:02:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z5so34842109ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0f9iRcSsCU/k5L+VbuDUsYeEux2WN96aAx3sy3SC9c=;
        b=Dcrdwc1B6HWhDdaf1O5JH+TqzMxb3cMuOuaU9GtFTUDuGgaV3Ji5vmD2mKc2/Sb5DR
         erb+34mjxpF4H1aaNZfvCjRTO+/ssiwYJj/Upf5b+HEEA9OThYCftfBhqPUFIdslsAET
         ZAIdN9AwwTXuyc26EvpFmQCMjwU16Bi+lxpk4MkbsxjwmtXKAcPgi3a4x2aP/IllUr7S
         rM3YdN9A4PNT2YjzPlF5y6GI7+GnG6F1Bovvc9dWG+wHaK8uKGsTmX0dYRA3dNv++Ut3
         dOsUXMkgztU3w2AP0jnGRMswEMJyTmQdekjPlcZIcLTfLpI3+2ELGD9OEXpdO50iux5q
         UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0f9iRcSsCU/k5L+VbuDUsYeEux2WN96aAx3sy3SC9c=;
        b=nE3aA9vXmWKNBj+bTNPPOTx3RO2PzI1e2NfKi6MhqDQ6RQv8TWubOZ+l8yAHQSQY/V
         KX3OhajfTyt1VpJhklcdUjJh+Jmp4mxx/8stIBVdX+JD+4OyfzY9ABCK/tL4ObYEMyQK
         W1FqwV+Tpm/egd/EPKvoYqcq8n7grKLiBeoBMTZgzRjZKe1FDX3oCELVbAOuC3nw2V3L
         Nl0qoxOVKzyk3Qo0tEyW5pNtTVIqOcs9nGn1lHeNH93uSM6kfwQaVddrPMawaKP7Myws
         8hF+MBRzR4WaSVpEQIdiGwEagegsD5Gj1q/UEqL1r/bVkZxpTmPGDJzWVy7uMZCmULPC
         4PDw==
X-Gm-Message-State: AOAM5324pHmzM0+fbeYVQ1+4iMwaA3eZ7fyeX33PhsEHt2NBwcaS/7j0
        eXqXbApA7mr9D6ytuSscjoHibXSSyYgP2AB4iw9wVQ==
X-Google-Smtp-Source: ABdhPJwR09CPvPLzoIX6mxvF1M/yXa/y8ztSGP+JV/qw0FXfUOiKsi5NS1cWdEmZ64/j28oDzNwkhT9TbOTMR09jVM4=
X-Received: by 2002:a25:30c:: with SMTP id 12mr23527035ybd.212.1629140565133;
 Mon, 16 Aug 2021 12:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210816154401.23919-1-tao.zhou@linux.dev> <YRqz93crZIS1Mvmy@hirez.programming.kicks-ass.net>
In-Reply-To: <YRqz93crZIS1Mvmy@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 16 Aug 2021 12:02:34 -0700
Message-ID: <CABk29Nt=a0RPfoVMP=FiKY_ObtU9enYU3cK00RgDUVqJrTmkiQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: An optimization of pick_next_task() not sure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 16, 2021 at 11:44:01PM +0800, Tao Zhou wrote:
> > When find a new candidate max, wipe the stale and start over.
> > Goto again: and use the new max to loop to pick the the task.
> >
> > Here first want to get the max of the core and use this new
> > max to loop once to pick the task on each thread.
> >
> > Not sure this is an optimization and just stop here a little
> > and move on..
> >
>
> Did you find this retry was an issue on your workload? Or was this from
> reading the source?

I would be surprised if this made a noticeable difference on SMT2, but
I could certainly see how this would help with larger SMT
configurations where we have more opportunities to invalidate the
other siblings.
