Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4B3B908D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhGAKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:37:22 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:40135 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235300AbhGAKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:37:21 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 2FA531C3FF5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:34:50 +0100 (IST)
Received: (qmail 25466 invoked from network); 1 Jul 2021 10:34:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Jul 2021 10:34:49 -0000
Date:   Thu, 1 Jul 2021 11:34:48 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Odin Ugedal <odin@uged.al>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
Message-ID: <20210701103448.GL3840@techsingularity.net>
References: <20210624111815.57937-1-odin@uged.al>
 <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 03:17:16PM +0530, Sachin Sant wrote:
> 
> 
> > On 24-Jun-2021, at 4:48 PM, Odin Ugedal <odin@uged.al> wrote:
> > 
> > The _sum and _avg values are in general sync together with the PELT
> > divider. They are however not always completely in perfect sync,
> > resulting in situations where _sum gets to zero while _avg stays
> > positive. Such situations are undesirable.
> > 
> > This comes from the fact that PELT will increase period_contrib, also
> > increasing the PELT divider, without updating _sum and _avg values to
> > stay in perfect sync where (_sum == _avg * divider). However, such PELT
> > change will never lower _sum, making it impossible to end up in a
> > situation where _sum is zero and _avg is not.
> > 
> > Therefore, we need to ensure that when subtracting load outside PELT,
> > that when _sum is zero, _avg is also set to zero. This occurs when
> > (_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
> > or equal to the current _sum, while the subtracted _avg is smaller than
> > the current _avg.
> > 
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Odin Ugedal <odin@uged.al>
> 
> Hello Odin, Vincent,
> 
> The issue of kernel warning(during boot) seen on Power sever, reported few days back is not completely fixed.
> I am able to recreate this issue with latest 5.13 kernel(which has this fix)
> 
> # git log --oneline kernel/sched/fair.c
> a6eaf3850cb1 Merge tag 'sched-urgent-2021-06-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 54a728dc5e4f Merge tag 'sched-core-2021-06-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 1c35b07e6d39 sched/fair: Ensure _sum and _avg values stay consistent  <<==
> 

What was HEAD when you checked this? 1c35b07e6d39 was merged in the
5.14-rc1 merge window so would not be in 5.13.

# git log v5.13..origin/master --pretty=one | grep 1c35b07e
1c35b07e6d3986474e5635be566e7bc79d97c64d sched/fair: Ensure _sum and _avg values stay consistent

It's not tagged for stable and lacks a Fixes: tag so I don't think
it'll be automatically picked up for 5.13-stable unless Odin sends it
to stable@vger.kernel.org.

-- 
Mel Gorman
SUSE Labs
