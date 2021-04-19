Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3E364225
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhDSNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233225AbhDSNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618837207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95Hzbf8uMd7pYDHNFE/rwOVcsd+fNEKytR41sNl7E+w=;
        b=ZYasIruZxbLdJMzVKZwcceeov7mFds5012EMr7OvFMZhXMlvQdUUe87YJ5maCV8OgrQveQ
        UZDS3opcEIHSZpLdm+gouVjZp3139HCLJJRWODO1L3cHSGLpzcCegKvNsgb9yp+zweksz0
        +nIRo+Wl6C83MaD04jOnEduoWYdcQII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Qk-DAkusNIeAtndZWjna1w-1; Mon, 19 Apr 2021 09:00:02 -0400
X-MC-Unique: Qk-DAkusNIeAtndZWjna1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D798C4580;
        Mon, 19 Apr 2021 13:00:00 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0A2E10190AA;
        Mon, 19 Apr 2021 12:59:59 +0000 (UTC)
Date:   Mon, 19 Apr 2021 08:59:58 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
Message-ID: <YH1+zpzUdJeTk0Z3@lorien.usersys.redhat.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-3-valentin.schneider@arm.com>
 <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com>
 <87tuo6lg39.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuo6lg39.mognet@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:43:38AM +0100 Valentin Schneider wrote:
> On 15/04/21 16:39, Rik van Riel wrote:
> > On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
> >> Consider the following topology:
> >>
> >> Long story short, preempted misfit tasks are affected by task_hot(),
> >> while
> >> currently running misfit tasks are intentionally preempted by the
> >> stopper
> >> task to migrate them over to a higher-capacity CPU.
> >>
> >> Align detach_tasks() with the active-balance logic and let it pick a
> >> cache-hot misfit task when the destination CPU can provide a capacity
> >> uplift.
> >>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >
> > Reviewed-by: Rik van Riel <riel@surriel.com>
> >
> 
> Thanks!
> 
> >
> > This patch looks good, but...
> >
> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p,
> >> struct lb_env *env)
> >>      if (tsk_cache_hot == -1)
> >>              tsk_cache_hot = task_hot(p, env);
> >>
> >> +	/*
> >> +	 * On a (sane) asymmetric CPU capacity system, the increase in
> >> compute
> >> +	 * capacity should offset any potential performance hit caused
> >> by a
> >> +	 * migration.
> >> +	 */
> >> +	if ((env->dst_grp_type == group_has_spare) &&
> >> +	    !migrate_degrades_capacity(p, env))
> >> +		tsk_cache_hot = 0;
> >
> > ... I'm starting to wonder if we should not rename the
> > tsk_cache_hot variable to something else to make this
> > code more readable. Probably in another patch :)
> >
> 
> I'd tend to agree, but naming is hard. "migration_harmful" ?

I thought Rik meant tsk_cache_hot, for which I'd suggest at least
buying a vowel and putting an 'a' in there :) 


Cheers,
Phil

> 
> > --
> > All Rights Reversed.
> 

-- 

