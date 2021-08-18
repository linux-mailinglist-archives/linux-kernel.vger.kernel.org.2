Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26D63F0814
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhHRPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:32:33 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:55411 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhHRPcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:32:32 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 277BDCAD20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:31:57 +0100 (IST)
Received: (qmail 5934 invoked from network); 18 Aug 2021 15:31:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Aug 2021 15:31:56 -0000
Date:   Wed, 18 Aug 2021 16:31:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
Message-ID: <20210818153155.GL6464@techsingularity.net>
References: <20210802024945.GA8372@xsang-OptiPlex-9020>
 <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
 <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:14:14AM -0700, Linus Torvalds wrote:
> On Mon, Aug 2, 2021 at 10:06 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Sandeep, does something like the attached patch (written to be on top
> > of the existing one) work for you?
> 
> .. and by "attached patch" I obviously meant the patch that wasn't attached.
> 
> It's here.
> 

Hi Linus,

Our own test systems also detected the regression and automatically
bisected to 3a34b13a88 but it is not universal. For example, it's not
visible on a single socket 8-cpu skylake machine but it gets progressively
worse the more CPUs there are and potentially the more LLCs there are. I
say LLCs because the number of interrupts generated was significantly
higher which *might* be more IPIs being sent to tasks running on CPUs
that do not share target with the waker.

Your "attached" patch alleviates the problem. The worse results were on
a Zen3 machine (256 CPUs, lots of last level caches).

hackbench-process-pipes
                          5.14.0-rc3             5.14.0-rc3             5.14.0-rc3
                             vanilla        alwayswake-v1r1       specialcase-v1r1
Amean     1        0.3800 (   0.00%)      0.4520 * -18.95%*      0.3580 (   5.79%)
Amean     4        0.5107 (   0.00%)      0.6660 * -30.42%*      0.5080 (   0.52%)
Amean     7        0.5717 (   0.00%)      0.6387 * -11.72%*      0.5310 *   7.11%*
Amean     12       0.5853 (   0.00%)      0.8563 * -46.30%*      0.5457 (   6.78%)
Amean     21       0.7693 (   0.00%)      1.3150 * -70.93%*      0.7297 (   5.16%)
Amean     30       0.9667 (   0.00%)      1.8530 * -91.69%*      0.8547 (  11.59%)
Amean     48       1.3100 (   0.00%)      2.5027 * -91.04%*      1.3143 (  -0.33%)
Amean     79       2.0633 (   0.00%)      3.4983 * -69.55%*      2.1180 (  -2.65%)
Amean     110      2.8080 (   0.00%)      3.9927 * -42.19%*      2.7850 (   0.82%)
Amean     141      3.6237 (   0.00%)      4.6810 * -29.18%*      3.6663 (  -1.18%)
Amean     172      4.6480 (   0.00%)      5.6707 * -22.00%*      4.8003 (  -3.28%)
Amean     203      5.2630 (   0.00%)      6.5000 * -23.50%*      5.6100 (  -6.59%)
Amean     234      6.3290 (   0.00%)      7.1473 * -12.93%*      6.1570 (   2.72%)
Amean     265      7.0907 (   0.00%)      7.9200 * -11.70%*      7.1417 (  -0.72%)
Amean     296      7.7550 (   0.00%)      8.2590 *  -6.50%*      7.8167 (  -0.80%)

alwayswake-v1r1 is commit 3a34b13a88 cherry-picked on top of 5.14-rc3.
specialcase-v1r1 is your suggested patch on top.

The * mark results that are likely statistically significant so with
your suggested patch, most of the results are mostly in the noise.

While this is Zen3, the same problem exists on at least 2-socket
cascadelake, 2-socket skylake and 2-socket broadwell systems although
not to the same degree (different CPU counts and topology).

I know hackbench is not particularly interesting but it's used often
enough when comparing kernels and patches that commit 3a34b13a88 will be
a regression magnet.

-- 
Mel Gorman
SUSE Labs
