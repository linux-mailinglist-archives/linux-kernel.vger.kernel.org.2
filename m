Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B11310E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBEPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhBEPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:05:22 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC3C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:42:51 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h16so5365207qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l6bMebmyF7buTXvOysPq9zxDkYGESwfJ+0swCeCd7qY=;
        b=SLM0C0UtOrbH5D6Y12E44XNcLTp5In6MXuIIDpnaG6XfEdHOyzT/poNGK0J4014eSk
         hf8G3B9Ibe/inStw2s/Hs8eXX9iyzLaoUFLD5FSmTAzj2WRU+XG+1b7TI8RUech0Uo8E
         LiAZcHUmS4URAHi0S4uH/vFIvgDvjslnOw/Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6bMebmyF7buTXvOysPq9zxDkYGESwfJ+0swCeCd7qY=;
        b=aEHatizZqRWDPn6uJiZ9/iREaLNyjMUKGbMT4lPpBasfncImxSMSfwsXAciot+Vdjy
         VdXE1OG8Ux9eKQ/zGnh1FoepNnhGLpi5Rx310W5jvVXOI34S4IDC2KEeGdM724AS6VpM
         0odQZOxpFF+De16/plsGuukm3i0onu7+hwZKCEbkc+QS45koH6mjiScV59owrHuHan/i
         dnW87EhNBecmgeGeR5ONKl3H/JkDT+XuFKF1UNMlk9ohHDEof45c55d05Q/DeeRkpBm1
         X9tXDGoBm091rhwDGUmIXtC0R5zDULVmeCyOKz0qR0m1ylygweMkQrV4PSX65Jfd0HWX
         MNQQ==
X-Gm-Message-State: AOAM533f/tLgW/7D/0Z1CP0AUZD3Mi0DMy4UpPgZDVIGc4mS2oW/Se/u
        K+KkdrKZtWqhXbz8OqkLbLcqpA==
X-Google-Smtp-Source: ABdhPJzpEMIMdDQrKEN0KuwLjSGPEKvKGCfFKihudOnFN41anZ7SJ/VY75puRM8ZI8fDPNXq37GzfA==
X-Received: by 2002:ac8:554d:: with SMTP id o13mr5106886qtr.55.1612543370667;
        Fri, 05 Feb 2021 08:42:50 -0800 (PST)
Received: from localhost ([2620:15c:6:411:7d0b:8b50:779:2056])
        by smtp.gmail.com with ESMTPSA id q6sm9446577qkd.41.2021.02.05.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:42:49 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:42:49 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
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
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YB11iXuitK96KbCO@google.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <YBrUgxLfjcpjwgo6@hirez.programming.kicks-ass.net>
 <YBv93iXqI8UTw9tD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBv93iXqI8UTw9tD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Feb 04, 2021 at 02:59:58PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 03, 2021 at 05:51:15PM +0100, Peter Zijlstra wrote:
> > 
> > I'm slowly starting to go through this...
> > 
> > On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> > > +static bool sched_core_empty(struct rq *rq)
> > > +{
> > > +	return RB_EMPTY_ROOT(&rq->core_tree);
> > > +}
> > > +
> > > +static struct task_struct *sched_core_first(struct rq *rq)
> > > +{
> > > +	struct task_struct *task;
> > > +
> > > +	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
> > > +	return task;
> > > +}
> > 
> > AFAICT you can do with:
> > 
> > static struct task_struct *sched_core_any(struct rq *rq)
> > {
> > 	return rb_entry(rq->core_tree.rb_node, struct task_struct, code_node);
> > }
> > 
> > > +static void sched_core_flush(int cpu)
> > > +{
> > > +	struct rq *rq = cpu_rq(cpu);
> > > +	struct task_struct *task;
> > > +
> > > +	while (!sched_core_empty(rq)) {
> > > +		task = sched_core_first(rq);
> > > +		rb_erase(&task->core_node, &rq->core_tree);
> > > +		RB_CLEAR_NODE(&task->core_node);
> > > +	}
> > > +	rq->core->core_task_seq++;
> > > +}
> > 
> > However,
> > 
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct rq *rq = cpu_rq(cpu);
> > > +
> > > +		WARN_ON_ONCE(enabled == rq->core_enabled);
> > > +
> > > +		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
> > > +			/*
> > > +			 * All active and migrating tasks will have already
> > > +			 * been removed from core queue when we clear the
> > > +			 * cgroup tags. However, dying tasks could still be
> > > +			 * left in core queue. Flush them here.
> > > +			 */
> > > +			if (!enabled)
> > > +				sched_core_flush(cpu);
> > > +
> > > +			rq->core_enabled = enabled;
> > > +		}
> > > +	}
> > 
> > I'm not sure I understand. Is the problem that we're still schedulable
> > during do_exit() after cgroup_exit() ?

Yes, exactly. Tim had written this code in the original patches and it
carried (I was not involved at that time). IIRC, the issue is the exit will
race with core scheduling being disabled. Even after core sched is disabled,
it will still exist in the core rb tree and needs to be removed. Otherwise it
causes crashes.

> It could be argued that when we
> > leave the cgroup there, we should definitely leave the tag group too.
> 
> That is, did you forget to implement cpu_cgroup_exit()?

Yes, I think it is better to implement it in cpu_cgroup_exit().

thanks,

 - Joel

