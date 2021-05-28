Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C843944EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhE1PUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 11:20:22 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:55263 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhE1PUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 11:20:12 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id DE78618E2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 16:18:35 +0100 (IST)
Received: (qmail 17224 invoked from network); 28 May 2021 15:18:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 15:18:35 -0000
Date:   Fri, 28 May 2021 16:18:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and
 active CPUs
Message-ID: <20210528151834.GR30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <893ce8ed-df14-612b-693f-48c9dac0eb19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <893ce8ed-df14-612b-693f-48c9dac0eb19@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 07:39:29AM -0700, Dave Hansen wrote:
> On 5/28/21 1:55 AM, Mel Gorman wrote:
> > -	 * onlined.
> > -	 */
> > -	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone)))) + cpu_online;
> > -	high = total_pages / nr_local_cpus;
> > +	 * onlined. For memory nodes that have no CPUs, split pcp->high across
> > +	 * all online CPUs to mitigate the risk that reclaim is triggered
> > +	 * prematurely due to pages stored on pcp lists.
> > +	 */
> > +	nr_split_cpus = cpumask_weight(cpumask_of_node(zone_to_nid(zone))) + cpu_online;
> > +	if (!nr_split_cpus)
> > +		nr_split_cpus = num_online_cpus();
> > +	high = total_pages / nr_split_cpus;
> 
> Updated version looks fine to me, thanks!
> 
> BTW, to do some of this testing, Feng was doing a plain old kernel
> build.  On the one system where this got run, he noted a ~2% regression
> in build times.  Nothing major, but you might want to be on the lookout
> in case 0day or the other test harnesses find something similar once
> this series gets to them.
> 

What type of system was it?

I noticed minor differences for some thread counts on kernel compilations
but for CascadeLake at least, it was mostly neutral. Below is an old test
result based on a previous revision.

kernbench
                               5.13.0-rc2             5.13.0-rc2
                                  vanilla       mm-pcpburst-v2r3
Amean     elsp-2        469.22 (   0.00%)      470.03 *  -0.17%*
Amean     elsp-4        251.03 (   0.00%)      250.83 (   0.08%)
Amean     elsp-8        131.39 (   0.00%)      130.89 (   0.38%)
Amean     elsp-16        74.37 (   0.00%)       75.11 (  -0.99%)
Amean     elsp-32        42.10 (   0.00%)       42.20 (  -0.24%)
Amean     elsp-64        32.21 (   0.00%)       32.14 (   0.23%)
Amean     elsp-128       31.59 (   0.00%)       31.68 (  -0.27%)
Amean     elsp-160       31.76 (   0.00%)       31.69 (   0.21%)

A Haswell machine showed the worst results for kernbench

Amean     elsp-2        459.99 (   0.00%)      465.27 *  -1.15%*
Amean     elsp-4        250.76 (   0.00%)      253.17 *  -0.96%*
Amean     elsp-8        141.28 (   0.00%)      141.78 (  -0.36%)
Amean     elsp-16        77.71 (   0.00%)       77.88 (  -0.22%)
Amean     elsp-32        44.09 (   0.00%)       44.40 (  -0.69%)
Amean     elsp-64        33.79 (   0.00%)       33.46 (   0.96%)
Amean     elsp-128       33.14 (   0.00%)       33.26 (  -0.37%)
Amean     elsp-160       33.26 (   0.00%)       33.36 *  -0.30%*

The series with review feedback and dealing with cpuless nodes is queued
and should complete over the weekend.

> Acked-by: Dave Hansen <dave.hansen@intel.com>

Thanks!

-- 
Mel Gorman
SUSE Labs
