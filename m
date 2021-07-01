Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01BE3B95C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhGASCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:02:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhGASCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:02:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D026D;
        Thu,  1 Jul 2021 10:59:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A8C3F5A1;
        Thu,  1 Jul 2021 10:59:34 -0700 (PDT)
Date:   Thu, 1 Jul 2021 18:59:32 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210701175932.66hiwvuia4drs4yl@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
 <YN2T1qnalRUKNcXt@google.com>
 <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
 <YN24bLOthLd6RIpF@google.com>
 <20210701145750.7mqat4ehja7ikbtc@e107158-lin.cambridge.arm.com>
 <YN3dUhsAHL2M4JbR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN3dUhsAHL2M4JbR@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 15:20, Quentin Perret wrote:
> > > Right or maybe we can just check that uclamp_id == UCLAMP_MAX here and
> > > we should be good to go? That is, what about the below?
> > 
> > Wouldn't it be better to do this from uclamp_idle_reset() then?
> 
> That should work too, but clearing the flag outside of
> uclamp_rq_inc_id() feels a little bit more robust to ordering
> issues.
> 
> Specifically, uclamp_rq_inc() has the following pattern:
> 
> 	for_each_clamp_id(clamp_id)
> 		uclamp_rq_inc_id(rq, p , clamp_id);
> 
> 	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> 		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> 
> So, if we change this to clear the flag from
> uclamp_rq_inc_id()->uclamp_idle_reset() then we'll have issues if
> (for example) for_each_clamp_id()'s order changes in the future.
> IOW, it feels cleaner to not create side effects in uclamp_rq_inc_id()
> that impact the idle flag given that its very own behaviour depends on
> the flag.
> 
> WDYT?

Do the clearing from outside the loop then to keep the pattern consistent?

Anyway, I think there's no clear objective advantage. So I'll trust your
judgement and promise not to complain with your final choice ;-)

Cheers

--
Qais Yousef
