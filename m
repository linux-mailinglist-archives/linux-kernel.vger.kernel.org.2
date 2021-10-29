Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AD43F915
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhJ2Ioz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:44:55 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:57087 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232504AbhJ2Iou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:44:50 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 1F46717FB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:42:21 +0100 (IST)
Received: (qmail 7036 invoked from network); 29 Oct 2021 08:42:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Oct 2021 08:42:20 -0000
Date:   Fri, 29 Oct 2021 09:42:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <20211029084219.GV3959@techsingularity.net>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
 <20211028094834.1312-2-mgorman@techsingularity.net>
 <YXrNfHcfhp2LutiL@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YXrNfHcfhp2LutiL@geo.homenetwork>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 12:19:48AM +0800, Tao Zhou wrote:
> Hi Mel,
> 
> On Thu, Oct 28, 2021 at 10:48:33AM +0100, Mel Gorman wrote:
> 
> > @@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct *p)
> >  	}
> >  
> >  	if (current->last_wakee != p) {
> > +		int min = __this_cpu_read(sd_llc_size) << 1;
> > +		/*
> > +		 * Couple the wakee flips to the waker for the case where it
> > +		 * doesn't accrue flips, taking care to not push the wakee
> > +		 * high enough that the wake_wide() heuristic fails.
> > +		 */
> > +		if (current->wakee_flips > p->wakee_flips * min)
> > +			p->wakee_flips++;
> >  		current->last_wakee = p;
> >  		current->wakee_flips++;
> >  	}
> > @@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
> >  
> >  	if (master < slave)
> >  		swap(master, slave);
> > -	if (slave < factor || master < slave * factor)
> > +	if ((slave < factor && master < (factor>>1)*factor) || master < slave * factor)
> 
> So, the check like this include the above range:
> 
>   if ((slave < factor && master < slave * factor) ||
>        master < slave * factor)
> 
> That "factor>>1" filter some.
> 
> If "slave < factor" is true and "master < (factor>>1)*factor" is false,
> then we check "master < slave * factor".(This is one path added by the
> check "&&  master < (factor>>1)*factor").
> In the latter check "slave < factor" must be true, the result of this
> check depend on slave in the range [factor, factor>>1] if there is possibility
> that "master < slave * factor". If slave in [factor>>1, 0], the check of
> "master < slave * factor" is absolutly false and this can be filtered if
> we use a variable to load the result of master < (factor>>1)*factor.
> 
> My random random inputs and continue confusing to move on.
> 

I'm not sure what point you're trying to make.

-- 
Mel Gorman
SUSE Labs
