Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3AA447D40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhKHKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:06:45 -0500
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:52837 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhKHKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:06:43 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 7256F1C5CCE
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:03:58 +0000 (GMT)
Received: (qmail 11170 invoked from network); 8 Nov 2021 10:03:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Nov 2021 10:03:58 -0000
Date:   Mon, 8 Nov 2021 10:03:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211108100356.GG3959@techsingularity.net>
References: <20211028130305.GS3959@techsingularity.net>
 <875yt6tqbn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <875yt6tqbn.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:22:52PM +0000, Valentin Schneider wrote:
> On 28/10/21 14:03, Mel Gorman wrote:
> > Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> > nodes") allowed an imbalance between NUMA nodes such that communicating
> > tasks would not be pulled apart by the load balancer. This works fine when
> > there is a 1:1 relationship between LLC and node but can be suboptimal
> > for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
> >
> > Zen* has multiple LLCs per node with local memory channels and due to
> > the allowed imbalance, it's far harder to tune some workloads to run
> > optimally than it is on hardware that has 1 LLC per node. This patch
> > adjusts the imbalance on multi-LLC machines to allow an imbalance up to
> > the point where LLCs should be balanced between nodes.
> >
> 
> I've run out of brain juice for today and didn't get to decipher the logic
> you're implementing, but for now I do have a comment on the topology
> detection side of things (see inline).
> 
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> > +DEFINE_PER_CPU(int, sd_numaimb_shift);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > @@ -672,6 +673,20 @@ static void update_top_cache_domain(int cpu)
> >       sd = lowest_flag_domain(cpu, SD_NUMA);
> >       rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
> >
> > +	/*
> > +	 * Save the threshold where an imbalance is allowed between SD_NUMA
> > +	 * domains. If LLC spans the entire node, then imbalances are allowed
> > +	 * until 25% of the domain is active. Otherwise, allow an imbalance
> > +	 * up to the point where LLCs between NUMA nodes should be balanced
> > +	 * to maximise cache and memory bandwidth utilisation.
> > +	 */
> > +	if (sd) {
> > +		if (sd->span_weight == size)
> > +			per_cpu(sd_numaimb_shift, cpu) = 2;
> > +		else
> > +			per_cpu(sd_numaimb_shift, cpu) = max(2, ilog2(sd->span_weight / size * num_online_nodes()));
> > +	}
> > +
> 
> So nodes are covered by the NODE topology level which *doesn't* have
> SD_NUMA set. I always get confused on how MC/DIE/NODE is supposed to look
> on those sub-NUMA clustering thingies, but either way consider:
> 

The Zen machines don't have sub-NUMA clustering as such, each LLC is not
represented as a separate NUMA node. For example, an example Zen3
machines looks like

available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
node 0 size: 128278 MB
node 0 free: 126193 MB
node 1 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
node 1 size: 111571 MB
node 1 free: 109755 MB
node distances:
node   0   1
  0:  10  32
  1:  32  10

Each node has 8 LLCs and treated as if they are equal distance from memory
so node != LLC but for peak memory utilisation, it's best to spread based
on LLC and not just NUMA distance.

Hence, the intent of the patch is "allow some NUMA imbalance but not
enough imbalance that tasks share LLC prematurely". I didn't see an
obvious way of doing that with SD flag trickery.

-- 
Mel Gorman
SUSE Labs
