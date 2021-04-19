Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E80364B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhDSUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231294AbhDSUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618863838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMK5LdGW1tcHxkX+kXlO6KoaSLfAhc06ukgjVccttxE=;
        b=VJceume/Gn75PSi39Z4vr3KIOCU/KEjx0I+tbzjyGnhCyQnMEK1QBMqOJjG1rkh3kna1v1
        S4Ulcnr/tgvWD02IQyTsnS6gGQ9VBkWgB6NOl9FlXtv1Um/XFURTqw7LKYVvGqH7GnjEVk
        XJB3SnYcZxKntc2GXRBwec+XWeCQMog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-QRMdvGKMNbqdW7a-UmQKQw-1; Mon, 19 Apr 2021 16:23:53 -0400
X-MC-Unique: QRMdvGKMNbqdW7a-UmQKQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86535801814;
        Mon, 19 Apr 2021 20:23:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C0DC5C1CF;
        Mon, 19 Apr 2021 20:23:50 +0000 (UTC)
Date:   Mon, 19 Apr 2021 16:23:48 -0400
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
Message-ID: <YH3m1AGCoQoUo0kr@lorien.usersys.redhat.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-3-valentin.schneider@arm.com>
 <a5abd06c61e4152b483043f8b180ba041f0464d1.camel@surriel.com>
 <87tuo6lg39.mognet@arm.com>
 <YH1+zpzUdJeTk0Z3@lorien.usersys.redhat.com>
 <878s5ekxc4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s5ekxc4.mognet@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 06:17:47PM +0100 Valentin Schneider wrote:
> On 19/04/21 08:59, Phil Auld wrote:
> > On Fri, Apr 16, 2021 at 10:43:38AM +0100 Valentin Schneider wrote:
> >> On 15/04/21 16:39, Rik van Riel wrote:
> >> > On Thu, 2021-04-15 at 18:58 +0100, Valentin Schneider wrote:
> >> >> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p,
> >> >> struct lb_env *env)
> >> >>      if (tsk_cache_hot == -1)
> >> >>              tsk_cache_hot = task_hot(p, env);
> >> >>
> >> >> +	/*
> >> >> +	 * On a (sane) asymmetric CPU capacity system, the increase in
> >> >> compute
> >> >> +	 * capacity should offset any potential performance hit caused
> >> >> by a
> >> >> +	 * migration.
> >> >> +	 */
> >> >> +	if ((env->dst_grp_type == group_has_spare) &&
> >> >> +	    !migrate_degrades_capacity(p, env))
> >> >> +		tsk_cache_hot = 0;
> >> >
> >> > ... I'm starting to wonder if we should not rename the
> >> > tsk_cache_hot variable to something else to make this
> >> > code more readable. Probably in another patch :)
> >> >
> >>
> >> I'd tend to agree, but naming is hard. "migration_harmful" ?
> >
> > I thought Rik meant tsk_cache_hot, for which I'd suggest at least
> > buying a vowel and putting an 'a' in there :)
> >
> 
> That's the one I was eyeing: s/tsk_cache_hot/migration_harmful/ or
> somesuch. Right now we're feeding it:
>

Fair enough, my bad, the migration part immediately drew me to
migrate_degrades_capacity().

> o migrate_degrades_locality()
> o task_hot()
> 
> and I'm adding another one, so that's 2/3 which don't actually care about
> cache hotness, but rather "does doing this migration degrade/improve
> $criterion?"
> 

prefer_no_migrate? 


Cheers,
Phil
-- 

