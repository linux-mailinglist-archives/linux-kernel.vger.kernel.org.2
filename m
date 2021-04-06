Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8439355472
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbhDFNBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:01:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53197 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344274AbhDFNBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:01:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617714063; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=sX/dPEAAoi06drO8Jv2y6lJBxs4XsNAHD4nrwcIcUQw=; b=FqnDVt6Z+sb64knADCAVkPk7rjrCIsz1UR6B11Wc1U28sYYpFMkpgzUNE6JDwlnGcjaJnqqT
 oe4nBgMO4eUAES3ccZmlAhyl/9+DAAaYiCciWdg/7UXNTpocF3MnFnMcmMApfG5ciXyscZiL
 +SenN/+9XlThfr0KLNWvJJGVTXg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 606c5b6dfebcffa80fa13663 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 13:00:29
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D831DC43461; Tue,  6 Apr 2021 13:00:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2867C433ED;
        Tue,  6 Apr 2021 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2867C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 6 Apr 2021 18:30:23 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <20210406130023.GA21941@codeaurora.org>
References: <1617706753-25349-1-git-send-email-pkondeti@codeaurora.org>
 <YGxPwTVvpqYkkIMI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxPwTVvpqYkkIMI@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Apr 06, 2021 at 12:10:41PM +0000, Quentin Perret wrote:
> Hi Pavan,
> 
> On Tuesday 06 Apr 2021 at 16:29:13 (+0530), Pavankumar Kondeti wrote:
> > In Android GKI, CONFIG_FAIR_GROUP_SCHED is enabled [1] to help prioritize
> > important work. Given that CPU shares of root cgroup can't be changed,
> > leaving the tasks inside root cgroup will give them higher share
> > compared to the other tasks inside important cgroups. This is mitigated
> > by moving all tasks inside root cgroup to a different cgroup after
> > Android is booted. However, there are many kernel tasks stuck in the
> > root cgroup after the boot.
> > 
> > We see all kworker threads are in the root cpu cgroup. This is because,
> > tasks with PF_NO_SETAFFINITY flag set are forbidden from cgroup migration.
> > This restriction is in place to avoid kworkers getting moved to a cpuset
> > which conflicts with kworker affinity. Relax this restriction by explicitly
> > checking if the task is moving out of a cpuset cgroup. This allows kworkers
> > to be moved out root cpu cgroup.
> > 
> > We also see kthreadd_task and any kernel thread created after the Android boot
> > also stuck in the root cgroup. The current code prevents kthreadd_task moving
> > out root cgroup to avoid the possibility of creating new RT kernel threads
> > inside a cgroup with no RT runtime allocated. Apply this restriction when tasks
> > are moving out of cpu cgroup under CONFIG_RT_GROUP_SCHED. This allows all
> > kernel threads to be moved out of root cpu cgroup if the kernel does not
> > enable RT group scheduling.
> 
> OK, so IIUC this only works with cgroup v1 -- the unified hierarchy in
> v2 forces you to keep cpu and cpuset in 'sync'. But that should be fine,
> so this looks like a nice improvement to me.
> 
Yes. I will mention this in commit description.

> >  
> >  struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> > -					     bool *locked)
> > +					     bool *locked,
> > +					     struct cgroup *dst_cgrp)
> >  	__acquires(&cgroup_threadgroup_rwsem)
> >  {
> >  	struct task_struct *tsk;
> > @@ -2784,15 +2785,28 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> >  		tsk = tsk->group_leader;
> >  
> >  	/*
> > +	 * RT kthreads may be born in a cgroup with no rt_runtime allocated.
> > +	 * Just say no.
> > +	 */
> > +#ifdef CONFIG_RT_GROUP_SCHED
> > +	if (tsk->no_cgroup_migration && (dst_cgrp->root->subsys_mask & (1U << cpu_cgrp_id))) {
> > +		tsk = ERR_PTR(-EINVAL);
> > +		goto out_unlock_threadgroup;
> > +	}
> > +#endif
> > +
> > +	/*
> >  	 * kthreads may acquire PF_NO_SETAFFINITY during initialization.
> >  	 * If userland migrates such a kthread to a non-root cgroup, it can
> > -	 * become trapped in a cpuset, or RT kthread may be born in a
> > -	 * cgroup with no rt_runtime allocated.  Just say no.
> > +	 * become trapped in a cpuset. Just say no.
> >  	 */
> > -	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
> > +#ifdef CONFIG_CPUSETS
> > +	if ((tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) &&
> > +			(dst_cgrp->root->subsys_mask & (1U << cpuset_cgrp_id))) {
> >  		tsk = ERR_PTR(-EINVAL);
> >  		goto out_unlock_threadgroup;
> >  	}
> > +#endif
> 
> Nit: maybe move this #ifdefery out to a header?
> 
Agreed.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

