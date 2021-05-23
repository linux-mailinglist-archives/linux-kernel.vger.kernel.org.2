Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55438DCD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhEWUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhEWUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 16:32:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F255C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 13:30:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id h20so9670333qko.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KZOdzKpdCtx3J5Gdt5i125p00DG3gg5/FCu81JRadSM=;
        b=ZpkzlRp9fR8BmOo7PQQYa0rtdoJxcSKqQZ6aY+UTojxFQ2hkUCXe3DhTKZOAGgF6wl
         PZcrArPr1WA/kpgkk5VMtVIGcHQD4AhSUW4FwDm+r2ZdyYwQaldksO1ylsZ6cG6nLb0E
         OQ4Jxv720k2K2hsjKehnPw6BOmfCzl8/9uqsFWAMcaV2QPsEc2CTvzG7ESoONZF7DYEA
         u4toE725mdKSzhwnd5NZtI7HJ1mqNiujILSiUe+9uSEN81LQ6ZcPJy2bJ+IUgmt/4oKk
         ktJWp9bMmsXSW2G5ZK1iKj+zoVnCnALFUCvMpp1/Xl1/EC5jFdoDrr357TvlB4qXynu9
         Neow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KZOdzKpdCtx3J5Gdt5i125p00DG3gg5/FCu81JRadSM=;
        b=DZ7/ZyqZ5DJx0bjo3qwd+8fM63Lu/rIjbDHcpgpCDiC47expydYo5WHFjhu1glXdFB
         uNNoNMy0hoj+qJllZJjRfXl2GDy+CUjlpdd2441tJOrTcjYlDNoHazkQLI5V8MndPJ8D
         K+6hsbZd8b2mNahzBOuq5Pl6LMPGBC1Wv+Vi1oU965khV7Hh6xUCcLszfVeVCYhb3gXE
         3Sod2cJcfhn0VhUZ7fjGEnB5qL1zHd+SsvNv9+hT3QnAMAF64m7JE5FDwKfRhg5spj9V
         PjvEEiRV5pN3SAkSTbeb9zHCuKPruCmQ4cZWCFMIWyirtdXLDyGY4JTTjh83buNlfIuv
         Yksg==
X-Gm-Message-State: AOAM533fV0Doehpd8mkpGB+YD4LmLEeq0vuwknUP6MrdWQlAbUUz2fzM
        bZEzRAH07kM1++0gBnNC7N0vXg==
X-Google-Smtp-Source: ABdhPJy8dX5Bcn1EEtnagXs/TxB+Mq7MohucQW4+wTbkV3a0W9CV8bHRrAGTneqdz22FTFP4/F8EKw==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr24592539qke.64.1621801834776;
        Sun, 23 May 2021 13:30:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 42sm8779883qtf.37.2021.05.23.13.30.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 23 May 2021 13:30:34 -0700 (PDT)
Date:   Sun, 23 May 2021 13:30:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hugh Dickins <hughd@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: config SCHED_CORE
In-Reply-To: <YKo1AOIIsZectSQt@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.11.2105231252070.29171@eggly.anvils>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils> <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net> <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com> <YKo1AOIIsZectSQt@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021, Peter Zijlstra wrote:
> On Fri, May 21, 2021 at 07:57:35AM -0400, Joel Fernandes wrote:
> > On Fri, May 21, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > +       help
> > > +         This option enables Core scheduling, a means of coordinated task
> > > +         selection across SMT siblings with the express purpose of creating a
> > > +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> > > +         -- task selection will ensure all SMT siblings will execute a task
> > > +         from the same 'core group', forcing idle when no matching task is found.
> > > +
> > > +         This provides means of mitigation against a number of SMT side-channels;
> > > +         but is, on its own, insufficient to mitigate all known side-channels.
> > > +         Notable: the MDS class of attacks require more.
> > > +
> > > +         Default enabled for anything that has SCHED_SMT, when unused there should
> > > +         be no impact on performance.
> > 
> > This description sort of makes it sound like security is the only
> > usecase. Perhaps we can also add here that core-scheduling can help
> > performance of workloads where hyperthreading is undesired, such as
> > when VM providers don't want to share hyperthreads.
> 
> Something like so then?

Much more helpful, thanks. And I agree that you have to keep it fairly
brief here: I think you've struck the right balance.  Some nits below.

> 
> ---
>  kernel/Kconfig.preempt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index ea1e3331c0ba..cd497fecfd43 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,18 @@ config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y
>  	depends on SCHED_SMT
> +	help
> +	  This option enables Core scheduling, a means of coordinated task

Maybe s/scheduling/Scheduling/ to match the title?

I think I got the picture once I reached the end, but was confused here
by the stages of enablement.  s/This option enables/This option permits/
would be clearer, I think.


> +	  selection across SMT siblings. When enabled -- see
> +	  prctl(PR_SCHED_CORE) -- task selection will ensure all SMT siblings

s/will ensure/ensures that/ (it felt like too many "will"s before)

> +	  will execute a task from the same 'core group', forcing idle when no
> +	  matching task is found.
> +
> +	  Use of this feature includes:
> +	   - mitigation of some (not all) SMT side channels;
> +	   - limiting SMT interference to improve determinism and/or performance.
> +
> +	  Default enabled for anything that has SCHED_SMT, when unused there

"SCHED_CORE is default enabled when SCHED_SMT is enabled - when unused there"
would be better.

> +	  should be no impact on performance.
> +

Thanks,
Hugh
