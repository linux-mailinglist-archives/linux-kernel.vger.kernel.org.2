Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB543C5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhJ0JCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:02:50 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:55453 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237432AbhJ0JCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:02:48 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 591E5FA87F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:00:22 +0100 (IST)
Received: (qmail 18255 invoked from network); 27 Oct 2021 09:00:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Oct 2021 09:00:22 -0000
Date:   Wed, 27 Oct 2021 10:00:20 +0100
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
Message-ID: <20211027090020.GO3959@techsingularity.net>
References: <20211021145603.5313-2-mgorman@techsingularity.net>
 <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
 <20211022110534.GJ3959@techsingularity.net>
 <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
 <20211026081817.GM3959@techsingularity.net>
 <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
 <b53de0da7c863ec4c883a92b2526a0f9132a24cb.camel@gmx.de>
 <20211026115707.GN3959@techsingularity.net>
 <65e20ad92f2580c632f793eafce59140b8b4c827.camel@gmx.de>
 <93033bdc35fb2ddd374700b76324de88639ef5ae.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93033bdc35fb2ddd374700b76324de88639ef5ae.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:09:12AM +0200, Mike Galbraith wrote:
> On Tue, 2021-10-26 at 14:13 +0200, Mike Galbraith wrote:
> > On Tue, 2021-10-26 at 12:57 +0100, Mel Gorman wrote:
> > > 
> > > The patch in question was also tested on other workloads on NUMA
> > > machines. For a 2-socket machine (20 cores, HT enabled so 40 CPUs)
> > > running specjbb 2005 with one JVM per NUMA node, the patch also
> > > scaled
> > > reasonably well
> > 
> > That's way more more interesting.  No idea what this thing does under
> > the hood thus whether it should be helped or not, but at least it's a
> > real deal benchmark vs a kernel hacker tool.
> 
> ...
> Installing test specjbb
> specjvm-install: Fetching from mirror
> http://mcp/mmtests-mirror/spec/SPECjbb2005_kitv1.07.tar.gz
> specjvm-install: Fetching from internet
> NOT_AVAILABLE/SPECjbb2005_kitv1.07.tar.gz
> specjvm-install: Fetching from alt internet
> /SPECjbb2005_kitv1.07.tar.gz
> FATAL specjvm-install: specjvm-install: Could not download
> /SPECjbb2005_kitv1.07.tar.gz
> FATAL specjbb-bench: specjbb install script returned error
> FATAL: specjbb returned failure, unable to continue
> FATAL: Installation step failed for specjbb
> 
> Hohum, so much for trying to take a peek.
> 

The benchmark is not available for free unfortunately.

> At any rate, unlike the tbench numbers, these have the look of signal
> rather than test jig noise, and pretty strong signal at that, so maybe
> patchlet should fly. At the very least, it appears to be saying that
> there is significant performance to be had by some means.
> 
> Bah, fly or die little patchlet.  Either way there will be winners and
> losers, that's just the way it works if you're not shaving cycles.
> 

So, I assume you are ok for patch 1 to take flight to either live or
die. I'll handle any bugs that show up in relation to it. How about
patch 2?

-- 
Mel Gorman
SUSE Labs
