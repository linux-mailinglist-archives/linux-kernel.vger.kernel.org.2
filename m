Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578D6386CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbhEQWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhEQWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:35:35 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:34:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h6so7427792ila.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2lzbJ9P0FQNQBZFPVMQl9SZq7x6A1s/nJAuCabOCsU=;
        b=rdAy7sHelIGAQNJSXi1vPzxtgj0qcgBVuFEdOpeBRW3COvVEtyCJkPnPbmijB0t1lc
         pXugKxpTOcKlxSPoEvV9aPTrt/p4xNAfc9L/lWTz2PM9hf4Ax5nEJ0F1eQ6KSDWAxmjT
         fV/IQX94um/nQPHCLxIFIPKqADwP2KPHvKEDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2lzbJ9P0FQNQBZFPVMQl9SZq7x6A1s/nJAuCabOCsU=;
        b=Q/AdyDq0dlb3KXG4oWL6r/GMXTGAC+vIrUXcF2Q1A1ZlWV9IDPWEVbq/RQaGntgptL
         6YDc/8ZVt/1rB83VrrjXhsRs4Fatd0CpeE++rKiWs2GVe1DZh2bW1N68VBlNW5fEIRq0
         /yx3o8rJ59v+tSRrKRUpiY0Wp9wBnrVSgccEOcmfbvYMN+1a5tjkc6HqZtGDzT/d3YdG
         JgR8jx7wiP+JZffRcINj+VYevKCLKAzu09HWHT/FVeuD5L8pzAWHjAEWtMl71wgPbfhj
         Ws6nCunVLWx8KMX0ovsdQHO126togRbCXdw5oxxN01VBvox9HQcpmwvm4sxq80eMp2se
         mGkA==
X-Gm-Message-State: AOAM533BTvL42GKJsuujw/u7GbicXMCg2B2w0Qq+c/2AVPtXCqR7Zoq9
        xAK3nwAdpblNcSuFfbQnvVTjujzv9xG5F9fFeLJKTQ==
X-Google-Smtp-Source: ABdhPJxCIunoGYXAcGkSuPiURYshQSAt002TNFG5lo5aEb/fiPKLaUWheY886i+plIVa2c5g2n7nYxbZl123Gq45Ee0=
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr1621917ilu.13.1621290857830;
 Mon, 17 May 2021 15:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com> <YKLuJHcqea/zU1H1@google.com>
In-Reply-To: <YKLuJHcqea/zU1H1@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 17 May 2021 18:34:07 -0400
Message-ID: <CAEXW_YQZiV6tQC-UNoRujWDes-zF91BC1GvxBYoEKfPABZEYhA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load balance
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 6:28 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, May 13, 2021 at 08:49:08AM -0700, Ricardo Neri wrote:
> > When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
> > check for the idle state of the destination CPU, dst_cpu, but also of
> > its SMT siblings.
> >
[...]
> > +     if (!local_is_smt) {
> > +             /*
> > +              * If we are here, @dst_cpu is idle and does not have SMT
> > +              * siblings. Pull tasks if candidate group has two or more
> > +              * busy CPUs.
> > +              */
> > +             if (sg_is_smt && sg_busy_cpus >= 2)
> > +                     return true;
> > +
> > +             /*
> > +              * @dst_cpu does not have SMT siblings. @sg may have SMT
> > +              * siblings and only one is busy. In such case, @dst_cpu
> > +              * can help if it has higher priority and is idle.
> > +              */
> > +             return !sds->local_stat.group_util &&
> > +                    sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > +     }
> > +
> > +     /* @dst_cpu has SMT siblings. */
> > +
> > +     local_busy_cpus = sds->local->group_weight - sds->local_stat.idle_cpus;
> > +
> > +     if (sg_is_smt) {
> > +             int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> > +
> > +             /* Local can always help to even the number busy CPUs. */
> > +             if (busy_cpus_delta >= 2)
> > +                     return true;
> > +
> > +             if (busy_cpus_delta == 1)
> > +                     return sched_asym_prefer(dst_cpu,
> > +                                              sg->asym_prefer_cpu);
> > +
> > +             return false;
> > +     }
> > +
> > +     /*
> > +      * @sg does not have SMT siblings. Ensure that @sds::local does not end
> > +      * up with more than one busy SMT sibling and only pull tasks if there
> > +      * are not busy CPUs. As CPUs move in and out of idle state frequently,
> > +      * also check the group utilization to smoother the decision.
>
> nit: s/smoother/smoothen/
>
> > +      */
> > +     if (!local_busy_cpus && !sds->local_stat.group_util)
> > +             return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
>
> Hmm, I am not sure but is it possible that there some local_busy_cpus yet
> group_util is 0? If not just check for !group_util ?

Sorry - I meant here, "yet group_util is not 0..."
