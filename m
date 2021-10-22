Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851F44375DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhJVLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:07:56 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:37867 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhJVLHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:07:55 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 605831C480F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:05:36 +0100 (IST)
Received: (qmail 15570 invoked from network); 22 Oct 2021 11:05:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 11:05:36 -0000
Date:   Fri, 22 Oct 2021 12:05:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <20211022110534.GJ3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
 <20211021145603.5313-2-mgorman@techsingularity.net>
 <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:26:08PM +0200, Mike Galbraith wrote:
> On Thu, 2021-10-21 at 15:56 +0100, Mel Gorman wrote:
> > 
> > From additional tests on various servers, the impact is machine dependant
> > but generally this patch improves the situation.
> > 
> > hackbench-process-pipes
> >                           5.15.0-rc3             5.15.0-rc3
> >                              vanilla  sched-wakeeflips-v1r1
> > Amean     1        0.3667 (   0.00%)      0.3890 (  -6.09%)
> > Amean     4        0.5343 (   0.00%)      0.5217 (   2.37%)
> > Amean     7        0.5300 (   0.00%)      0.5387 (  -1.64%)
> > Amean     12       0.5737 (   0.00%)      0.5443 (   5.11%)
> > Amean     21       0.6727 (   0.00%)      0.6487 (   3.57%)
> > Amean     30       0.8583 (   0.00%)      0.8033 (   6.41%)
> > Amean     48       1.3977 (   0.00%)      1.2400 *  11.28%*
> > Amean     79       1.9790 (   0.00%)      1.8200 *   8.03%*
> > Amean     110      2.8020 (   0.00%)      2.5820 *   7.85%*
> > Amean     141      3.6683 (   0.00%)      3.2203 *  12.21%*
> > Amean     172      4.6687 (   0.00%)      3.8200 *  18.18%*
> > Amean     203      5.2183 (   0.00%)      4.3357 *  16.91%*
> > Amean     234      6.1077 (   0.00%)      4.8047 *  21.33%*
> > Amean     265      7.1313 (   0.00%)      5.1243 *  28.14%*
> > Amean     296      7.7557 (   0.00%)      5.5940 *  27.87%*
> > 
> > While different machines showed different results, in general
> > there were much less CPU migrations of tasks
> 
> Patchlet helped hackbench?  That's.. unexpected (at least by me).
> 

I didn't analyse in depth and other machines do not show as dramatic
a difference but it's likely due to timings of tasks getting wakeup
preempted. On a 2-socket cascadelake machine the difference was -7.4%
to 7.66% depending on group count. The second biggest loss was -0.71%
and more gains than losses. In each case, CPU migrations and system CPU
usage are reduced.

The big difference here is likely because the machine is Zen 3 and has
multiple LLCs per cache so it suffers more if there are imbalances between
LLCs that wouldn't be visible on most Intel machines with 1 LLC per socket.

> > tbench4
> >                            5.15.0-rc3             5.15.0-rc3
> >                               vanilla  sched-wakeeflips-v1r1
> > Hmean     1         824.05 (   0.00%)      802.56 *  -2.61%*
> > Hmean     2        1578.49 (   0.00%)     1645.11 *   4.22%*
> > Hmean     4        2959.08 (   0.00%)     2984.75 *   0.87%*
> > Hmean     8        5080.09 (   0.00%)     5173.35 *   1.84%*
> > Hmean     16       8276.02 (   0.00%)     9327.17 *  12.70%*
> > Hmean     32      15501.61 (   0.00%)    15925.55 *   2.73%*
> > Hmean     64      27313.67 (   0.00%)    24107.81 * -11.74%*
> > Hmean     128     32928.19 (   0.00%)    36261.75 *  10.12%*
> > Hmean     256     35434.73 (   0.00%)    38670.61 *   9.13%*
> > Hmean     512     50098.34 (   0.00%)    53243.75 *   6.28%*
> > Hmean     1024    69503.69 (   0.00%)    67425.26 *  -2.99%*
> > 
> > Bit of a mixed bag but wins more than it loses.
> 
> Hm.  If patchlet repeatably impacts buddy pairs one way or the other,
> it should probably be tossed out the nearest window.
> 

I don't see how buddy pairing would be impacted although there is likely
differences in the degree tasks get preempted due to pulling tasks.

-- 
Mel Gorman
SUSE Labs
